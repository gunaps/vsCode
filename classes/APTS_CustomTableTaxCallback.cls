/*************************************************************************************************************
* Honeywell TC EMEA Custom Tax Table is the Tax Engine  (APTS_Tax_Rate_Table__c)
* @author Shubham Bhatt  - Apttus
* @CreatedDate  02/13/2017
* Last Modified By Yury Iagutyan 03/07/2017
* Last Modified By Shubham Bhatt 03/09/2017
* Last Modified By Shubham Bhatt 03/31/2017 Added CreditMemo Logic and modified and adjusted whole LOGIC
* @ModifiedDate 03/31/2017
***************************************************************************************************************/


global class APTS_CustomTableTaxCallback implements Apttus_Config2.CustomClass.ITaxCallback,Apttus_Config2.CustomClass.ITaxCallback2 { 
     private static Map<String, APTS_Tax_Rate_Table__c> taxTableMap;
     
     //constructor
     public APTS_CustomTableTaxCallback(){
         if( taxTableMap == null ){
            system.debug('###Tax Callback Called 0 : In constructor about to fire SOQL Query in static tax table');
            List<APTS_Tax_Rate_Table__c> taxTableList = [SELECT Id, Name, Tax_Code__r.Apttus_Config2__Code__c, Tax_Applies_To__c, Tax_Rate__c, Tax_Type__c FROM APTS_Tax_Rate_Table__c];
            taxTableMap = new Map<String, APTS_Tax_Rate_Table__c>();
            for(APTS_Tax_Rate_Table__c taxTableEntry : taxTableList){
                taxTableMap.put(taxTableEntry.Tax_Code__r.Apttus_Config2__Code__c,taxTableEntry);
            }
         }

     }
     
    /**
     * Calculates the tax.
     *
     * @param      taxInput  The tax input
     *
     * @return     taxresult
     */
    public Apttus_Config2.CustomClass.TaxResult computeTax (Apttus_Config2.CustomClass.TaxInput taxInput) {
        Apttus_Config2.CustomClass.TaxResult result = null;
        
        List<Apttus_Config2.CustomClass.TaxResult> results = computeTaxMultiple( new List<Apttus_Config2.CustomClass.TaxInput>{taxinput});
        if( results != null && results.size() == 1){
            result = results[0];
        }
        
        return result;
    }

    /*
     - Implement the interface method.
     - Product OOB passes multiple tax inputs from Batch.
     - We will have multiple taxinputs across the accounts for Invoice run.
     - Tax Inputs never be null and Product doesnt invoke call back if no
       invoice generated.
    
     Calculates the tax multiple.
    
     @param      taxInputs  The tax inputs
    
     @return     multiple.taxresults
    */
    public List<Apttus_Config2.CustomClass.TaxResult> computeTaxMultiple (List<Apttus_Config2.CustomClass.TaxInput> taxInputs) {
        system.debug('###Tax Callback Called 2 : In computeTaxMultiple' + taxInputs);

        List<Apttus_Config2.CustomClass.TaxResult> taxResults = new List<Apttus_Config2.CustomClass.TaxResult>();
        

        Schema.SobjectType sobjectType = taxInputs[0].Item.getSObjectType();
        system.debug('###Tax Callback Called 3 : Item Type => '+ String.valueOf(sobjectType));
        /* Cart,Invoice & CreditMemo Tax Engnie */
        if (String.valueOf(sobjectType) == 'Apttus_Billing__InvoiceLineItem__c' || String.valueOf(sobjectType) == 'Apttus_Config2__LineItem__c' || String.valueOf(sobjectType) == 'Apttus_Billing__CreditMemoLineItem__c') {
            
            for (Apttus_Config2.CustomClass.TaxInput input : taxInputs) {
                Decimal taxAmount = 0;
                Apttus_Config2.CustomClass.TaxResult taxResult = new Apttus_Config2.CustomClass.TaxResult();
                List<Apttus_Config2__TaxBreakup__c> taxBreakUps = new List<Apttus_Config2__TaxBreakup__c>();
                // Add the handback object to correlate the result with the input
                Apttus_Billing.CustomClass.TaxResultHandback taxHandBAck = new Apttus_Billing.CustomClass.TaxResultHandback();
                taxHandBAck.lineItem = input.Item;
                taxResult.Handback = taxHandBAck ;

                
                // Tax Code is required
                if (input.TaxCode != null && input.TaxCode.trim().length() != 0 && taxTableMap.containsKey(input.TaxCode) ) {
                    
                    APTS_Tax_Rate_Table__c taxRateTableRow = taxTableMap.get(input.TaxCode);
                    Decimal taxRate = taxRateTableRow.Tax_Rate__c;
                    String taxAppliesTo = taxRateTableRow.Tax_Applies_To__c;
                    String taxType = taxRateTableRow.Tax_Type__c;
                    SObject sObj = input.Item;
                    Decimal listPrice;
                    //We are not using OOTB Tax Inclusive Because our price are Tax Inclusive and if we check this OOTB Tax Inclusive then On Invoice RUN No tax callback batch will get call
                    Boolean taxInclusive = (Boolean) sObj.get('APTS_UI_Tax_Inclusive__c');
                    system.debug('###tax input.TaxCode' + input.TaxCode);
                    
                    /* Invoice Tax Engnie */
                    if (String.valueOf(sobjectType) == 'Apttus_Billing__InvoiceLineItem__c'){
                         listPrice = (Decimal) sObj.get('APTS_List_Price__c');
                         //taxInclusive = (Boolean) sObj.get('Apttus_Billing__TaxInclusive__c');
                         system.debug('###Apttus_Billing__InvoiceLineItem__c'+ listPrice + '**'+ taxInclusive);
                         
                    /* Credit Memo Tax Engine */
                    } else if(String.valueOf(sobjectType) == 'Apttus_Billing__CreditMemoLineItem__c') {                         
                        listPrice = (Decimal) sObj.get('Apttus_Billing__Amount__c');
                        //taxInclusive = (Boolean) sObj.get('Apttus_Config2__TaxInclusive__c');
                        system.debug('###Apttus_Billing__CreditMemoLineItem__c'+ listPrice + '**'+ taxInclusive);                         

                    /* Cart Tax Engine */
                    } else if(String.valueOf(sobjectType) == 'Apttus_Config2__LineItem__c') {   
                         listPrice = (Decimal) sObj.get('Apttus_Config2__ListPrice__c');
                         //taxInclusive = (Boolean) sObj.get('Apttus_Config2__TaxInclusive__c');
                         system.debug('###Apttus_Config2__LineItem__c'+ listPrice + '**'+ taxInclusive);                        
                    }
                    
                    if(taxInclusive){
                        Decimal ActualListPrice = (listPrice*100)/(100+taxRate);
                        //taxAmount += (taxRate != null ? (taxRate * ActualListPrice) / 100 : 0);
                        
                        Decimal actualTaxableAmount = (input.TaxableAmount*100)/(100+taxRate);
                        taxAmount += (taxRate != null ? (taxRate * actualTaxableAmount) / 100 : 0); 
                        system.debug('###taxInclusive'+ ActualListPrice + '**'+ taxAmount);
                    }else{
                        //taxAmount += (taxRate != null ? (taxRate * listPrice) / 100 : 0);
                        
                        taxAmount += (taxRate != null ? (taxRate * input.TaxableAmount) / 100 : 0);
                        system.debug('###NOT taxInclusive' + '**'+ taxAmount);
                    }
                    
                    //We are not using below line because "input.TaxableAmount" is always refer to the Net Price but we want tax to be apply on "List Price"
                    //taxAmount += (taxRate != null ? (taxRate * input.TaxableAmount) / 100 : 0);
                    
                    Apttus_Config2__TaxBreakup__c taxBreakUp = new Apttus_Config2__TaxBreakup__c();
                    taxBreakUp.Apttus_Config2__Sequence__c = 1;
                    taxBreakUp.Apttus_Config2__TaxType__c = taxType;
                    taxBreakUp.Apttus_Config2__TaxRate__c = taxRate;
                    taxBreakUp.Apttus_Config2__TaxAppliesTo__c = taxAppliesTo;
                    taxBreakUp.Apttus_Config2__TaxAmount__c = taxAmount;
                    taxBreakUp.Apttus_Config2__BreakupType__c = 'Detail';
                    taxBreakUps.add(taxBreakUp);
                    taxResult.TaxBreakups = taxBreakUps;
                    taxResult.TaxAmount = taxAmount;
                    
                    system.debug('###taxBreakUp' + '**'+ taxAmount + ' %% ' +taxBreakUp);                    
                    
                } else {
                    // Tax Amount
                    taxResult.TaxAmount = 0;
                    system.debug('###Either Tax code is null or tax code is not exist in tax table' + input.TaxCode.trim().length() + taxTableMap.containsKey(input.TaxCode) );
                    system.debug('###TaxAmount' + '**'+ input.TaxCode + '%%' + input.TaxableAmount);
                }
                
                taxResults.add(taxResult);
            }
         
        /* Different sobjectType, Not Suitable for Taxcallback  */
        }else{
             //Different sobjectType 
             system.debug('### Different sobjectType => Tax callback Not allowed for this ' + String.valueOf(sobjectType) );
        } 
        
        return taxResults;
        
    }
}