public with sharing class SDO_Tools {
    
    public SDO_Tools() {       
    }
    
    public void setInstanceURL(){
            //Instance URL related 
            String instanceUrl = System.URL.getSalesforceBaseURL().toExternalForm().replace('https://c.', 'https://').replace('visual.force.com', 'salesforce.com');
            Apttus_Config2__ConfigSystemProperties__c a1 = new Apttus_Config2__ConfigSystemProperties__c();
            a1 = Apttus_Config2__ConfigSystemProperties__c.getValues('System Properties');
            a1.Apttus_Config2__InstanceUrl__c = instanceUrl;
            update a1;
            Apttus_Proposal__ProposalSystemProperties__c a2 = new Apttus_Proposal__ProposalSystemProperties__c();
            a2 = Apttus_Proposal__ProposalSystemProperties__c.getValues('System Properties');
            a2.Apttus_Proposal__InstanceUrl__c = instanceUrl;
            update a2;
            Apttus_Approval__ApprovalsSystemProperties__c a3 = new Apttus_Approval__ApprovalsSystemProperties__c();
            a3 = Apttus_Approval__ApprovalsSystemProperties__c.getValues('System Properties');
            a3.Apttus_Approval__InstanceUrl__c = instanceUrl;
            update a3;
            Apttus__ComplySystemProperties__c a4 = new Apttus__ComplySystemProperties__c();
            a4 = Apttus__ComplySystemProperties__c.getValues('System Properties');
            a4.Apttus__InstanceUrl__c = instanceUrl;
            update a4;
            Apttus_XApps__XAuthorForExcelSystemProperties__c a5 = new Apttus_XApps__XAuthorForExcelSystemProperties__c();
            a5 = Apttus_XApps__XAuthorForExcelSystemProperties__c.getValues('System Properties');
            a5.Apttus_XApps__InstanceUrl__c = instanceUrl;
            update a5;
            
            //PAR Script 
            List<Apttus_Config2__ProductAttributeRule__c> PARList = [select Id, Apttus_Config2__ProductScope__c,
                                                                     Apttus_Config2__ProductGroupScope__c
                                                                     from Apttus_Config2__ProductAttributeRule__c];
            List<String> oldProdGroupIds = new List<String>();
            List<String> oldProdIds = new List<String>();
            for(Apttus_Config2__ProductAttributeRule__c paRule: PARList) {
                if (paRule.Apttus_Config2__ProductScope__c != null && paRule.Apttus_Config2__ProductScope__c != 'All') {
                    List<String> splitresult = paRule.Apttus_Config2__ProductScope__c.split(';'); 
                    oldProdIds.addAll(splitresult);
                }
                
                if (paRule.Apttus_Config2__ProductGroupScope__c != null && paRule.Apttus_Config2__ProductGroupScope__c != 'All') {
                    List<String> splitresult1 = paRule.Apttus_Config2__ProductGroupScope__c.split(';'); 
                    oldProdGroupIds.addAll(splitresult1);
                }
            }
            
            List<Product2> prodList = new List<Product2>();
            List< Apttus_Config2__ProductGroup__c > prodGrpList;
                If(oldProdIds != null && oldProdIds.size() > 0)
                prodList = [Select Id, APTS_Ext_ID__c from product2 where APTS_Ext_ID__c in : oldProdIds];
            
            If(oldProdGroupIds != null && oldProdGroupIds.size() > 0)
            prodGrpList = [Select Id, APTS_Ext_ID__c from Apttus_Config2__ProductGroup__c where APTS_Ext_ID__c in : oldProdGroupIds];
            
            Map<Id, String> oldNewIDMap = new Map<Id, String>();
            for(Product2 prd: prodList) {
                oldNewIDMap.put(prd.APTS_Ext_ID__c, prd.Id);
            }
            
            Map<Id, String> oldNewgrpIDMap = new Map<Id, String>();
            
            if (prodGrpList != null && prodGrpList.size() > 0){
                for(Apttus_Config2__ProductGroup__c prdgrp: prodGrpList) {
                   oldNewgrpIDMap.put(prdgrp.APTS_Ext_ID__c, prdgrp.Id);
                }
            }
            
            system.debug('PARList:::::'+PARList);
            for(Apttus_Config2__ProductAttributeRule__c paRule: PARList) {
                if(paRule.Apttus_Config2__ProductScope__c != null && paRule.Apttus_Config2__ProductScope__c != 'All') {
                    List<String> splitresult1 = paRule.Apttus_Config2__ProductScope__c.split(';'); 
                    String newProdIds = '';
                    for(String str: splitresult1) {
                        String newId = oldNewIDMap.get(str);
                        if(newProdIds != '')
                                newProdIds = newProdIds + ';' + newId;
                        else
                            newProdIds = newId;
                    }
                    paRule.Apttus_Config2__ProductScope__c = newProdIds;   
                }
            //--------------------------------------------------------------------------
                if(paRule.Apttus_Config2__ProductGroupScope__c != null && paRule.Apttus_Config2__ProductGroupScope__c != 'All') {
                    List<String> splitresult2 = paRule.Apttus_Config2__ProductGroupScope__c.split(';'); 
                    String newProdGrpIds = '';
                    for(String str: splitresult2) {
                        String newId = oldNewgrpIDMap.get(str);
                        if(newProdGrpIds.length() > 0)
                               newProdGrpIds = newProdGrpIds + ';' + newId;
                        else
                           newProdGrpIds = newId;
                    }
                    paRule.Apttus_Config2__ProductGroupScope__c = newProdGrpIds;    
                }
            }
            system.debug('PARListafter:::::'+PARList);
            Update PARList;
    
            //Field Expression Part
          
            try
            {
                            List<Apttus_Config2__ProductAttributeGroupMember__c> listRules = [select ID, Apttus_Config2__FieldUpdateCriteriaIds__c from Apttus_Config2__ProductAttributeGroupMember__c ];
            
                            Set<String> setProductIDs = new Set<String>();
            
                            for(Apttus_Config2__ProductAttributeGroupMember__c sObjRule: listRules)
                            {               
                                if(sObjRule.Apttus_Config2__FieldUpdateCriteriaIds__c != NULL){
                                    setProductIDs.addAll(sObjRule.Apttus_Config2__FieldUpdateCriteriaIds__c.replace('[', '').replace(']', '').replace('"', '').split(','));
                                }
                                            
                            }
                            system.debug('setProductIDs' + setProductIDs);
                            List<Apttus_Config2__FieldExpression__c> listProduct = [Select ID, APTS_Final_ID_for_script__c from Apttus_Config2__FieldExpression__c where APTS_Final_ID_for_script__c IN : setProductIDs];
                            Map<String,String> mapProductExtIDToID = new Map<String,String>();
                            for(Apttus_Config2__FieldExpression__c sObjProd : listProduct)
                            {
                                            system.debug('#@'+sObjProd.APTS_Final_ID_for_script__c+'#@');
                                            mapProductExtIDToID.put(sObjProd.APTS_Final_ID_for_script__c , sObjProd.ID);
                            }
            
                            String temp = '';
                            for(Apttus_Config2__ProductAttributeGroupMember__c sObjRule: listRules)
                            {
                                         if(sObjRule.Apttus_Config2__FieldUpdateCriteriaIds__c != NULL){   
                                            for(String str : sObjRule.Apttus_Config2__FieldUpdateCriteriaIds__c.replace('[', '').replace(']', '').replace('"', '').split(','))
                                            {
                                                            system.debug('#'+str+'#');
                                                            temp = '[' +'"'+mapProductExtIDToID.get(str)+'"'+ ']';
                                            }
                                         }    
                                            sObjRule.Apttus_Config2__FieldUpdateCriteriaIds__c = temp;
                                            system.debug(temp);
                                            temp = '';
                            }
            
                            if(listRules.size() > 0)
                            {
                                            update listRules;
                            }
            }
            Catch(Exception ex)
            {
                            System.Debug('Exception : ' + ex.getMessage());
            }             
    
    
    }
    
    public void executeMaintenanceJobs(){
            APTSMD_ExecuteMaintenanceJobs.executeAllJobs();
    }
    
    public SDO_Tools(SDOToolsHomepage sdoToolsHomepage) {
    }


}