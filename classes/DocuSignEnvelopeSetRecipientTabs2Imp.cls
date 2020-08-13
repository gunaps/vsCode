/*
 * Sample class for demonstarting how to set the default values for DocuSign tags
*/
global class DocuSignEnvelopeSetRecipientTabs2Imp implements Apttus_DocuApi.IDocuSignEnvelopeSetRecipientTabs2{
    
    //private final static String BUSINESS_OBJECT_TYPE_PROPOSAL = 'Proposal';
     
    global List<Apttus_DocuApi.SetRecipientTabsWrapper> listToSetRecipientTabsWrapper = new List<Apttus_DocuApi.SetRecipientTabsWrapper>();
    
    global List<Apttus_DocuApi.SetRecipientTabsWrapper> setRecipientTabs(List<Apttus_DocuApi.SetRecipientTabsWrapper> iListSetRecipientTabsWrapper){
        System.debug(System.LoggingLevel.ERROR, 'SETTER : Step 001 ');
        this.listToSetRecipientTabsWrapper = iListSetRecipientTabsWrapper;
         
        /*for(Integer counter = 0 ; counter < listToSetRecipientTabsWrapper.size(); counter++){
            Apttus_DocuApi.SetRecipientTabsWrapper objSetRecipientTabsWrapper = this.listToSetRecipientTabsWrapper.get(counter);
            
            System.debug(System.LoggingLevel.ERROR, 'objSetRecipientTabsWrapper: ' + objSetRecipientTabsWrapper);
            
            this.listToSetRecipientTabsWrapper[counter] = this.addRecipeintTabs(objSetRecipientTabsWrapper);
        }*/
        
        if(!listToSetRecipientTabsWrapper.isEmpty()){
            Apttus_DocuApi.SetRecipientTabsWrapper objSetRecipientTabsWrapper = this.listToSetRecipientTabsWrapper.get(0);
            this.listToSetRecipientTabsWrapper[0] = this.addRecipeintTabs(objSetRecipientTabsWrapper);
        }
        
        /*[SELECT Id FROM Apttus_Config2__ProductConfiguration__c WHERE Apttus_Config2__BusinessObjectType__c = 'Proposal' and Apttus_QPConfig__Proposald__c = 'a1M410000003xjwEAA' order by SystemModstamp desc limit 1];*/
        
        System.debug(System.LoggingLevel.ERROR, 'SETTER : Step 002 ');
        return listToSetRecipientTabsWrapper;
    }
     
    public Apttus_DocuApi.SetRecipientTabsWrapper addRecipeintTabs(Apttus_DocuApi.SetRecipientTabsWrapper iSetRecipientTabsWrapper){
         
        System.debug(System.LoggingLevel.ERROR, ' addRecipeintTabs SETTER : Step 003 '); 
        List<Apttus_DocuApi.DocuSignUtil.Recipient> listRecipient = iSetRecipientTabsWrapper.listRecipient;
        String parentId = iSetRecipientTabsWrapper.parentId;

        System.debug(System.LoggingLevel.ERROR, 'listRecipient: ' + listRecipient);

        List<Optional_Products__c> listOptionalProducts = [SELECT Id, APTH_Sequence_number__c, Product__c FROM Optional_Products__c WHERE Quote_Proposal__c =: parentId AND Product__c != null  order by APTH_Sequence_number__c];
        
        /*for(Integer counter = 0 ; counter < listRecipient.size(); counter++){
             
            Apttus_DocuApi.DocuSignUtil.Recipient objRecipient = listRecipient.get(counter);
            System.debug(System.LoggingLevel.ERROR, 'objRecipient: ' + objRecipient); 
              
            listRecipient[counter] = this.addRecipeintTab(objRecipient);
        }*/
        
        if(!listRecipient.isEmpty()){
            Apttus_DocuApi.DocuSignUtil.Recipient objRecipient = listRecipient.get(0);
            
            System.debug(System.LoggingLevel.ERROR, 'objRecipient: ' + objRecipient);
            
            listRecipient[0] = this.addRecipeintTab(objRecipient, listOptionalProducts);
        }
        
        System.debug(System.LoggingLevel.ERROR, 'SETTER : Step 004 iSetRecipientTabsWrapper: ' + iSetRecipientTabsWrapper);
        iSetRecipientTabsWrapper.listRecipient = listRecipient;
        return iSetRecipientTabsWrapper;
    }
     
    public Apttus_DocuApi.DocuSignUtil.Recipient addRecipeintTab(Apttus_DocuApi.DocuSignUtil.Recipient iRecipient, List<Optional_Products__c> listOptionalProducts){
        Apttus_DocuApi.DocuSignUtil.Recipient objRecipient = iRecipient;
        System.debug(System.LoggingLevel.ERROR, 'SETTER : Step 005 ');
        objRecipient.tabs =  getRecipientTabs(listOptionalProducts);
          
        return objRecipient;
    }
     
     
    public Apttus_DocuApi.DocuSignUtil.RecipientTabs getRecipientTabs(List<Optional_Products__c> listOptionalProducts){
        String iRecipientId;
         
        System.debug(System.LoggingLevel.ERROR, 'SETTER : Step 006 ');
        Apttus_DocuApi.DocuSignUtil.RecipientTabs objRecipientTabs = new Apttus_DocuApi.DocuSignUtil.RecipientTabs();
        
        Apttus_DocuApi.DocuSignUtil.textTab objTextTab;
        Apttus_DocuApi.DocuSignUtil.checkboxTab objCheckboxTab;
        
        for(Integer counter = 0 ; counter < listOptionalProducts.size(); counter++){
            Optional_Products__c oOptionalProducts = listOptionalProducts.get(counter);
            System.debug(System.LoggingLevel.ERROR, 'oOptionalProducts: ' + oOptionalProducts);
            
            objTextTab = new Apttus_DocuApi.DocuSignUtil.textTab(''+oOptionalProducts.APTH_Sequence_number__c, ''+oOptionalProducts.Product__c,'1','0','0');
            objTextTab.name = 'Text'+oOptionalProducts.APTH_Sequence_number__c;
            objTextTab.tabLabel = 'Text'+oOptionalProducts.APTH_Sequence_number__c;
            objTextTab.anchorString = '\\tx'+oOptionalProducts.APTH_Sequence_number__c+'\\';
            
            objCheckboxTab = new Apttus_DocuApi.DocuSignUtil.checkboxTab(''+oOptionalProducts.APTH_Sequence_number__c , 'false','40','0','0');
            objCheckboxTab.name = 'Checkbox'+oOptionalProducts.APTH_Sequence_number__c;
            objCheckboxTab.tabLabel = 'Checkbox'+oOptionalProducts.APTH_Sequence_number__c;
            objCheckboxTab.anchorString = '\\p'+oOptionalProducts.APTH_Sequence_number__c+'\\';
            
            objRecipientTabs.addTextTab(objTextTab);
            objRecipientTabs.addCheckboxTab(objCheckboxTab);
        }
         
        //Set values for two text tags and one email tag in the document
  
        //Apttus_DocuApi.DocuSignUtil.emailTab objEmailTab  = new Apttus_DocuApi.DocuSignUtil.emailTab(iRecipientId,'email'+iRecipientId+'@test.com','40','0','0');
        // Apttus_DocuApi.DocuSignUtil.textTab objTextTab = new Apttus_DocuApi.DocuSignUtil.textTab(iRecipientId,'text'+iRecipientId,'400','0','0');
        
        // Apttus_DocuApi.DocuSignUtil.checkboxTab objCheckboxTab = new Apttus_DocuApi.DocuSignUtil.checkboxTab(iRecipientId,'true','40','0','0');
        //Apttus_DocuApi.DocuSignUtil.textTab objTextTab1  = new Apttus_DocuApi.DocuSignUtil.textTab(iRecipientId,'title'+iRecipientId,'40','0','0');
         
         
        /*objEmailTab.name = 'Email'+iRecipientId;
        objEmailTab.tabLabel = 'Email'+iRecipientId;
        objEmailTab.anchorString = '\\e'+iRecipientId+'\\';*/
         
        /*objTextTab.name = 'Text'+iRecipientId;
        objTextTab.tabLabel = 'Text'+iRecipientId;
        objTextTab.anchorString = '\\tx'+iRecipientId+'\\';
        
        objCheckboxTab.name = 'Checkbox'+iRecipientId;
        objCheckboxTab.tabLabel = 'Checkbox'+iRecipientId;
        objCheckboxTab.anchorString = '\\p'+iRecipientId+'\\';*/
         
        /*objTextTab1.name = 'SecondText'+iRecipientId;
        objTextTab1.tabLabel = 'SecondText'+iRecipientId;
        objTextTab1.anchorString = '\\t'+iRecipientId+'\\';
         
        objRecipientTabs.addEmailTab(objEmailTab);*/
        //objRecipientTabs.addTextTab(objTextTab);
        //objRecipientTabs.addCheckboxTab(objCheckboxTab);
        //objRecipientTabs.addTextTab(objTextTab1);
         
        System.debug(System.LoggingLevel.ERROR, 'SETTER : objRecipientTabs: ' + objRecipientTabs);
        return objRecipientTabs;
             
    }
}