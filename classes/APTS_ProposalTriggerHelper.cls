public class APTS_ProposalTriggerHelper {
    public static final String PARTNER_SERVER_URL_140   = System.Url.getSalesforceBaseUrl().toExternalForm() + '/services/Soap/u/14.0/' + UserInfo.getOrganizationId();
    
    public static void invokeGenerateProposalBatch(Apttus_Proposal__Proposal__c oProposal){
        GenerateDocbatch oGenerateDocbatch = new GenerateDocbatch(APTS_Constants.DEFAULT_QUOTE_TEMPLATE_ID, oProposal.Id, 'Full Access', 'PDF', True, UserInfo.getSessionId(), PARTNER_SERVER_URL_140);
        
        System.enqueueJob(oGenerateDocbatch);
        //Database.executeBatch(oGenerateDocbatch, 1);
        
        oProposal.APTS_Execute_Batch__c = false;
    }
}