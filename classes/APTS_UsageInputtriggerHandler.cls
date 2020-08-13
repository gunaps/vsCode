/*************************************************************
***** Description Section:
@Name: APTS_UsageInputtriggerHandler
@Author: Shubham Bhatt - PS, APTTUS
@CreateDate: 14/08/2016
@Description: Handler for the APTS_UsageInputtrigger Trigger
@UsedBy: APTS_UsageInputtrigger
******************************************************************
*/

public class APTS_UsageInputtriggerHandler{
    public static Boolean onAfterInsert = false;
    public static Boolean onAfterUpdate = false;

    public static void doBeforeInsert(List<Apttus_Billing__UsageInput__c> newList){
        List<Apttus_Billing__UsageInput__c> listUsageInputWithAssetID = new List<Apttus_Billing__UsageInput__c>();
        for(Apttus_Billing__UsageInput__c usageInputSO : newList){
            if(usageInputSO.Apttus_Billing__AssetLineItemId__c != null
              && usageInputSO.Apttus_Billing__UsageDate__c != null){
                listUsageInputWithAssetID.add(usageInputSO);
            }
        }
        APTS_UsageInputtriggerHandler.updateAgreementFeeonUsageInput(listUsageInputWithAssetID);
    }

    public static void doBeforeUpdate(Map<Id,Apttus_Billing__UsageInput__c> newMap, Map<Id,Apttus_Billing__UsageInput__c> oldMap){
        List<Apttus_Billing__UsageInput__c> listUsageInputWithUpdatedAssetID = new List<Apttus_Billing__UsageInput__c>();
        for(Apttus_Billing__UsageInput__c usageInputSO : newMap.values()){
            if(usageInputSO.Apttus_Billing__AssetLineItemId__c != null
               && usageInputSO.Apttus_Billing__UsageDate__c != null
               && (oldMap.get(usageInputSO.ID).Apttus_Billing__AssetLineItemId__c != usageInputSO.Apttus_Billing__AssetLineItemId__c
                  || usageInputSO.APTS_AgreementFeeId__c == null)) {
                listUsageInputWithUpdatedAssetID.add(usageInputSO);
            }
            if(usageInputSO.Apttus_Billing__AssetLineItemId__c == null ){
                usageInputSO.APTS_AgreementFeeId__c = null;
            }
        }
        APTS_UsageInputtriggerHandler.updateAgreementFeeonUsageInput(listUsageInputWithUpdatedAssetID);
    }
    
    public static void doAfterUpdate(Map<Id,Apttus_Billing__UsageInput__c> newMap, Map<Id,Apttus_Billing__UsageInput__c> oldMap){
        if(!onAfterUpdate){
            onAfterUpdate =true;
            
        }
        updateUsageAgreementFee(newMap, oldMap);
    }
    
    // To add agreement fee on the Usage Input Record so that we are able to find all usage input records associated with one agreement Fee
    public static void updateAgreementFeeonUsageInput(List<Apttus_Billing__UsageInput__c> listUsageInput){
        Set<Id> setAssetLineItemID = new Set<Id>();
        Map<String, List<Apttus_Billing__UsageInput__c>> mapUsageInput = new Map<String, List<Apttus_Billing__UsageInput__c>>();
        
        for(Apttus_Billing__UsageInput__c usageInputSO : listUsageInput){
            String key = usageInputSO.Apttus_Billing__AssetLineItemId__c +'#' + usageInputSO.Apttus_Billing__UsageDate__c;
            if(mapUsageInput.containsKey(key)){
                mapUsageInput.get(Key).add(usageInputSO);
            }
            else{
                List<Apttus_Billing__UsageInput__c> listUsage = new List<Apttus_Billing__UsageInput__c>();
                listUsage.add(usageInputSO);
                mapUsageInput.put(Key, listUsage);
                setAssetLineItemID.add(usageInputSO.Apttus_Billing__AssetLineItemId__c);
            }
        }
        
        Map<Id,Apttus_Config2__OrderLineItem__c> mapOrderLineItem = new Map<Id,Apttus_Config2__OrderLineItem__c>();
        Map<Id,ID> mapAssetToOrderLineItem = new Map<Id,ID>();
        for(Apttus_Config2__OrderLineItem__c orderLineItemSO : [Select Id
                                                                        , Name
                                                                        , Apttus_Config2__AssetLineItemId__c
                                                                        , createdDate
                                                                        From Apttus_Config2__OrderLineItem__c
                                                                WHERE Apttus_Config2__AssetLineItemId__c IN :setAssetLineItemID
                                                                        AND Apttus_Config2__PriceType__c = 'Usage' 
                                                                ORDER BY createdDate DESC]){
            mapAssetToOrderLineItem.put(orderLineItemSO.Apttus_Config2__AssetLineItemId__c, orderLineItemSO.ID);
            mapOrderLineItem.put(orderLineItemSO.ID, orderLineItemSO);
        }
        
        Map<String,ID> mapUsageInputToOrderLineItem = new Map<String,ID>();
        for(String key : mapUsageInput.keySet()){
            ID assetLineItemID = key.substringBeforeLast('#');
            if(mapAssetToOrderLineItem.containsKey(assetLineItemID)){
                mapUsageInputToOrderLineItem.put(key,mapAssetToOrderLineItem.get(assetLineItemID));
            }
        }
        
        if(mapUsageInputToOrderLineItem == null && mapUsageInputToOrderLineItem.isEmpty()){
            return;
        }
        
        List<String> listAgreementFeeFields = new List<String>(Apttus_Revenue2__Agreement_Fee__c.getSObjectType().getDescribe().fields.getMap().keySet());
        List<String> listAgreementFeeScheduleFields  = new List<String>(Apttus_Revenue2__Agreement_Fee_Schedule__c.getSObjectType().getDescribe().fields.getMap().keySet());
        String strQuery = ' SELECT ' 
                            + String.join( listAgreementFeeFields, ',' ) 
                            + ' , (SELECT ' + String.join( listAgreementFeeScheduleFields, ',' ) 
                                    + ' FROM Apttus_Revenue2__Agreement_Fee_Schedules__r)'
                            + ' FROM Apttus_Revenue2__Agreement_Fee__c '
                            + ' WHERE Apttus_RVConfig__OrderLineItemId__c IN :setOrderLineItemID';
        system.debug('0###$$$ =>> ' + strQuery);
        
        Set<ID> setOrderLineItemID = new Set<ID>(mapUsageInputToOrderLineItem.values());
        List<Apttus_Revenue2__Agreement_Fee__c> listAgreementFee = Database.query(strQuery);
        map<ID,Apttus_Revenue2__Agreement_Fee__c> mapAgreementFee = new Map<ID,Apttus_Revenue2__Agreement_Fee__c>(listAgreementFee);
        
        if(mapAgreementFee == null || mapAgreementFee.isEmpty()){
            return;
        }
        
        Map<ID,List<Apttus_Revenue2__Agreement_Fee__c>> mapOrderLineItemToAgreementFee = new Map<ID,List<Apttus_Revenue2__Agreement_Fee__c>>();
        for(Apttus_Revenue2__Agreement_Fee__c agreementFeeSO : mapAgreementFee.values()){
            if(mapOrderLineItemToAgreementFee.containsKey(agreementFeeSO.Apttus_RVConfig__OrderLineItemId__c)){
                mapOrderLineItemToAgreementFee.get(agreementFeeSO.Apttus_RVConfig__OrderLineItemId__c).add(agreementFeeSO);
            }
            List<Apttus_Revenue2__Agreement_Fee__c> listAfreementFeeTemp = new List<Apttus_Revenue2__Agreement_Fee__c>();
            listAfreementFeeTemp.add(agreementFeeSO);
            mapOrderLineItemToAgreementFee.put(agreementFeeSO.Apttus_RVConfig__OrderLineItemId__c, listAfreementFeeTemp);
        }
        
        for(String key : mapUsageInput.keySet()){
            
            ID assetLineItemID = key.substringBeforeLast('#');
            Date usagedateSO = Date.valueOf( key.substringAfterLast('#'));
            if(mapUsageInputToOrderLineItem.containsKey(key)){
                List<Apttus_Revenue2__Agreement_Fee__c> listAfreementFeeTemp = mapOrderLineItemToAgreementFee.get(mapUsageInputToOrderLineItem.get(key));
                if(listAfreementFeeTemp == null){
                    continue;
                }
                
                for(Apttus_Billing__UsageInput__c usageInputSO :  mapUsageInput.get(key)){
                    for(Apttus_Revenue2__Agreement_Fee__c agreementFeeSO : listAfreementFeeTemp){
                        if(usageInputSO.Apttus_Billing__UsageDate__c >= agreementFeeSO.Apttus_Revenue2__Actual_Start_Date__c
                           && usageInputSO.Apttus_Billing__UsageDate__c <= agreementFeeSO.Apttus_Revenue2__Actual_End_Date__c){
                            usageInputSO.APTS_AgreementFeeId__c = agreementFeeSO.ID;
                               for(Apttus_Revenue2__Agreement_Fee_Schedule__c agreementFeeScheduleSO : agreementFeeSO.Apttus_Revenue2__Agreement_Fee_Schedules__r){
                                   if(usageInputSO.Apttus_Billing__UsageDate__c != null
                                       && agreementFeeScheduleSO.Apttus_Revenue2__Period_Date__c != null
                                       && usageInputSO.Apttus_Billing__UsageDate__c.toStartOfMonth() == agreementFeeScheduleSO.Apttus_Revenue2__Period_Date__c.toStartOfMonth()){
                                           usageInputSO.APTS_AgreementFeeScheduleID__c = agreementFeeScheduleSO.ID;
                                           continue;
                                       }
                               }
                            continue;
                        }
                    }
                }
            }
        }
    }
    
    // To update agreement fee on the Usage Input Record so that all aggregated values are up to date on agrrement fee ( Which can point to many usage input records )
    public static void updateUsageAgreementFee(Map<Id,Apttus_Billing__UsageInput__c> newMap, Map<Id,Apttus_Billing__UsageInput__c> oldMap){
        
        Set<Id> setAgreementFeeID = new Set<Id>();
        Set<Id> setAgreementFeeScheduleID = new Set<Id>();
        List<Apttus_Billing__UsageInput__c> listUsageInputRated = new List<Apttus_Billing__UsageInput__c>();
        
        for(Apttus_Billing__UsageInput__c usageInputSO : newMap.values()){
            if(usageInputSO.Apttus_Billing__UsageDate__c !=null 
               && usageInputSO.Apttus_Billing__AssetLineItemId__c !=null 
               && usageInputSO.Apttus_Billing__RatedAmount__c !=null 
               && usageInputSO.Apttus_Billing__Status__c =='Rated'
               && oldMap.containsKey(usageInputSO.ID)
               && oldMap.get(usageInputSO.ID).Apttus_Billing__Status__c =='Loaded'){
                setAgreementFeeID.add(usageInputSO.APTS_AgreementFeeId__c);
                setAgreementFeeScheduleID.add(usageInputSO.APTS_AgreementFeeScheduleID__c);
                listUsageInputRated.add(usageInputSO);
            }
        }
        
        if(listUsageInputRated == null || listUsageInputRated.isEmpty()){
            return;
        }
        
        Map<ID,Apttus_Revenue2__Agreement_Fee__c> mapAgreementFee = new Map<ID,Apttus_Revenue2__Agreement_Fee__c>([Select ID
                                                                                                        , Apttus_Revenue2__Flat_Fee__c
                                                                                                        , Apttus_Revenue2__Actual_Amount__c
                                                                                                        , Apttus_Revenue2__Actual_Units2__c
                                                                                                        , Apttus_Revenue2__Fee_Type__c
                                                                                                        from Apttus_Revenue2__Agreement_Fee__c
                                                                                                        Where ID in :setAgreementFeeID]);
        
        Map<ID,Apttus_Revenue2__Agreement_Fee_Schedule__c> mapAgreementFeeSchedule= new Map<ID,Apttus_Revenue2__Agreement_Fee_Schedule__c>([Select ID
                                                                                                        , Apttus_Revenue2__Actual_Amount__c
                                                                                                        , Apttus_Revenue2__Actual_Units2__c
                                                                                                        from Apttus_Revenue2__Agreement_Fee_Schedule__c
                                                                                                        Where ID in :setAgreementFeeScheduleID]);
        
        for(Apttus_Billing__UsageInput__c usageInputSO : listUsageInputRated){
            if(mapAgreementFee.containsKey(usageInputSO.APTS_AgreementFeeId__c)){
                Apttus_Revenue2__Agreement_Fee__c agreementFeeSO = mapAgreementFee.get(usageInputSO.APTS_AgreementFeeId__c);
                if(agreementFeeSO.Apttus_Revenue2__Flat_Fee__c == null){
                    agreementFeeSO.Apttus_Revenue2__Flat_Fee__c = 0;
                }
                if(agreementFeeSO.Apttus_Revenue2__Actual_Amount__c == null){
                    agreementFeeSO.Apttus_Revenue2__Actual_Amount__c = 0;
                }
                if(agreementFeeSO.Apttus_Revenue2__Actual_Units2__c == null){
                    agreementFeeSO.Apttus_Revenue2__Actual_Units2__c = 0;
                }
                agreementFeeSO.Apttus_Revenue2__Flat_Fee__c += usageInputSO.Apttus_Billing__RatedAmount__c;
                agreementFeeSO.Apttus_Revenue2__Actual_Amount__c += usageInputSO.Apttus_Billing__RatedAmount__c;
                agreementFeeSO.Apttus_Revenue2__Actual_Units2__c += usageInputSO.Apttus_Billing__Quantity__c;
                //agreementFeeSO.Apttus_Revenue2__Fee_Type__c = 'Flat Fee' ;
            }
            if(mapAgreementFeeSchedule.containsKey(usageInputSO.APTS_AgreementFeeScheduleID__c)){
                Apttus_Revenue2__Agreement_Fee_Schedule__c agreementFeeScheduleSO = mapAgreementFeeSchedule.get(usageInputSO.APTS_AgreementFeeScheduleID__c);
                if(agreementFeeScheduleSO.Apttus_Revenue2__Actual_Amount__c == null){
                    agreementFeeScheduleSO.Apttus_Revenue2__Actual_Amount__c = 0;
                }
                if(agreementFeeScheduleSO.Apttus_Revenue2__Actual_Units2__c == null){
                    agreementFeeScheduleSO.Apttus_Revenue2__Actual_Units2__c = 0;
                }
                agreementFeeScheduleSO.Apttus_Revenue2__Actual_Amount__c += usageInputSO.Apttus_Billing__RatedAmount__c;
                agreementFeeScheduleSO.Apttus_Revenue2__Actual_Units2__c += usageInputSO.Apttus_Billing__Quantity__c;
            }
        }
        if(mapAgreementFee != null && !mapAgreementFee.isEmpty()){
            update mapAgreementFee.values();
        }
        if(mapAgreementFeeSchedule != null && !mapAgreementFeeSchedule.isEmpty()){
            update mapAgreementFeeSchedule.values();
        }
    }
}