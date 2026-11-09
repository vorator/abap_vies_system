class lhc_Vendor definition inheriting from cl_abap_behavior_handler.
  private section.

    methods get_global_authorizations for global authorization
      importing request requested_authorizations for Vendor result result.

    methods validatesVIES for determine on modify
      importing keys for Vendor~validatesVIES.

endclass.

class lhc_Vendor implementation.

  method get_global_authorizations.
    if requested_authorizations-%create = if_abap_behv=>mk-on.
      result-%create = if_abap_behv=>auth-allowed.
    endif.
    if requested_authorizations-%update = if_abap_behv=>mk-on.
      result-%update = if_abap_behv=>auth-allowed.
    endif.
    if requested_authorizations-%delete = if_abap_behv=>mk-on.
      result-%delete = if_abap_behv=>auth-allowed.
    endif.
  endmethod.

  method validatesVIES.

    read entities of zi_vies_vendor in local mode
      entity Vendor
      fields ( CountryCode VatNumber ) with corresponding #( keys )
      result data(lt_vendors).

    loop at lt_vendors into data(ls_vendor).
      if ls_vendor-CountryCode is initial or ls_vendor-VatNumber is initial.
        continue.
      endif.

      data(ls_validation) = zcl_vies_integration=>validate_vat(
                                                    iv_country_code = ls_vendor-CountryCode
                                                    iv_vat_number = ls_vendor-VatNumber
                                                  ).

      if ls_validation-is_valid = abap_true.
        modify entities of zi_vies_vendor in local mode
          entity Vendor
          update fields ( ViesStatus )
          with value #( ( %tky = ls_vendor-%tky
                          ViesStatus = 'V'
                      ) ).
      else.
        modify entities of zi_vies_vendor in local mode
          entity Vendor
          update fields ( ViesStatus )
          with value #( ( %tky = ls_vendor-%tky
                          ViesStatus = 'I'
                      ) ).

        APPEND VALUE #( %tky = ls_vendor-%tky
                        %msg = new_message_with_text(
                                 severity = if_abap_behv_message=>severity-error
                                 text     = ls_validation-error_msg )
                        %element-vatnumber = if_abap_behv=>mk-on ) TO reported-vendor.
      endif.
    endloop.
  endmethod.

endclass.
