@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Vendor Consumption & UI annotations'
@Metadata.ignorePropagatedAnnotations: false
@Metadata.allowExtensions: true
define root view entity ZC_VIES_VENDOR 
  provider contract transactional_query 
  as projection on ZI_VIES_VENDOR
{
  @UI.facet: [{ 
    id: 'VendorInfo', 
    purpose: #STANDARD,
    type: #IDENTIFICATION_REFERENCE,
    label: 'Vendor details',
    position: 10 },
    
    { id: 'AdminData', 
      purpose: #STANDARD, 
      type: #FIELDGROUP_REFERENCE, 
      targetQualifier: 'AdminGroup', 
      label: 'Administrative Data', 
      position: 20 }]
    
  
  @UI.selectionField: [{ position: 10 }]
  @UI.lineItem:       [{ position: 10, label: 'Vendor No' }]
  @UI.identification: [{ position: 10, label: 'Vendor No' }]
  key VendorId,
  
  @UI.lineItem:       [{ position: 20, label: 'Vendor Name' }]
  @UI.identification: [{ position: 20, label: 'Vendor Name' }]
  VendorName,
  
  @UI.lineItem:       [{ position: 30, label: 'Country Code' }]
  @UI.identification: [{ position: 30, label: 'Country Code' }]
  CountryCode,
  
  @UI.lineItem:       [{ position: 40, label: 'VAT No' }]
  @UI.identification: [{ position: 40, label: 'VAT No' }]
  VatNumber,
  
  @UI.lineItem:       [{ position: 50, label: 'VIES status' }]
  @UI.identification: [{ position: 50, label: 'VIES status' }]
  ViesStatus,
  
  @UI.fieldGroup: [{ qualifier: 'AdminGroup', position: 10, label: 'Created by' }]
  CreatedBy,
  @UI.fieldGroup: [{ qualifier: 'AdminGroup', position: 20, label: 'Created at' }]
  CreatedAt,
  @UI.fieldGroup: [{ qualifier: 'AdminGroup', position: 30, label: 'Modif. by' }]
  ModifiedBy,
  @UI.fieldGroup: [{ qualifier: 'AdminGroup', position: 40, label: 'Modif. at' }]
  ModifiedAt
  
}
