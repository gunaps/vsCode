public class APTS_AppliedRuleInfoTriggerHandler {
    public void afterInsert(Map<ID, Apttus_Config2__AppliedRuleInfo__c> mapAppliedRuleInfo){
        APTS_AppliedRuleInfoTriggerHelper.createOptionProducts(mapAppliedRuleInfo);
    }
}