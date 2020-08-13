/*********************************************************************************************************************************************
Name : APTS_TC_EMEAPricingCallback class
Created BY : Yury Iagutyan
Company Name : Apttus
Project      : eCommerce - Air and Water
Created Date : 7th March 2017
Modified Date : 3th May 2017
Modified By  : Yury Iagutyan
Class   :  APTS_TC_EMEAPricingCallback
Test Class: - 
Test Class URL: - 
Description : Implmenets TC EMEA Pricing Call back
***********************************************************************************************************************************************/
global with sharing class APTS_TC_EMEAPricingCallback implements Apttus_Config2.CustomClass.IPricingCallback3 {
    private Apttus_Config2.CustomClass.Address location;
    private Map<ID, String> taxCodeMap = new Map<ID, String>();
    private Map<ID, boolean> taxInclusiveMap = new Map<ID, boolean>();
	public class IllegalArgumentException extends Exception {}

    global void start(Apttus_Config2.ProductConfiguration cart) {
      Apttus_Config2__ProductConfiguration__c pc = cart.getConfigSO();
      if(pc.Apttus_Config2__LocationId__c != null) {
		Apttus_Config2__AccountLocation__c al = [select ID,Apttus_Config2__Street__c,Apttus_Config2__City__c,Apttus_Config2__State__c,Apttus_Config2__PostalCode__c,Apttus_Config2__Country__c,Apttus_Config2__County__c from  Apttus_Config2__AccountLocation__c where ID =: pc.Apttus_Config2__LocationId__c limit 1];
		
		location = new Apttus_Config2.CustomClass.Address(); 
		location.Street = al.Apttus_Config2__Street__c;
		location.City = al.Apttus_Config2__City__c;  
		location.State = al.Apttus_Config2__State__c;
		location.PostalCode = al.Apttus_Config2__PostalCode__c;
		location.Country = al.Apttus_Config2__Country__c;
		location.County = al.Apttus_Config2__County__c;
      }
    }                           
 
    global void afterPricingLineItem(Apttus_Config2.ProductConfiguration.LineItemColl itemColl, 
                                                  Apttus_Config2.LineItem lineItemMO) {
      Apttus_Config2__LineItem__c item = lineItemMO.getLineItemSO();
      system.debug('###$$$afterPricingLineItem0');
      system.debug('###$$$afterPricingLineItem'+item.ID+'==========> '+item.Apttus_Config2__PriceListItemId__r.Apttus_Config2__TaxCodeId__r.Apttus_Config2__Code__c);
      taxCodeMap.put(item.ID, item.Apttus_Config2__PriceListItemId__r.Apttus_Config2__TaxCodeId__r.Apttus_Config2__Code__c);
      taxInclusiveMap.put(item.ID, item.Apttus_Config2__PriceListItemId__r.APTS_UI_Tax_Inclusive__c);
      system.debug('###$$$afterPricingLineItem'+item.ID+'==========> '+item.Apttus_Config2__PriceListItemId__r.APTS_UI_Tax_Inclusive__c);
    }

    global void afterPricing(Apttus_Config2.ProductConfiguration.LineItemColl itemColl) { 
      for(Apttus_Config2.LineItem configLineItem :itemColl.getAllLineItems()){
           Apttus_Config2__LineItem__c item = configLineItem.getLineItemSO();
           system.debug('###$$$afterPricing0');
           if( taxCodeMap.containsKey(item.ID) && taxInclusiveMap.containsKey(item.ID) ){
                    system.debug('###$$$afterPricing1');
                    if(taxCodeMap.get(item.ID) == null) {
                      throw new IllegalArgumentException('No tax code found: ' + item.ID);
                    }
            
                    if(taxInclusiveMap.get(item.ID) == null) {
                      throw new IllegalArgumentException('No tax inclusive flag found: ' + item.ID);   
                    }
            
                    Apttus_Config2.CustomClass.TaxInput taxInput = new Apttus_Config2.CustomClass.TaxInput();            
                    taxInput.TaxCode = taxCodeMap.get(item.ID);
                    taxInput.TaxableAmount = item.Apttus_Config2__NetPrice__c;
                    item.APTS_UI_Tax_Inclusive__c = taxInclusiveMap.get(item.ID);
                    taxInput.Item = item;
                    if(location != null) {
                        taxInput.TaxAddress = location;
                    }
                   
                    Apttus_Config2.CustomClass.ITaxCallback2 taxCallBack = APTS_TaxCalculationFactory.getTaxCallback();
            
                    Apttus_Config2.CustomClass.TaxResult taxResult = taxCallBack.computeTax(taxInput);
                    item.APTS_Calculated_Tax__c = taxResult.TaxAmount;
           }  
        }
    }     

    global void setMode(Apttus_Config2.CustomClass.PricingMode mode) {}

    global void beforePricing(Apttus_Config2.ProductConfiguration.LineItemColl itemColl) {}    

    global void onPriceItemSet(Apttus_Config2__PriceListItem__c itemSO, Apttus_Config2.LineItem lineItemMO){} 

    global void beforePricingLineItem(Apttus_Config2.ProductConfiguration.LineItemColl itemColl, 
                                                  Apttus_Config2.LineItem lineItemMO) {}     

    global void finish() {}         
}