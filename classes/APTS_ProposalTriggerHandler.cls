public class APTS_ProposalTriggerHandler {
    public void beforeUpdate(List<Apttus_Proposal__Proposal__c> listOldProposal, List<Apttus_Proposal__Proposal__c> listNewProposal){
        
        System.debug(System.LoggingLevel.DEBUG ,'-----Updated New proposal : '  + listNewProposal[0]);
        System.debug(System.LoggingLevel.DEBUG ,'-----Updated Old proposal : '  + listNewProposal[0]);
        
        if(listOldProposal.size() == 1 && listOldProposal[0].APTS_Execute_Batch__c == false && listNewProposal[0].APTS_Execute_Batch__c == true){
            APTS_ProposalTriggerHelper.invokeGenerateProposalBatch(listNewProposal[0]);
        }
    }
}