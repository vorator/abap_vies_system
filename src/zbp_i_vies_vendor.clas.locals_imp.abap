class lhc_Vendor definition inheriting from cl_abap_behavior_handler.
  private section.

    methods get_instance_authorizations for instance authorization
      keys request requested_authorizations for Vendor result result.

    methods get_global_authorizations for global authorization
      request requested_authorizations for Vendor result result.

    methods validatesVIES for validate on save
       keys for Vendor~validatesVIES.

endclass.

class lhc_Vendor implementation.

  method get_instance_authorizations.
  endmethod.

  method get_global_authorizations.
  endmethod.

  method validatesVIES.
  endmethod.

endclass.
