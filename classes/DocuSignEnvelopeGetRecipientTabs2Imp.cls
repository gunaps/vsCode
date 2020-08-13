/*
 * Sample class for demonstrating how to get the values from DocuSign custom tags
 * and update the custom fields on DocuSign Default Recipient object on an Apttus Agreement
*/
global class DocuSignEnvelopeGetRecipientTabs2Imp implements Apttus_DocuApi.IDocuSignEnvelopeGetRecipientTabs2{
    
    private final static String BUSINESS_OBJECT_TYPE_PROPOSAL = 'Proposal';
    
    global DocuSignEnvelopeGetRecipientTabs2Imp(){
    }
    
    global void getRecipientTabs(List<Apttus_DocuApi.GetRecipientTabsWrapper> iListGetRecipientTabsWrapper){
        
        System.debug(System.LoggingLevel.ERROR, 'GETTER iListGetRecipientTabsWrapper: ' + iListGetRecipientTabsWrapper);
        try{
            if(!iListGetRecipientTabsWrapper.isEmpty()){
                List<ID> listProductIds = new List<ID>();
                Apttus_DocuApi.GetRecipientTabsWrapper objGetRecipientTabsWrapper = iListGetRecipientTabsWrapper[0];
                
                ID parentId = ID.valueOf(objGetRecipientTabsWrapper.parentId);
                System.debug(System.LoggingLevel.ERROR, 'GETTER parentId: ' + parentId);
                
                Apttus_DocuApi.DocuSignUtil2.DocuSignRecipientStatus objRecipeintStatus = objGetRecipientTabsWrapper.recipientStatus;
                System.debug(System.LoggingLevel.ERROR, 'GETTER objRecipeintStatus: ' + objRecipeintStatus);
                
                Apttus_DocuApi.DocuSignUtil2.RecipientTabs rTabs = objRecipeintStatus.tabs;
                System.debug(System.LoggingLevel.ERROR, 'GETTER rTabs: ' + rTabs);
                
                //Map to hold key as checkbox id and value as Textbox
                Map<String, Apttus_DocuApi.DocuSignUtil2.textTab> mapCbTextbox = new Map<String, Apttus_DocuApi.DocuSignUtil2.textTab>();
                
                if(!rTabs.textTabs.isEmpty()){
                    for(Integer index=0; index<rTabs.textTabs.size(); index++){
                        Apttus_DocuApi.DocuSignUtil2.textTab tTab = rTabs.textTabs[index];
                        if(String.isNotBlank(tTab.name)){
                            mapCbTextbox.put(String.valueOf(tTab.name).replace('Text' , 'Checkbox'), tTab);
                        }
                    }
                    System.debug(System.LoggingLevel.ERROR, 'GETTER mapCbTextbox: ' + mapCbTextbox);
                }
                if(!rTabs.checkboxTabs.isEmpty()){
                    for(Integer index=0; index<rTabs.checkboxTabs.size(); index++){
                        Apttus_DocuApi.DocuSignUtil2.checkboxTab cbTab = rTabs.checkboxTabs[index];
                        if(String.isNotBlank(cbTab.name) && cbTab.selected == 'true'){
                            System.debug(System.LoggingLevel.ERROR, 'GETTER cbTab.selected: ' + cbTab);
                            listProductIds.add(mapCbTextbox.get(cbTab.name).value);
                        }
                    }
                }
                List<Apttus_Config2__ProductConfiguration__c> listProductConfig = [SELECT Id FROM Apttus_Config2__ProductConfiguration__c WHERE Apttus_Config2__BusinessObjectType__c = :BUSINESS_OBJECT_TYPE_PROPOSAL and Apttus_QPConfig__Proposald__c = :parentId ORDER BY SystemModstamp DESC LIMIT 1];
                System.debug(System.LoggingLevel.ERROR, 'GETTER listProductIds: ' + listProductIds);
                System.debug(System.LoggingLevel.ERROR, 'GETTER listProductIds: ' + listProductConfig);
                
                if(!listProductConfig.isEmpty()){                   
                    APTS_InteractivePDFUtility.addMultiProducts(listProductIds, parentId, listProductConfig[0].Id);
                    
         Apttus_Config2.PricingWebService.updatePriceForCart(listProductConfig[0].Id);
         Apttus_Config2.CPQWebService.finalizeConfiguration(listProductConfig[0].Id);
        
        Apttus_CPQApi.CPQ.FinalizeCartRequestDO finalrequest = new Apttus_CPQApi.CPQ.FinalizeCartRequestDO();
        finalrequest.CartId = listProductConfig[0].Id;
        
        Apttus_CPQApi.CPQ.FinalizeCartResponseDO FinalResponse = Apttus_CPQApi.CPQWebService.finalizeCart(finalrequest);
        
        system.debug('----------- SFFinalResponse: ' + FinalResponse);
        
                }
            }
        }catch(Exception ex){
            System.debug(System.LoggingLevel.ERROR, 'ERROR : '  + ex.getMessage());
        }
        
        //----------------------------------------- user upper portion only
        
        /*Set<ID> setParentId = new Set<ID>();
        for(Apttus_DocuApi.GetRecipientTabsWrapper objGetRecipientTabsWrapper : iListGetRecipientTabsWrapper){
            try{
                ID parentId = ID.valueOf(objGetRecipientTabsWrapper.parentId);
                if(!setParentId.contains(parentId)){
                    setParentId.add(parentId);
                }
            }catch(Exception ex){
                System.debug(System.LoggingLevel.ERROR, 'ERROR :  it is DEMO...!');
            }
        }
        
        List <Apttus_DocuApi__DocuSignDefaultRecipient2__c> listRecipients = [SELECT Apttus_CMDSign__AgreementId__c,Apttus_DocuApi__ReadOnlyEmail__c,Apttus_DocuApi__SigningOrder__c  from  Apttus_DocuApi__DocuSignDefaultRecipient2__c  where Apttus_CMDSign__AgreementId__c  in :setParentId];
        Map <String,Apttus_DocuApi__DocuSignDefaultRecipient2__c> recipientMap = new Map <String,Apttus_DocuApi__DocuSignDefaultRecipient2__c>();
         
        for(Apttus_DocuApi__DocuSignDefaultRecipient2__c r : listRecipients){
            String strKey = r.Apttus_CMDSign__AgreementId__c + String.valueOf(r.Apttus_DocuApi__SigningOrder__c);
            recipientMap.put(strKey,r);
        }     
        List<Apttus_DocuApi__DocuSignDefaultRecipient2__c> toUpdate = new List<Apttus_DocuApi__DocuSignDefaultRecipient2__c>();
        */
        /*for(Apttus_DocuApi.GetRecipientTabsWrapper objGetRecipientTabsWrapper : iListGetRecipientTabsWrapper){           
            
             try{
                 
                ID parentId = ID.valueOf(objGetRecipientTabsWrapper.parentId);
                 
                System.debug(System.LoggingLevel.ERROR, System.LoggingLevel.ERROR, 'Parent Id == > '+parentId);
                Apttus_DocuApi__DocuSignDefaultRecipient2__c docuSignDefaultRecipient = null;
                System.debug(System.LoggingLevel.ERROR, System.LoggingLevel.ERROR, 'Step 001 == >');
                 
                Apttus_DocuApi.DocuSignUtil2.DocuSignRecipientStatus objRecipeintStatus = objGetRecipientTabsWrapper.recipientStatus;
                System.debug(System.LoggingLevel.ERROR, System.LoggingLevel.ERROR, 'Step 001.1 == >');
                 
                String strKey = parentId + objRecipeintStatus.routingOrder;
                 
                Apttus_DocuApi.DocuSignUtil2.RecipientTabs rTabs = objRecipeintStatus.tabs;
                 
                //check if the recipient tab has text tabs
                 
                System.debug(System.LoggingLevel.ERROR, 'Map values == > '+JSON.serialize(recipientMap));
                 
                if(recipientMap.containsKey(strKey)){
                    System.debug(System.LoggingLevel.ERROR, 'Getting Map values for Id == > '+strKey);
                    docuSignDefaultRecipient = recipientMap.get(strKey);
                }
                if(rTabs.textTabs.size() > 0){
                    //populate the first custom field with the data in the first text tab
                    Apttus_DocuApi.DocuSignUtil2.textTab tTab = rTabs.textTabs[0];
                    //docuSignDefaultRecipient.CustomTab1__c = String.ValueOf(tTab.value);
                     
                    //populate the second custom field with the data in the second text tab
                    Apttus_DocuApi.DocuSignUtil2.textTab tTab1 = rTabs.textTabs[1];
                    //docuSignDefaultRecipient.CustomTab2__c = String.ValueOf(tTab1.value);   
                }
                 
                //check if the recipient tab has email tabs
                if(rTabs.emailTabs.size() > 0){
                    //populate the third custom field with the data in the first email tab
                    Apttus_DocuApi.DocuSignUtil2.emailTab eTab = rTabs.emailTabs[0];
                    //docuSignDefaultRecipient.CustomTab3__c = String.ValueOf(eTab.value);
                        
                }
                 
                toUpdate.add(docuSignDefaultRecipient);
            } catch(Exception ex){
                System.debug(System.LoggingLevel.ERROR, 'ERROR AT the :'+ex.getMessage());
            }
        } // for
         
        if(toUpdate.size() > 0){
            update toUpdate;
            System.debug(System.LoggingLevel.ERROR, 'ERROR: UPDATE DocuSignDefaultRecipient: '+toUpdate.size());  
        }  else{
            System.debug(System.LoggingLevel.ERROR, 'ERROR: UPDATE DocuSignDefaultRecipient: '+toUpdate.size());
        }*/
    }
}