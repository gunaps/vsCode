public class GenerateDocbatch implements Queueable, Database.Allowscallouts{
    public String templateId;
    public String proposalId;
    public String pLevel;
    public String docFormat;
    public Boolean isDraft;
    public String sessionId;
    public String serverUrl;
   
   public GenerateDocbatch(String templateId, String proposalId, String pLevel, String docFormat, Boolean isDraft, String sessionId, String serverUrl){
      this.templateId = templateId;
      this.proposalId = proposalId;
      this.pLevel = pLevel;
      this.docFormat = docFormat;
      this.isDraft = isDraft;
      this.sessionId = sessionId;
      this.serverUrl = serverUrl;    
  
   } 
   
    /*public Database.QueryLocator start(Database.BatchableContext BC){
        
            return Database.getQueryLocator('select Id, name from Apttus_Proposal__Proposal__c where id =:proposalId');
     }*/
    
    
    public void execute(QueueableContext context){
        
       try{
          
            Id attachmentId = Apttus_Proposal.MergeWebService.generateDoc2(templateId,proposalId,pLevel,docFormat,isDraft,sessionId,serverUrl);
            
            System.debug('------attachmentId  : ' + attachmentId);
            System.assertEquals('', attachmentId ,'Attachment Not Generated');

            List<Messaging.SingleEmailMessage> msgList= new List<Messaging.SingleEmailMessage>();
            Messaging.SingleEmailMessage msg = new Messaging.SingleEmailMessage();
            
            msg.setWhatId(proposalId); //Proposal Id
            msg.setTemplateId(ID.valueOf(APTS_Constants.DEFAULT_QUOTE_TEMPLATE_ID)); //templateID  '00X41000000ncfy'
            msg.settargetObjectId(ID.valueOf(APTS_Constants.DEFAULT_CONTACT_ID)); //Contact ID '00341000003lhtX'
            
            msg.setToAddresses(new List<String>{'kprajapati@apttus.com'});
            
            Attachment oAttachment = [select Id, Name, Body, BodyLength from Attachment where ID = :attachmentId];
            Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment();
            efa.setFileName(oAttachment.Name); 
            efa.setBody(oAttachment.Body);
            msg.setFileAttachments(new List<Messaging.Emailfileattachment>{efa});
            
            msgList.add(msg);
            Messaging.sendEmail(msgList);
        }
        catch(Exception e){
            System.debug('------Exception : ' + e.getMessage());
            System.debug('------Exception : ' + e.getStackTraceString());
        }
            
    }
    
    
  // public void finish(Database.BatchableContext BC){}
  
   
}