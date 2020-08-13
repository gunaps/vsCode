@isTest
public class APT_CartValidationCallBackTest{
  
    static testMethod void cartValidationOnlyAddOn() {
        
        //Create Cart
        Apttus_Proposal__Proposal__c prop = [select id from Apttus_Proposal__Proposal__c Limit 1];
        List<Product2>  listProduct = [Select id from Product2 where name = 'X-Author'] ;

        Id cartId = APTS_TestDataSetup.createCart(prop.Id);         

        //Add Products to cart
        Apttus_CPQApi.CPQ.AddMultiProductRequestDO request2 = new Apttus_CPQApi.CPQ.AddMultiProductRequestDO ();
        request2.CartId = cartId;
        request2.SelectedProducts = new List<Apttus_CPQApi.CPQ.SelectedProductDO>();
        for(Product2 productSO : listProduct)
            {request2.SelectedProducts.add(APTS_TestDataSetup.createSelectProductDo(productSO.Id, 1, Date.today(), Date.today().addMonths(36), 4));}
        Apttus_CPQApi.CPQ.AddMultiProductResponseDO  response2 = Apttus_CPQApi.CPQWebService.addMultiProducts(request2);		
        Test.startTest();
        Apttus_Config2.CustomClass.ValidationResult result = Apttus_Config2.CPQWebService.validateCart(cartId);
        system.debug('***** Result : '+ result.IsSuccess);
        system.debug('***** Messages '+ result.Messages);
        //System.assert(Result.IsSuccess);
        Test.stopTest();
    }
    
    static testMethod void cartValidation() {
        
        //Create Cart
        Apttus_Proposal__Proposal__c prop = [select id from Apttus_Proposal__Proposal__c Limit 1];
        List<Product2>  listProduct = [Select id from Product2] ;

        Id cartId = APTS_TestDataSetup.createCart(prop.Id);         

        //Add Products to cart
        Apttus_CPQApi.CPQ.AddMultiProductRequestDO request2 = new Apttus_CPQApi.CPQ.AddMultiProductRequestDO ();
        request2.CartId = cartId;
        request2.SelectedProducts = new List<Apttus_CPQApi.CPQ.SelectedProductDO>();
        for(Product2 productSO : listProduct)
            {request2.SelectedProducts.add(APTS_TestDataSetup.createSelectProductDo(productSO.Id, 1, Date.today(), Date.today().addMonths(36), 4));}
        Apttus_CPQApi.CPQ.AddMultiProductResponseDO  response2 = Apttus_CPQApi.CPQWebService.addMultiProducts(request2);        
        Test.startTest();
        Apttus_Config2.CustomClass.ValidationResult result = Apttus_Config2.CPQWebService.validateCart(cartId);
        system.debug('***** Result : '+ result.IsSuccess);
        system.debug('***** Messages '+ result.Messages);
        //System.assert(Result.IsSuccess);
        Test.stopTest();
    }

    static testMethod void cartValidationDifferentQuantity() {
        
        //Create Cart
        delete [select id from Apttus_Config2__AssetLineItem__c];
        Apttus_Proposal__Proposal__c prop = [select id from Apttus_Proposal__Proposal__c Limit 1];
        Product2  productSO2 = [Select id from Product2 where name = 'Sprint CPQ'] ;
        Product2  productSO1 = [Select id from Product2 where name = 'X-Author'] ;
        Id cartId = APTS_TestDataSetup.createCart(prop.Id);         

        //Add Products to cart
        Apttus_CPQApi.CPQ.AddMultiProductRequestDO request2 = new Apttus_CPQApi.CPQ.AddMultiProductRequestDO ();
        request2.CartId = cartId;
        request2.SelectedProducts = new List<Apttus_CPQApi.CPQ.SelectedProductDO>();
        request2.SelectedProducts.add(APTS_TestDataSetup.createSelectProductDo(productSO1.Id, 3, Date.today(), Date.today().addMonths(36), 4));
        request2.SelectedProducts.add(APTS_TestDataSetup.createSelectProductDo(productSO1.Id, 3, Date.today(), Date.today().addMonths(36), 4));
        request2.SelectedProducts.add(APTS_TestDataSetup.createSelectProductDo(productSO1.Id, 3, Date.today(), Date.today().addMonths(36), 4));
        request2.SelectedProducts.add(APTS_TestDataSetup.createSelectProductDo(productSO2.Id, 1, Date.today(), Date.today().addMonths(36), 4));
        Apttus_CPQApi.CPQ.AddMultiProductResponseDO  response2 = Apttus_CPQApi.CPQWebService.addMultiProducts(request2);        
        Test.startTest();
        Apttus_Config2.CustomClass.ValidationResult result = Apttus_Config2.CPQWebService.validateCart(cartId);
        system.debug('***** Result : '+ result.IsSuccess);
        system.debug('***** Messages '+ result.Messages);
        //System.assert(Result.IsSuccess);
        Test.stopTest();
    }

    static testMethod void cartValidationMethods() {
        Test.startTest();
        APT_CartValidationCallBack callBackClass = new APT_CartValidationCallBack();
        callBackClass.validateAssetItems(null, null);
        callBackClass.validateRampLineItems(null, null);
        Test.stopTest();
    }
    
    @testSetup
    static void testDataSetup() {
        
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
        Apttus_Proposal__Proposal__c prop = APTS_TestDataSetup.createProposal(account.ID, opp.Id, priceList.Id);       
        insert prop;
        
        List<Product2> listProduct = new list<Product2>();
        listProduct.add(APTS_TestDataSetup.createProduct('Sprint CPQ', 'Products', 'Standalone'));
        listProduct.add(APTS_TestDataSetup.createProduct('X-Author', 'Products', 'Standalone'));
        //listProduct.add(APTS_TestDataSetup.createProduct('ABCD', 'Products', 'Option'));
        //listProduct.add(APTS_TestDataSetup.createProduct('ABCDE', 'Products', 'Standalone'));        
        
        insert listProduct;
        
        //create PriceListIteams
        List<Apttus_Config2__PriceListItem__c> listPLI = new List<Apttus_Config2__PriceListItem__c>();
        listPLI.add(APTS_TestDataSetup.createPriceListItem(pricelist.Id, listProduct[0].ID));
        listPLI.add(APTS_TestDataSetup.createPriceListItem(pricelist.Id, listProduct[1].Id));
        //listPLI.add(APTS_TestDataSetup.createPriceListItem(pricelist.Id, listProduct[2].Id));
        //listPLI.add(APTS_TestDataSetup.createPriceListItem(pricelist.Id, listProduct[3].Id));
        insert listPLI;

        List<Apttus_Config2__AssetLineItem__c> listAssetLineItem = new  List<Apttus_Config2__AssetLineItem__c>();
        listAssetLineItem.add(APTS_TestDataSetup.createAssetLineItem(account.ID , listPLI[0].Id , listProduct[0].ID ,null, 1, 1, 'Product/Service',100, 'Sprint CPQ', 3));
        listAssetLineItem.add(APTS_TestDataSetup.createAssetLineItem(account.ID , listPLI[1].Id , listProduct[1].ID ,null, 1, 2, 'Product/Service',100,'X-Author', 5));
        //listAssetLineItem.add(APTS_TestDataSetup.createAssetLineItem(account.ID , listPLI[2].Id , listProduct[3].ID ,null, 1, 2, 'Product/Service',100,'ABCD'));
        //listAssetLineItem.add(APTS_TestDataSetup.createAssetLineItem(account.ID , listPLI[3].Id , listProduct[3].ID ,null, 1, 1, 'Product/Service',100, 'ABCDE'));
        insert listAssetLineItem;

        system.debug('Assets: '+[select Name, Apttus_Config2__Quantity__c from Apttus_Config2__AssetLineItem__c] );
                
    }
}