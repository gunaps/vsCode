@isTest
public class APTS_PricingCallBackTest {
    
    static testMethod void pricingcallbackTest() {
        
        Apttus_Config2__ProductConfiguration__c configuration = [select Id from Apttus_Config2__ProductConfiguration__c Limit 1];
        system.debug('===>Before '+Database.query(APTS_TestDataSetup.getQueryStringWithAllFields('Apttus_Config2__LineItem__c',null,null)));
        Test.startTest();
        Apttus_Config2.PricingWebService.computeTotalPriceForCart(configuration.Id);
        Apttus_Config2.PricingWebService.updatePriceForCart(configuration.Id);
        Test.stopTest();
        system.debug('===>After '+Database.query(APTS_TestDataSetup.getQueryStringWithAllFields('Apttus_Config2__LineItem__c',null,null)));
        
    }
    
    static testMethod void pricingcallbackChannelDistributor() {
        
        Account accountSO = [Select Id, type, Is_Premium__c from Account Limit 1];
        accountSO.type = 'Channel Distributor';
        accountSO.Is_Premium__c = false;
        update accountSO;
        
        Apttus_Proposal__Proposal__c proposalSO = [select id,Apttus_Proposal__Account__c  from Apttus_Proposal__Proposal__c Limit 1];
        proposalSO.Apttus_Proposal__Account__c = accountSO.ID;
        update proposalSO;        
        
        
        Apttus_Config2__ProductConfiguration__c configuration = [select Id from Apttus_Config2__ProductConfiguration__c Limit 1];
        system.debug('===>Before '+Database.query(APTS_TestDataSetup.getQueryStringWithAllFields('Apttus_Config2__LineItem__c',null,null)));
        Test.startTest();
        Apttus_Config2.PricingWebService.computeTotalPriceForCart(configuration.Id);
        Apttus_Config2.PricingWebService.updatePriceForCart(configuration.Id);
        Test.stopTest();
        system.debug('===>After '+Database.query(APTS_TestDataSetup.getQueryStringWithAllFields('Apttus_Config2__LineItem__c',null,null)));
        
    } 
    
    static testMethod void pricingcallbackPremiumChannelDistributor() {
        
        Account accountSO = [Select Id, type, Is_Premium__c from Account Limit 1];
        accountSO.type = 'Channel Distributor';
        accountSO.Is_Premium__c = true;
        update accountSO; 
        
        Apttus_Config2__ProductConfiguration__c configuration = [select Id from Apttus_Config2__ProductConfiguration__c Limit 1];
        system.debug('===>Before '+Database.query(APTS_TestDataSetup.getQueryStringWithAllFields('Apttus_Config2__LineItem__c',null,null)));
        
        Test.startTest();
        Apttus_Config2.PricingWebService.computeTotalPriceForCart(configuration.Id);
        Apttus_Config2.PricingWebService.updatePriceForCart(configuration.Id);
        Test.stopTest();
        system.debug('===>After '+Database.query(APTS_TestDataSetup.getQueryStringWithAllFields('Apttus_Config2__LineItem__c',null,null)));
        
    }
    
    @testSetup 
    static void setupTest(){
        
        APTS_TestDataSetup.createAllCustomSetting();
        
        //Insert Account
        Account account = APTS_TestDataSetup.createAccount('Test Account', true);
        insert account;
        
        //Insert Price List
        Apttus_Config2__PriceList__c pricelist = APTS_TestDataSetup.createPriceList('Test Price List');
        insert pricelist;
        
        //Insert Opportunity
        Opportunity opp = APTS_TestDataSetup.createOpportunity('Test Opportunity', account.Id, 'Prospecting' );
        insert opp;
        
        //Create Proposal
        Apttus_Proposal__Proposal__c proposalSO = APTS_TestDataSetup.createProposal(account.ID, opp.Id, priceList.Id);
        proposalSO.Apttus_Proposal__Account__c = null;       
        insert proposalSO;
        
        List<Product2> listProduct = new list<Product2>();
        listProduct.add(APTS_TestDataSetup.createProduct('Product1', 'Products', 'Standalone'));
        listProduct.add(APTS_TestDataSetup.createProduct('Product2', 'Products', 'Standalone'));
        insert listProduct;
        
        //create PriceListIteams
        List<Apttus_Config2__PriceListItem__c> listPLI = new List<Apttus_Config2__PriceListItem__c>();
        listPLI.add(APTS_TestDataSetup.createPriceListItem(pricelist.Id, listProduct[0].ID));
        listPLI.add(APTS_TestDataSetup.createPriceListItem(pricelist.Id, listProduct[1].Id));
        insert listPLI;
        
        //create Cart
        Id cartId = APTS_TestDataSetup.createCart(proposalSO.Id);           
        
        //Add Products to cart
        Apttus_CPQApi.CPQ.AddMultiProductRequestDO request2 = new Apttus_CPQApi.CPQ.AddMultiProductRequestDO ();
        request2.CartId = cartId;
        request2.SelectedProducts = new List<Apttus_CPQApi.CPQ.SelectedProductDO>();
        request2.SelectedProducts.add(APTS_TestDataSetup.createSelectProductDo(listProduct[0].Id, 1, Date.today(), Date.today().addMonths(36), 4));
        request2.SelectedProducts.add(APTS_TestDataSetup.createSelectProductDo(listProduct[1].Id, 1, Date.today(), Date.today().addMonths(36), 4));        
        Apttus_CPQApi.CPQ.AddMultiProductResponseDO  response2 = Apttus_CPQApi.CPQWebService.addMultiProducts(request2);
        
    }
}