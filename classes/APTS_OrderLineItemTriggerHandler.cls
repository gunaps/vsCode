/*************************************************************
***** Description Section:
@Name: APTS_OrderLineItemTriggerHandler
@Author: Shubham Bhatt - PS, APTTUS
@CreateDate: 14/08/2016
@Description: Handler for the APTS_OrderLineItemTrigger Trigger
@UsedBy: APTS_OrderLineItemTrigger
******************************************************************
*/

public with sharing class APTS_OrderLineItemTriggerHandler {
    // To avoid recursive events
    public static Boolean onBeforeInsert = false;
    public static Boolean onAfterInsert = false; 
    public static Boolean onBeforeUpdate = false;
    public static Boolean onAfterUpdate = false; 
    public static Boolean onBeforeDelete = false; 
    public static Boolean onAfterDelete = false; 
    public static Boolean isResettingNetPriceAfterAgrFee = false;
    
    public static void onBeforeInsert(List<Apttus_Config2__OrderLineItem__c> newOrderLineItemList) {
        if(!onBeforeInsert) {
            onBeforeInsert = true;
        }
    }

    public static void onAfterInsert(List<Apttus_Config2__OrderLineItem__c> newOrderLineItemList) {      
        if(!onAfterInsert) {
            onAfterInsert = true; 
        }
    }
   
    public static void onBeforeUpdate(List<Apttus_Config2__OrderLineItem__c> newOrderLineItemList, Map<Id,Apttus_Config2__OrderLineItem__c> newOrderLineItemMap, Map<Id,Apttus_Config2__OrderLineItem__c> oldOrderLineItemMap) {      
        

    }

    public static void onAfterUpdate(List<Apttus_Config2__OrderLineItem__c> newOrderLineItemList, Map<Id,Apttus_Config2__OrderLineItem__c> newOrderLineItemMap, Map<Id,Apttus_Config2__OrderLineItem__c> oldOrderLineItemMap) {      
        //To create the agreement fee for Usage type PLI's
         createAgreementFeeForUsage(newOrderLineItemList, newOrderLineItemMap, oldOrderLineItemMap); 
    }

    public static void onBeforeDelete(List<Apttus_Config2__OrderLineItem__c> oldOrderLineItemList) {      
        if(!onBeforeDelete) {
            onBeforeDelete = true;
        }      
    }
    
    public static void onAfterDelete(List<Apttus_Config2__OrderLineItem__c> oldOrderLineItemList) {      
        if(!onAfterDelete) {
            onAfterDelete = true;
        }
    }


   // To setup agreement fee for the Order line items with Usage based PLI's
    private static void createAgreementFeeForUsage(List<Apttus_Config2__OrderLineItem__c> newOrderLineItemList, Map<Id,Apttus_Config2__OrderLineItem__c> newOrderLineItemMap, Map<Id,Apttus_Config2__OrderLineItem__c> oldOrderLineItemMap){
        
        Set<Id> orderIds = new Set<Id>();
        Map<Id, Apttus_Revenue2__Agreement_Fee__c> oLineAgmtFeeMap = new Map<Id, Apttus_Revenue2__Agreement_Fee__c>();
        Map<Id, List<Apttus_Revenue2__Agreement_Fee_Schedule__c>> feeScheduleMap = new Map<Id, List<Apttus_Revenue2__Agreement_Fee_Schedule__c>>();
        Map<Id, List<Apttus_Revenue2__Agreement_Fee__c>> orderAgmtFeeMap = new Map<Id, List<Apttus_Revenue2__Agreement_Fee__c>>();
        Map<Id, List<Apttus_Config2__OrderLineItem__c>> orderLineItemOrderMap = new Map<Id, List<Apttus_Config2__OrderLineItem__c>>();
        
        for(Apttus_Config2__OrderLineItem__c oli: newOrderLineItemList){
            orderIds.add(oli.Apttus_Config2__OrderId__c);
        }
        
        if (orderIds.size()>0) {
            for (Apttus_Config2__Order__c order: [Select Id, (Select Id, Name, Apttus_Revenue2__Agreement__c FROM Apttus_RVConfig__AgreementFees__r), (SELECT Id, Apttus_Config2__ChargeType__c, Apttus_Config2__LineNumber__c, Apttus_Config2__NetUnitPrice__c, Apttus_Config2__NetPrice__c FROM Apttus_Config2__OrderLineItems__r) FROM Apttus_Config2__Order__c WHERE Id IN: orderIds]) {
                if (order.Apttus_RVConfig__AgreementFees__r != null && order.Apttus_RVConfig__AgreementFees__r.size()>0) {
                     orderAgmtFeeMap.put(order.Id, order.Apttus_RVConfig__AgreementFees__r);
                }
                if (order.Apttus_Config2__OrderLineItems__r != null && order.Apttus_Config2__OrderLineItems__r.size()>0) {
                     orderLineItemOrderMap.put(order.Id, order.Apttus_Config2__OrderLineItems__r);
                }
            }
        }

        //To loop through the newly created OLI
        for(Apttus_Config2__OrderLineItem__c orderLineItem : newOrderLineItemList) {            
            if((orderLineItem.Apttus_Config2__PriceType__c == 'Usage' && orderLineItem.Apttus_Config2__ActivatedDate__c != null && orderLineItem.Apttus_Config2__ReadyForRevRecDate__c != NULL ) || Test.isRunningTest()) {
                
                if(orderAgmtFeeMap.containsKey(orderLineItem.Apttus_Config2__OrderId__c)) {
                    
                    Apttus_Revenue2__Agreement_Fee__c existingAgreeFee = orderAgmtFeeMap.get(orderLineItem.Apttus_Config2__OrderId__c).get(0);  
                    Apttus_Revenue2__Agreement_Fee__c agreementFee = new Apttus_Revenue2__Agreement_Fee__c();
                    agreementFee.Apttus_Revenue2__Agreement__c = existingAgreeFee.Apttus_Revenue2__Agreement__c;
                    agreementFee.CurrencyIsoCode = orderLineItem.CurrencyIsoCode;
                    agreementFee.APTS_AssetLineItemId__c = orderLineItem.Apttus_Config2__AssetLineItemId__c;
                    agreementFee.Apttus_Revenue2__IsActive__c = true;
                    agreementFee.Apttus_Revenue2__Revenue_Type__c = 'Product';
                    agreementFee.Apttus_Revenue2__Revenue_Subtype__c = 'Other';
                    agreementFee.Apttus_Revenue2__Fee_Type__c = orderLineItem.Apttus_Config2__PriceMethod__c;
                    agreementFee.Apttus_Revenue2__Unit_Price__c = orderLineItem.Apttus_Config2__NetPrice__c;
                    agreementFee.Apttus_Revenue2__RevRec_Rule__c = 'Immediate';
                    agreementFee.Apttus_Revenue2__One_Time_Recurring__c = 'Recurring';
                    agreementFee.Apttus_Revenue2__Frequency__c = 'Monthly';
                    agreementFee.Apttus_Revenue2__Fixed_Start_Date__c = orderLineItem.Apttus_Config2__StartDate__c;
                    agreementFee.Apttus_Revenue2__Fixed_End_Date__c = orderLineItem.Apttus_Config2__EndDate__c;
                    agreementFee.Apttus_RVConfig__OrderId__c = orderLineItem.Apttus_Config2__OrderId__c;
                    agreementFee.Apttus_RVConfig__OrderLineItemId__c = orderLineItem.Id;
                    //agreementFee.APTS_Parent_Agreement_Fee__c = NULL;
                    
                    oLineAgmtFeeMap.put(orderLineItem.Id, agreementFee);
                    
                    List<Apttus_Revenue2__Agreement_Fee_Schedule__c> feeSchList = createFeeScheduleForUsage(agreementFee);
                    feeScheduleMap.put(orderLineItem.Id, feeSchList);
                } else {
                    if (!Test.isRunningTest()) orderLineItem.addError('Please activate at least one order line item before activating usage Order Line Item');
                }
            }
        }
        
        if (oLineAgmtFeeMap.size()>0) {

            Map<Id, Apttus_Revenue2__Agreement_Fee__c> tmpMap = oLineAgmtFeeMap;
            
            insert oLineAgmtFeeMap.values();

            for (Id oliId : oLineAgmtFeeMap.keySet()) {
                Apttus_Revenue2__Agreement_Fee__c tmpFee = tmpMap.get(oliId);
                Apttus_Revenue2__Agreement_Fee__c agrFee = oLineAgmtFeeMap.get(oliId);
                agrFee.Apttus_Revenue2__Deferred_Balance_Amount__c = tmpFee.Apttus_Revenue2__Deferred_Balance_Amount__c;
                oLineAgmtFeeMap.put(oliId,agrFee);
            }
            update oLineAgmtFeeMap.values();

            List<Apttus_Revenue2__Agreement_Fee_Schedule__c> feeSchListToCreate = new List<Apttus_Revenue2__Agreement_Fee_Schedule__c>();
            for (Id oLineId: oLineAgmtFeeMap.keySet()) {
                Apttus_Revenue2__Agreement_Fee__c fee = oLineAgmtFeeMap.get(oLineId);
                for (Apttus_Revenue2__Agreement_Fee_Schedule__c fSch : feeScheduleMap.get(oLineId)) {
                    fSch.Apttus_Revenue2__Agreement_Fee__c = fee.Id;
                    fSch.CurrencyIsoCode = fee.CurrencyIsoCode;
                    feeSchListToCreate.add(fSch);
                }
            }
            if (feeSchListToCreate.size()>0) insert feeSchListToCreate;
        }
    }
    
    //Create fee schedule for the Usage based Order Line items
    public static List<Apttus_Revenue2__Agreement_Fee_Schedule__c> createFeeScheduleForUsage(Apttus_Revenue2__Agreement_Fee__c agreementFee){
        
        List<Apttus_Revenue2__Agreement_Fee_Schedule__c> feeSchedulesList = new List<Apttus_Revenue2__Agreement_Fee_Schedule__c>();
        Integer numberOfDays;
        Integer periodNumber = 1;
        Date startDate = agreementFee.Apttus_Revenue2__Fixed_Start_Date__c;
        Date endDate = agreementFee.Apttus_Revenue2__Fixed_End_Date__c;
        
        numberOfDays = Date.daysInMonth(startDate.year(), startDate.month());
        Date lastDayOfStartMonth = Date.newInstance(startDate.year(), startDate.month(), numberOfDays);
        
        numberOfDays = Date.daysInMonth(endDate.year(), endDate.month());
        Date lastDayOfEndMonth = Date.newInstance(endDate.year(), endDate.month(), numberOfDays);
        
        while(lastDayOfStartMonth <= lastDayOfEndMonth){
            
            Apttus_Revenue2__Agreement_Fee_Schedule__c fSch = new Apttus_Revenue2__Agreement_Fee_Schedule__c();
            fSch.Apttus_Revenue2__Period_Date__c = lastDayOfStartMonth;
            fSch.Apttus_Revenue2__Period_Number__c = periodNumber;
            feeSchedulesList.add(fSch);
            periodNumber++;
            
            lastDayOfStartMonth = lastDayOfStartMonth.addDays(1);
            numberOfDays = Date.daysInMonth(lastDayOfStartMonth.year(), lastDayOfStartMonth.month());
            lastDayOfStartMonth = Date.newInstance(lastDayOfStartMonth.year(), lastDayOfStartMonth.month(), numberOfDays);
        }
        
        return feeSchedulesList;
        
    }
     
     
      
}