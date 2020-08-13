public with sharing class APTPS_ApplyPricingNewController {
    //show error messages
    public Boolean haserrorMessages {get;set;}
    public String configurationId {get; set;}
    public String configRequestId {get; set;}
    private String baseLineId;
    
    //constructor
    public APTPS_ApplyPricingNewController(ApexPages.StandardController controller) {
        haserrorMessages = false;
        
        configurationId = ApexPages.currentPage().getParameters().get('id');
        configRequestId = ApexPages.currentPage().getParameters().get('configRequestId');
        
        

    }
    
    public PageReference goBack(){      
        return new PageReference('/apex/Apttus_Config2__ConfigureBundle?callerPage=SelectConfigProducts&configRequestId='+configRequestId+'&Id='+baseLineId);
    }
    
    //save and submit pricing
    public PageReference saveAndSubmitPricing() { 
        Apttus_CpqApi.CPQ.UpdatePriceRequestDO objUpdatePriceRequestDO = new Apttus_CpqApi.CPQ.UpdatePriceRequestDO();
        objUpdatePriceRequestDO.CartId = configurationId ;
        Apttus_CpqApi.CPQ.UpdatePriceResponseDO result1 = Apttus_CpqApi.CPQWebService.updatePriceForCart(objUpdatePriceRequestDO);
        Apttus_CPQApi.CPQ.FinalizeCartRequestDO finalRequest = new Apttus_CPQApi.CPQ.FinalizeCartRequestDO();
        finalRequest.CartId = configurationId ;
        Apttus_CPQApi.CPQ.FinalizeCartResponseDO finalResponse = Apttus_CPQApi.CPQWebService.finalizeCart(finalRequest);      
        /*try {
            if(configurationId != null) {
                
                list<Apttus_Config2__LineItem__c> lineItemsList = new list<Apttus_Config2__LineItem__c>();
                
                lineItemsList = [SELECT Id, Apttus_Config2__ConfigurationId__c, Apttus_Config2__LineNumber__c, Apttus_Config2__Quantity__c, 
                                Apttus_Config2__NetPrice__c, Apttus_Config2__BasePrice__c, Apttus_Config2__ProductId__c, Apttus_Config2__OptionId__c,
                                APTPS_Quote_Record_Type__c, Apttus_Config2__ConfigurationId__r.Apttus_QPConfig__Proposald__c,
                                Apttus_Config2__ConfigurationId__r.Apttus_QPConfig__Proposald__r.APTPS_Country_Abroad__c,
                                Apttus_Config2__OptionId__r.APTPS_Applicable_Countries__c, APTPS_Product_Family__c, Apttus_Config2__OptionId__r.Name 
                                FROM Apttus_Config2__LineItem__c
                                WHERE Apttus_Config2__ConfigurationId__c = :String.escapeSingleQuotes(configurationId)];
                
                if(lineItemsList != null && lineItemsList.size() > 0){*/
                    
                    //Validation for Invalid Frieght
                    /*
                    List<String> countryAbroadSet = lineItemsList[0].Apttus_Config2__ConfigurationId__r.Apttus_QPConfig__Proposald__r.APTPS_Country_Abroad__c != null ? lineItemsList[0].Apttus_Config2__ConfigurationId__r.Apttus_QPConfig__Proposald__r.APTPS_Country_Abroad__c.split(',') : new List<String>();
                    String optionName = '<ul>';
                    
                    if(countryAbroadSet.size() > 0){
                        
                        for(Apttus_Config2__LineItem__c line : lineItemsList){                      
                            if(line.APTPS_Product_Family__c == 'DSV Offering'){
                                baseLineId = line.Id;
                            }
                            
                            List<String> lstApplicableCountries = line.Apttus_Config2__OptionId__r.APTPS_Applicable_Countries__c != null ? line.Apttus_Config2__OptionId__r.APTPS_Applicable_Countries__c.split(',') : new List<String>();
                            Set<String> applicableCountry = new Set<String>();
                            applicableCountry.addAll(lstApplicableCountries);
                            
                            
                            if(applicableCountry.isEmpty() || applicableCountry.contains('General')){
                                continue;
                            }
                            
                            Boolean atleastOneMatched = false;
                            for(String cAbroad : countryAbroadSet){
                                
                                if(applicableCountry.contains(cAbroad)){
                                    atleastOneMatched = true;
                                    continue;
                                }
                            }
                            
                            if(!atleastOneMatched){
                                
                                optionName = optionName + '<li> ' + line.Apttus_Config2__OptionId__r.Name + '</li>';
                                haserrorMessages = true;
                            }
                        }
                    }
                    
                    optionName = optionName + '</ul>';
                    */
                    
                    /*for(Apttus_Config2__LineItem__c line : lineItemsList){                      
                        if(line.APTPS_Product_Family__c == 'DSV Offering'){
                            baseLineId = line.Id;
                        }
                    }
                    
                    String optionName = APTPS_Helper.validateOptionSelection(lineItemsList);
                    
                    if(optionName != null){
                        haserrorMessages = true;
                        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'Invalid Options selected. Please remove below products: <br/>'+optionName));
                        return null;
                    }
                }
                
                //validate spot quote               
                if(lineItemsList != null && lineItemsList[0].APTPS_Quote_Record_Type__c == APTPS_Constants.QUOTE_RECORD_TYPE_SPOT_QUOTE){
                    //spot quote
                    //return new PageReference(Page.Apttus_Config2__pricing.getURL()+'?id=' + configurationId + '&configRequestId=' + configRequestId);
                    haserrorMessages = true;
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.WARNING, 'This action is available for Tariff Quote only.'));
                    return null;
                }
                
                else if(lineItemsList != null && lineItemsList[0].APTPS_Quote_Record_Type__c == APTPS_Constants.QUOTE_RECORD_TYPE_TARIFF_QUOTE) {
                    
                    
                    //tarrif quote
                    //validate tariff quote threshold limit
                    //get all line items
                    
                    //get tariff quote pricing threshold limit
                    //profile level
                    Tariff_Quote_Pricing_Threshold_Settings__c pricingThresholdSettings1 = Tariff_Quote_Pricing_Threshold_Settings__c.getInstance(userInfo.getProfileId());
                    //user level
                    Tariff_Quote_Pricing_Threshold_Settings__c pricingThresholdSettings2 = Tariff_Quote_Pricing_Threshold_Settings__c.getInstance(userINfo.getUserId());
                    
                    if(pricingThresholdSettings1 != null && pricingThresholdSettings1.APTPS_Threshold_Limit__c != null && pricingThresholdSettings1.APTPS_Threshold_Limit__c < lineItemsList.size()) {
                        
                        //profile level
                        //batch process
                        //pricing
                        if(lineItemsList != null && lineItemsList[0].Apttus_Config2__ConfigurationId__c != null && lineItemsList[0].Apttus_Config2__ConfigurationId__r.Apttus_QPConfig__Proposald__c != null) {
                            
                            //set proposal stage and batch status
                            Apttus_Proposal__Proposal__c proposal = new Apttus_Proposal__Proposal__c(Id = lineItemsList[0].Apttus_Config2__ConfigurationId__r.Apttus_QPConfig__Proposald__c);
                            proposal.Apttus_Proposal__Approval_Stage__c = APTPS_Constants.APPROVAL_STAGE_APPLYING_PRICING;
                            proposal.APTPS_Pricing_Batch_Status__c = APTPS_Constants.BATCH_STATUS_PROCESSING;
                            proposal.APTPS_Send_Pricing_Complete_Email__c = true;
                            update proposal;
                            
                            if(!Test.isRunningTest()) {
                                //pricing batch
                                APTPS_SubmitPricing_BJob submitPricingBatch = new APTPS_SubmitPricing_BJob(configurationId);
                                database.executebatch(submitPricingBatch, 1);   //prodcess one line item at a time
                            }
                        }
                        
                        //return to quote/proposal detail
                        return new PageReference('/' + lineItemsList[0].Apttus_Config2__ConfigurationId__r.Apttus_QPConfig__Proposald__c);
                        
                    } else if(pricingThresholdSettings2 != null && pricingThresholdSettings2.APTPS_Threshold_Limit__c != null && pricingThresholdSettings2.APTPS_Threshold_Limit__c < lineItemsList.size()) {
                        //user level
                        //batch process
                        //pricing
                        if(lineItemsList != null && lineItemsList[0].Apttus_Config2__ConfigurationId__c != null && lineItemsList[0].Apttus_Config2__ConfigurationId__r.Apttus_QPConfig__Proposald__c != null) {
                            
                            //set proposal stage and batch status
                            Apttus_Proposal__Proposal__c proposal = new Apttus_Proposal__Proposal__c(Id = lineItemsList[0].Apttus_Config2__ConfigurationId__r.Apttus_QPConfig__Proposald__c);
                            proposal.Apttus_Proposal__Approval_Stage__c = APTPS_Constants.APPROVAL_STAGE_APPLYING_PRICING;
                            proposal.APTPS_Pricing_Batch_Status__c = APTPS_Constants.BATCH_STATUS_PROCESSING;
                            proposal.APTPS_Send_Pricing_Complete_Email__c = true;
                            update proposal;
                            
                            if(!Test.isRunningTest()) {
                                //pricing batch                         
                                APTPS_SubmitPricing_BJob submitPricingBatch = new APTPS_SubmitPricing_BJob(configurationId);
                                database.executebatch(submitPricingBatch, 1);   //prodcess one line item at a time
                            }
                        }
                        
                        //return to quote/proposal detail
                        return new PageReference('/' + lineItemsList[0].Apttus_Config2__ConfigurationId__r.Apttus_QPConfig__Proposald__c);
                        
                    } else {
                        //not exceeding threshold limit
                        //no batch process
                        
                        //return new PageReference(Page.Apttus_Config2__pricing.getURL()+'?id=' + configurationId + '&configRequestId=' + configRequestId);
                    }
                }
            }
        } catch(Exception ex) {
            haserrorMessages = true;
            ApexPages.AddMessage(new ApexPages.Message(ApexPages.Severity.ERROR, ex.getMessage()));
        }*/
         
        return null;
    }
    
    public void rePriceLineItem(){          
        /*Id cartId = Apexpages.currentPage().getParameters().get('cartId');
        Decimal lineNumber = Decimal.valueOf(Apexpages.currentPage().getParameters().get('lineNumber'));
        
        //System.debug('*** completed *** cartId ****' + cartId + '*** line number ***' + lineNumber);
        
        if(cartId != null && lineNumber != null){
            Apttus_Config2.PricingWebService.computeBasePriceForItemColl(cartId, lineNumber);
        }   */
    }
}