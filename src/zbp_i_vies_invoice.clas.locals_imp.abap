class lhc_Invoice definition inheriting from cl_abap_behavior_handler.
  private section.

    methods get_global_authorizations for global authorization
      request requested_authorizations for Invoice result result.

    methods convertToEur for determine on modify
      importing keys for Invoice~convertToEur.

    methods checkViesStatus for validate on save
      importing keys for Invoice~checkViesStatus.

endclass.

class lhc_Invoice implementation.

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

  method convertToEur.

    read entities of zi_vies_invoice in local mode
      entity Invoice
      fields ( AmountLC CurrencyLC ) with corresponding #( keys )
      result data(lt_invoices).

    loop at lt_invoices into data(ls_invoice).
      if ls_invoice-AmountLC is initial or ls_invoice-CurrencyLC is initial.
        continue.
      endif.

      if ls_invoice-CurrencyLC = 'EUR'.
        modify entities of zi_vies_invoice in local mode
          entity Invoice
          update fields ( AmountEur )
          with value #( ( %tky = ls_invoice-%tky AmountEur = ls_invoice-AmountLC ) ).
        continue.
      endif.

      data(lv_amount_eur) = ls_invoice-AmountLC.

    " Hardcoded due to trial limitations
      case ls_invoice-CurrencyLC.
        when 'EUR'.
          lv_amount_eur = ls_invoice-AmountLC.
        when 'USD'.
          lv_amount_eur = ls_invoice-AmountLC * '0.92'.
        when 'GBP'.
          lv_amount_eur = ls_invoice-AmountLC * '1.17'.
        when others.
          lv_amount_eur = ls_invoice-AmountLC.
      endcase.

      modify entities of zi_vies_invoice in local mode
          entity Invoice
          update fields ( AmountEur )
          with value #( ( %tky        = ls_invoice-%tky
                          AmountEur = lv_amount_eur ) ).
    endloop.

  endmethod.

  method checkViesStatus.

    read entities of zi_vies_invoice in local mode
      entity Invoice
      fields ( VendorId ) with corresponding #( keys )
      result data(lt_invoices).

    loop at lt_invoices into data(ls_invoice).
      if ls_invoice-VendorId is initial.
        continue.
      endif.

      read entities of zi_vies_vendor
        entity Vendor
        fields ( ViesStatus )
        with value #( ( VendorId = ls_invoice-VendorId ) )
        result data(lt_vendors).

      if lt_vendors is not initial.
        data(ls_vendor) = lt_vendors[ 1 ].

        if ls_vendor-ViesStatus <> 'V'.
          append value #( %tky = ls_invoice-%tky ) to failed-invoice.

          append value #( %tky = ls_invoice-%tky
                          %msg = new_message_with_text(
                                   severity = if_abap_behv_message=>severity-error
                                   text     = |Rejected document: Vendor { ls_invoice-VendorId } with invalid VAT.| )
                          %element-vendorid = if_abap_behv=>mk-on ) to reported-invoice.
        endif.
      else.
        " missing supplier
        append value #( %tky = ls_invoice-%tky ) to failed-invoice.
        append value #( %tky = ls_invoice-%tky
                        %msg = new_message_with_text(
                                 severity = if_abap_behv_message=>severity-error
                                 text     = |Rejected document: Vendor { ls_invoice-VendorId } does not exist.| )
                        %element-vendorid = if_abap_behv=>mk-on ) to reported-invoice.
      endif.
    endloop.
  endmethod.
endclass.
