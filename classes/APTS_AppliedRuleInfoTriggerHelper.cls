public class APTS_AppliedRuleInfoTriggerHelper {
    private static final String TYPE_RECOMMENDATION = 'Recommendation';
    
    public static void createOptionProducts(Map<ID, Apttus_Config2__AppliedRuleInfo__c> mapAppliedRuleInfo){
        ID proposalID = null;
        
        System.debug('mapAppliedRuleInfo.values(): ' + mapAppliedRuleInfo.values());
        Set<ID> setConfigIDs = new Set<ID>();
        Set<ID> setConstraintRuleID = new Set<ID>();
        
        for(Apttus_Config2__AppliedRuleInfo__c oAppliedRuleInfo : mapAppliedRuleInfo.values()){
            if(String.isNotBlank(oAppliedRuleInfo.Apttus_Config2__ConstraintRuleId__c)){
                setConstraintRuleID.add(oAppliedRuleInfo.Apttus_Config2__ConstraintRuleId__c);
                setConfigIDs.add(oAppliedRuleInfo.Apttus_Config2__ConfigurationId__c);
            }
        }
        
        if(!setConstraintRuleID.isEmpty()){
            List<Apttus_Config2__ProductConfiguration__c> listConfigurations = [SELECT Id, Apttus_QPConfig__Proposald__c FROM Apttus_Config2__ProductConfiguration__c WHERE Id IN : setConfigIDs AND Apttus_QPConfig__Proposald__c != null];
            List<Apttus_Config2__ConstraintRuleAction__c> listConstraintRuleAction = [SELECT Id, Apttus_Config2__ProductId__c from Apttus_Config2__ConstraintRuleAction__c WHERE Apttus_Config2__ConstraintRuleId__c IN : setConstraintRuleID AND Apttus_Config2__ActionType__c = :TYPE_RECOMMENDATION AND Apttus_Config2__ProductId__c != null];
            
            List<Optional_Products__c> listOptionalProducts = new List<Optional_Products__c>();
            Optional_Products__c oOptionalProduct;
            
            System.debug('listConfigurations: ' + listConfigurations);
            System.debug('listConstraintRuleAction: ' + listConstraintRuleAction);
            
            if(!listConfigurations.isEmpty()){
                proposalID = listConfigurations[0].Apttus_QPConfig__Proposald__c;
                Integer iCounter = 1;
                
                for(Apttus_Config2__ConstraintRuleAction__c oConstraintRuleAction : listConstraintRuleAction){
                    oOptionalProduct = new Optional_Products__c();
                    oOptionalProduct.Product__c = oConstraintRuleAction.Apttus_Config2__ProductId__c;
                    oOptionalProduct.Quote_Proposal__c= proposalID;
                    oOptionalProduct.APTH_Sequence_number__c = iCounter++;
                    
                    listOptionalProducts.add(oOptionalProduct);
                }
                if(!listOptionalProducts.isEmpty()){
                    delete [SELECT Id FROM Optional_Products__c WHERE Quote_Proposal__c = :proposalID];
                    insert listOptionalProducts;
                }
            }
        }
    }
}