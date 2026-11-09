class zcl_vies_integration definition
  public
  final
  create public .

  public section.
    " internal structure to read the JSON
    types: begin of ty_vies_response,
             is_valid   type abap_bool,
             name       type string,
             address    type string,
             user_error type string,
           end of ty_vies_response.

    " exit structure for local classes
    types: begin of ty_validation_result,
             is_valid  type abap_bool,
             error_msg type string,
           end of ty_validation_result.

    class-methods validate_vat
      importing
        iv_country_code  type land1
        iv_vat_number    type abap_encod " todo: correct the type
      returning
        value(rs_result) type ty_validation_result.

  protected section.
  private section.
endclass.



class zcl_vies_integration implementation.

  method validate_vat.

    data ls_api_response type ty_vies_response.
    DATA lv_json_string  TYPE string.

    data(lv_country) = condense( iv_country_code ).
    data(lv_vat) = condense( iv_vat_number ).

    if lv_country is initial or lv_vat is initial.
      rs_result-is_valid = abap_false.
      rs_result-error_msg = 'Country code or VAT number is missing'.
      return.
    endif.

    try.
        " Define path
        data(lv_url) = |https://ec.europa.eu/taxation_customs/vies/rest-api/ms/{ lv_country }/vat/{ lv_vat }|.
        data(lo_destination) = cl_http_destination_provider=>create_by_url( lv_url ).
        data(lo_client) = cl_web_http_client_manager=>create_by_http_destination( lo_destination ).

        " force JSON
        data(lo_request) = lo_client->get_http_request( ).
        lo_request->set_header_field( i_name = 'Accept' i_value = 'application/json' ).

        " execute GET
        data(lo_response) = lo_client->execute( i_method = if_web_http_client=>get ).

        "execute GET
        lv_json_string = lo_response->get_text( ).

        " assess response
        if lo_response->get_status( )-code = 200.
          TRY.
              " prase
              xco_cp_json=>data->from_string( lv_json_string )->apply(
                VALUE #( ( xco_cp_json=>transformation->camel_case_to_underscore )
                         ( xco_cp_json=>transformation->boolean_to_abap_bool ) )
              )->write_to( REF #( ls_api_response ) ).

              rs_result-is_valid = ls_api_response-is_valid.

              IF rs_result-is_valid = abap_false.
                rs_result-error_msg = |VIES: Invalid VAT { lv_vat }.|.
              ENDIF.

            CATCH cx_root INTO DATA(lx_parse).
              rs_result-is_valid = abap_false.
              DATA(lv_preview) = substring( val = lv_json_string off = 0 len = nmin( val1 = 50 val2 = strlen( lv_json_string ) ) ).
              rs_result-error_msg = |API did not return a JSON. Response: { lv_preview }|.
          ENDTRY.
        else.
          rs_result-is_valid = abap_false.
          rs_result-error_msg = |HTTP fail: { lo_response->get_status( )-code }|.
        endif.

      catch cx_root into data(lx_error).
        rs_result-is_valid = abap_false.
        rs_result-error_msg = |Captured exception: { lx_error->get_text( ) }|.
    endtry.

  endmethod.

endclass.
