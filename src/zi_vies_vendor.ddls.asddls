@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic View for vendor master table'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZI_VIES_VENDOR as select from zvies_vendor
{
  key vendor_id as VendorId,
  vendor_name   as VendorName,
  country_code  as CountryCode,
  vendor_type   as VendorType,
  vat_number    as VatNumber,
  vies_status   as ViesStatus,
  created_by    as CreatedBy,
  created_at    as CreatedAt,
  modified_by   as ModifiedBy,
  modified_at   as ModifiedAt
}
