class lhc_Invoice definition inheriting from cl_abap_behavior_handler.
  private section.

    methods get_global_authorizations for global authorization
      request requested_authorizations for Invoice result result.

    methods convertToEur for determine on save
       keys for Invoice~convertToEur.

    methods validateVendorVies for validate on save
       keys for Invoice~validateVendorVies.

endclass.

class lhc_Invoice implementation.

  method get_global_authorizations.
  endmethod.

  method convertToEur.
  endmethod.

  method validateVendorVies.
  endmethod.

endclass.
