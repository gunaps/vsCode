public without sharing class APTPS_Utils {
    /*
    public static Boolean isAutoApproval;
    public static Set<String> errorMessagesSet;
    
    private static Map<String, Schema.SObjectField> lineItemSObjectFieldsMap;
    
    public static String getErrorMessage(Exception e) {
        String exceptionType = e.getTypeName();
        String errorMessage = 'An unexpected error occured, please contact your Administrator';
        
        if(exceptionType == 'System.DmlException') {
            errorMessage = e.getDmlMessage(0);
        } else if(exceptionType == 'System.ListException' || exceptionType == 'System.MathException' || exceptionType == 'System.NoAccessException' ||
            exceptionType == 'System.NullPointerException' || exceptionType == 'System.QueryException' || exceptionType == 'System.StringException' ||
            exceptionType == 'System.VisualforceException' || exceptionType == 'System.TypeException') {
            
            errorMessage = e.getMessage();
        }
        
        return errorMessage;         
    }
    
    public static Set<String> getSalesPathSpecificFields(String salesPath) {
        List<APTPS_Shopping_Cart_Fields__c> shoppingCartFieldsList = APTPS_Shopping_Cart_Fields__c.getall().values();
        
        Set<String> allFieldsSet = new Set<String>();
        
        for(APTPS_Shopping_Cart_Fields__c shoppingCartFieldsCS : shoppingCartFieldsList) {
            if(shoppingCartFieldsCS.APTPS_Sales_Path__c == salesPath) {
                
                String generalFields = shoppingCartFieldsCS.APTPS_General_Fields__c;
                String arubaFields = shoppingCartFieldsCS.APTPS_Aruba_Fields__c;
                String distributorFields = shoppingCartFieldsCS.APTPS_Distributor_Fields__c;
                String resellerFields = shoppingCartFieldsCS.APTPS_Reseller_Account_Fields__c;
                String endUserFields = shoppingCartFieldsCS.APTPS_End_User_Fields__c;
                String burdenGrossMarginFields = shoppingCartFieldsCS.APTPS_Burden_Gross_Margin_Fields__c;
                String discountFields = shoppingCartFieldsCS.APTPS_Discount_Fields__c;
                
                if(generalFields != null && generalFields != '') {
                    List<String> fieldsList = generalFields.split(',');
                    for(String field : fieldsList) {
                        Integer index = field.indexOf('{');
                        if(index != -1) {
                            Integer endIndex = field.indexOf('}');
                            field = field.substring(0, index);
                        }

                        field = field.trim();
                        
                        if(isLineItemFieldAccessible(field)) {
                            allFieldsSet.add(field);    
                        }
                    }
                }
                
                if(arubaFields != null && arubaFields != '') {
                    List<String> fieldsList = arubaFields.split(',');
                    for(String field : fieldsList) {
                        Integer index = field.indexOf('{');
                        if(index != -1) {
                            Integer endIndex = field.indexOf('}');
                            field = field.substring(0, index);
                        }
                        
                        field = field.trim();
                        
                        if(isLineItemFieldAccessible(field)) {
                            allFieldsSet.add(field);    
                        }
                    }
                }
                
                if(distributorFields != null && distributorFields != '') {
                    List<String> fieldsList = distributorFields.split(',');
                    for(String field : fieldsList) {
                        Integer index = field.indexOf('{');
                        if(index != -1) {
                            Integer endIndex = field.indexOf('}');
                            field = field.substring(0, index);
                        }
                        
                        field = field.trim();
                        
                        if(isLineItemFieldAccessible(field)) {
                            allFieldsSet.add(field);    
                        }
                    }
                }
                
                if(resellerFields != null && resellerFields != '') {
                    List<String> fieldsList = resellerFields.split(',');
                    for(String field : fieldsList) {
                        Integer index = field.indexOf('{');
                        if(index != -1) {
                            Integer endIndex = field.indexOf('}');
                            field = field.substring(0, index);
                        }
                        
                        field = field.trim();
                        
                        if(isLineItemFieldAccessible(field)) {
                            allFieldsSet.add(field);
                        }
                    }
                }
                
                if(endUserFields != null && endUserFields != '') {
                    List<String> fieldsList = endUserFields.split(',');
                    for(String field : fieldsList) {
                        Integer index = field.indexOf('{');
                        if(index != -1) {
                            Integer endIndex = field.indexOf('}');
                            field = field.substring(0, index);
                        }
                        
                        field = field.trim();
                        
                        if(isLineItemFieldAccessible(field)) {
                            allFieldsSet.add(field);
                        }       
                    }
                }
                
                if(burdenGrossMarginFields != null && burdenGrossMarginFields != '') {
                    List<String> fieldsList = burdenGrossMarginFields.split(',');
                    for(String field : fieldsList) {
                        Integer index = field.indexOf('{');
                        if(index != -1) {
                            Integer endIndex = field.indexOf('}');
                            field = field.substring(0, index);
                        }
                        
                        field = field.trim();
                        
                        if(isLineItemFieldAccessible(field)) {
                            allFieldsSet.add(field);
                        }       
                    }
                }
                
                if(discountFields != null && discountFields != '') {
                    List<String> fieldsList = discountFields.split(',');
                    for(String field : fieldsList) {
                        Integer index = field.indexOf('{');
                        if(index != -1) {
                            Integer endIndex = field.indexOf('}');
                            field = field.substring(0, index);
                        }
                        
                        field = field.trim();
                        
                        if(isLineItemFieldAccessible(field)) {
                            allFieldsSet.add(field);
                        }       
                    }
                }
            }
        }
        
        return allFieldsSet;
    }
    
    private static Boolean isLineItemFieldAccessible(String fieldAPIName) {
        if(lineItemSObjectFieldsMap == null) {
            lineItemSObjectFieldsMap = Schema.SObjectType.Apttus_Config2__LineItem__c.fields.getMap(); 
        }
        
        Schema.Sobjectfield sObjectField = lineItemSObjectFieldsMap.get(fieldAPIName);
        Schema.DescribeFieldResult res = sObjectField.getDescribe();
        
        return res.isAccessible();
    }
    
    public static String getSalesforceBaseUrl() {
        return System.URL.getSalesforceBaseUrl().toExternalForm();
    }
    */
    public static String getVFPageUrlPrefix() {
        
        if(UserInfo.getUserType() == 'Partner' || UserInfo.getUserType() == 'PowerPartner') {
            //return '/prm';
            return '';
        } else {
            return '/apex';
        }
        
        //return '';
    }
    
    public static Boolean isPartnerUser() {
        if(UserInfo.getUserType() == 'Partner' || UserInfo.getUserType() == 'PowerPartner') {
            return true;
        } else {
            return false;
        }
    }
    /*
    public static Boolean isIndirectPartnerUser() {
        if(UserInfo.getUserType() == 'Partner' || UserInfo.getUserType() == 'PowerPartner') {
            String userId = UserInfo.getUserId();
            
            User usr = [Select Contact.Account.Direct__c From User Where Id = :userId limit 1];
            
            if(usr != null && usr.Contact.Account.Direct__c != null && usr.Contact.Account.Direct__c == 'Direct') {
                return false;
            }
            
            return true;
        } else {
            return false;
        }
    }
    */
    /*
    public static void setCloneFromQuoteIdFieldInProposal(Apttus_Proposal__Proposal__c proposal, String proposalId) {
        proposal.Cloned_From_Quote_Id__c = proposalId;
        update proposal;
    }
    
    public static List<String> getApproversList(String productConfigId, String proposalOwnerName) {
        List<String> approversList = new List<String>();
        errorMessagesSet = new Set<String>();
        isAutoApproval = false;
        
        DateTime currentDateTime = System.now();
        
        try {
            Boolean response = Apttus_Approval.ApprovalsWebService.previewApprovals('Apttus_Config2__ProductConfiguration__c', productConfigId);   
            
            List<Apttus_Approval__Approval_Request__c> approvalRequestList = [Select Apttus_Approval__Assigned_To_Type__c, Apttus_Approval__Assigned_To_Id__c,
                Apttus_Approval__Assigned_To_Link__c, Apttus_Approval__Approval_Status__c 
                From Apttus_Approval__Approval_Request__c Where Apttus_CQApprov__CartId__c = : productConfigId AND CreatedDate >= :currentDateTime 
                order by Apttus_Approval__StepSequence__c];
            
            if(!approvalRequestList.isEmpty()) {
                List<Id> userIdList = new List<Id>();
                for(Apttus_Approval__Approval_Request__c request : approvalRequestList) {
                    if(request.Apttus_Approval__Approval_Status__c == 'Not Submitted' && (request.Apttus_Approval__Assigned_To_Type__c == 'User' || 
                        request.Apttus_Approval__Assigned_To_Type__c == 'Related User' || request.Apttus_Approval__Assigned_To_Type__c == 'Custom User')) {
                        userIdList.add(request.Apttus_Approval__Assigned_To_Id__c);
                    }
                }
                
                Map<Id, User> userMap = new Map<Id, User>([Select UserRoleId, UserRole.Name, Name From User Where Id IN :userIdList]);
                
                for(Apttus_Approval__Approval_Request__c request : approvalRequestList) {
                    if(request.Apttus_Approval__Approval_Status__c == 'Not Submitted' && (request.Apttus_Approval__Assigned_To_Type__c == 'User' || 
                        request.Apttus_Approval__Assigned_To_Type__c == 'Related User' || request.Apttus_Approval__Assigned_To_Type__c == 'Custom User')) {
                        User u = userMap.get(request.Apttus_Approval__Assigned_To_Id__c);
                        
                        if(u.Name == proposalOwnerName) {
                            isAutoApproval = true;
                        }
                        
                        String approver = '';
                    
                        if(u.UserRoleId != null) {
                          //  approver = approver + u.UserRole.Name + ', ';
                            approver = u.UserRole.Name + ', ';
                        }
                        
                      //  approver = approver + u.Name;
                        approver = u.Name;
                        approversList.add(approver);    
                    } else if(request.Apttus_Approval__Approval_Status__c == 'Not Submitted') {
                        approversList.add(request.Apttus_Approval__Assigned_To_Link__c);
                    }
                }
                
                if(approversList.size() > 1) {
                    isAutoApproval = false;    
                }
                
                deleteApprovalRequests(approvalRequestList);
            }
        } catch(Exception e) {
            system.debug(e);
            errorMessagesSet.add('ERROR: ' + 'Error occured while accessing approvers list, please contact your System Administrator.');
            //errorMessagesSet.add('ERROR: ' + e.getMessage());
        }
        
        return approversList;
    }
    
    public static void deleteApprovalRequests(List<Apttus_Approval__Approval_Request__c> approvalRequestList) {
        delete approvalRequestList; 
    }
    
    public static void submitForApprovals(String productConfigId, String submissionComments) {
        
        if(submissionComments != null && submissionComments.trim() != '') {
            Apttus_Approval.SubmissionComments comments = Apttus_Approval.ApprovalsWebService.checkIfCommentsRequired(productConfigId, 'Apttus_Config2__ProductConfiguration__c');
            
            if(comments != null) {
                comments.setProcessComment(submissionComments);
            
                Apttus_Approval.ApprovalsWebService.submitForApprovalsWithComments('Apttus_Config2__ProductConfiguration__c', productConfigId, comments);
            } else {
                Apttus_Approval.ApprovalsWebService.submitForApprovals('Apttus_Config2__ProductConfiguration__c', productConfigId); 
            }
        } else {
            Apttus_Approval.ApprovalsWebService.submitForApprovals('Apttus_Config2__ProductConfiguration__c', productConfigId); 
        }
        
    }
    
    public static void resetClonedFromIdFieldOnSource(Set<Id> sourceProposalIdSet) {
        List<Apttus_Proposal__Proposal__c> sourceProposalObjList = [Select Cloned_From_Quote_Id__c From Apttus_Proposal__Proposal__c Where Id IN :sourceProposalIdSet];
        
        for(Apttus_Proposal__Proposal__c sourceProp : sourceProposalObjList) {
            sourceProp.Cloned_From_Quote_Id__c = null;
        }
        
        update sourceProposalObjList;
    }
    
    public static List<Account> getAccounts(ID AccountID1, ID AccountID2) {
        List<Account> accountList = [Select ID, Direct__c, Partner_Contract_s_and_Level1__c 
            From Account Where ID = :AccountID1 OR ID = :AccountID2 Limit 2];
        
        return accountList;
    }
    
    public static List<Contract> getContracts(ID AccountID1) {
        List<Contract> myContract = [Select ID, NSP_Rate__c, NSP__c, Product_Discount__c, Professional_Services_Discount__c, Support_Discount__c, 
            Training_Discount_Internal__c, Training_Discount_Re_sale__c 
            From Contract Where AccountID = :AccountID1 AND Status = 'Activated' 
            AND RecordTypeID IN (Select Id From RecordType where sobjecttype = 'Contract' and name in ('Channel Partner Contract')) Limit 1];
            
        return myContract;
    }
    */
}