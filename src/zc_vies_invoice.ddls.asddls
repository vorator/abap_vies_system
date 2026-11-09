@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Invoice consumption View'
@Metadata.ignorePropagatedAnnotations: false
@Metadata.allowExtensions: true
define root view entity ZC_VIES_INVOICE 
  provider contract transactional_query
  as projection on Zi_vies_invoice
{

  @UI.facet: [{ id: 'InvoiceInfo', 
                purpose: #STANDARD, 
                type: #IDENTIFICATION_REFERENCE, 
                label: 'Invoice details', 
                position: 10 },
                
              { id: 'AdminData', 
                purpose: #STANDARD, 
                type: #FIELDGROUP_REFERENCE, 
                targetQualifier: 'AdminGroup', 
                label: 'Administrative Data', 
                position: 20 }]

  @UI.hidden: true
  key InvoiceId,
  
  @UI.selectionField:               [{ position: 10 }]
  @UI.lineItem:                     [{ position: 10, label: 'Vendor No' }]
  @UI.identification:               [{ position: 10, label: 'Vendor No' }]
  @Consumption.valueHelpDefinition: [{ entity: { name: 'ZC_VIES_VENDOR', element: 'VendorId' } }]
  VendorId,
  
  @UI.lineItem:       [{ position: 20, label: 'Invoice No' }]
  @UI.identification: [{ position: 20, label: 'Invoice No' }]
  InvoiceNo,
  
  @UI.lineItem:       [{ position: 30, label: 'Invoice Date' }]
  @UI.identification: [{ position: 30, label: 'Invoice Date' }]
  InvoiceDate,
  
  @UI.lineItem:       [{ position: 40, label: 'Amount LC' }]
  @UI.identification: [{ position: 40, label: 'Amount LC' }]
  AmountLC,
  
  @UI.identification: [{ position: 41, label: 'Curreny LC' }]
  CurrencyLC,
  
  @UI.lineItem:       [{ position: 50, label: 'Amount EUR (API)' }]
  @UI.identification: [{ position: 50, label: 'Amount EUR (API)' }]
  AmountEur,
  
  @UI.identification: [{ position: 51, label: 'Curreny EUR' }]
  CurrencyEur,
  
  @UI.identification: [{ position: 60 }]
  DcIndicator,
  
  @UI.lineItem:       [{ position: 70 }]
  @UI.identification: [{ position: 70 }]
  Status,
  
  @UI.identification: [{ position: 80 }]
  Description,
  
  @UI.fieldGroup: [{ qualifier: 'AdminGroup', position: 10, label: 'Created by' }]
  CreatedBy,
  @UI.fieldGroup: [{ qualifier: 'AdminGroup', position: 20, label: 'Created at' }]
  CreatedAt,
  @UI.fieldGroup: [{ qualifier: 'AdminGroup', position: 30, label: 'Modif. by' }]
  ModifiedBy,
  @UI.fieldGroup: [{ qualifier: 'AdminGroup', position: 40, label: 'Modif. at' }]
  ModifiedAt,
  /* Associations */
  _Vendor
}
