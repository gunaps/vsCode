@isTest
public class APTS_OrderLIAndUsageInputHandlerTest {
    
    
	@isTest 
    static void usageServiceTest(){
        
        APTS_TestDataSetup.createAllCustomSetting();
        
        //Insert Account
        Account account = APTS_TestDataSetup.createAccount('Test Account', true);
        insert account;
        
        Apttus_Config2__AccountLocation__c accLoc = createAccountLocation(account.Id);
        
        //Insert Price List
        Apttus_Config2__PriceList__c pricelist = APTS_TestDataSetup.createPriceList('Test Price List');
        insert pricelist;
        
        //Insert Opportunity
        Opportunity opp = APTS_TestDataSetup.createOpportunity('Test Opportunity', account.Id, 'Prospecting' );
        insert opp;
        
        Apttus_Revenue2__RevRec_Period__c revRecPeriodHodler = createRevRecPeriod();
		Apttus_Config2__RevRecPolicy__c revRecPolicyRatable = createRevRecPolicy('Ratable - Month');
        // Create Master Data
        Pricebook2 pb = createPriceBook();
        Apttus_Config2__PaymentTerm__c pt = createPaymentTerm();
        //Create Proposal
        Apttus_Proposal__Proposal__c proposalSO = APTS_TestDataSetup.createProposal(account.ID, opp.Id, priceList.Id);
        proposalSO.Apttus_Proposal__Account__c = null;       
        insert proposalSO;
        
        List<Product2> listProduct = new list<Product2>();
        listProduct.add(APTS_TestDataSetup.createProduct('Product1', 'Products', 'Standalone'));
        listProduct.add(APTS_TestDataSetup.createProduct('Product2', 'Products', 'Standalone'));
        insert listProduct;
        
        Apttus_Config2__BillingPreference__c bp = createBillingPreference();
        Apttus_Config2__RevRecPolicy__c revRecPolicyImmediate = createRevRecPolicy('Immediate');
        //create PriceListIteams
        List<Apttus_Config2__PriceListItem__c> listPLI = new List<Apttus_Config2__PriceListItem__c>();
        listPLI.add(createPriceListItem(pricelist.Id, listProduct[0].ID,'Recurring', revRecPolicyRatable.Id));
        listPLI.add(createPriceListItem(pricelist.Id, listProduct[0].Id, 'Usage', revRecPolicyImmediate.Id));
        
        
       
        Apttus_Config2__Order__c order = createOrder(account.Id, pricelist.Id, accLoc.Id, bp.Id);

        List<Apttus_Config2__OrderLineItem__c> orderLineIList = new List<Apttus_Config2__OrderLineItem__c>();
		
        test.startTest();
        Apttus_Config2__OrderLineItem__c orderLIRecurring = createOrderLI(order.Id, listProduct[0].Id, proposalSO.Id);
        orderLIRecurring.Apttus_Config2__StartDate__c = Date.today();
        orderLIRecurring.Apttus_Config2__EndDate__c = Date.today().addMonths(12).addDays(-1);
        orderLIRecurring.Apttus_Config2__PriceType__c = 'Recurring';
        orderLIRecurring.Apttus_Config2__PriceListItemId__c = listPLI[0].Id;
        orderLIRecurring.Apttus_Config2__RevRecPolicyId__c = revRecPolicyImmediate.Id;
        orderLIRecurring.Apttus_Config2__ReadyForRevRecDate__c = Datetime.now();
        orderLIRecurring.Apttus_Config2__BillingFrequency__c = 'Monthly';
        orderLIRecurring.Apttus_Config2__BillingRule__c = 'Bill In Advance';
        orderLIRecurring.Apttus_Config2__SellingFrequency__c = 'Monthly';
        orderLIRecurring.Apttus_Config2__SellingTerm__c = 12;
        orderLIRecurring.Apttus_Config2__PriceUom__c = 'Each';
        orderLIRecurring.Apttus_Config2__Uom__c = 'Each';
        orderLIRecurring.Apttus_Config2__Quantity__c = 1;
        orderLIRecurring.Apttus_Config2__NetPrice__c = 1000;
        orderLineIList.add(orderLIRecurring);
        
        Apttus_Config2__OrderLineItem__c orderLIUsage = createOrderLI(order.Id, listProduct[0].Id, proposalSO.Id);
        orderLIUsage.Apttus_Config2__StartDate__c = Date.today();
        orderLIUsage.Apttus_Config2__EndDate__c = Date.today().addMonths(12).addDays(-1);
        orderLIUsage.Apttus_Config2__PriceType__c = 'Usage';
        orderLIUsage.Apttus_Config2__PriceListItemId__c = listPLI[1].Id;
        orderLIUsage.Apttus_Config2__RevRecPolicyId__c = revRecPolicyImmediate.Id;
        orderLIUsage.Apttus_Config2__ReadyForRevRecDate__c = Datetime.now();
        orderLIUsage.Apttus_Config2__BillingFrequency__c = 'Monthly';
        orderLIUsage.Apttus_Config2__BillingRule__c = 'Bill In Arrears';
        orderLIUsage.Apttus_Config2__SellingFrequency__c = 'Monthly';
        orderLIUsage.Apttus_Config2__SellingTerm__c = 12;
        orderLIUsage.Apttus_Config2__PriceUom__c = 'Each';
        orderLIUsage.Apttus_Config2__Uom__c = 'Each';
        orderLIUsage.Apttus_Config2__Quantity__c = 1;
        orderLIUsage.Apttus_Config2__NetPrice__c = 0;
        orderLineIList.add(orderLIUsage);

        update orderLineIList;
        createAsset(order.Id);

        Apttus_Config2__AssetLineItem__c assetLineItem = [SELECT Id, Apttus_Config2__BillingPreferenceId__c, Apttus_Config2__PriceType__c FROM Apttus_Config2__AssetLineItem__c WHERE Apttus_Config2__PriceType__c = 'Usage' LIMIT 1];  
        Apttus_Config2__AssetLineItem__c assetLineItem2 = [SELECT Id, Apttus_Config2__BillingPreferenceId__c, Apttus_Config2__PriceType__c FROM Apttus_Config2__AssetLineItem__c WHERE Apttus_Config2__PriceType__c = 'Recurring' LIMIT 1];

        List<Apttus_Config2__AssetLineItem__c> assetLIList = new List<Apttus_Config2__AssetLineItem__c>();
        assetLineItem.Apttus_Config2__BillingPreferenceId__c = bp.Id;
        assetLIList.add(assetLineItem);
        assetLineItem2.Apttus_Config2__BillingPreferenceId__c = bp.Id;
        assetLIList.add(assetLineItem2);
        update assetLIList;

        for (Apttus_Config2__OrderLineItem__c orderLineItem : orderLineIList) {
            orderLineItem.Apttus_Config2__ActivatedDate__c = Datetime.now();
            orderLineItem.Apttus_Config2__ReadyForBillingDate__c = Datetime.now();
        }
        if (orderLineIList.size()>0) update orderLineIList;

        Apttus__APTS_Agreement__c agreementHeader = [SELECT Id FROM Apttus__APTS_Agreement__c LIMIT 1];
		system.debug('agreementHeader'+agreementHeader);
        Map<Integer,Apttus_Revenue2__Agreement_Fee__c> agrFeeMap = new Map<Integer,Apttus_Revenue2__Agreement_Fee__c>(); 
        Map<Integer,List<Apttus_Revenue2__Agreement_Fee_Schedule__c>> feeSchMap = new Map<Integer,List<Apttus_Revenue2__Agreement_Fee_Schedule__c>>();
        Integer count = 1;
        for (Apttus_Config2__OrderLineItem__c orderLineItem : orderLineIList) {
            if (orderLineItem.Apttus_Config2__PriceType__c == 'Usage') {
                orderLineItem.Apttus_Config2__AssetLineItemId__c = assetLineItem.Id;


                Apttus_Revenue2__Agreement_Fee__c agreementFee = new Apttus_Revenue2__Agreement_Fee__c();
                agreementFee.Apttus_Revenue2__Agreement__c = agreementHeader.Id;
                agreementFee.Apttus_Revenue2__Deferred_Balance_Amount__c = orderLIRecurring.Apttus_Config2__NetPrice__c;

                
                //agreementFee.CurrencyIsoCode = orderLineItem.CurrencyIsoCode;
                agreementFee.Apttus_Revenue2__IsActive__c = true;
                agreementFee.Apttus_Revenue2__Revenue_Type__c = 'Product';
                agreementFee.Apttus_Revenue2__Revenue_Subtype__c = 'Other';
                agreementFee.Apttus_Revenue2__Fee_Type__c = 'Per Unit';
                agreementFee.Apttus_Revenue2__Unit_Price__c = 1.00;
                agreementFee.Apttus_Revenue2__RevRec_Rule__c = 'Immediate';
                agreementFee.Apttus_Revenue2__One_Time_Recurring__c = 'Recurring';
                agreementFee.Apttus_Revenue2__Frequency__c = 'Monthly';
                agreementFee.Apttus_Revenue2__Fixed_Start_Date__c = orderLineItem.Apttus_Config2__StartDate__c;
                agreementFee.Apttus_Revenue2__Fixed_End_Date__c = orderLineItem.Apttus_Config2__EndDate__c;
                agreementFee.Apttus_RVConfig__OrderId__c = orderLineItem.Apttus_Config2__OrderId__c;
                agreementFee.Apttus_RVConfig__OrderLineItemId__c = orderLineItem.Id;
                agreementFee.APTS_AssetLineItemId__c = orderLineItem.Apttus_Config2__AssetLineItemId__c;

                agrFeeMap.put(count,agreementFee);
                feeSchMap.put(count,APTS_OrderLineItemTriggerHandler.createFeeScheduleForUsage(agreementFee));
                count++;
            } else {
                orderLineItem.Apttus_Config2__AssetLineItemId__c = assetLineItem2.Id;
            }
        }
        if (orderLineIList.size()>0) update orderLineIList;
        if (agrFeeMap.size()>0) insert agrFeeMap.values();

        List<Apttus_Revenue2__Agreement_Fee_Schedule__c> tmpList = new List<Apttus_Revenue2__Agreement_Fee_Schedule__c>();
        for (Integer key : agrFeeMap.keySet()) {
            for (Apttus_Revenue2__Agreement_Fee_Schedule__c feeSch : feeSchMap.get(key)) {
                feeSch.Apttus_Revenue2__Agreement_Fee__c = agrFeeMap.get(key).Id;
                tmpList.add(feeSch);
            }
        }
        if (tmpList.size()>0) insert tmpList;

        List<Apttus_Billing__UsageInput__c> usageInputInsert = new List<Apttus_Billing__UsageInput__c>();

        Apttus_Billing__UsageInput__c usageInput = createUsageInput(assetLineItem.Id);
        //usageInput.Apttus_Billing__AssetLineItemId__c = assetLineItem.Id;
        //usageInput.Apttus_Billing__Status__c = 'Loaded';
        usageInput.Apttus_Billing__UsageDate__c = Date.newInstance(2016,01,01);
        usageInput.Apttus_Billing__Quantity__c = 100;
        usageInput.APTS_AgreementFeeId__c = agrFeeMap.get(1).Id;
        usageInput.APTS_AgreementFeeScheduleID__c = tmpList.get(0).Id;
        usageInputInsert.add(usageInput);

        Apttus_Billing__UsageInput__c usageInput2 = createUsageInput(assetLineItem.Id);
        //usageInput2.Apttus_Billing__AssetLineItemId__c = assetLineItem.Id;
        usageInput2.Apttus_Billing__Status__c = 'Rated';
        usageInput2.Apttus_Billing__UsageDate__c = Date.newInstance(2016,01,01);
        usageInput2.Apttus_Billing__Quantity__c = 100;
        usageInput.APTS_AgreementFeeId__c = agrFeeMap.get(1).Id;
        usageInput.APTS_AgreementFeeScheduleID__c = tmpList.get(0).Id;
        usageInputInsert.add(usageInput2);

        if (usageInputInsert.size()>0) update usageInputInsert;

        usageInput.Apttus_Billing__Status__c = 'Rated';
        usageInput.Apttus_Billing__RatedAmount__c = 100;

        update usageInput;
        delete usageInput;

        Apttus_Billing__UsageInput__c usageInput3 = createUsageInput(assetLineItem.Id);
        //usageInput3.Apttus_Billing__AssetLineItemId__c = assetLineItem.Id;
        usageInput3.Apttus_Billing__Status__c = 'Rated';
        usageInput3.Apttus_Billing__UsageDate__c = Date.newInstance(2016,01,01);
        usageInput3.Apttus_Billing__Quantity__c = 100;
        usageInput3.Apttus_Billing__RatedAmount__c = 100;
        usageInput.APTS_AgreementFeeId__c = agrFeeMap.get(1).Id;
        usageInput.APTS_AgreementFeeScheduleID__c = tmpList.get(0).Id;
        update usageInput3;

        usageInput3.Apttus_Billing__Status__c = 'Loaded';
        update usageInput3;
        delete orderLineIList;
    }
    // Create Order
    public static Apttus_Config2__Order__c createOrder(Id accountId, Id priceListId, Id accLocId, Id billingPreferencesId) {
        System.debug('accLocId: ' +accLocId);
        Apttus_Config2.CPQStruct.CreateOrderRequestDO request = new Apttus_Config2.CPQStruct.CreateOrderRequestDO();
        request.AccountId = accountId;
        request.PriceListId = priceListId;
        request.PricingDate = Datetime.now();
        Apttus_Config2.CPQStruct.CreateOrderResponseDO result = Apttus_Config2.OrderWebService.createOrder(request);

        Apttus_Config2__Order__c order = result.OrderSO;
        order.Apttus_Config2__SoldToAccountId__c = accountId;
        order.Apttus_Config2__ShipToAccountId__c = accountId;
        order.Apttus_Config2__BillingPreferenceId__c = billingPreferencesId;
        update order;

        return order;
    }
    //Create Order Line Item
    public static Apttus_Config2__OrderLineItem__c createOrderLI(Id orderId,Id prodId,Id proposalId){
        Apttus_Config2__OrderLineItem__c ordLI = new Apttus_Config2__OrderLineItem__c();
        ordLI.Apttus_Config2__OrderId__c = orderId;
        ordLI.Apttus_Config2__ProductId__c = prodId;
        ordLI.Apttus_Config2__StartDate__c = Date.today();
        ordLI.Apttus_Config2__EndDate__c = ordLI.Apttus_Config2__StartDate__c.addMonths(12);
        ordLI.Apttus_QPConfig__ProposalId__c = proposalId;
        insert ordLI;
        return ordLI;
    }
    // Create Billing Preferences
    public static Apttus_Config2__BillingPreference__c createBillingPreference() {
        Apttus_Config2__BillingPreference__c bp = new Apttus_Config2__BillingPreference__c();
        bp.Name = 'Billing Cycle Jan 1st';
        bp.Apttus_Config2__Active__c = True;
        bp.Apttus_Config2__AllowPaymentTermOverride__c = True;
        bp.Apttus_Config2__AllowPrefOverride__c = True;
        bp.Apttus_Config2__BillingCycleStart__c = 'Billing Day of Month';
        bp.Apttus_Config2__BillingDayOfMonth2__c = '1st of the Month';
        bp.Apttus_Config2__BillingInterval__c = 'Anytime';
        bp.Apttus_Config2__CalendarCycleStart__c = 'January';
        bp.Apttus_Config2__Default__c = False;
        bp.Apttus_Config2__DoNotCreateInformational__c = True;
        bp.Apttus_Config2__HideInformational__c = True;
        bp.Apttus_Config2__InvoiceDeliveryMethod__c ='Email';
        bp.Apttus_Config2__InvoiceOutputFormat__c = 'PDF';
        bp.Apttus_Config2__PrefLevel__c = 'Organization';
        bp.Apttus_Config2__ProrationPeriodTreatment__c = 'Separate Period';
        bp.Apttus_Config2__TaxLevel__c = 'Product';
        insert bp;
        return bp;
    }
    // Create Account Location
    public static Apttus_Config2__AccountLocation__c createAccountLocation(Id accountId) {
        Apttus_Config2__AccountLocation__c accLoc = new Apttus_Config2__AccountLocation__c();
        accLoc.Name = 'Test Account Location';
        accLoc.Apttus_Config2__AccountId__c = accountId;
        accLoc.Apttus_Config2__BillingDayOfMonth__c = '1st of the Month';
        accLoc.Apttus_Config2__BillingPreferenceId__c = null;
        accLoc.Apttus_Config2__CertificateId__c = null;
        accLoc.Apttus_Config2__City__c = 'SUNNYVALE';
        accLoc.Apttus_Config2__Country__c = 'USA';
        accLoc.Apttus_Config2__IsDefault__c = true;
        accLoc.Apttus_Config2__PaymentTermId__c = null;
        accLoc.Apttus_Config2__PostalCode__c = '94089';
        accLoc.Apttus_Config2__State__c = 'CALIFORNIA';
        accLoc.Apttus_Config2__TaxExempt__c = 'No';
        accLoc.Apttus_Config2__Type__c = 'Shipping';
        accLoc.Apttus_Billing__LastInvoicedDate__c = Date.today();
        insert accLoc;
        return accLoc;
    }
    // Create RevRec Policy
    // Acceptable String Values = Immediate, Ratable - Month, Ratable - Day, Subscription - Day, Subscription - Month 
    public static Apttus_Config2__RevRecPolicy__c createRevRecPolicy(String revRecRule) {
        Apttus_Config2__RevRecPolicy__c revrecpolicy = new Apttus_Config2__RevRecPolicy__c();
        revrecpolicy.Name = revRecRule;
        revrecpolicy.Apttus_Config2__Description__c = revRecRule;
        revrecpolicy.Apttus_Config2__RevRec_Rule__c = revRecRule; 
        insert revrecpolicy;
        return revrecpolicy;
    }
     public static void createAsset(Id orderId) {
        Apttus_Config2.CPQStruct.CreateAssetRequestDO request3 = new Apttus_Config2.CPQStruct.CreateAssetRequestDO();
        request3.OrderId = orderId;
        Apttus_Config2.CPQStruct.CreateAssetResponseDO result3 = Apttus_Config2.OrderWebService.createAsset(request3);
    }
    // Create Usage Input for the Assets
    public static Apttus_Billing__UsageInput__c createUsageInput(Id assetLineItemId) {
        Apttus_Billing__UsageInput__c usageInput = new Apttus_Billing__UsageInput__c();
        usageInput.Apttus_Billing__AssetLineItemId__c = assetLineItemId;
        usageInput.Apttus_Billing__Status__c = 'Loaded';
        usageInput.CurrencyIsoCode = 'USD';
        insert usageInput;
        return usageInput;
    }
    // Create Price List Item
    // Acceptable Values for priceType are: One Time, Recurring, Usage
    public static Apttus_Config2__PriceListItem__c createPriceListItem(Id priceListId, Id productId, String priceType, Id revRecPolicyId) {
        // Create Price List Item
        Apttus_Config2__PriceListItem__c priceListItem = new Apttus_Config2__PriceListItem__c();
        priceListItem.Apttus_Config2__PriceListId__c = priceListId;
        priceListItem.Apttus_Config2__Active__c = True;
        priceListItem.Apttus_Config2__AllocateGroupAdjustment__c = True;
        priceListItem.Apttus_Config2__AllowManualAdjustment__c = True;
        priceListItem.Apttus_Config2__AllowPriceRampOverlap__c = False;
        priceListItem.Apttus_Config2__AllowProration__c = False;
        priceListItem.Apttus_Config2__AutoCascadeQuantity__c = True;
        priceListItem.Apttus_Config2__AutoCascadeSellingTerm__c = True;
        priceListItem.Apttus_Config2__AutoRenew__c = False;
        if (priceType == 'Recurring') {
            priceListItem.Apttus_Config2__PriceMethod__c = 'Per Unit';
            priceListItem.Apttus_Config2__PriceType__c = 'Recurring';
            priceListItem.Apttus_Config2__Frequency__c = 'Monthly';
            priceListItem.Apttus_Config2__BillingFrequency__c = 'Yearly';
            priceListItem.Apttus_Config2__BillingRule__c = 'Bill In Advance';
        } else if (priceType == 'Usage') {
            priceListItem.Apttus_Config2__PriceMethod__c = 'Per Unit';
            priceListItem.Apttus_Config2__PriceType__c = 'Usage';
            priceListItem.Apttus_Config2__Frequency__c = 'Monthly';
            priceListItem.Apttus_Config2__BillingFrequency__c = 'Monthly';
            priceListItem.Apttus_Config2__BillingRule__c = 'Bill In Arrears';
        } else if (priceType == 'One Time') {
            priceListItem.Apttus_Config2__PriceMethod__c = 'Per Unit';
            priceListItem.Apttus_Config2__PriceType__c = 'One Time';
            priceListItem.Apttus_Config2__Frequency__c = Null;
            priceListItem.Apttus_Config2__BillingFrequency__c = 'One Time';
            priceListItem.Apttus_Config2__BillingRule__c = 'Bill In Advance';
        }
        priceListItem.Apttus_Config2__ChargeType__c = 'Subscription Fee';
        priceListItem.Apttus_Config2__DisableAssetIntegration__c = False;
        priceListItem.Apttus_Config2__DisableSyncWithOpportunity__c = False;
        priceListItem.Apttus_Config2__EnableCommitment__c = False;
        priceListItem.Apttus_Config2__EnablePriceRamp__c = False;
        priceListItem.Apttus_Config2__HasCriteria__c = False;
        priceListItem.Apttus_Config2__IsQuantityReadOnly__c = False;
        priceListItem.Apttus_Config2__IsSellingTermReadOnly__c = False;
        priceListItem.Apttus_Config2__IsUsageTierModifiable__c = False;
        priceListItem.Apttus_Config2__ListPrice__c = 1000;
        priceListItem.Apttus_Config2__PriceIncludedInBundle__c = False;
        priceListItem.Apttus_Config2__PriceUom__c = 'Each';
        priceListItem.Apttus_Config2__ProductId__c = productId;
        priceListItem.Apttus_Config2__RevRecPolicyId__c = revRecPolicyId;
        priceListItem.Apttus_Config2__Sequence__c = 1;
        priceListItem.Apttus_Config2__Taxable__c = True;
        
        
        insert priceListItem;

        
        return priceListItem;
    }
	// Create RevRec Period Date Holder
    public static Apttus_Revenue2__RevRec_Period__c createRevRecPeriod() {
        Apttus_Revenue2__RevRec_Period__c revRecPeriod = new Apttus_Revenue2__RevRec_Period__c();
        revRecPeriod.Name = 'RevRec Constants';
        revRecPeriod.Apttus_Revenue2__Current_Period_Date__c = Date.newInstance(2016,01,01);
        revRecPeriod.Apttus_Revenue2__Forecast_Period_Date__c = Date.newInstance(2016,01,01);
        insert revRecPeriod;
        return revRecPeriod;
    }
   
    // Create PriceBook
    public static Pricebook2 createPriceBook() {
        Id pricebookId = Test.getStandardPricebookId();
        Pricebook2 pb = new Pricebook2();
        pb.Name = 'Standard Price Book';
        pb.IsActive = True;
        if(pricebookId != null){
            pb.Id = pricebookId;
            update pb;
        }
        else{
            insert pb;
        }
        return pb;
    }
    // Create Payment Term
    public static Apttus_Config2__PaymentTerm__c createPaymentTerm() {
        Apttus_Config2__PaymentTerm__c pt = new Apttus_Config2__PaymentTerm__c();
        pt.Name = 'NET 30';
        pt.Apttus_Config2__Sequence__c = 1;
        pt.Apttus_Config2__Description__c = 'Net 30';
        pt.Apttus_Config2__IsDefault__c = True;
        pt.Apttus_Config2__Label__c = 'Net 30 Days';
        pt.Apttus_Config2__OffsetType__c = 'Day';
        pt.Apttus_Config2__StartType__c = 'Invoice Date';
        pt.Apttus_Config2__Value__c = 30;
        insert pt;
        return pt;
    }
}