@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic View for invoice table'
@Metadata.ignorePropagatedAnnotations: false
define root view entity Zi_vies_invoice as select from zvies_invoice
  association [0..1] to ZI_VIES_VENDOR as _Vendor
  on $projection.VendorId = _Vendor.VendorId
{
  key invoice_id  as InvoiceId,
  vendor_id       as VendorId,
  invoice_number  as InvoiceNo,
  amount_lc       as Amount,
  currency_lc     as Currency,
  amount_eur      as AmountEur,
  currency_eur    as CurrencyEur,
  invoice_date    as InvoiceDate,
  dc_indicator    as DcIndicator,
  status          as Status,
  description     as Description,
  created_by      as CreatedBy,
  created_at      as CreatedAt,
  modified_by     as ModifiedBy,
  modified_at     as ModifiedAt,
  _Vendor
}
