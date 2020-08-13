@isTest
public class APTS_TestDataSetup {

    public static void createAllCustomSetting(){
        
        //Insert custom Settings
		Apttus_Config2__ConfigCustomClasses__c configCustomClassesProperty = new Apttus_Config2__ConfigCustomClasses__c();
        configCustomClassesProperty.Name = 'Config Custom Classes';
        configCustomClassesProperty.Apttus_Config2__PricingCallbackClass__c = 'APTS_PricingCallBack';
        configCustomClassesProperty.Apttus_Config2__ValidationCallbackClass__c = 'APT_CartValidationCallBack';
        insert configCustomClassesProperty;
        
        Apttus_Config2__ConfigLineItemCustomFields__c configLineItemCustomSetting = new Apttus_Config2__ConfigLineItemCustomFields__c();
        configLineItemCustomSetting.name = 'System Properties';
        configLineItemCustomSetting.Apttus_Config2__CustomFieldNames__c = 'Account_Industry__c'
            																+',Account_Annual_Revenue__c'
            																+',APT_AIC_Discount_Checking_Attribute__c'
	            															+',Apttus_Config2__ConfigurationId__r.Apttus_Config2__AccountId__c'
    	        															+',Apttus_Config2__ConfigurationId__r.Apttus_Config2__AccountId__r.Name';
        configLineItemCustomSetting.Apttus_Config2__CustomFieldNames2__c = 'APT_Revenue_management_total_attr__c'
            																+',APT_Same_Quantity_Product_1__c'
            																+',APT_Same_Quantity_Product_2__c'
            																+',APT_Total_of_Revenue__c'
            																+',User_Profile__c';
        insert configLineItemCustomSetting;
    }

    public static Account createAccount(String name, Boolean isPremium){
        Account accountSO = new Account ();
        accountSO.Name = name;
        accountSO.Is_Premium__c = isPremium;
        accountSO.Standard_Discount_Rate__c = '10';
        accountSO.Premium_Discount_Rate__c = '20';
        return accountSO;
    }

    public static Apttus_Config2__PriceList__c createPriceList(String name){

        Apttus_Config2__PriceList__c pricelist = new Apttus_Config2__PriceList__c ();
        pricelist.Name = name;
        pricelist.Apttus_Config2__Active__c = true;
        return pricelist;
    }

    public static Opportunity createOpportunity(String opportunityName, Id accountId, String stageName ){
        Opportunity opp = new Opportunity ();
        opp.Name = opportunityName;
        opp.accountId = accountId;
        opp.StageName = stageName;
        opp.closedate =  Date.today().addDays(30);
        return opp;
    }

    public static Apttus_Proposal__Proposal__c createProposal(Id accID, Id oppID, Id priceListID){
        
        Apttus_Proposal__Proposal__c prop = new Apttus_Proposal__Proposal__c ();        
        //prop.Apttus_Proposal__Account__c = accID;
        prop.Apttus_QPConfig__BillToAccountId__c = accID;
        prop.Apttus_QPConfig__ShipToAccountId__c = accID;
        prop.Apttus_Proposal__Opportunity__c = oppID;
        prop.Apttus_QPConfig__PriceListId__c = priceListID;
        prop.Apttus_Proposal__Primary__c  = true;
        prop.Apttus_Proposal__Approval_Stage__c = 'Draft';
        prop.Apttus_Proposal__ExpectedStartDate__c = Date.today();
        prop.Apttus_Proposal__ExpectedEndDate__c = Date.today().addMonths(36);
        return prop;
    }
    
    public static Product2 createProduct(String productName, String pfamily, String sConfigType) {
        
        Product2 productSO = new Product2();
        productSO.Name = productName;
        productSO.Family = pfamily;
        productSO.ProductCode = 'pcode';
        productSO.IsActive = true;
        productSO.Apttus_Config2__ConfigurationType__c = sConfigType;
        productSO.Apttus_Config2__HasAttributes__c = true;
        productSO.Apttus_Config2__HasOptions__c = true;
        return productSO;
    }
    
    public static Apttus_Config2__PriceListItem__c createPriceListItem(Id priceListId, Id productId) {
        
        Apttus_Config2__PriceListItem__c priceListItem = new Apttus_Config2__PriceListItem__c();
        priceListItem.Apttus_Config2__PriceListId__c = priceListId;     
        priceListItem.Apttus_Config2__ProductId__c = productId;
        priceListItem.Apttus_Config2__ChargeType__c = 'Standard Price';
        priceListItem.Apttus_Config2__PriceType__c = 'One Time';
        priceListItem.Apttus_Config2__PriceMethod__c = 'Flat Price';
        priceListItem.Apttus_Config2__ListPrice__c = 100;
        priceListItem.Apttus_Config2__EffectiveDate__c = Date.today().addDays(-100);
        priceListItem.Apttus_Config2__ExpirationDate__c = Date.today().addDays(365);
        priceListItem.Apttus_Config2__Frequency__c = 'Yearly';
        priceListItem.Apttus_Config2__PriceUom__c = 'Each';
        priceListItem.Apttus_Config2__Active__c = true;
        priceListItem.Apttus_Config2__BillingFrequency__c = 'Yearly';
        priceListItem.Apttus_Config2__BillingRule__c = 'Bill In Advance';
        priceListItem.Apttus_Config2__DefaultSellingTerm__c = 2;
        return priceListItem;
    }
    
    public static Id createCart(Id propID){
        Apttus_CPQApi.CPQ.CreateCartRequestDO request = new Apttus_CPQApi.CPQ.CreateCartRequestDO();
        request.QuoteId = propID;
        Apttus_CPQApi.CPQ.CreateCartResponseDO response = Apttus_CPQApi.CPQWebService.createCart(request);
        return response.CartId;
    }
    
    public static Apttus_CPQApi.CPQ.SelectedProductDO createSelectProductDo(Id productId, Integer quantity, Date startDate, Date endDate, Integer sellingTerm){
        Apttus_CPQApi.CPQ.SelectedProductDO selectedProductDO1 = new  Apttus_CPQApi.CPQ.SelectedProductDO();
        selectedProductDO1.ProductId= productId;
        selectedProductDO1.Quantity = quantity;
        selectedProductDO1.SellingTerm = sellingTerm;
        selectedProductDO1.StartDate = startDate;
        selectedProductDO1.EndDate = endDate;
        return selectedProductDO1;
    }

     public static Apttus_Config2__AssetLineItem__c createAssetLineItem(Id accId,ID  priceListItemId,Id productId, Id optionId, Decimal dLineNumber, Decimal dItemSequence, String sLineType,Decimal dBasePrice, String sName, Integer quantity ){

        //Apttus_Proposal__Proposal__c oProposal, Id PriceListItemId, Id LocationId, Id ProductId, Id OptionId, Decimal dLineNumber, Decimal dItemSequence, String sLineType, Id BillPreferenceId, String sBillFrequency, String sBillingRule, String sPriceType, String sPriceMethod, String sPriceUOM, Decimal dBasePrice ){

        Apttus_Config2__AssetLineItem__c assetLine = new Apttus_Config2__AssetLineItem__c();
        assetLine.Apttus_Config2__AccountId__c = accId;
        assetLine.Name = sName;
        assetLine.Apttus_Config2__BillToAccountId__c = accId;
        assetLine.Apttus_Config2__ShipToAccountId__c = accId;
        //assetLine.Apttus_Config2__PriceListId__c = oProposal.Apttus_QPConfig__PriceListId__c;
        //assetLine.Apttus_QPConfig__ProposalId__c = oProposal.Id;        
        assetLine.Apttus_Config2__PriceListItemId__c = priceListItemId;
        //assetLine.Apttus_Config2__LocationId__c = LocationId;
        assetLine.Apttus_Config2__ProductId__c = productId;
        assetLine.Apttus_Config2__OptionId__c = optionId;
        assetLine.Apttus_Config2__LineNumber__c = dLineNumber;
        assetLine.Apttus_Config2__ItemSequence__c = dItemSequence;      
        assetLine.Apttus_Config2__LineType__c = sLineType;
        assetLine.Apttus_Config2__StartDate__c = Date.Today().addMonths(-6);
        assetLine.Apttus_Config2__EndDate__c = Date.Today().addMonths(6);
        assetLine.Apttus_Config2__BillingStartDate__c = Date.Today().addMonths(-6);
        assetLine.Apttus_Config2__BillingEndDate__c = Date.Today().addMonths(6);        
        //assetLine.Apttus_Config2__BillingPreferenceId__c = BillPreferenceId;
        assetLine.Apttus_Config2__BillingFrequency__c = 'Monthly';
        //assetLine.Apttus_Config2__BillingRule__c = sBillingRule;
        //assetLine.Apttus_Config2__PriceType__c = sPriceType;
        //assetLine.Apttus_Config2__PriceMethod__c = sPriceMethod;
        //assetLine.Apttus_Config2__PriceUom__c = sPriceUOM;
        assetLine.Apttus_Config2__BasePrice__c = dBasePrice;
        assetLine.Apttus_Config2__NetPrice__c = dBasePrice;
        assetLine.Apttus_Config2__SellingTerm__c = 1;
        assetLine.Apttus_Config2__SellingFrequency__c = 'Yearly';
        assetLine.Apttus_Config2__Quantity__c = quantity;
        return assetLine;
    }

    public static string getQueryStringWithAllFields(String objectName, String strExtraFields, String whereClause){
        String selects = '';
     
        Map<String, Schema.SObjectField> fMap = Schema.getGlobalDescribe().get(objectName.toLowerCase()).getDescribe().Fields.getMap();
        list<string> selectFields = new list<string>();
         
        if (fMap != null){
            for (Schema.SObjectField ft : fMap.values()){ // loop through all field tokens (ft)
                Schema.DescribeFieldResult fd = ft.getDescribe(); // describe each field (fd)
                if (fd.isCreateable()){ // field is creatable
                    selectFields.add(fd.getName());
                }
            }
        }
         
        if (!selectFields.isEmpty()){
            for (string s:selectFields){
                selects += s + ',';
            }
            if (selects.endsWith(',')){selects = selects.substring(0,selects.lastIndexOf(','));}
             
        }
        
        if( strExtraFields != null ){
            selects = selects + ' ' + strExtraFields;
        }

        if (whereClause != null) {
            return 'SELECT ' + selects + ' FROM ' + objectName + ' WHERE ' + whereClause;
        }
        else {
            return 'SELECT ' + selects + ' FROM ' + objectName ;
        } 
    }

}