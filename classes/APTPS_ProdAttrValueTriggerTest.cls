/*************************************************************************
 * Author: Shubham Bhatt, 07/02/2017 (7th FEB) 
 * Purpose: this class contains test cases for APTPS_ProdAttrValueTrigger
 *************************************************************************/
@isTest
public with sharing class APTPS_ProdAttrValueTriggerTest {
    
    
        static testMethod void testSetPAV2ValuesHandler() {
        
        Apttus_Config2__PriceList__c priceList = createPriceList();
        ID priceListId = priceList.id;
        
        Account accnt = createAccount();
        ID accId = accnt.id;
        

        
        Opportunity oppty = createOpportunity(accnt);
        ID opptyId = oppty.id;
        
        Apttus_Proposal__Proposal__c proposal = createApttusProposal(accId, opptyId, priceListId);
        ID propId = proposal.id;
        
        Product2 bundleProd = createProduct('Test Legacy Attributes Product 1');
        ID bundleProdId = bundleProd.id;
        
        Product2 optionProd = createProduct('Test Legacy Attributes Option Product 1');
        ID optionProdId = optionProd.id;
        
        List<Product2> prodSOList = new List<Product2>();
        prodSOList.add(bundleProd);
        prodSOList.add(optionProd);
        
        Apttus_Config2__AssetLineItem__c ali = createAssetLineItem(bundleProdId);
        ID aliId = ali.Id;

        Apttus_Config2__ProductConfiguration__c configuration = createProductConfiguration(propId, priceListId);
        ID cfgId = configuration.id;
        
        Apttus_Config2__PriceListItem__c pliSO = createPriceListItem(priceList, prodSOList[0], 150.00, 'Standard Price', 
            'Recurring', 'Flat Price', '% Discount', 10, 'List Price', 5, 'MRC');
        
                List<Apttus_Config2__LineItem__c> liSOList = new List<Apttus_Config2__LineItem__c>();
        
        Apttus_Config2__LineItem__c li1SO = createLineItem(prodSOList[0], null, cfgId, 1, 1, 1, 'Product/Service', 
            priceList, pliSO, true, null, 2, 'New', null, System.today(),System.today().addDays(365));
        li1SO.Apttus_Config2__ItemSequence__c = 99999;
        li1SO.Apttus_Config2__LineNumber__c = 99999;
        li1SO.Apttus_Config2__ConfigurationId__c = cfgId;
        li1SO.Apttus_Config2__ChargeType__c = 'MRC';
        li1SO.Apttus_Config2__AssetLineItemId__c = aliId;
        liSOList.add(li1SO);

        Apttus_Config2__LineItem__c li2SO = createLineItem(prodSOList[0], prodSOList[1], cfgId, 1, 1, 1, 'Option', 
            priceList, pliSO, true, null, 2, 'New', null, System.today(),System.today().addDays(365));
        li2SO.Apttus_Config2__ItemSequence__c = 99998;
        li2SO.Apttus_Config2__LineNumber__c = 99999;
        li2SO.Apttus_Config2__ConfigurationId__c = cfgId;
        li2SO.Apttus_Config2__ChargeType__c = 'MRC';
        liSOList.add(li2SO);
        
        insert liSOList;
        
        Apttus_Config2__AssetAttributeValue__c aav = createAAV(aliId);
        ID aavId = aav.Id;
        
        update aav;
        
        ali.Apttus_Config2__AttributeValueId__c = aav.id;
        update ali;
        
        System.debug('Start of the main test');
        Test.startTest();
        Apttus_Config2__ProductAttributeValue__c pav = createPav(li1SO.Id, '12 Months');
        List<Apttus_Config2__ProductAttributeValue__c> prodAttrValuesList = new List<Apttus_Config2__ProductAttributeValue__c>();
        prodAttrValuesList.add(pav);
        update pav; 
        //APTPS_ProdAttrValueTriggerHandler.setPAV2Values(prodAttrValuesList);
        Test.stopTest();
        
        //PAV
        Apttus_Config2__ProductAttributeValue__c queriedPav = 
            [SELECT Id
             FROM Apttus_Config2__ProductAttributeValue__c 
             WHERE Apttus_Config2__LineItemId__r.Apttus_Config2__AssetLineItemId__c =:aliId];
        
        
        System.debug('End of Product Attribute Value Trigger Test!');
        
    }
    
    
    
    static testMethod void testSetPAV2Values() {
        
        Apttus_Config2__PriceList__c priceList = createPriceList();
        ID priceListId = priceList.id;
        
        Account accnt = createAccount();
        ID accId = accnt.id;
        
        
        Opportunity oppty = createOpportunity(accnt);
        ID opptyId = oppty.id;
        
        Apttus_Proposal__Proposal__c proposal = createApttusProposal(accId, opptyId, priceListId);
        ID propId = proposal.id;
        
        Product2 bundleProd = createProduct('Test Legacy Attributes Product 1');
        ID bundleProdId = bundleProd.id;
        
        Product2 optionProd = createProduct('Test Legacy Attributes Option Product 1');
        ID optionProdId = optionProd.id;
        
        List<Product2> prodSOList = new List<Product2>();
        prodSOList.add(bundleProd);
        prodSOList.add(optionProd);
        
        Apttus_Config2__AssetLineItem__c ali = createAssetLineItem(bundleProdId);
        ID aliId = ali.Id;

        Apttus_Config2__ProductConfiguration__c configuration = createProductConfiguration(propId, priceListId);
        ID cfgId = configuration.id;
        
        Apttus_Config2__PriceListItem__c pliSO = createPriceListItem(priceList, prodSOList[0], 150.00, 'Standard Price', 
            'Recurring', 'Flat Price', '% Discount', 10, 'List Price', 5, 'MRC');
        
                List<Apttus_Config2__LineItem__c> liSOList = new List<Apttus_Config2__LineItem__c>();
        
        Apttus_Config2__LineItem__c li1SO = createLineItem(prodSOList[0], null, cfgId, 1, 1, 1, 'Product/Service', 
            priceList, pliSO, true, null, 2, 'New', null, System.today(),System.today().addDays(365));
        li1SO.Apttus_Config2__ItemSequence__c = 99999;
        li1SO.Apttus_Config2__LineNumber__c = 99999;
        li1SO.Apttus_Config2__ConfigurationId__c = cfgId;
        li1SO.Apttus_Config2__ChargeType__c = 'MRC';
        li1SO.Apttus_Config2__AssetLineItemId__c = aliId;
        liSOList.add(li1SO);

        Apttus_Config2__LineItem__c li2SO = createLineItem(prodSOList[0], prodSOList[1], cfgId, 1, 1, 1, 'Option', 
            priceList, pliSO, true, null, 2, 'New', null, System.today(),System.today().addDays(365));
        li2SO.Apttus_Config2__ItemSequence__c = 99998;
        li2SO.Apttus_Config2__LineNumber__c = 99999;
        li2SO.Apttus_Config2__ConfigurationId__c = cfgId;
        li2SO.Apttus_Config2__ChargeType__c = 'MRC';
        liSOList.add(li2SO);
        
        insert liSOList;
        
        Apttus_Config2__AssetAttributeValue__c aav = createAAV(aliId);
        ID aavId = aav.Id;
        
        update aav;
        
        ali.Apttus_Config2__AttributeValueId__c = aav.id;
        update ali;
        
        System.debug('Start of the main test');
        Test.startTest();
        Apttus_Config2__ProductAttributeValue__c pav = createPav(li1SO.Id, '12 Months');
        Test.stopTest();
        
        //PAV
        Apttus_Config2__ProductAttributeValue__c queriedPav = 
            [SELECT Id 
             FROM Apttus_Config2__ProductAttributeValue__c 
             WHERE Apttus_Config2__LineItemId__r.Apttus_Config2__AssetLineItemId__c =:aliId];

        System.debug('End of Product Attribute Value Trigger Test!');
        
    }
    
    
   //auxiliary methods 
   
    private static Account createAccount() {
        Account account = new Account();
        account.Name = 'Test Legacy Attributes';
        insert account;
        return account;
    }
    
    private static Apttus_Config2__PriceList__c createPriceList(){
        Apttus_Config2__PriceList__c priceList = new Apttus_Config2__PriceList__c();
        priceList.Name = 'Test Legacy Attributes PriceList';
        insert priceList;
        return priceList;
    }
    
    private static Opportunity createOpportunity(Account accnt) {
        Opportunity opp = new Opportunity();
        opp.Account = accnt;
        opp.Name = 'Test Legacy Attributes Oppty';
        opp.StageName = 'Identified';
        opp.CloseDate = system.today();
        insert opp;
        return opp;
    }
    
    private static Apttus_Proposal__Proposal__c createApttusProposal(ID accId, ID opptyId, ID priceListId) {
        Apttus_Proposal__Proposal__c proposal = new Apttus_Proposal__Proposal__c();
        proposal.Apttus_Proposal__Proposal_Name__c = 'Test Legacy Attributes 1';
        proposal.Apttus_Proposal__Opportunity__c = opptyId;
        proposal.Apttus_Proposal__Account__c = accId;
        proposal.Apttus_QPConfig__PriceListId__c = priceListId;
        insert proposal;
        return proposal;
    }
    
    private static Product2 createProduct(String name) {
        Product2 product = new Product2();
        product.Name = name;
        insert product;
        return product;
    }
    
    private static Apttus_Config2__ProductConfiguration__c createProductConfiguration(ID propId, ID priceListId) {
        Apttus_Config2__ProductConfiguration__c configuration = new Apttus_Config2__ProductConfiguration__c();
        configuration.Name = 'Test Legacy Attributes Cfg';
        configuration.Apttus_QPConfig__Proposald__c = propId;
        configuration.Apttus_Config2__PriceListId__c = priceListId;
        insert configuration;
        return configuration;
    }

    private static Apttus_Config2__ProductAttributeValue__c createPav(ID liSOId, String serviceTerm){
        Apttus_Config2__ProductAttributeValue__c pav = new Apttus_Config2__ProductAttributeValue__c();
        pav.Apttus_Config2__LineItemId__c = liSOId;
        insert pav;
        return pav;
    }
    
    private static Apttus_Config2__PriceListItem__c createPriceListItem(Apttus_Config2__PriceList__c priceList, 
        Product2 prodSO, Decimal listPrice, string cType,String priceType, String priceMethod, String relatedAdjType, 
        Decimal relatedAdjAmt, String relatedAdjAmtAppliesTo, Decimal defaultQuant, String chargeType) {
        Apttus_Config2__PriceListItem__c pliSO = new Apttus_Config2__PriceListItem__c();
        pliSO.Apttus_Config2__Active__c = true;
        pliSO.Apttus_Config2__PriceType__c = 'One Time';
        if(priceType=='Recurring'){
          pliSO.Apttus_Config2__Frequency__c = 'Yearly';
        }
        pliSO.Apttus_Config2__ChargeType__c = chargeType;
        pliSO.Apttus_Config2__ListPrice__c = listPrice;
        pliSO.Apttus_Config2__PriceListId__c = priceList.ID;
        pliSO.Apttus_Config2__PriceMethod__c = priceMethod;
        pliSO.Apttus_Config2__PriceUom__c = 'Each';
        pliSO.Apttus_Config2__ProductId__c = prodSO.ID;
        pliSO.Apttus_Config2__RelatedAdjustmentType__c=relatedAdjType;
        pliSO.Apttus_Config2__RelatedAdjustmentAmount__c=relatedAdjAmt;
        pliSO.Apttus_Config2__RelatedAdjustmentAppliesTo__c=relatedAdjAmtAppliesTo;
        pliSO.Apttus_Config2__DefaultQuantity__c=defaultQuant;
        return pliSO;
    }
    
    private static Apttus_Config2__LineItem__c createLineItem(Product2 prodSO, Product2 optProdSO, ID cartID, 
        Decimal itemSeq, Decimal lineNum, Decimal primaryLineNum, string lineType, Apttus_Config2__PriceList__c plSO, 
        Apttus_Config2__PriceListItem__c pliSO, Boolean isPrimaryLine, Decimal parentBundleLineNumber, Decimal quant, 
        String lineStatus, Apttus_Config2__AssetLineItem__c aliSO, Date startDate, Date endDate) {
        
        Apttus_Config2__LineItem__c liSO = new Apttus_Config2__LineItem__c();
        liSO.Apttus_Config2__ConfigurationId__c = cartID;
        liSO.Apttus_Config2__ProductId__c = prodSO.ID;
        if(optProdSO != null) {
            liSO.Apttus_Config2__OptionId__c = optProdSO.ID;
        }
        liSO.Apttus_Config2__ChargeType__c = pliSO.Apttus_Config2__ChargeType__c;
            liSO.Apttus_Config2__IsPrimaryLine__c = isPrimaryLine;
            liSO.Apttus_Config2__IsPrimaryRampLine__c = isPrimaryLine;
            liSO.Apttus_Config2__ItemSequence__c = itemSeq;
            liSO.Apttus_Config2__LineNumber__c  = lineNum;
            liSO.Apttus_Config2__PrimaryLineNumber__c = primaryLineNum;
            liSO.Apttus_Config2__LineStatus__c = lineStatus;
            liSO.Apttus_Config2__LineType__c = lineType;
            liSO.Apttus_Config2__StartDate__c = startDate;
            liSO.Apttus_Config2__EndDate__c = endDate;
            liSO.Apttus_Config2__SellingTerm__c = 1;
            liSO.Apttus_Config2__PriceListId__c = plSO.ID;
            liSO.Apttus_Config2__PriceListItemId__c = pliSO.ID;
            liSO.Apttus_Config2__PriceType__c = pliSO.Apttus_Config2__PriceType__c;
            liSO.Apttus_Config2__PriceMethod__c = pliSO.Apttus_Config2__PriceMethod__c;
            liSO.Apttus_Config2__SellingFrequency__c = pliSO.Apttus_Config2__PriceMethod__c;
            liSO.Apttus_Config2__PricingStatus__c = 'Pending';
            liSO.Apttus_Config2__ListPrice__c = pliSO.Apttus_Config2__ListPrice__c;
            liSO.Apttus_Config2__BasePrice__c = pliSO.Apttus_Config2__ListPrice__c;
            liSO.Apttus_Config2__ExtendedPrice__c = pliSO.Apttus_Config2__ListPrice__c;
            liSO.Apttus_Config2__NetPrice__c = pliSO.Apttus_Config2__ListPrice__c;
        if(parentBundleLineNumber != null) {
            liSO.Apttus_Config2__ParentBundleNumber__c = parentBundleLineNumber;
        }
            liSO.Apttus_Config2__Quantity__c=quant;
        if(aliSO!=null){
            liSO.Apttus_Config2__AssetLineItemId__c=aliSO.Id;
            liSO.Apttus_Config2__AssetQuantity__c=aliSO.Apttus_Config2__Quantity__c;
        }
        return liSO;
    } 

    private static Apttus_Config2__AssetLineItem__c createAssetLineItem(ID prodId) {
        Apttus_Config2__AssetLineItem__c ali = new Apttus_Config2__AssetLineItem__c();
        ali.Apttus_Config2__ProductId__c = prodId;
        insert ali;
        return ali;
    }
    

    
    private static Apttus_Config2__AssetAttributeValue__c createAAV(ID aliId){
        Apttus_Config2__AssetAttributeValue__c aav = new Apttus_Config2__AssetAttributeValue__c();
        aav.Apttus_Config2__AssetLineItemId__c = aliId;
        insert aav;
        return aav;
    }
    

    

}