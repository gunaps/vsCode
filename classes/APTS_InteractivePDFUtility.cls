global class APTS_InteractivePDFUtility{
  public static final String PARTNER_SERVER_URL_140   = System.Url.getSalesforceBaseUrl().toExternalForm() + '/services/Soap/u/14.0/' + UserInfo.getOrganizationId(); 

  global APTS_InteractivePDFUtility(){

  }

  global List<ID> getRecomProducts(){

        Set<String> ruleinfoList = new Set<String>();
        for(Apttus_Config2__AppliedRuleInfo__c rl:[select Apttus_Config2__ConstraintRuleId__c FROM Apttus_Config2__AppliedRuleInfo__c Where Apttus_Config2__ConfigurationId__c = 'a3X410000000f6S' and Apttus_Config2__ConstraintRuleId__c in (Select Apttus_Config2__ConstraintRuleId__c from Apttus_Config2__ConstraintRuleAction__c where Apttus_Config2__ActionType__c = 'Recommendation')]){
        ruleinfoList.add(rl.Apttus_Config2__ConstraintRuleId__c);
        }
        List<ID> productList = new List<ID>();
        for(Apttus_Config2__ConstraintRuleAction__c cons:[Select Apttus_Config2__ProductId__c from Apttus_Config2__ConstraintRuleAction__c where Apttus_Config2__ConstraintRuleId__c in:ruleinfoList]){
        productList.add(cons.Apttus_Config2__ProductId__c);
        }
        system.debug('-----------' + productList);
        
        return productList;
     }
     
 global static void addMultiProducts(List<Id> lstProducts,string proposalId, string PdconfigurationId){
         string productConfigurationId =  PdconfigurationId;
        
        Apttus_CPQApi.CPQ.AddMultiProductRequestDO requests = new Apttus_CPQApi.CPQ.AddMultiProductRequestDO();
        List <Apttus_CPQApi.CPQ.SelectedProductDO> selectedProdDOList = new List<Apttus_CPQApi.CPQ.SelectedProductDO>();
        requests.CartId = productConfigurationId;
        
        for(Id bundleProd : lstProducts){
            Apttus_CPQApi.CPQ.SelectedProductDO prodDO = new Apttus_CPQApi.CPQ.SelectedProductDO();
            prodDO.ProductId = bundleProd;
            prodDO.Quantity = 1;
            prodDO.SellingTerm = 1;
            selectedProdDOList.add(prodDO);
            
        }
        requests.SelectedProducts = selectedProdDOList;
        Apttus_CPQApi.CPQ.AddMultiProductResponseDO response = Apttus_CPQApi.CPQWebService.addMultiProducts(requests);
        system.debug('-----------'+response);
        
        Apttus_CPQApi.CPQ.UpdatePriceRequestDO req = new Apttus_CPQApi.CPQ.UpdatePriceRequestDO();
        req.CartId = productConfigurationId;
        
        Apttus_CPQApi.CPQ.UpdatePriceResponseDO priceResponse = Apttus_CPQApi.CPQWebService.updatePriceForCart(req);
        system.debug('-----------'+priceResponse);
        
        Apttus_CPQApi.CPQ.FinalizeCartRequestDO finalrequest = new Apttus_CPQApi.CPQ.FinalizeCartRequestDO();
        finalrequest.CartId = productConfigurationId;
        
        Apttus_CPQApi.CPQ.FinalizeCartResponseDO FinalResponse = Apttus_CPQApi.CPQWebService.finalizeCart(finalrequest);
        
        system.debug('----------- FinalResponse: ' + FinalResponse);
        
        Apttus_Proposal__Proposal__c proposal = new Apttus_Proposal__Proposal__c(id=proposalId, APTS_Execute_Batch__c = true);
        update proposal;
        
        //GenerateDocbatch oGenerateDocbatch = new GenerateDocbatch(APTS_Constants.DEFAULT_QUOTE_TEMPLATE_ID, proposalId, 'Full Access', 'PDF', True, UserInfo.getSessionId(), PARTNER_SERVER_URL_140);
        
        
        //System.debug(System.LoggingLevel.ERROR ,'-----enqueueJob Id : '  + System.enqueueJob(oGenerateDocbatch));
        
        System.debug(System.LoggingLevel.ERROR ,'-----Updated proposal : '  + proposal);

        //Database.executeBatch(new GenerateDocbatch('a0E41000000Xgye',proposalId,'Full Access','PDF',True,UserInfo.getSessionId(),PARTNER_SERVER_URL_140),1);      
        
    }
   
   
        
 }