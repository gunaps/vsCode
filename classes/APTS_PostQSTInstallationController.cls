public with sharing class APTS_PostQSTInstallationController {

    public void executeMaintenanceJobs(){
            APTSMD_ExecuteMaintenanceJobs.executeAllJobs();
    }
    
    public void assignPermissionSet(){
            //THIS SCRIPT WILL ASSIGN PERMISSION SET TO PROFILE DIRECTLY 
            //SALESFORCE PROVIDE PERMISSION SET ASSIGNMENT FOR USER

            //INPUT THE PERMISSION SET API NAME IN STRING VARIABLE IN BELOW LINE
            String permissionSetAPIName = 'APTPS_CPQ';
            //INPUT THE PROFILE NAME IN STRING VARIABLE IN BELOW LINE
            String profileName = 'System Administrator';

            List<PermissionSetAssignment> newAssignmentList = new List<PermissionSetAssignment>();
            PermissionSetAssignment tempPerm;
            List<User> newListUser = [select user.id FROM user Where user.profile.name = :profileName and isActive = true];
            Set<ID> asigneeSet = new Set<ID>();
            List<PermissionSet> permObjList = [select ID from PermissionSet where Name = :permissionSetAPIName];
            System.Debug(permObjList[0].ID);
            for(PermissionSetAssignment tempVar: [SELECT Id, AssigneeID FROM PermissionSetAssignment WHERE PermissionSetId = :permObjList[0].ID])
            {
                System.Debug('AssigneeID => '+ tempVar.AssigneeID);
                asigneeSet.add(tempVar.AssigneeID);
            }

            for(User usr : newListUser)
            {
                System.Debug('Hello => '+ usr.ID);
                if(!asigneeSet.contains(usr.ID) && permObjList.size() >0)
                {
                    tempPerm = new PermissionSetAssignment(AssigneeId = usr.ID, PermissionSetId = permObjList[0].ID);
                    System.Debug(usr.ID);
                    newAssignmentList.add(tempPerm);
                }
            }
            if(newAssignmentList.size()>0)
            {
                insert newAssignmentList;
            }
    }
    
    


    public void deleteAllIWAData(){
        List<Apttus_Approval__Approval_Process__c> newList30 = [select Id from Apttus_Approval__Approval_Process__c];
        
        if(newList30.size() > 0 )
            delete newList30;
            
        List<Apttus_Approval__ApprovalRuleAssignee__c> newList31 = [select Id from Apttus_Approval__ApprovalRuleAssignee__c];
        
        if(newList31.size() > 0 )
            delete newList31;

        List<Apttus_Approval__ApprovalRuleEntry__c> newList32 = [select Id from Apttus_Approval__ApprovalRuleEntry__c];
        
        if(newList32.size() > 0 )
            delete newList32;

        List<Apttus_Approval__ApprovalRule__c> newList33 = [select Id from Apttus_Approval__ApprovalRule__c];
        
        if(newList33.size() > 0 )
            delete newList33;


        List<Apttus_Approval__ApprovalRuleDimension__c> newList34 = [select Id from Apttus_Approval__ApprovalRuleDimension__c];
        
        if(newList34.size() > 0 )
            delete newList34;


        List<Apttus_Approval__SearchFilter__c> newList35 = [select Id from Apttus_Approval__SearchFilter__c];
        
        if(newList35.size() > 0 )
            delete newList35;
            
    }


    public void deleteAllCPQData(){
    
        // Opportunity Products
    
        List<OpportunityLineItem> newList60 = [select Id from  OpportunityLineItem];
        
        if(newList60.size() > 0 )
            delete newList60;
    
        List<Product2> newList40 = [select Id from Product2];
        
        if(newList40.size() > 0 )
            delete newList40;
            
        List<Apttus_Config2__ClassificationName__c > newList41 = [select Id from Apttus_Config2__ClassificationName__c ];
        
        if(newList41.size() > 0 )
            delete newList41;

        List<Apttus_Config2__ClassificationHierarchy__c > newList42 = [select Id from Apttus_Config2__ClassificationHierarchy__c ];
        
        if(newList42.size() > 0 )
            delete newList42;

        List<Apttus_Config2__ProductClassification__c > newList43 = [select Id from Apttus_Config2__ProductClassification__c ];
        
        if(newList43.size() > 0 )
            delete newList43;


        List<Apttus_Config2__ProductOptionGroup__c > newList44 = [select Id from Apttus_Config2__ProductOptionGroup__c ];
        
        if(newList44.size() > 0 )
            delete newList44;


        List<Apttus_Config2__ProductOptionComponent__c > newList45 = [select Id from Apttus_Config2__ProductOptionComponent__c ];
        
        if(newList45.size() > 0 )
            delete newList45;
            
        List<Apttus_Config2__PriceList__c  > newList46 = [select Id from Apttus_Config2__PriceList__c  ];
        
        if(newList46.size() > 0 )
            delete newList46;

        List<Apttus_Config2__PriceListCategory__c  > newList47 = [select Id from Apttus_Config2__PriceListCategory__c  ];
        
        if(newList47.size() > 0 )
            delete newList47;   

        List<Apttus_Config2__PriceListItem__c   > newList48 = [select Id from Apttus_Config2__PriceListItem__c   ];
        
        if(newList48.size() > 0 )
            delete newList48;           
            
    }


    public void deleteAllCPQCateData(){

            


        List<Apttus_Config2__ClassificationHierarchy__c > newList62 = [select Id from Apttus_Config2__ClassificationHierarchy__c where Apttus_Config2__ProductCount__c = 0 ];
        
        if(newList62.size() > 0 )
            delete newList62;



         
            
    }

    
    public void deleteAllCustomSettings(){
    
        List<Apttus_Approval__ApprovalsSystemProperties__c> newList12 = [Select ID from Apttus_Approval__ApprovalsSystemProperties__c];
        List<Apttus__ComplyCustomProperties__c> newList13 = [Select ID from Apttus__ComplyCustomProperties__c];
        List<Apttus__ComplySystemProperties__c> newList14 = [Select ID from Apttus__ComplySystemProperties__c];
        List<Apttus_Config2__ConfigCustomClasses__c> newList15 = [Select ID from Apttus_Config2__ConfigCustomClasses__c];
        List<Apttus_Config2__ConfigSelectBundleOptionsSettings__c> newList16 = [Select ID from Apttus_Config2__ConfigSelectBundleOptionsSettings__c];
        List<Apttus_Config2__ConfigSelectConfigProductsSettings__c> newList17 = [Select ID from Apttus_Config2__ConfigSelectConfigProductsSettings__c];
        List<Apttus_Config2__ConfigSystemProperties__c> newList18 = [Select ID from Apttus_Config2__ConfigSystemProperties__c];
        List<Apttus_Proposal__ProposalSystemProperties__c> newList20 = [Select ID from Apttus_Proposal__ProposalSystemProperties__c];
        List<Apttus_XApps__XAuthorForExcelSystemProperties__c> newList21 = [Select ID from Apttus_XApps__XAuthorForExcelSystemProperties__c];
        List<Apttus_DocuApi__DocuSignSystemProperties__c> newList22 = [Select ID from Apttus_DocuApi__DocuSignSystemProperties__c];
        List<Apttus_Config2__ObjectSummarySettings__c> newList23 = [Select ID from Apttus_Config2__ObjectSummarySettings__c];
        List<Apttus_Approval__ApprovalsCustomConfig__c> newList24 = [Select ID from Apttus_Approval__ApprovalsCustomConfig__c];
        List<Apttus_Config2__ConfigFlow__c> newList25 = [Select ID from Apttus_Config2__ConfigFlow__c];
        List<Apttus_Config2__ConfigCustomDisplayActions__c> newList26 = [Select ID from Apttus_Config2__ConfigCustomDisplayActions__c];
        List<Apttus_Config2__ConfigCustomDisplayColumns__c> newList27 = [Select ID from Apttus_Config2__ConfigCustomDisplayColumns__c];
        List<Apttus_Config2__ConfigLineItemCustomFields__c> newList28 = [Select ID from Apttus_Config2__ConfigLineItemCustomFields__c];
        
        
        if(newList12.size() > 0 )
            delete newList12;
        if(newList13.size() > 0 )
            delete newList13;
        if(newList14.size() > 0 )
            delete newList14;
        if(newList15.size() > 0 )
            delete newList15;
        if(newList16.size() > 0 )
            delete newList16;
        if(newList17.size() > 0 )
            delete newList17;
        if(newList18.size() > 0 )
            delete newList18;
        if(newList20.size() > 0 )
            delete newList20;
        if(newList21.size() > 0 )
            delete newList21;
        if(newList22.size() > 0 )
            delete newList22;
        if(newList23.size() > 0 )
            delete newList23;
        if(newList24.size() > 0 )
            delete newList24;
        if(newList25.size() > 0 )
            delete newList25;
        if(newList26.size() > 0 )
            delete newList26;
        if(newList27.size() > 0 )
            delete newList27;
        if(newList28.size() > 0 )
            delete newList28;

    
    }
    
    public void createCustomSettings(){
            
            deleteAllCustomSettings();
            
            String instanceUrl = System.URL.getSalesforceBaseURL().toExternalForm().replace('https://c.', 'https://').replace('visual.force.com', 'salesforce.com');
            

            Apttus_Config2__ConfigCustomClasses__c customClasses = new Apttus_Config2__ConfigCustomClasses__c();
            customClasses.Name = 'System Properties';
            customClasses.Apttus_Config2__CartApprovalCallbackClass__c = 'Apttus_CQApprov.CartApprovalCallback';
            insert customClasses;

            Apttus_Approval__ApprovalsSystemProperties__c a1 = new Apttus_Approval__ApprovalsSystemProperties__c();
            a1.Name = 'System Properties';
            a1.Apttus_Approval__AdminUser__c= UserInfo.getName();
            a1.Apttus_Approval__ApprovalTaskPrefix__c= null;
            a1.Apttus_Approval__BackupAdminProfile__c= 'System Administrator';
            a1.Apttus_Approval__BackupAdminUser__c= UserInfo.getName();
            a1.Apttus_Approval__BackupFilterPage__c= null;
            a1.Apttus_Approval__BypassSharing__c= true;
            a1.Apttus_Approval__EmailApprovalServiceAddress__c= '';
            a1.Apttus_Approval__EmailSenderDisplayName__c= 'Approver';
            a1.Apttus_Approval__EnableApprovalRequestAutoEscalation__c= true;
            a1.Apttus_Approval__EnableEmailApprovalResponse__c= true;
            a1.Apttus_Approval__EnableResubmit__c= true;
            a1.Apttus_Approval__InstanceUrl__c= instanceUrl;
            a1.Apttus_Approval__ReassignFilterPage__c= null;
            a1.Apttus_Approval__ReassignMyApprovalsFilterPage__c= null;
            a1.Apttus_Approval__UIAssigneeSearchPageSize__c= null;
            a1.Apttus_Approval__UICustomAssigneeObjectTypes__c= 'Apttus_Proposal__Proposal__c.Apttus_Config2__ProductConfiguration__c';
            a1.Apttus_CQApprov__CartApprovalContextType__c= 'cart';
            a1.Apttus_CQApprov__CartApprovalPreviewPage__c= null;
            a1.Apttus_CQApprov__EnableApprovalCheckOnQuoteUpdate__c= true;
            insert a1;
            
            Apttus__ComplySystemProperties__c csp = new Apttus__ComplySystemProperties__c();
            
            csp.Name = 'System Properties';
            csp.Apttus__AdminUser__c=null;
            csp.Apttus__AgreementNumberFieldForImportedDocs__c=null;
            csp.Apttus__AllowPDFSelectionOverride__c=true;
            csp.Apttus__AllowPrivateSelectionOverride__c=true;
            csp.Apttus__AllowReconcileSelectionOverride__c=true;
            csp.Apttus__ApiUserKey__c=null;
            csp.Apttus__AutoEnablePDFForFinalDocs__c=false;
            csp.Apttus__AutoEnablePrivateIndicator__c=false;
            csp.Apttus__AutoEnableReconciliation__c=false;
            csp.Apttus__AutoInsertHeaderFooterData__c=false;
            csp.Apttus__BypassSharing__c=false;
            csp.Apttus__ContractSummaryTemplate__c=null;
            csp.Apttus__DefaultDocumentTags__c=null;
            csp.Apttus__DefaultOpportunityAgreementOwner__c='Opportunity Owner';
            csp.Apttus__DocumentNamingConvention__c=null;
            csp.Apttus__DocumentStructureFX2ForImportedDocs__c=true;
            csp.Apttus__DocumentVersioningNamingConvention__c=null;
            csp.Apttus__EmailTemplateForCheckinNotification__c=null;
            csp.Apttus__EnableClauseApprovals__c=false;
            csp.Apttus__EnableDocumentVersioning__c=true;
            csp.Apttus__EnableMergeCallDebug__c=false;
            csp.Apttus__EnableMultipleCheckout__c=false;
            csp.Apttus__EnablePDFSecurity__c=true;
            csp.Apttus__EnableSubmitMergeCall__c=false;
            csp.Apttus__EnableTemplateVersioning__c=false;
            csp.Apttus__EnableVersionControl__c=true;
            csp.Apttus__FooterDatetimeFormatForImportedDocs__c=null;
            csp.Apttus__InstanceUrl__c= instanceUrl;
            csp.Apttus__MaxChildLevel__c=null;
            csp.Apttus__MergeCallTimeoutMillis__c=60000;
            csp.Apttus__MergeWebserviceEndpoint__c='https://mergews.apttus.net/cgi-bin/4.2.1.2/MergeServer/Bin/MMCGI.exe';
            csp.Apttus__PDFOwnerPwd__c=null;
            csp.Apttus__PublishAuthorEvents__c=false;
            csp.Apttus__PublishMergeEvents__c=false;
            csp.Apttus__TempEmailTemplateInactiveHours__c=null;
            csp.Apttus__UseAgreementLocksForVersioning__c=true;
            csp.Apttus_CMConfig__AutoCreateOrder__c=true;
            csp.Apttus_CMConfig__AutoSyncWithOpportunity__c=true;
            csp.Apttus_CMConfig__CloneWithApprovalStatus__c=false;
            csp.Apttus_CMConfig__EnableAgreementSummary__c=false;
            csp.Apttus_CMConfig__SyncBundleUsingLineItems__c=false;
            csp.Apttus_CMConfig__SyncOptionProducts__c=false;
            csp.Apttus_CMDSign__AutoSelectAttachment__c=false;
            csp.Apttus_CMDSign__AutoSelectMultipleRecipients__c=false;
            csp.Apttus_CMDSign__ESignatureStrictMode__c=false;
            csp.Apttus_CMDSign__EnableDocumentPreviewInDocuSign__c=false;
            csp.Apttus_CMDSign__FieldNameAutoSelectRecipient__c=null;
            csp.Apttus_CMDSign__FilterRSPCByPrimaryAgreementStatus__c=false;
            csp.Apttus_CMDSign__OneClickSend__c=false;
            csp.Apttus_CMDSign__SelectAttachmentsFromRSPCAgreements__c=false;
            csp.Apttus_CMDSign__UpdateRSPCAgreementStatus__c=false;
            csp.Apttus_CMDSign__SelectAllAttachments__c=false;
            insert csp;
            
            Apttus_Config2__ConfigSelectBundleOptionsSettings__c a4 = new Apttus_Config2__ConfigSelectBundleOptionsSettings__c ();
            
            a4.Name='Primary Settings';
            a4.Apttus_Config2__BundleDescriptionField__c=null;
            a4.Apttus_Config2__HideDisabledOptions__c=false;
            a4.Apttus_Config2__HidePriceColumn__c=false;
            a4.Apttus_Config2__HideValidateButton__c=false;
            a4.Apttus_Config2__ListedOptionsColumn2__c=null;
            a4.Apttus_Config2__ListedOptionsColumn3__c=null;
            a4.Apttus_Config2__MainSectionRatio__c='0:70:30';
            a4.Apttus_Config2__MaxInlineOptionAttributes__c=3;
            a4.Apttus_Config2__OptionFieldInSummary__c=null;
            a4.Apttus_Config2__ShowBundleDetail__c=false;
            a4.Apttus_Config2__ShowOptionQuantity__c=true;
            insert a4;
            
            Apttus_Config2__ConfigSelectConfigProductsSettings__c a5 = new Apttus_Config2__ConfigSelectConfigProductsSettings__c ();
            
            a5.Name='Primary Settings';
            a5.Apttus_Config2__AlwaysDisplayLeafProducts__c=false;
            a5.Apttus_Config2__CacheAllProducts__c=false;
            a5.Apttus_Config2__CarouselCategoryLevel__c=null;
            a5.Apttus_Config2__CarouselDefaultIcon__c=null;
            a5.Apttus_Config2__CartListItemDescriptionField__c=null;
            a5.Apttus_Config2__CollapseAllLeafOptionGroups__c=false;
            a5.Apttus_Config2__CustomActionLabelName__c=null;
            a5.Apttus_Config2__CustomActionPage__c=null;
            a5.Apttus_Config2__DisableAddAnother__c=false;
            a5.Apttus_Config2__DisableAddToCartForOptionProducts__c=false;
            a5.Apttus_Config2__DisableAddToCartOnClick__c=false;
            a5.Apttus_Config2__EnableCategoryFilter__c=true;
            a5.Apttus_Config2__HideBreadcrumb__c=false;
            a5.Apttus_Config2__HideCartHeader__c=false;
            a5.Apttus_Config2__HideCompareProducts__c=false;
            a5.Apttus_Config2__HideConfigureAction__c=false;
            a5.Apttus_Config2__HideDefaultOptionsInDescription__c=false;
            a5.Apttus_Config2__HideHelpMeChoose__c=false;
            a5.Apttus_Config2__HideLineItemAttributeDetails__c=true;
            a5.Apttus_Config2__HideListedProductsPriceColumn__c=false;
            a5.Apttus_Config2__HideNarrowYourSearch__c=false;
            a5.Apttus_Config2__HideOptions__c=true;
            a5.Apttus_Config2__HideProductImage__c=false;
            a5.Apttus_Config2__HideSelectedProductChargeTypes__c=true;
            a5.Apttus_Config2__HideSelectedProductsColumn1__c=false;
            a5.Apttus_Config2__HideSingleTopCategory__c=false;
            a5.Apttus_Config2__ListedFavoriteConfigurationsColumn1__c=null;
            a5.Apttus_Config2__ListedFavoriteConfigurationsColumn2__c=null;
            a5.Apttus_Config2__ListedProductsColumn2__c='Description';
            a5.Apttus_Config2__ListedProductsColumn3__c=null;
            a5.Apttus_Config2__ListedProductsDefaultIcon__c=null;
            a5.Apttus_Config2__MainSectionRatio__c='20:60:20';
            a5.Apttus_Config2__OrderStatusFields__c=null;
            a5.Apttus_Config2__ProductCacheFields1__c=null;
            a5.Apttus_Config2__ProductCacheFields2__c=null;
            a5.Apttus_Config2__ProductCacheFields3__c=null;
            a5.Apttus_Config2__ProductCacheFields4__c=null;
            a5.Apttus_Config2__ReadOnlyLocation__c=true;
            a5.Apttus_Config2__SearchQueryLimit__c=1000;
            a5.Apttus_Config2__SelectedProductsColumn2__c=null;
            a5.Apttus_Config2__SelectedProductsColumn3__c=null;
            a5.Apttus_Config2__SelectedProductsColumn4__c=null;
            a5.Apttus_Config2__ShowCartIcon__c=false;
            a5.Apttus_Config2__ShowCheckboxInRuleDialog__c=true;
            a5.Apttus_Config2__ShowProductIconCartDetailView__c=true;
            a5.Apttus_Config2__ShowQuantity__c=true;
            a5.Apttus_Config2__ShowRecommendedProductsCartView__c=true;
            a5.Apttus_Config2__ShowSelectedProductAllCharges__c=false;
            a5.Apttus_Config2__ShowSelectedProductsInConfigOptions__c=true;
            a5.Apttus_Config2__TwoColumnAttributeDisplay__c=false;
            a5.Apttus_Config2__DisableFavorites__c=false;
            a5.Apttus_Config2__FavoritesCategoryUploadImage__c=null;
            a5.Apttus_Config2__FavoritesDisplayLabel__c=null;
            a5.Apttus_Config2__FavoritesIconAttachmentId__c=null;
            insert a5;
            
            Apttus_Config2__ConfigSystemProperties__c a6 = new Apttus_Config2__ConfigSystemProperties__c ();
            
            a6.Name='System Properties';
            a6.Apttus_Config2__CartTheme__c = 'Classic';
            a6.Apttus_Config2__ActionsColumnPosition__c=null;
            a6.Apttus_Config2__AdminUser__c=null;
            a6.Apttus_Config2__AlertInclude__c=true;
            a6.Apttus_Config2__AlertSelectedExclude__c=false;
            a6.Apttus_Config2__AutoFinalizeOnCartApproval__c=true;
            a6.Apttus_Config2__AutoSyncOnCartApproval__c=true;
            a6.Apttus_Config2__AutoUpdateCategoryView__c=false;
            a6.Apttus_Config2__BaseProductRelationField__c=null;
            a6.Apttus_Config2__BypassSharing__c=false;
            a6.Apttus_Config2__BypassShoppingCart__c=false;
            a6.Apttus_Config2__CSSOverride__c='';
            a6.Apttus_Config2__CascadeSharedAttributeUpdates__c=true;
            a6.Apttus_Config2__CleanupInvalidRulePrompt__c=false;
            a6.Apttus_Config2__ComputeTotalsInSeparateStep__c=false;
            a6.Apttus_Config2__CurrencyFieldPrecision__c=2;
            a6.Apttus_Config2__CustomAssetActionLabelName__c=null;
            a6.Apttus_Config2__CustomAssetActionPage__c=null;
            a6.Apttus_Config2__CustomDealGuidancePage__c=null;
            a6.Apttus_Config2__CustomOptionAttributePage__c=null;
            a6.Apttus_Config2__CustomPricingFields__c=null;
            a6.Apttus_Config2__DefaultAssetPricingIndicator__c=true;
            a6.Apttus_Config2__DefaultProductsPage__c='Apttus_Config2__SelectConfigProductsFilterView';
            a6.Apttus_Config2__DeferPricingUntilCart__c=false;
            a6.Apttus_Config2__DeferValidationCheckInBundles__c=true;
            a6.Apttus_Config2__DirectConfigureAssetActions__c=null;
            a6.Apttus_Config2__DisableChargeTypeTotaling__c=false;
            a6.Apttus_Config2__DisableConstraintRules__c=false;
            a6.Apttus_Config2__DisableExistingAssetPricing__c=false;
            a6.Apttus_Config2__DisablePricingQueryOptimization__c=false;
            a6.Apttus_Config2__DisplayCartActionsAsDropdown__c=true;
            a6.Apttus_Config2__EnableAggregatePricing__c=false;
            a6.Apttus_Config2__EnableAutoReprice__c=true;
            a6.Apttus_Config2__EnableAutoSequencingForOptions__c=false;
            a6.Apttus_Config2__EnableDefaultingForOptions__c=false;
            a6.Apttus_Config2__EnableDefaultingForProducts__c=false;
            a6.Apttus_Config2__EnableExternalPricing__c=false;
            a6.Apttus_Config2__EnableFastCloning__c=false;
            a6.Apttus_Config2__EnableFieldExpression__c=true;
            a6.Apttus_Config2__EnableLocation__c=true;
            a6.Apttus_Config2__EnableMatrixPricingForOptions__c=true;
            a6.Apttus_Config2__EnhancedSearchURL__c=null;
            a6.Apttus_Config2__ExpandBundleLinesByDefault__c=false;
            a6.Apttus_Config2__FieldExpressionsExecutionMode__c=null;
            a6.Apttus_Config2__FixedButtonBar__c=false;
            a6.Apttus_Config2__GroupByFields__c=null;
            a6.Apttus_Config2__GuidePageDefault__c='SFDCFlow';
            a6.Apttus_Config2__HideAssetActions__c=null;
            a6.Apttus_Config2__HideCopyAction__c=false;
            a6.Apttus_Config2__HideGrandTotal__c=false;
            a6.Apttus_Config2__HideResolveConfigLink__c=false;
            a6.Apttus_Config2__HideSubtotalsInCart__c=false;
            a6.Apttus_Config2__IndicateErrorTypeExclude__c=false;
            a6.Apttus_Config2__IndicateWarningTypeExclude__c=false;
            a6.Apttus_Config2__InstanceUrl__c=instanceUrl;
            a6.Apttus_Config2__KeepAbandonedCarts__c=false;
            a6.Apttus_Config2__LargeCartThreshold__c=null;
            a6.Apttus_Config2__MaxAdjustmentLines__c=1;
            a6.Apttus_Config2__MaxConstraintRulesRoundTrip__c=3;
            a6.Apttus_Config2__MiscChargeTypes__c=null;
            a6.Apttus_Config2__MultiCurrencyManagement__c=null;
            a6.Apttus_Config2__OptionLineItemColumns__c=null;
            a6.Apttus_Config2__OptionPricingChunkSize__c=100;
            a6.Apttus_Config2__OptionProductColumns__c=null;
            a6.Apttus_Config2__OptionsPageDefault__c='Apttus_Config2__SelectConfigOptionsDetailView';
            a6.Apttus_Config2__PercentageFieldPrecision__c=null;
            a6.Apttus_Config2__PreventErrorExcludeSelection__c=false;
            a6.Apttus_Config2__PreventErrorTypeExcludeSelection__c=false;
            a6.Apttus_Config2__PricingBatchSize__c=null;
            a6.Apttus_Config2__PricingProfile__c='Advanced';
            a6.Apttus_Config2__ProductAttributeDetailPage__c='Apttus_Config2__ProductAttributeDetail3';
            a6.Apttus_Config2__ProductAttributeExtensionLookupFields__c=null;
            a6.Apttus_Config2__ProductDisplayMaxLength__c=1000;
            a6.Apttus_Config2__ProductTotalingHierarchy__c=null;
            a6.Apttus_Config2__QuantityFieldPrecision__c=null;
            a6.Apttus_Config2__ResolveConfigurationPageDefault__c='Apttus_Config2__ResolveConfig';
            a6.Apttus_Config2__RunFinalizationTaskInAsyncMode__c=true;
            a6.Apttus_Config2__RunSecondaryFinalizationTaskInAsyncMode__c=false;
            a6.Apttus_Config2__SaveOnAllActions__c=false;
            a6.Apttus_Config2__SearchAttributeDefaultPage__c=null;
            a6.Apttus_Config2__SearchAttributeValuePage__c='Cart';
            a6.Apttus_Config2__SearchCategoryDefault__c='AllCategories';
            a6.Apttus_Config2__ShowAdminSidebar__c=false;
            a6.Apttus_Config2__ShowAttributesInCart__c=true;
            a6.Apttus_Config2__ShowErrorInHeader__c=false;
            a6.Apttus_Config2__ShowHeader__c=false;
            a6.Apttus_Config2__ShowInfoInHeader__c=false;
            a6.Apttus_Config2__ShowMessageInline__c=false;
            a6.Apttus_Config2__ShowWarningInHeader__c=false;
            a6.Apttus_Config2__SkipPricingOnSelectPages__c=false;
            a6.Apttus_Config2__SkipReview__c=true;
            a6.Apttus_Config2__StaticCriteriaFields__c=null;
            a6.Apttus_Config2__TabViewInConfigureBundle__c=false;
            a6.Apttus_Config2__TermFieldPrecision__c=null;
            a6.Apttus_Config2__TotalingGroupType__c='Category';
            a6.Apttus_Config2__UseButtonToSaveSelection__c=false;
            a6.Apttus_Config2__UseEnhancedCSS__c=true;
            a6.Apttus_Config2__ViewCartCustomFields2__c=null;
            a6.Apttus_Config2__ViewCartCustomFields__c=null;
            a6.Apttus_Config2__ViewCartPage__c='Apttus_Config2__CartDetailView';
            a6.Apttus_Config2__ViewCartTotalCustomFields__c=null;
            a6.Apttus_Config2__RevalidationProductColumns__c=null;
            insert a6;
            
            Apttus_Proposal__ProposalSystemProperties__c a7 = new Apttus_Proposal__ProposalSystemProperties__c ();
            
            a7.Name='System Properties';
            a7.Apttus_Proposal__AdminUser__c=null;
            a7.Apttus_Proposal__BypassSharing__c=false;
            a7.Apttus_Proposal__CustomDocGenURL__c=null;
            a7.Apttus_Proposal__DefaultOpportunityQuoteOwner__c='Opportunity Owner';
            a7.Apttus_Proposal__DefaultQuoteAgreementOwner__c='Quote Owner';
            a7.Apttus_Proposal__DisableOpportunityProductsCopy__c=true;
            a7.Apttus_Proposal__EmailTemplateForPresentingProposals__c=null;
            a7.Apttus_Proposal__EnablePDFSecurity__c=false;
            a7.Apttus_Proposal__InstanceUrl__c=instanceUrl ;
            a7.Apttus_Proposal__MaxChildLevel__c=null;
            a7.Apttus_Proposal__MergeCallTimeoutMillis__c=60000;
            a7.Apttus_Proposal__MergeWebserviceEndpoint__c='https://mergews.apttus.net/cgi-bin/4.2.1.2/MergeServer/Bin/MMCGI.exe';
            a7.Apttus_Proposal__PDFOwnerPwd__c=null;
            a7.Apttus_QPConfig__AutoCreateCartVersionAfterFinalize__c=false;
            a7.Apttus_QPConfig__AutoCreateOrder__c=true;
            a7.Apttus_QPConfig__AutoSyncWithOpportunity__c=true;
            a7.Apttus_QPConfig__CloneWithApprovalStatus__c=false;
            a7.Apttus_QPConfig__EnableProposalSummary__c=false;
            a7.Apttus_QPConfig__SyncBundleUsingLineItems__c=true;
            a7.Apttus_QPConfig__SyncOptionProducts__c=false;
            a7.Apttus_QPDSign__AutoSelectAttachment__c=true;
            a7.Apttus_QPDSign__AutoSelectMultipleRecipients__c=false;
            a7.Apttus_QPDSign__ESignatureStrictMode__c=false;
            a7.Apttus_QPDSign__EnableDocumentPreviewInDocuSign__c=false;
            a7.Apttus_QPDSign__EnableRoleNameInUI__c=false;
            a7.Apttus_QPDSign__FieldNameAutoSelectRecipient__c=null;
            a7.Apttus_QPDSign__OneClickSend__c=false;
            a7.Apttus_Proposal__CSSOverride__c=null;
            a7.Apttus_Proposal__DefaultEmailTemplate__c=null;
            a7.Apttus_Proposal__EnableFastDocGen__c=false;
            insert a7;
            
            Apttus_XApps__XAuthorForExcelSystemProperties__c  a8 = new Apttus_XApps__XAuthorForExcelSystemProperties__c ();
            
            a8.Name='System Properties';
            a8.Apttus_XApps__InstanceUrl__c=instanceUrl;
            a8.Apttus_XApps__LicenseWebserviceEndpoint__c='https://ls.apttus.net:8443/cgi-bin/LicenseServer/Bin/LSCGI.exe';
            a8.Apttus_XApps__MergeCallTimeoutMillis__c=50000;
            insert a8;

            Apttus_DocuApi__DocuSignSystemProperties__c  a9 = new Apttus_DocuApi__DocuSignSystemProperties__c();
            
            a9.Name= 'System Properties';
            a9.Apttus_DocuApi__AddAttachmentsEnabled__c= true;
            a9.Apttus_DocuApi__AddRecipientsEnabled__c= true;
            a9.Apttus_DocuApi__AutoProvisionUserEnabled__c= true;
            a9.Apttus_DocuApi__CompletedEnvelopeSyncInterval__c= '30';
            a9.Apttus_DocuApi__DocuSignEnvelopeStatusSubscriber__c= null;
            a9.Apttus_DocuApi__DocuSignServer__c= 'DEMO';
            a9.Apttus_DocuApi__EditEmailEnabled__c= true;
            a9.Apttus_DocuApi__EmailBody__c= 'eSignature request';
            a9.Apttus_DocuApi__EmailSubject__c= 'eSignature request';
            a9.Apttus_DocuApi__EnvelopeStatusSyncInterval__c= '30';
            a9.Apttus_DocuApi__HttpTimeout__c= 30000;
            a9.Apttus_DocuApi__InPersonSigner__c= false;
            a9.Apttus_DocuApi__IncludeCertificate__c= false;
            a9.Apttus_DocuApi__IsRecipientTabsEnabled__c= true;
            a9.Apttus_DocuApi__MaxNumberOfSignerRole__c= 4;
            a9.Apttus_DocuApi__ProductionEnvironment__c= false;
            a9.Apttus_DocuApi__ProfilesEnabledForFinalizeInDocuSign__c= null;
            a9.Apttus_DocuApi__RecipientRolesEnabled__c= true;
            a9.Apttus_DocuApi__RecipientStatusSyncInterval__c= '30';
            a9.Apttus_DocuApi__RemoveRecipientOrdering__c= false;
            a9.Apttus_DocuApi__RetrieveAsCombinedDocument__c= false;
            a9.Apttus_DocuApi__SelectFirstDocumentDefault__c= true;
            a9.Apttus_DocuApi__SendForSignatureEnabled__c= true;
            a9.Apttus_DocuApi__SortDocumentDescending__c= false;
            a9.Apttus_DocuApi__SyncApttusCreatedEnvelopesOnly__c= true;
            a9.Apttus_DocuApi__UseDefaultRemindersExpiration__c= true;
            a9.Apttus_DocuApi__ViewInDocuSignEnabled__c= true;
            a9.Apttus_DocuApi__DocuSignTemplatesEnabled__c= false;
            a9.Apttus_DocuApi__ProfilesEnabledForTemplateSelection__c= null;
            insert a9;
            
            Apttus_Config2__ObjectSummarySettings__c  a10 = new Apttus_Config2__ObjectSummarySettings__c();
            
            a10.Name = 'Proposal Summary';
            a10.Apttus_Config2__DisplayFields__c = 'Name,Apttus_Proposal__Proposal_Name__c,Apttus_Proposal__Account__c,Apttus_QPConfig__PriceListId__c';
            a10.Apttus_Config2__ObjectName__c = 'Apttus_Proposal__Proposal__c';
            insert a10;
            
            Apttus_Config2__ObjectSummarySettings__c  a11 = new Apttus_Config2__ObjectSummarySettings__c();
            
            a11.Name = 'Product Summary';
            a11.Apttus_Config2__DisplayFields__c = 'Name,Description,Family';
            a11.Apttus_Config2__ObjectName__c = 'Product2';
            insert a11;
            
            Apttus_Config2__ObjectSummarySettings__c a12 = new Apttus_Config2__ObjectSummarySettings__c();
            
            a12.Name = 'Favorite Configuration';
            a12.Apttus_Config2__DisplayFields__c = 'Name,Apttus_Config2__PriceListId__c,Apttus_Config2__ConfigurationId__c';
            a12.Apttus_Config2__ObjectName__c = 'Apttus_Config2__FavoriteConfiguration__c';
            insert a12;
            
            Apttus_Approval__ApprovalsCustomConfig__c a13 = new Apttus_Approval__ApprovalsCustomConfig__c();
            
            a13.Name = 'ProductConfiguration__c';
            a13.Apttus_Approval__ApprovalContextType__c = 'Multiple';
            a13.Apttus_Approval__ApprovalGroupStatusField__c = null;
            a13.Apttus_Approval__ApprovalStatusField__c = 'Apttus_CQApprov__Approval_Status__c';
            a13.Apttus_Approval__ApprovalSummaryPage__c = null;
            a13.Apttus_Approval__AssignmentEmailTemplate__c = 'ApttusCartApprovalAssignEmail';
            a13.Apttus_Approval__BackupAdminUser__c = null;
            a13.Apttus_Approval__CancellationEmailTemplate__c = 'ApttusCartApprovalCancelEmail';
            a13.Apttus_Approval__ChildObjectTypes2__c = null;
            a13.Apttus_Approval__ChildObjectTypes__c = 'Apttus_Config2__LineItem__c';
            a13.Apttus_Approval__EnableAdhocApproval__c = false;
            a13.Apttus_Approval__EscalationEmailTemplate__c = 'ApttusCartApprovalEscalationEmail';
            a13.Apttus_Approval__MyApprovalsPage__c = null;
            a13.Apttus_Approval__NotifyOnlyEmailTemplate__c = 'ApttusCartApprovalNotifyOnlyEmail';
            a13.Apttus_Approval__ParentReferenceField__c = null;
            a13.Apttus_Approval__PreviewPage__c = null;
            a13.Apttus_Approval__ReassignmentEmailTemplate__c = 'ApttusCartApprovalReassignEmail';
            insert a13;
            
            Apttus_Config2__ConfigFlow__c  a14 = new Apttus_Config2__ConfigFlow__c();
            
            a14.Name = 'Default';
            a14.Apttus_Config2__AssetsPage__c = 'SelectInstalledProductsEn';
            a14.Apttus_Config2__CartPage__c = 'Apttus_Config2__CartDetailView';
            a14.Apttus_Config2__CatalogPage__c = 'Apttus_Config2__SelectConfigProductsFilterView';
            a14.Apttus_Config2__OptionsPage__c = 'Apttus_Config2__SelectConfigOptionsDetailView';
            a14.Apttus_Config2__ProductAttributeDetailPage__c = 'Apttus_Config2__ProductAttributeDetail3';
            insert a14;
            
            Apttus_Config2__ConfigFlow__c  a15 = new Apttus_Config2__ConfigFlow__c();
            
            a15.Name = 'NGDefault';
            a15.Apttus_Config2__AssetsPage__c = 'Apttus_Config2__Cart#assetsgrid';
            a15.Apttus_Config2__CartPage__c = 'Apttus_Config2__Cart';
            a15.Apttus_Config2__CatalogPage__c = 'Apttus_Config2__Cart';
            a15.Apttus_Config2__OptionsPage__c = 'Apttus_Config2__Cart';
            a15.Apttus_Config2__ProductAttributeDetailPage__c = 'Apttus_Config2__Cart';
            insert a15;
            
            InsertCustomDisplayAction();
            
            InsertCustomDisplayColumns();
            
            
            
    }
    
    
    
     public void deleteAllRevRecData(){
      
        List<Apttus_Revenue2__RevenueSystemProperties__c> newList904 = [select Id from  Apttus_Revenue2__RevenueSystemProperties__c];
        
        if(newList904.size() > 0 )
            delete newList904;
    
        List<Apttus_Config2__RevRecPolicy__c> newList905 = [select Id from Apttus_Config2__RevRecPolicy__c];
        
        if(newList905.size() > 0 )
            delete newList905;
            
        List<Apttus_Config2__GLAccountMapRule__c> newList906 = [select Id from Apttus_Config2__GLAccountMapRule__c];
        
        if(newList906.size() > 0 )
            delete newList906;            
            
    }     
    
    
     public void createRevRecData(){
    
            deleteAllRevRecData();
            String instanceUrl = System.URL.getSalesforceBaseURL().toExternalForm().replace('https://c.', 'https://').replace('visual.force.com', 'salesforce.com');

            String abc1 =  'Apttus_Revenue2__RevenueSystemProperties__c';
            if(Schema.getGlobalDescribe().ContainsKey(abc1) ) {
                SObject sObj = Schema.getGlobalDescribe().get(abc1).newSObject() ; 
                sObj.put('Name','System Properties');
                sObj.put('Apttus_Revenue2__DefaultScale__c', 4);
                sObj.put('Apttus_Revenue2__DisableTriggers__c', false);
                sObj.put('Apttus_Revenue2__FeeAdjustmentCallbackClass__c', null);
                sObj.put('Apttus_Revenue2__IgnoreLeapYearForRevenueRecognition__c', true);
                sObj.put('Apttus_Revenue2__InstanceUrl__c',instanceUrl);
                sObj.put('Apttus_Revenue2__MaxBatchIteratorSize__c', 10000);
                sObj.put('Apttus_Revenue2__ProcessRevenueForClosedPeriods__c', true);
                sObj.put('Apttus_Revenue2__RevenueRecordTypes__c','APTS_Revenue');
                sObj.put('Apttus_Revenue2__RevenueTermRoundingMode__c', null);
                sObj.put('Apttus_Revenue2__RoundingMethod__c', null);
                sObj.put('Apttus_RVConfig__RevenueFeeCallbackClass__c', null);            
                insert sObj;
            } 
            
            abc1 =  'Apttus_Config2__RevRecPolicy__c';
            if(Schema.getGlobalDescribe().ContainsKey(abc1) ) {
                SObject sObj = Schema.getGlobalDescribe().get(abc1).newSObject() ; 
                sObj.put('Name','Ratable - Month');
                sObj.put('Apttus_Config2__Description__c','Ratable - Month Revenue Recognition Policy');
                sObj.put('Apttus_Config2__RevRec_Rule__c','Ratable - Month');           
                insert sObj;
            }               
            
            
            abc1 =  'Apttus_Config2__RevRecPolicy__c';
            if(Schema.getGlobalDescribe().ContainsKey(abc1) ) {
                SObject sObj = Schema.getGlobalDescribe().get(abc1).newSObject() ; 
                sObj.put('Name','Immediate');
                sObj.put('Apttus_Config2__Description__c','Immediate Revenue Recognition Policy');
                sObj.put('Apttus_Config2__RevRec_Rule__c','Immediate');            
                insert sObj;
            }            
            

            abc1 =  'Apttus_Config2__RevRecPolicy__c';
            if(Schema.getGlobalDescribe().ContainsKey(abc1) ) {
                SObject sObj = Schema.getGlobalDescribe().get(abc1).newSObject() ; 
                sObj.put('Name','Manual');
                sObj.put('Apttus_Config2__Description__c','Manual Revenue Recognition Policy');
                sObj.put('Apttus_Config2__RevRec_Rule__c','Manual');          
                insert sObj;
            }

            //Apttus_Config2__GLAccountMapRule__c
            
            abc1 =  'Apttus_Config2__GLAccountMapRule__c';
            if(Schema.getGlobalDescribe().ContainsKey(abc1) ) {
                SObject sObj = Schema.getGlobalDescribe().get(abc1).newSObject() ; 
                sObj.put('Name','QST UnBilled DefAccount');
                sObj.put('Apttus_Config2__GLAccountType__c','Unbilled Deferred Account');
                sObj.put('Apttus_Config2__NumberOfEntries__c', 0);           
                insert sObj;
            }               
            
            
            abc1 =  'Apttus_Config2__GLAccountMapRule__c';
            if(Schema.getGlobalDescribe().ContainsKey(abc1) ) {
                SObject sObj = Schema.getGlobalDescribe().get(abc1).newSObject() ; 
                sObj.put('Name','QST DefRev');
                sObj.put('Apttus_Config2__GLAccountType__c','Deferred Revenue Account');
                sObj.put('Apttus_Config2__NumberOfEntries__c', 0);           
                insert sObj;
            }            
            

            abc1 =  'Apttus_Config2__GLAccountMapRule__c';
            if(Schema.getGlobalDescribe().ContainsKey(abc1) ) {
                SObject sObj = Schema.getGlobalDescribe().get(abc1).newSObject() ; 
                sObj.put('Name','QST UnBilled AR');
                sObj.put('Apttus_Config2__GLAccountType__c','Unbilled A/R Account');
                sObj.put('Apttus_Config2__NumberOfEntries__c', 0);           
                insert sObj;
            }

            abc1 =  'Apttus_Config2__GLAccountMapRule__c';
            if(Schema.getGlobalDescribe().ContainsKey(abc1) ) {
                SObject sObj = Schema.getGlobalDescribe().get(abc1).newSObject() ; 
                sObj.put('Name','QST AR');
                sObj.put('Apttus_Config2__GLAccountType__c','Accounts Receivable Account');
                sObj.put('Apttus_Config2__NumberOfEntries__c', 0);           
                insert sObj;
            }            
            

            abc1 =  'Apttus_Config2__GLAccountMapRule__c';
            if(Schema.getGlobalDescribe().ContainsKey(abc1) ) {
                SObject sObj = Schema.getGlobalDescribe().get(abc1).newSObject() ; 
                sObj.put('Name','QST RecRev');
                sObj.put('Apttus_Config2__GLAccountType__c','Recognized Revenue Account');
                sObj.put('Apttus_Config2__NumberOfEntries__c', 0);                              
                insert sObj;
            }

            
            
     }       
 
     public void deleteAllBillingData(){
      
        List<Apttus_Config2__PaymentTerm__c> newList902 = [select Id from  Apttus_Config2__PaymentTerm__c];
        
        if(newList902.size() > 0 )
            delete newList902;
    
        List<Apttus_Config2__BillingPreference__c> newList903 = [select Id from Apttus_Config2__BillingPreference__c];
        
        if(newList903.size() > 0 )
            delete newList903;
            
    }     
    
    public void createBillingData(){
    
            deleteAllBillingData();
            

            String abc1 =  'Apttus_Config2__PaymentTerm__c';
            if(Schema.getGlobalDescribe().ContainsKey(abc1) ) {
                SObject sObj = Schema.getGlobalDescribe().get(abc1).newSObject() ; 
                sObj.put('Name', 'Net 30 Days');
                sObj.put('Apttus_Config2__Description__c', 'Payment is due within 30 days of your purchase time only');
                sObj.put('Apttus_Config2__IsDefault__c', true);
                sObj.put('Apttus_Config2__Label__c', 'Net 30 Days');
                sObj.put('Apttus_Config2__OffsetOccurrence__c', null);
                sObj.put('Apttus_Config2__OffsetType__c', 'Day');
                sObj.put('Apttus_Config2__Sequence__c', 1);
                sObj.put('Apttus_Config2__StartType__c', 'Invoice Date');
                sObj.put('Apttus_Config2__StartValue__c', null);
                sObj.put('Apttus_Config2__Value__c', 30);
                insert sObj;
                
                sObj = Schema.getGlobalDescribe().get(abc1).newSObject() ; 
                sObj.put('Name', 'Net 60 Days');
                sObj.put('Apttus_Config2__Description__c', 'Payment is due within 60 days of your purchase time only');
                sObj.put('Apttus_Config2__IsDefault__c', true);
                sObj.put('Apttus_Config2__Label__c', 'Net 60 Days');
                sObj.put('Apttus_Config2__OffsetOccurrence__c', null);
                sObj.put('Apttus_Config2__OffsetType__c', 'Day');
                sObj.put('Apttus_Config2__Sequence__c', 1);
                sObj.put('Apttus_Config2__StartType__c', 'Invoice Date');
                sObj.put('Apttus_Config2__StartValue__c', null);
                sObj.put('Apttus_Config2__Value__c', 30);
                insert sObj;
            
            
                sObj = Schema.getGlobalDescribe().get(abc1).newSObject() ; 
                sObj.put('Name', 'Due Upon Receipt');
                sObj.put('Apttus_Config2__Description__c', 'Payment is due upon your purchase time only');
                sObj.put('Apttus_Config2__IsDefault__c', true);
                sObj.put('Apttus_Config2__Label__c', 'Due Upon Receipt');
                sObj.put('Apttus_Config2__OffsetOccurrence__c', null);
                sObj.put('Apttus_Config2__OffsetType__c', 'Day');
                sObj.put('Apttus_Config2__Sequence__c', 1);
                sObj.put('Apttus_Config2__StartType__c', 'Invoice Date');
                sObj.put('Apttus_Config2__StartValue__c', null);
                sObj.put('Apttus_Config2__Value__c', 0);
                insert sObj;
            
            
                sObj = Schema.getGlobalDescribe().get(abc1).newSObject() ; 
                sObj.put('Name', 'Custom: Due on 20th of the second month');
                sObj.put('Apttus_Config2__Description__c', 'Any invoice billed after the 20th of the month (21st to End of Month) will be\r\ndue on 20th of the second month.\r\nFor example: Invoice dated Apr 11); should have the due date of June 20th.');
                sObj.put('Apttus_Config2__IsDefault__c', true);
                sObj.put('Apttus_Config2__Label__c', 'Custom: Due on 20th of the second month');
                sObj.put('Apttus_Config2__OffsetOccurrence__c', null);
                sObj.put('Apttus_Config2__OffsetType__c', 'Month');
                sObj.put('Apttus_Config2__Sequence__c', 1);
                sObj.put('Apttus_Config2__StartType__c', 'Specific Day');
                sObj.put('Apttus_Config2__StartValue__c', 20);
                sObj.put('Apttus_Config2__Value__c', 2);
                insert sObj;
            
            
            
            
            
                sObj = Schema.getGlobalDescribe().get(abc1).newSObject() ; 
                sObj.put('Name', 'Net 45 Days');
                sObj.put('Apttus_Config2__Description__c', 'Payment is due within 45 days of your purchase time only');
                sObj.put('Apttus_Config2__IsDefault__c', true);
                sObj.put('Apttus_Config2__Label__c', 'Net 45 Days');
                sObj.put('Apttus_Config2__OffsetOccurrence__c', null);
                sObj.put('Apttus_Config2__OffsetType__c', 'Day');
                sObj.put('Apttus_Config2__Sequence__c', 1);
                sObj.put('Apttus_Config2__StartType__c', 'Invoice Date');
                sObj.put('Apttus_Config2__StartValue__c', null);
                sObj.put('Apttus_Config2__Value__c', 30);
                insert sObj;
                
                sObj = Schema.getGlobalDescribe().get(abc1).newSObject() ; 
                sObj.put('Name', 'Net 90 Days');
                sObj.put('Apttus_Config2__Description__c', 'Payment is due within 90 days of your purchase time only');
                sObj.put('Apttus_Config2__IsDefault__c', true);
                sObj.put('Apttus_Config2__Label__c', 'Net 90 days');
                sObj.put('Apttus_Config2__OffsetOccurrence__c', null);
                sObj.put('Apttus_Config2__OffsetType__c', 'Day');
                sObj.put('Apttus_Config2__Sequence__c', 1);
                sObj.put('Apttus_Config2__StartType__c', 'Invoice Date');
                sObj.put('Apttus_Config2__StartValue__c', null);
                sObj.put('Apttus_Config2__Value__c', 30);
                insert sObj;
            
            
                sObj = Schema.getGlobalDescribe().get(abc1).newSObject() ; 
                sObj.put('Name', 'Custom: Due 20 days from the End of the Quarter');
                sObj.put('Apttus_Config2__Description__c', 'Requirement -Any invoice billed in a month will be due End of Month); two months later.\r\nFor example: Invoice dated Jan 20); should have the due date of March 31st.');
                sObj.put('Apttus_Config2__IsDefault__c', true);
                sObj.put('Apttus_Config2__Label__c', 'Custom:  Due 20 days from the End of the Quarter');
                sObj.put('Apttus_Config2__OffsetOccurrence__c', null);
                sObj.put('Apttus_Config2__OffsetType__c', 'Day');
                sObj.put('Apttus_Config2__Sequence__c', 1);
                sObj.put('Apttus_Config2__StartType__c', 'End of Quarter');
                sObj.put('Apttus_Config2__StartValue__c', null);
                sObj.put('Apttus_Config2__Value__c', 20);
                insert sObj;
            
            
                sObj = Schema.getGlobalDescribe().get(abc1).newSObject() ; 
                sObj.put('Name', 'Custom: Due End of Month); two months later');
                sObj.put('Apttus_Config2__Description__c', 'Requirement -Any invoice billed in a month will be due End of Month); two months later.\r\nFor example: Invoice dated Jan 20); should have the due date of March 31st.');
                sObj.put('Apttus_Config2__IsDefault__c', true);
                sObj.put('Apttus_Config2__Label__c', 'Custom: Due End of Month); two months later');
                sObj.put('Apttus_Config2__OffsetOccurrence__c', null);
                sObj.put('Apttus_Config2__OffsetType__c', 'Month');
                sObj.put('Apttus_Config2__Sequence__c', 1);
                sObj.put('Apttus_Config2__StartType__c', 'End of Month');
                sObj.put('Apttus_Config2__StartValue__c', null);
                sObj.put('Apttus_Config2__Value__c', 2);
                insert sObj;    
                
            }

             String abcc1 =  'Apttus_Config2__BillingPreference__c';
            if(Schema.getGlobalDescribe().ContainsKey(abcc1 ) ) {
                SObject sObj = Schema.getGlobalDescribe().get(abcc1 ).newSObject() ; 
                sObj.put('Name','Default Billing Preference for 1st of the Month');
                sObj.put('Apttus_Config2__Active__c',true);
                sObj.put('Apttus_Config2__AllowPaymentTermOverride__c',true);
                sObj.put('Apttus_Config2__AllowPrefOverride__c',false);
                sObj.put('Apttus_Config2__BillingCycleStart__c','Billing Day of Month');
                sObj.put('Apttus_Config2__BillingDayOfMonth2__c','1st of the Month');
                sObj.put('Apttus_Config2__BillingInterval__c','Anytime');
                sObj.put('Apttus_Config2__CalendarCycleStart__c',null);
                sObj.put('Apttus_Config2__Default__c',true);
                sObj.put('Apttus_Config2__DoNotCreateInformational__c',false);
                sObj.put('Apttus_Config2__HideInformational__c',false);
                sObj.put('Apttus_Config2__InvoiceDeliveryMethod__c','Email');
                sObj.put('Apttus_Config2__InvoiceOutputFormat__c','PDF');
                sObj.put('Apttus_Config2__PrefLevel__c','Organization');
                sObj.put('Apttus_Config2__ProrationPeriodTreatment__c','Separate Period');
                sObj.put('Apttus_Config2__TaxLevel__c',null);
                sObj.put('Apttus_QPConfig__ProposalId__c',null);
                sObj.put('Apttus_QPConfig__ProposalLineItemId__c',null);
                sObj.put('Apttus_CMConfig__AgreementId__c',null);
                sObj.put('Apttus_CMConfig__AgreementLineItemId__c',null);
                insert sObj;
            }   
    
    }
    
    public void deleteAllBillingSettings(){
      
        List<Apttus_Config2__OrderSystemProperties__c> newList900 = [select Id from  Apttus_Config2__OrderSystemProperties__c];
        
        if(newList900.size() > 0 )
            delete newList900;
    
        List<Apttus_Billing__BillingSystemProperties__c> newList901 = [select Id from Apttus_Billing__BillingSystemProperties__c];
        
        if(newList901.size() > 0 )
            delete newList901;
            
    }            
    
    public void createBillingSettings(){
    
            deleteAllBillingSettings();
            
            String abc1 =  'Apttus_Config2__OrderSystemProperties__c';
            if(Schema.getGlobalDescribe().ContainsKey(abc1) ) {
                SObject sObj = Schema.getGlobalDescribe().get(abc1).newSObject() ; 
                sObj.put('Name','System Properties');
                sObj.put('Apttus_Config2__InitiateBillingOnOrderActivation__c',true);
                insert sObj;
            }


            String abc =  'Apttus_Billing__BillingSystemProperties__c';
            if(Schema.getGlobalDescribe().ContainsKey(abc) ) {
                SObject sObj = Schema.getGlobalDescribe().get(abc).newSObject() ; 
                sObj.put('Name','System Properties');
                sObj.put('Apttus_Billing__AllowBillingPreferenceOverride__c',true);
                sObj.put('Apttus_Billing__BillingOrgWideEmailAddress__c',null);
                sObj.put('Apttus_Billing__CreateActivityForBillingEmails__c',false);
                sObj.put('Apttus_Billing__CreateRedundantBillingSchedules__c',true);
                sObj.put('Apttus_Billing__CurrencyDecimalPlaces__c',5);
                sObj.put('Apttus_Billing__GenerateCreditMemoDocuments__c',true);
                sObj.put('Apttus_Billing__GenerateInvoiceDocuments__c',true);
                sObj.put('Apttus_Billing__InvoiceEmailDeliveryPeriod__c',0);
                sObj.put('Apttus_Billing__InvoiceGenerationBatchSize__c',200);
                sObj.put('Apttus_Billing__SameDayCancellation__c',true);
                sObj.put('Apttus_Billing__TaxLevel__c',null);
                sObj.put('Apttus_Billing__UsageRatingBatchSize__c',200);
                insert sObj;
            }


    }
    
    
    public void updatePLI(){
            
            for(Apttus_Config2__PriceListItem__c pli : [select id,Apttus_Config2__BillingFrequency__c, Apttus_Config2__BillingRule__c, Apttus_Config2__RevRecPolicyId__r.name,Apttus_Config2__ARAccountRuleId__r.name,Apttus_Config2__DRAccountRuleId__r.name,Apttus_Config2__RRAccountRuleId__r.name,Apttus_Config2__UBAccountRuleId__r.name,Apttus_Config2__UBARAccountRuleId__r.name from Apttus_Config2__PriceListItem__c] ){
            
                   pli.Apttus_Config2__BillingFrequency__c = 'Monthly';
                   pli.Apttus_Config2__BillingRule__c= 'Bill In Advance';
                   pli.Apttus_Config2__RevRecPolicyId__c= [select ID  from Apttus_Config2__RevRecPolicy__c where Apttus_Config2__RevRec_Rule__c = 'Ratable - Month' limit 1 ].ID;
                   pli.Apttus_Config2__ARAccountRuleId__c= [select ID  from Apttus_Config2__GLAccountMapRule__c where Apttus_Config2__GLAccountType__c = 'Accounts Receivable Account' limit 1 ].ID;
                   pli.Apttus_Config2__DRAccountRuleId__c= [select ID  from Apttus_Config2__GLAccountMapRule__c  where Apttus_Config2__GLAccountType__c = 'Deferred Revenue Account' limit 1 ].ID;
                   pli.Apttus_Config2__RRAccountRuleId__c= [select ID  from Apttus_Config2__GLAccountMapRule__c where Apttus_Config2__GLAccountType__c = 'Recognized Revenue Account' limit 1 ].ID;
                   pli.Apttus_Config2__UBAccountRuleId__c= [select ID  from Apttus_Config2__GLAccountMapRule__c where Apttus_Config2__GLAccountType__c = 'Unbilled Deferred Account' limit 1 ].ID;
                   pli.Apttus_Config2__UBARAccountRuleId__c= [select ID  from Apttus_Config2__GLAccountMapRule__c where Apttus_Config2__GLAccountType__c = 'Unbilled A/R Account' limit 1 ].ID;
                   update pli;
            }
                
    }
    
    public void createSampleCPQData(){
    
            deleteAllCPQData();
            
            PopulateQSTCPQData populateCPQForQST = new PopulateQSTCPQData();
            populateCPQForQST.setupProduct();
            populateCPQForQST.setupCategory();
            populateCPQForQST.setupCategoryHierarchy();
            populateCPQForQST.setupProductClassification();
            populateCPQForQST.setupProductOptionGroup();
            populateCPQForQST.setupProductOptionComponent();
            populateCPQForQST.setupPriceList();
            populateCPQForQST.setupPriceListCategory();
            populateCPQForQST.setupPriceListItem();
            
            deleteAllCPQCateData();
    }
    
    public void createSampleIWAData(){
            deleteAllIWAData();
            
            Apttus_Approval__SearchFilter__c r9 = new Apttus_Approval__SearchFilter__c();
            
            r9.Name = 'On Line Item Discount %';
            r9.Apttus_Approval__BusinessObject__c = 'Apttus_Config2__LineItem__c';
            r9.Apttus_Approval__CriteriaFieldNames__c = 'Apttus_Config2__NetAdjustmentPercent__c';
            r9.Apttus_Approval__Criteria__c = '{ "sObjectName" : "Apttus_Config2__LineItem__c", "sObjectLabel" : "Line Item", "filter" : { "predicates" : [ { "RowNum" : 1, "RHSFieldValueType" : null, "RHSChildFilterName" : null, "LHSFieldValueType" : null, "LHSChildFilterName" : null, "FieldValue" : "-10.01", "FieldType" : "PERCENT", "FieldName" : "Apttus_Config2__NetAdjustmentPercent__c", "FieldLabel" : "Net Adjustment (%)", "CompOper" : "less than or equal to", "BoolOper" : "AND" } ], "condExpr" : "1" }, "fields" : [ "Apttus_Config2__NetAdjustmentPercent__c" ], "exprStr" : "(Net Adjustment (%) <= -10.01)" }';
            r9.Apttus_Approval__Description__c = 'Entry Criteria and Line Item Discount %';
            r9.Apttus_Approval__Sequence__c = 1;
            r9.Apttus_Approval__UseType__c = 'Entry Criteria';
            
            insert r9;
            
            Apttus_Approval__ApprovalRuleDimension__c a1 = new Apttus_Approval__ApprovalRuleDimension__c();
            
            a1.Name = 'Net Discount on Line Item object';
            a1.Apttus_Approval__BusinessObject__c = 'Apttus_Config2__LineItem__c';
            a1.Apttus_Approval__Datasource__c = 'Apttus_Config2__NetAdjustmentPercent__c';
            a1.Apttus_Approval__Description__c = 'Net Discount on Line Item object';
            a1.Apttus_Approval__DimensionType__c = 'Field';
            
            insert a1;
            
            Apttus_Approval__ApprovalRule__c a2 = new Apttus_Approval__ApprovalRule__c();
            
            a2.Name = 'Net Discount Rule on Line Item';
            a2.Apttus_Approval__Active__c = true;
            a2.Apttus_Approval__BusinessObject__c = 'Apttus_Config2__LineItem__c';
            a2.Apttus_Approval__Description__c = 'Net Discount Rule on Line Item';
            a2.Apttus_Approval__Dimension1Id__c = a1.Id;
            a2.Apttus_Approval__Dimension1ValueType__c = 'Range';
            a2.Apttus_Approval__MatchRule__c = 'Match All';
            a2.Apttus_Approval__RuleType__c = 'Dimension';
            a2.Apttus_Approval__Sequence__c = 1;
            a2.Apttus_Approval__StopProcessingMoreRules__c = false;
         
            insert a2;
            
            Apttus_Approval__ApprovalRuleEntry__c a3 = new Apttus_Approval__ApprovalRuleEntry__c();
            
            a3.Apttus_Approval__ApprovalRuleId__c = a2.Id;
            a3.Apttus_Approval__AutoReapprove__c = false;
            a3.Apttus_Approval__Dimension1Value__c = '-10.01';
            a3.Apttus_Approval__EntryLabel__c = 'Discount > 10%';
            a3.Apttus_Approval__IncludePrevious__c = false;
            a3.Apttus_Approval__Sequence__c = 1;
            
            insert a3;
            
            Apttus_Approval__ApprovalRuleEntry__c a4 = new Apttus_Approval__ApprovalRuleEntry__c();
            
            a4.Apttus_Approval__ApprovalRuleId__c = a2.Id;
            a4.Apttus_Approval__AutoReapprove__c = false;
            a4.Apttus_Approval__DependsOn__c = '1';
            a4.Apttus_Approval__Dimension1Value__c = '-35';
            a4.Apttus_Approval__EntryLabel__c = 'Discount >35%';
            a4.Apttus_Approval__IncludePrevious__c = true;
            a4.Apttus_Approval__Sequence__c = 2;
            
            insert a4;
            
            Apttus_Approval__ApprovalRuleAssignee__c a5 = new Apttus_Approval__ApprovalRuleAssignee__c();

            a5.Apttus_Approval__RuleEntryId__c = a3.Id;
            a5.Apttus_Approval__AssigneeDescription__c = 'More then 35% Net Discount on Line Item';
            a5.Apttus_Approval__AssigneeLabel__c = 'Main Approval';
            a5.Apttus_Approval__AssigneeType__c = 'User';
            a5.Apttus_Approval__AssigneeValue__c = UserInfo.getName();
            a5.Apttus_Approval__NotifyOnly__c = false;
            a5.Apttus_Approval__SendEmail__c = true;
            a5.Apttus_Approval__Sequence__c = 1;
            
            insert a5;
            
            Apttus_Approval__ApprovalRuleAssignee__c a51 = new Apttus_Approval__ApprovalRuleAssignee__c();
            
            a51.Apttus_Approval__RuleEntryId__c = a4.Id;
            a51.Apttus_Approval__AssigneeDescription__c = 'Upto 35% Net Discount on Line Item';
            a51.Apttus_Approval__AssigneeLabel__c = 'Approval';
            a51.Apttus_Approval__AssigneeType__c = 'User';
            a51.Apttus_Approval__AssigneeValue__c = UserInfo.getName();
            a51.Apttus_Approval__NotifyOnly__c = false;
            a51.Apttus_Approval__SendEmail__c = true;
            a51.Apttus_Approval__Sequence__c = 1;
            
            insert a51;
            
            InsertApprovalProcess();
            
            
    }
    
    
    public void InsertApprovalProcess(){
    
            Apttus_Approval__Approval_Process__c a6 = new Apttus_Approval__Approval_Process__c(); 
            

            a6.RecordTypeId = [select id from RecordType where name = 'Approval Process' limit 1].Id;
            a6.Apttus_Approval__Active__c = true;
            a6.Apttus_Approval__Assignment_Email_Template__c = 'Apttus Cart Approval Notification (Assignment)';
            a6.Apttus_Approval__Cancellation_Email_Template__c = 'Apttus Cart Approval Notification (Cancellation)';
            a6.Apttus_Approval__ConsolidateApprovals__c = true;
            a6.Apttus_Approval__ConsolidateNotifications__c = true;
            a6.Apttus_Approval__Description__c = 'Net Discount PROCESS on Product Config (based on Line Item )';
            a6.Apttus_Approval__Escalation_Email_Template__c = 'Apttus Cart Approval Notification (Escalation)';
            a6.Apttus_Approval__NotifyOnly_Email_Template__c = 'Apttus Cart Approval Notification (Notify Only)';
            a6.Apttus_Approval__Object_Label__c = 'Product Configuration';
            a6.Apttus_Approval__Object_Name__c = 'Apttus_Config2__ProductConfiguration__c';
            a6.Apttus_Approval__ProcessAutoEscalate__c = false;
            a6.Apttus_Approval__Process_Name__c = 'Net Discount PROCESS on Product Config (based on Line Item 23 )';
            a6.Apttus_Approval__Reassignment_Email_Template__c = 'Apttus Cart Approval Notification (Reassignment)';
            a6.Apttus_Approval__SubmissionCommentsEnabled__c = false;
            a6.Apttus_Approval__SubmissionCommentsPerStep__c = '1';
            a6.Apttus_Approval__SubmissionCommentsType__c = 'Process';
            
            insert a6;
            
            Apttus_Approval__Approval_Process__c a7 =  new Apttus_Approval__Approval_Process__c(); 
            
            a7.RecordTypeId = [select id from RecordType where name = 'Entry Criteria' limit 1].Id;
            a7.Apttus_Approval__Active__c = true;
            a7.Apttus_Approval__Entry_Criteria_Active__c = true;
            a7.Apttus_Approval__Entry_Criteria_BoolOper__c = 'AND';
            a7.Apttus_Approval__Entry_Criteria_Comparison_Type__c = 'not equal to';
            a7.Apttus_Approval__Entry_Criteria_Field__c = 'Id';
            a7.Apttus_Approval__Entry_Criteria__c = a6.ID;
            
            insert a7;

            
            Apttus_Approval__Approval_Process__c a8 =  new Apttus_Approval__Approval_Process__c();
            
            a8.RecordTypeId = [select id from RecordType where name = 'Initial Submission Action' limit 1].Id;
            a8.Apttus_Approval__Active__c = true;
            a8.Apttus_Approval__Description__c = 'Initial Submission Action on Status';
            a8.Apttus_Approval__Initial_Submission_Action_Type__c = 'Field Update (Constant)';
            a8.Apttus_Approval__Initial_Submission_Action__c = a6.ID;
            a8.Apttus_Approval__Initial_Submission_Field_Name_Source__c = 'Self';
            a8.Apttus_Approval__Initial_Submission_Field_Name__c = 'Apttus_Config2__Status__c';
            a8.Apttus_Approval__Initial_Submission_Field_Value__c = 'Pending Approval';
            
            insert a8;
            
            Apttus_Approval__Approval_Process__c a9 =  new Apttus_Approval__Approval_Process__c();
            
            a9.RecordTypeId = [select id from RecordType where name = 'Initial Submission Action' limit 1].Id;
            a9.Apttus_Approval__Active__c = true;
            a9.Apttus_Approval__Description__c = 'Initial Submission Action on Approval Status';
            a9.Apttus_Approval__Initial_Submission_Action_Type__c = 'Field Update (Constant)';
            a9.Apttus_Approval__Initial_Submission_Action__c = a6.ID;
            a9.Apttus_Approval__Initial_Submission_Field_Name_Source__c = 'Self';
            a9.Apttus_Approval__Initial_Submission_Field_Name__c = 'Apttus_CQApprov__Approval_Status__c';
            a9.Apttus_Approval__Initial_Submission_Field_Value__c = 'Pending Approval';
            
            insert a9;
            
            
            Apttus_Approval__Approval_Process__c a10 =  new Apttus_Approval__Approval_Process__c();
            
            a10.RecordTypeId = [select id from RecordType where name = 'Step Group' limit 1].Id;
            a10.Apttus_Approval__Active__c = true;
            a10.Apttus_Approval__Step_Group_Active__c = true;
            a10.Apttus_Approval__Step_Group_Name__c = 'Dummy';
            a10.Apttus_Approval__Step_Group_Rejection_Action__c = null;
            a10.Apttus_Approval__Step_Group_Seq_Number__c = 1;
            a10.Apttus_Approval__Step_Group__c = a6.ID;
            
            insert a10;
            
            Apttus_Approval__Approval_Process__c a11 =  new Apttus_Approval__Approval_Process__c();
            
            a11.RecordTypeId = [select id from RecordType where name = 'Step' limit 1].Id;
            a11.Apttus_Approval__Active__c = true;
            a11.Apttus_Approval__ChildObjectType__c = 'Apttus_Config2__LineItem__c';
            a11.Apttus_Approval__DependsOn__c = null;
            a11.Apttus_Approval__Send_Email__c = true;
            a11.Apttus_Approval__StepAutoEscalate__c = false;
            a11.Apttus_Approval__StepAutoReapprove__c = false;
            a11.Apttus_Approval__StepFilterConditionDescription__c = null;
            a11.Apttus_Approval__StepLabel__c = 'Net Discount Step on Line Item Object';
            a11.Apttus_Approval__StepSequence__c = 2;
            a11.Apttus_Approval__StepSubmissionComment1Enabled__c = false;
            a11.Apttus_Approval__StepSubmissionComment2Enabled__c = false;
            a11.Apttus_Approval__StepSubmissionComment3Enabled__c = false;
            a11.Apttus_Approval__StepSubmissionCommentsEnabled__c = false;
            a11.Apttus_Approval__StepType__c = 'Child Process';
            a11.Apttus_Approval__Step_Active__c = true;
            a11.Apttus_Approval__Step_Assignee_Description__c = null;
            a11.Apttus_Approval__Step_Assignee_Type__c = 'Subprocess';
            a11.Apttus_Approval__Step_Assignee__c = 'Net Discount Rule on Line Item';
            a11.Apttus_Approval__Step_Auto_Complete__c = false;
            a11.Apttus_Approval__Step_Name__c = 'Net Discount Step on Line Item Object';
            a11.Apttus_Approval__Step_Notify_Only__c = false;
            a11.Apttus_Approval__Step_Seq_Number__c = null;
            a11.Apttus_Approval__Step__c = a10.ID;            

            insert a11;
            
            
            
            
            
            Apttus_Approval__Approval_Process__c a12 =  new Apttus_Approval__Approval_Process__c();
            
            a12.RecordTypeId = [select id from RecordType where name = 'Final Action' limit 1].Id;
            a12.Apttus_Approval__Active__c = true;
            a12.Apttus_Approval__Final_Approval_Action__c = a6.ID;
            a12.Apttus_Approval__Description__c = 'Final Action on Status';
            a12.Apttus_Approval__Final_Action_Field_Name_Source__c = null;
            a12.Apttus_Approval__Final_Action_Field_Name__c = 'Apttus_Config2__Status__c';
            a12.Apttus_Approval__Final_Action_Field_Update_Type__c = 'Field Update (Constant)';
            a12.Apttus_Approval__Final_Action_Field_Value__c = 'Ready For Finalization';
            a12.Apttus_Approval__Final_Action_Type__c = 'Approved';            
            
            insert a12;
            
            
            Apttus_Approval__Approval_Process__c a13 =  new Apttus_Approval__Approval_Process__c();
            
            a13.RecordTypeId = [select id from RecordType where name = 'Final Action' limit 1].Id;
            a13.Apttus_Approval__Active__c = true;
            a13.Apttus_Approval__Final_Approval_Action__c = a6.ID;
            a13.Apttus_Approval__Description__c = 'Final Action on Status';
            a13.Apttus_Approval__Final_Action_Field_Name_Source__c = null;
            a13.Apttus_Approval__Final_Action_Field_Name__c = 'Apttus_Config2__Status__c';
            a13.Apttus_Approval__Final_Action_Field_Update_Type__c = 'Field Update (Constant)';
            a13.Apttus_Approval__Final_Action_Field_Value__c = 'Ready For Approvals';
            a13.Apttus_Approval__Final_Action_Type__c = 'Rejected';            
            
            insert a13;

            Apttus_Approval__Approval_Process__c a14 =  new Apttus_Approval__Approval_Process__c();
            
            a14.RecordTypeId = [select id from RecordType where name = 'Final Action' limit 1].Id;
            a14.Apttus_Approval__Active__c = true;
            a14.Apttus_Approval__Final_Approval_Action__c = a6.ID;
            a14.Apttus_Approval__Description__c = 'Final Action on Approval Status';
            a14.Apttus_Approval__Final_Action_Field_Name_Source__c = null;
            a14.Apttus_Approval__Final_Action_Field_Name__c = 'Apttus_CQApprov__Approval_Status__c';
            a14.Apttus_Approval__Final_Action_Field_Update_Type__c = 'Field Update (Constant)';
            a14.Apttus_Approval__Final_Action_Field_Value__c = 'Approval Required';
            a14.Apttus_Approval__Final_Action_Type__c = 'Rejected';            
            
            insert a14;            
            
            
            Apttus_Approval__Approval_Process__c a15 =  new Apttus_Approval__Approval_Process__c();
            
            a15.RecordTypeId = [select id from RecordType where name = 'Final Action' limit 1].Id;
            a15.Apttus_Approval__Active__c = true;
            a15.Apttus_Approval__Final_Approval_Action__c = a6.ID;
            a15.Apttus_Approval__Description__c = 'Final Action on Approval Status';
            a15.Apttus_Approval__Final_Action_Field_Name_Source__c = null;
            a15.Apttus_Approval__Final_Action_Field_Name__c = 'Apttus_CQApprov__Approval_Status__c';
            a15.Apttus_Approval__Final_Action_Field_Update_Type__c = 'Field Update (Constant)';
            a15.Apttus_Approval__Final_Action_Field_Value__c = 'Approved';
            a15.Apttus_Approval__Final_Action_Type__c = 'Approved';            
            
            insert a15;            
            

    }
    public void InsertCustomDisplayAction()
    {
        List<Apttus_Config2__ConfigCustomDisplayActions__c> CSD = new List<Apttus_Config2__ConfigCustomDisplayActions__c>();
            
 
            Apttus_Config2__ConfigCustomDisplayActions__c a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 10 DBsTQLWsG2WSlcX';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'GenerateDocument';
            a16.Apttus_Config2__ActionName__c = 'GenerateDocument';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 10;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 11 QNjBTqblmKRacHy';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'EditPriceAgreement';
            a16.Apttus_Config2__ActionName__c = 'EditPriceAgreement';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 11;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 12 uFTaJeE8LdWAIti';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'AnalyzeDeal';
            a16.Apttus_Config2__ActionName__c = 'AnalyzeDeal';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 12;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 13 zYoHRtVOZhfrkOv';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'AnalyzeQuote';
            a16.Apttus_Config2__ActionName__c = 'AnalyzeQuote';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 13;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 14 1S1G6zRXja7YtXe';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'ReviewAndFinalize';
            a16.Apttus_Config2__ActionName__c = 'ReviewAndFinalize';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 14;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 11 tKgSQ4OHYorkDRg';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'EditPriceAgreement';
            a16.Apttus_Config2__ActionName__c = 'EditPriceAgreement';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 11;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 12 H2WwEyl3bfZ9FPU';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'AnalyzeDeal';
            a16.Apttus_Config2__ActionName__c = 'AnalyzeDeal';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 12;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 10 NNijms6xNJ5fcf4';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'GenerateDocument';
            a16.Apttus_Config2__ActionName__c = 'GenerateDocument';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 10;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 13 qQTGRWkD5C1K48r';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'ReviewAndFinalize';
            a16.Apttus_Config2__ActionName__c = 'ReviewAndFinalize';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 13;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 14 rJ6wJRU1rxvMYyp';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'More';
            a16.Apttus_Config2__ActionName__c = 'More';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 14;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Resolve Config Item 3 Ss4S8OYGUv6Yla7';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'UpdatePrice';
            a16.Apttus_Config2__ActionName__c = 'UpdatePrice';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Resolve Config Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 3;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Resolve Config Item 4 fCw5HQvdNe1pexv';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'CloseCart';
            a16.Apttus_Config2__ActionName__c = 'CloseCart';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Resolve Config Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 4;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Resolve Config Item 5 p9zKYQruxGt52R1';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Abandon';
            a16.Apttus_Config2__ActionName__c = 'Abandon';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Resolve Config Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 5;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Attribute Item 1 P47xKrlfgVzho4a';
            a16.Apttus_Config2__ActionArea__c = 'Left';
            a16.Apttus_Config2__ActionLabelName__c = 'AddMoreProducts';
            a16.Apttus_Config2__ActionName__c = 'AddMoreProducts';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Task';
            a16.Apttus_Config2__DisplayType__c = 'Attribute Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 1;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Attribute Item 2 gwQC837V4Do2gqm';
            a16.Apttus_Config2__ActionArea__c = 'Left';
            a16.Apttus_Config2__ActionLabelName__c = 'InstalledProducts';
            a16.Apttus_Config2__ActionName__c = 'InstalledProducts';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Task';
            a16.Apttus_Config2__DisplayType__c = 'Attribute Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 2;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 15 vkjabQnU4jINBlt';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'More';
            a16.Apttus_Config2__ActionName__c = 'More';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 15;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 16 ht42cFIGZzcF6Ti';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Finalize';
            a16.Apttus_Config2__ActionName__c = 'Finalize';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 16;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 17 I1RyMWyafy3dpqW';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'CloseCart';
            a16.Apttus_Config2__ActionName__c = 'CloseCart';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 17;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 18 Fpsg3fblB7AFpPk';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Abandon';
            a16.Apttus_Config2__ActionName__c = 'Abandon';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 18;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 19 sI9bd9nFOYbUWAg';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Revalidate';
            a16.Apttus_Config2__ActionName__c = 'Revalidate';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 19;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 20 62n1AomICyDDHvm';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'SubmitForMerge';
            a16.Apttus_Config2__ActionName__c = 'SubmitForMerge';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 20;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 15 NEpwMAVB8OKobsF';
            a16.Apttus_Config2__ActionArea__c = 'Right';
            a16.Apttus_Config2__ActionLabelName__c = 'Finalize';
            a16.Apttus_Config2__ActionName__c = 'Finalize';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 15;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 19 Tep9RmQqaMFEgCD';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'SubmitForMerge';
            a16.Apttus_Config2__ActionName__c = 'SubmitForMerge';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 19;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 16 kXtn1yu7ofw8cVI';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'CloseCart';
            a16.Apttus_Config2__ActionName__c = 'CloseCart';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 16;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 17 rB3rvRDcIVAk657';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Abandon';
            a16.Apttus_Config2__ActionName__c = 'Abandon';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 17;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Asset Line Item 1 NYqylf4VSODHggK';
            a16.Apttus_Config2__ActionArea__c = 'Left';
            a16.Apttus_Config2__ActionLabelName__c = 'CatalogProducts';
            a16.Apttus_Config2__ActionName__c = 'CatalogProducts';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Task';
            a16.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 1;
            
            CSD.add(a16); 
            
            /*a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 21 Y2XIrIRXx9ImEQV';
            a16.Apttus_Config2__ActionArea__c = 'Right';
            a16.Apttus_Config2__ActionLabelName__c = 'Custom Reprice';
            a16.Apttus_Config2__ActionName__c = 'CustomAction21';
            a16.Apttus_Config2__ActionPage__c = 'APTS_CustomReprice';
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = 'QuickSave';
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = 'Self';
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 21;
            
            CSD.add(a16);*/ 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Asset Line Item 1 LZad4aqcO2U2GCd';
            a16.Apttus_Config2__ActionArea__c = 'Left';
            a16.Apttus_Config2__ActionLabelName__c = 'CatalogProducts';
            a16.Apttus_Config2__ActionName__c = 'CatalogProducts';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Task';
            a16.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 1;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Asset Line Item 2 IShFl3gEto7AfTb';
            a16.Apttus_Config2__ActionArea__c = 'Left';
            a16.Apttus_Config2__ActionLabelName__c = 'GoToPricing';
            a16.Apttus_Config2__ActionName__c = 'GoToPricing';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Task';
            a16.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 2;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Asset Line Item 3 Vw8hGJHC9xnejC5';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Increment';
            a16.Apttus_Config2__ActionName__c = 'Increment';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 3;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Asset Line Item 4 GEXb4c7IzM4dyq4';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Amend';
            a16.Apttus_Config2__ActionName__c = 'Amend';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 4;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Attribute Item 3 XUtEkcQGEGy89rF';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'RemoveItem';
            a16.Apttus_Config2__ActionName__c = 'RemoveItem';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Attribute Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 3;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Attribute Item 4 LzzQw3NBzHVNhyf';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'BackToPricing';
            a16.Apttus_Config2__ActionName__c = 'BackToPricing';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Attribute Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 4;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Attribute Item 5 oEcG8ivnizsbi2Y';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Next';
            a16.Apttus_Config2__ActionName__c = 'Next';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Attribute Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 5;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Attribute Item 6 K5qGKlIejt6Z8mH';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'GoToPricing';
            a16.Apttus_Config2__ActionName__c = 'GoToPricing';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Attribute Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 6;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Attribute Item 7 ePs1Ie5PJBKO2YI';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'UpdatePrice';
            a16.Apttus_Config2__ActionName__c = 'UpdatePrice';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Attribute Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 7;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Attribute Item 8 x572DbtldbrlanC';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'CloseCart';
            a16.Apttus_Config2__ActionName__c = 'CloseCart';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Attribute Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 8;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Attribute Item 9 KnVr4kaTedKN5KI';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Abandon';
            a16.Apttus_Config2__ActionName__c = 'Abandon';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Attribute Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 9;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Attribute Item 1 6xUCVO5Dw3xgqpk';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'AddMoreProducts';
            a16.Apttus_Config2__ActionName__c = 'AddMoreProducts';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Attribute Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 1;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Attribute Item 2 HcnU91BJSkarsgY';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'InstalledProducts';
            a16.Apttus_Config2__ActionName__c = 'InstalledProducts';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Attribute Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 2;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 1 ifYnqhVPIzMRVUC';
            a16.Apttus_Config2__ActionArea__c = 'Left';
            a16.Apttus_Config2__ActionLabelName__c = 'AddMoreProducts';
            a16.Apttus_Config2__ActionName__c = 'AddMoreProducts';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Task';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 1;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 2 MtNr4m1KbE1qnts';
            a16.Apttus_Config2__ActionArea__c = 'Left';
            a16.Apttus_Config2__ActionLabelName__c = 'InstalledProducts';
            a16.Apttus_Config2__ActionName__c = 'InstalledProducts';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Task';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 2;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 3 Q3CjbThaLTlHApc';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'AddMiscellaneousItem';
            a16.Apttus_Config2__ActionName__c = 'AddMiscellaneousItem';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 3;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Asset Line Item 5 xeqtT4wVc58HtqF';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Renew';
            a16.Apttus_Config2__ActionName__c = 'Renew';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 5;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Asset Line Item 6 feDJdmP5GVxv1tH';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Terminate';
            a16.Apttus_Config2__ActionName__c = 'Terminate';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 6;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Asset Line Item 7 WgLTuOdEYoUBWa1';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Upgrade';
            a16.Apttus_Config2__ActionName__c = 'Upgrade';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 7;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Asset Line Item 8 GlntWdxau2IbGqo';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'UpdatePrice';
            a16.Apttus_Config2__ActionName__c = 'UpdatePrice';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 8;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Asset Line Item 9 qZdVkGDNTZkZfsG';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'More';
            a16.Apttus_Config2__ActionName__c = 'More';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 9;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Attribute Item 3 1slM8iq6qty9gte';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'RemoveItem';
            a16.Apttus_Config2__ActionName__c = 'RemoveItem';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Attribute Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 3;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Attribute Item 4 8i1COI5JBlgshim';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'BackToPricing';
            a16.Apttus_Config2__ActionName__c = 'BackToPricing';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Attribute Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 4;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Attribute Item 5 29v3aZekH5LWCoE';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Next';
            a16.Apttus_Config2__ActionName__c = 'Next';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Attribute Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 5;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Attribute Item 6 MIEGAT6M4LLVOgA';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'GoToPricing';
            a16.Apttus_Config2__ActionName__c = 'GoToPricing';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Attribute Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 6;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Attribute Item 7 cMlVg6OkRomifJc';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'UpdatePrice';
            a16.Apttus_Config2__ActionName__c = 'UpdatePrice';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Attribute Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 7;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 4 s83sxIXjVF8wqkb';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'BackToPricing';
            a16.Apttus_Config2__ActionName__c = 'BackToPricing';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 4;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 5 TjXve2TVSKqgUeX';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Reprice';
            a16.Apttus_Config2__ActionName__c = 'Reprice';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 5;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 6 9na9ybfyCXrNngb';
            a16.Apttus_Config2__ActionArea__c = 'Left';
            a16.Apttus_Config2__ActionLabelName__c = 'Save';
            a16.Apttus_Config2__ActionName__c = 'Save';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 6;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 7 xe7jiK5kkaJLwYM';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'QuickSave';
            a16.Apttus_Config2__ActionName__c = 'QuickSave';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 7;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 8 UZOkyj3qmKAuoMj';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'SaveAndReload';
            a16.Apttus_Config2__ActionName__c = 'SaveAndReload';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 8;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Asset Line Item 10 oLFUI7s6kE9pIqU';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Finalize';
            a16.Apttus_Config2__ActionName__c = 'Finalize';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 10;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Asset Line Item 11 XsnCuynIK1vFg3a';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'CloseCart';
            a16.Apttus_Config2__ActionName__c = 'CloseCart';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 11;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Asset Line Item 12 wKRie8KTlyZoeCC';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Abandon';
            a16.Apttus_Config2__ActionName__c = 'Abandon';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 12;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Bundle Line Item 1 MEea5pdJoknPy7k';
            a16.Apttus_Config2__ActionArea__c = 'Left';
            a16.Apttus_Config2__ActionLabelName__c = 'AddMoreProducts';
            a16.Apttus_Config2__ActionName__c = 'AddMoreProducts';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Task';
            a16.Apttus_Config2__DisplayType__c = 'Bundle Line Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 1;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Bundle Line Item 2 fwPlvAtmUNBelhy';
            a16.Apttus_Config2__ActionArea__c = 'Left';
            a16.Apttus_Config2__ActionLabelName__c = 'InstalledProducts';
            a16.Apttus_Config2__ActionName__c = 'InstalledProducts';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Task';
            a16.Apttus_Config2__DisplayType__c = 'Bundle Line Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 2;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Asset Line Item 2 rKV7NqgobVtmSJN';
            a16.Apttus_Config2__ActionArea__c = 'Left';
            a16.Apttus_Config2__ActionLabelName__c = 'GoToPricing';
            a16.Apttus_Config2__ActionName__c = 'GoToPricing';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Task';
            a16.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 2;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Asset Line Item 4 oPCnJOkiqvIURaF';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Amend';
            a16.Apttus_Config2__ActionName__c = 'Amend';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 4;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Asset Line Item 5 PvIs1n7ncKbkaFY';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Renew';
            a16.Apttus_Config2__ActionName__c = 'Renew';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 5;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Asset Line Item 3 QK8Z8N6XaKk3kIv';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Increment';
            a16.Apttus_Config2__ActionName__c = 'Increment';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 3;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Asset Line Item 6 6EPwkWYFzghqfXR';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Terminate';
            a16.Apttus_Config2__ActionName__c = 'Terminate';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 6;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Attribute Item 8 miEjO1F4wNkC3QA';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'CloseCart';
            a16.Apttus_Config2__ActionName__c = 'CloseCart';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Attribute Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 8;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Attribute Item 9 8OHp9COEk8S848W';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Abandon';
            a16.Apttus_Config2__ActionName__c = 'Abandon';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Attribute Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 9;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Catalog Item 1 rvEk19qTxij4dTb';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'InstalledProducts';
            a16.Apttus_Config2__ActionName__c = 'InstalledProducts';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Catalog Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 1;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Catalog Item 2 MJr1SJDjMsyjNst';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'CompareProducts';
            a16.Apttus_Config2__ActionName__c = 'CompareProducts';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Catalog Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 2;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Catalog Item 3 g1EBOlHGNrmRvdR';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'GoToPricing';
            a16.Apttus_Config2__ActionName__c = 'GoToPricing';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Catalog Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 3;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Bundle Line Item 3 pmS4Zxl1QxFqod1';
            a16.Apttus_Config2__ActionArea__c = 'Left';
            a16.Apttus_Config2__ActionLabelName__c = 'GoToPricing';
            a16.Apttus_Config2__ActionName__c = 'GoToPricing';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Task';
            a16.Apttus_Config2__DisplayType__c = 'Bundle Line Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 3;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Bundle Line Item 4 zOCvQDLQRPKsQvo';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'RemoveItem';
            a16.Apttus_Config2__ActionName__c = 'RemoveItem';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Bundle Line Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 4;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Bundle Line Item 5 o8W4jfyIguskVts';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'BackToDetail';
            a16.Apttus_Config2__ActionName__c = 'BackToDetail';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Bundle Line Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 5;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Bundle Line Item 6 kGLQAMNSXpjdyac';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'UpdatePrice';
            a16.Apttus_Config2__ActionName__c = 'UpdatePrice';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Bundle Line Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 6;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Asset Line Item 8 3WrqSg5b3EeP38i';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'UpdatePrice';
            a16.Apttus_Config2__ActionName__c = 'UpdatePrice';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 8;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Asset Line Item 9 Mwa7kgKhNVrvjB9';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'More';
            a16.Apttus_Config2__ActionName__c = 'More';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 9;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Asset Line Item 10 J84ICi1ShxTgJeL';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Finalize';
            a16.Apttus_Config2__ActionName__c = 'Finalize';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 10;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Asset Line Item 7 wWqSqwgTase2Ll2';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Upgrade';
            a16.Apttus_Config2__ActionName__c = 'Upgrade';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 7;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Asset Line Item 11 hqqvcJljfOAJ32D';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'CloseCart';
            a16.Apttus_Config2__ActionName__c = 'CloseCart';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 11;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Catalog Item 4 wVeja6YNGB259li';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'UpdatePrice';
            a16.Apttus_Config2__ActionName__c = 'UpdatePrice';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Catalog Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 4;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Catalog Item 5 getutoPqEOHHbXB';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'More';
            a16.Apttus_Config2__ActionName__c = 'More';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Catalog Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 5;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Catalog Item 6 kErlvtxwIJMjrnC';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Finalize';
            a16.Apttus_Config2__ActionName__c = 'Finalize';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Catalog Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 6;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Catalog Item 7 lKOAElkxRetaP7n';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'CloseCart';
            a16.Apttus_Config2__ActionName__c = 'CloseCart';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Catalog Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 7;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Catalog Item 8 gx1MyjuMqCussvj';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Abandon';
            a16.Apttus_Config2__ActionName__c = 'Abandon';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Catalog Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 8;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 9 G2dmRBEUvhmv73y';
            a16.Apttus_Config2__ActionArea__c = 'Right';
            a16.Apttus_Config2__ActionLabelName__c = 'SubmitForApproval';
            a16.Apttus_Config2__ActionName__c = 'SubmitForApproval';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 9;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 10 ZbbUJiXFdpcXNgS';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'GenerateDocument';
            a16.Apttus_Config2__ActionName__c = 'GenerateDocument';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 10;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 11 ze6DqjHOcmX8Nuf';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'EditPriceAgreement';
            a16.Apttus_Config2__ActionName__c = 'EditPriceAgreement';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 11;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 12 ikUt6qxHfP1kOVP';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'AnalyzeDeal';
            a16.Apttus_Config2__ActionName__c = 'AnalyzeDeal';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 12;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 13 2IOCNa5DVkZDupn';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'ReviewAndFinalize';
            a16.Apttus_Config2__ActionName__c = 'ReviewAndFinalize';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 13;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Bundle Line Item 7 eJpHAw9TkN3wA1Q';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'More';
            a16.Apttus_Config2__ActionName__c = 'More';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Bundle Line Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 7;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Bundle Line Item 8 mciCUecOzTMXx4G';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Finalize';
            a16.Apttus_Config2__ActionName__c = 'Finalize';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Bundle Line Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 8;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Bundle Line Item 9 G3khJ83mAIiHDA3';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'CloseCart';
            a16.Apttus_Config2__ActionName__c = 'CloseCart';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Bundle Line Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 9;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Bundle Line Item 10 HYo8r95A9Vurm84';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Abandon';
            a16.Apttus_Config2__ActionName__c = 'Abandon';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Bundle Line Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 10;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Bundle Line Item 11 P2leU7gfSiY5K3c';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'ValidateBundle';
            a16.Apttus_Config2__ActionName__c = 'ValidateBundle';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Bundle Line Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 11;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Asset Line Item 12 ShSycSdx9GdE1gP';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Abandon';
            a16.Apttus_Config2__ActionName__c = 'Abandon';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 12;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Bundle Line Item 1 hBQ19aJaYzjQFUZ';
            a16.Apttus_Config2__ActionArea__c = 'Left';
            a16.Apttus_Config2__ActionLabelName__c = 'AddMoreProducts';
            a16.Apttus_Config2__ActionName__c = 'AddMoreProducts';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Task';
            a16.Apttus_Config2__DisplayType__c = 'Bundle Line Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 1;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Bundle Line Item 2 y8FvCYxdNx8G6UQ';
            a16.Apttus_Config2__ActionArea__c = 'Left';
            a16.Apttus_Config2__ActionLabelName__c = 'InstalledProducts';
            a16.Apttus_Config2__ActionName__c = 'InstalledProducts';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Task';
            a16.Apttus_Config2__DisplayType__c = 'Bundle Line Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 2;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Bundle Line Item 3 ULOMgu6p1bCpj2v';
            a16.Apttus_Config2__ActionArea__c = 'Left';
            a16.Apttus_Config2__ActionLabelName__c = 'GoToPricing';
            a16.Apttus_Config2__ActionName__c = 'GoToPricing';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Task';
            a16.Apttus_Config2__DisplayType__c = 'Bundle Line Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 3;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Bundle Line Item 4 rx44KeQO2AkvVqc';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'RemoveItem';
            a16.Apttus_Config2__ActionName__c = 'RemoveItem';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Bundle Line Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 4;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Catalog Item 9 wp7cJEg89FLSvjQ';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Save';
            a16.Apttus_Config2__ActionName__c = 'Save';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Catalog Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 9;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Catalog Item 10 tI6ol9BiL2aqdSF';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'QuickSave';
            a16.Apttus_Config2__ActionName__c = 'QuickSave';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Catalog Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 10;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Asset Line Item 1 czHiPPydDIjiL6n';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'CatalogProducts';
            a16.Apttus_Config2__ActionName__c = 'CatalogProducts';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 1;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Asset Line Item 2 ckN9mxoEHO82f4k';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'GoToPricing';
            a16.Apttus_Config2__ActionName__c = 'GoToPricing';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 2;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Asset Line Item 3 K1h89sDFQzAT7JM';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Increment';
            a16.Apttus_Config2__ActionName__c = 'Increment';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 3;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 16 S4JHKlM2UrP2iHo';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'CloseCart';
            a16.Apttus_Config2__ActionName__c = 'CloseCart';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 16;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 14 5FdllXZEuT1JncY';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'More';
            a16.Apttus_Config2__ActionName__c = 'More';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 14;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 15 yYDPMZPGsvMvkze';
            a16.Apttus_Config2__ActionArea__c = 'Right';
            a16.Apttus_Config2__ActionLabelName__c = 'Finalize';
            a16.Apttus_Config2__ActionName__c = 'Finalize';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 15;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 17 Q7nBNz2SLQk2lU4';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Abandon';
            a16.Apttus_Config2__ActionName__c = 'Abandon';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 17;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 18 aA6JLPJWeqkpt3B';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'SubmitForMerge';
            a16.Apttus_Config2__ActionName__c = 'SubmitForMerge';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 18;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Bundle Line Item 12 LCnHA2PbmzBomAK';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Save';
            a16.Apttus_Config2__ActionName__c = 'Save';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Bundle Line Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 12;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Bundle Line Item 13 BQWRpABW7ZyfQZd';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'QuickSave';
            a16.Apttus_Config2__ActionName__c = 'QuickSave';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Bundle Line Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 13;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Catalog Item 1 9rR7Ok9dQCihmWW';
            a16.Apttus_Config2__ActionArea__c = 'Left';
            a16.Apttus_Config2__ActionLabelName__c = 'InstalledProducts';
            a16.Apttus_Config2__ActionName__c = 'InstalledProducts';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Task';
            a16.Apttus_Config2__DisplayType__c = 'Catalog Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 1;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Catalog Item 2 7gXItIz1Xp5fSWX';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'CompareProducts';
            a16.Apttus_Config2__ActionName__c = 'CompareProducts';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Catalog Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 2;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Catalog Item 3 bchneHU2PgEnBlH';
            a16.Apttus_Config2__ActionArea__c = 'Left';
            a16.Apttus_Config2__ActionLabelName__c = 'GoToPricing';
            a16.Apttus_Config2__ActionName__c = 'GoToPricing';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Task';
            a16.Apttus_Config2__DisplayType__c = 'Catalog Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 3;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Bundle Line Item 6 SkVgL99VSSzLSrQ';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'UpdatePrice';
            a16.Apttus_Config2__ActionName__c = 'UpdatePrice';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Bundle Line Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 6;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Bundle Line Item 7 6dKijkksOvZD3d5';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'More';
            a16.Apttus_Config2__ActionName__c = 'More';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Bundle Line Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 7;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Bundle Line Item 8 aSxHBPDZ5PVMSaU';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Finalize';
            a16.Apttus_Config2__ActionName__c = 'Finalize';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Bundle Line Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 8;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Bundle Line Item 5 9VLaQLY7Tg8EwoK';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'BackToDetail';
            a16.Apttus_Config2__ActionName__c = 'BackToDetail';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Bundle Line Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 5;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Bundle Line Item 9 FCh7rlPNSKKtFnp';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'CloseCart';
            a16.Apttus_Config2__ActionName__c = 'CloseCart';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Bundle Line Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 9;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Asset Line Item 4 67ghyvLfvdfW1pz';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Amend';
            a16.Apttus_Config2__ActionName__c = 'Amend';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 4;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Asset Line Item 5 fJgeVIVTJranpip';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Renew';
            a16.Apttus_Config2__ActionName__c = 'Renew';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 5;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Asset Line Item 6 uacHidxabjZEAlG';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Terminate';
            a16.Apttus_Config2__ActionName__c = 'Terminate';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 6;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Asset Line Item 7 anCfhs3iTkpGnKe';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Upgrade';
            a16.Apttus_Config2__ActionName__c = 'Upgrade';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 7;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Asset Line Item 8 95q7St7Q7ljGmzY';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'UpdatePrice';
            a16.Apttus_Config2__ActionName__c = 'UpdatePrice';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 8;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 19 MANOdKj3l51CNk7';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'AnalyzeQuote';
            a16.Apttus_Config2__ActionName__c = 'AnalyzeQuote';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 19;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 20 f4lA3dSkplmVeHr';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Revalidate';
            a16.Apttus_Config2__ActionName__c = 'Revalidate';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 20;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Catalog Item 4 RhApTnRJBV8noHR';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'UpdatePrice';
            a16.Apttus_Config2__ActionName__c = 'UpdatePrice';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Catalog Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 4;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Catalog Item 5 yDaIGDrYviKWPTS';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'More';
            a16.Apttus_Config2__ActionName__c = 'More';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Catalog Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 5;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Catalog Item 6 urv2ifxUIiSTnG4';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Finalize';
            a16.Apttus_Config2__ActionName__c = 'Finalize';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Catalog Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 6;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Catalog Item 7 NxopqvFL3K5mJSu';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'CloseCart';
            a16.Apttus_Config2__ActionName__c = 'CloseCart';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Catalog Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 7;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Catalog Item 8 4SjTsprGBQTQc88';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Abandon';
            a16.Apttus_Config2__ActionName__c = 'Abandon';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Catalog Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 8;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Bundle Line Item 10 crcSr1LFDp2nU55';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Abandon';
            a16.Apttus_Config2__ActionName__c = 'Abandon';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Bundle Line Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 10;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Bundle Line Item 11 b1X3lAJrUUmoT2J';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'ValidateBundle';
            a16.Apttus_Config2__ActionName__c = 'ValidateBundle';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Bundle Line Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 11;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Bundle Line Item 12 zD1JcoBh8QwFAFx';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Save';
            a16.Apttus_Config2__ActionName__c = 'Save';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Bundle Line Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 12;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Bundle Line Item 13 uyvTa5EMbSoyIY8';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'QuickSave';
            a16.Apttus_Config2__ActionName__c = 'QuickSave';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Bundle Line Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 13;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Catalog Item 1 NjQDAIQanIyitOJ';
            a16.Apttus_Config2__ActionArea__c = 'Left';
            a16.Apttus_Config2__ActionLabelName__c = 'InstalledProducts';
            a16.Apttus_Config2__ActionName__c = 'InstalledProducts';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Task';
            a16.Apttus_Config2__DisplayType__c = 'Catalog Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 1;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Asset Line Item 9 4je2cUeYwdKuWyb';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'More';
            a16.Apttus_Config2__ActionName__c = 'More';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 9;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Asset Line Item 10 ekgQVgSI6qiLIpl';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Finalize';
            a16.Apttus_Config2__ActionName__c = 'Finalize';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 10;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Asset Line Item 11 3ErQtWxvLUDncTY';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'CloseCart';
            a16.Apttus_Config2__ActionName__c = 'CloseCart';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 11;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Asset Line Item 12 mZre68NetEcbBjk';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Abandon';
            a16.Apttus_Config2__ActionName__c = 'Abandon';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 12;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Catalog Item 9 sfCYgalwRuRvrdh';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Save';
            a16.Apttus_Config2__ActionName__c = 'Save';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Catalog Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 9;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Catalog Item 10 pZZWCuW6AyAb2sX';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'QuickSave';
            a16.Apttus_Config2__ActionName__c = 'QuickSave';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Catalog Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 10;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Resolve Config Item 1 6YqxoqYW7jCgapn';
            a16.Apttus_Config2__ActionArea__c = 'Left';
            a16.Apttus_Config2__ActionLabelName__c = 'CatalogProducts';
            a16.Apttus_Config2__ActionName__c = 'CatalogProducts';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Task';
            a16.Apttus_Config2__DisplayType__c = 'Resolve Config Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 1;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Resolve Config Item 2 KNWTXQEgVGiKeCF';
            a16.Apttus_Config2__ActionArea__c = 'Left';
            a16.Apttus_Config2__ActionLabelName__c = 'GoToPricing';
            a16.Apttus_Config2__ActionName__c = 'GoToPricing';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Task';
            a16.Apttus_Config2__DisplayType__c = 'Resolve Config Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 2;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Resolve Config Item 3 ABBJ5CWEWjhKLSh';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'UpdatePrice';
            a16.Apttus_Config2__ActionName__c = 'UpdatePrice';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Resolve Config Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 3;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Resolve Config Item 5 C3P1HCwb5C1zJux';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Abandon';
            a16.Apttus_Config2__ActionName__c = 'Abandon';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Resolve Config Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 5;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Resolve Config Item 4 CDmap8BTAKDv3OC';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'CloseCart';
            a16.Apttus_Config2__ActionName__c = 'CloseCart';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Resolve Config Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 4;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Attribute Item 1 w3olRRHaMlibirL';
            a16.Apttus_Config2__ActionArea__c = 'Left';
            a16.Apttus_Config2__ActionLabelName__c = 'AddMoreProducts';
            a16.Apttus_Config2__ActionName__c = 'AddMoreProducts';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Task';
            a16.Apttus_Config2__DisplayType__c = 'Attribute Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 1;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Attribute Item 2 BuzSnYxCCo29HOO';
            a16.Apttus_Config2__ActionArea__c = 'Left';
            a16.Apttus_Config2__ActionLabelName__c = 'InstalledProducts';
            a16.Apttus_Config2__ActionName__c = 'InstalledProducts';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Task';
            a16.Apttus_Config2__DisplayType__c = 'Attribute Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 2;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Attribute Item 3 WVJj2E93gWB5RjB';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'RemoveItem';
            a16.Apttus_Config2__ActionName__c = 'RemoveItem';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Attribute Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 3;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Attribute Item 4 Bae4QAnfh81jqpO';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'BackToPricing';
            a16.Apttus_Config2__ActionName__c = 'BackToPricing';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Attribute Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 4;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Attribute Item 5 KDQqqKnXCej5PIl';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Next';
            a16.Apttus_Config2__ActionName__c = 'Next';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Attribute Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 5;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Attribute Item 6 cCM9zEJxSG9B7Hc';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'GoToPricing';
            a16.Apttus_Config2__ActionName__c = 'GoToPricing';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Attribute Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 6;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Attribute Item 7 WhXP7MGfib1hfT9';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'UpdatePrice';
            a16.Apttus_Config2__ActionName__c = 'UpdatePrice';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Attribute Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 7;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Attribute Item 8 FxME6vAUZcQGCLK';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'CloseCart';
            a16.Apttus_Config2__ActionName__c = 'CloseCart';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Attribute Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 8;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 1 LDhFcGaBDGH8Gui';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'AddMoreProducts';
            a16.Apttus_Config2__ActionName__c = 'AddMoreProducts';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 1;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 2 vrCbPqw2KmNGtgX';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'InstalledProducts';
            a16.Apttus_Config2__ActionName__c = 'InstalledProducts';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 2;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 3 jDEZRcTczfyQw57';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'AddMiscellaneousItem';
            a16.Apttus_Config2__ActionName__c = 'AddMiscellaneousItem';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 3;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 4 dbjEFvlSmGFkXre';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'BackToPricing';
            a16.Apttus_Config2__ActionName__c = 'BackToPricing';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 4;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Attribute Item 9 WVHj6qfXdo4KnkF';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Abandon';
            a16.Apttus_Config2__ActionName__c = 'Abandon';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Attribute Item';
            a16.Apttus_Config2__Flow__c = 'Default';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 9;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 3 WmwJ9ZYCgKHtt5l';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'AddMiscellaneousItem';
            a16.Apttus_Config2__ActionName__c = 'AddMiscellaneousItem';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 3;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 4 Hvu3hvbAv8Dpcm2';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'BackToPricing';
            a16.Apttus_Config2__ActionName__c = 'BackToPricing';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 4;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 5 8zcnqbCPzWlcevK';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Reprice';
            a16.Apttus_Config2__ActionName__c = 'Reprice';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 5;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 6 XgQ8FI1FV5ee2tx';
            a16.Apttus_Config2__ActionArea__c = 'Left';
            a16.Apttus_Config2__ActionLabelName__c = 'Save';
            a16.Apttus_Config2__ActionName__c = 'Save';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 6;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Catalog Item 2 kKmsBXWEIAbBMSK';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'CompareProducts';
            a16.Apttus_Config2__ActionName__c = 'CompareProducts';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Catalog Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 2;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Catalog Item 3 DRvGANYHkFAdAw5';
            a16.Apttus_Config2__ActionArea__c = 'Left';
            a16.Apttus_Config2__ActionLabelName__c = 'GoToPricing';
            a16.Apttus_Config2__ActionName__c = 'GoToPricing';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Task';
            a16.Apttus_Config2__DisplayType__c = 'Catalog Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 3;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Catalog Item 4 88XE3M1OfshxJnm';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'UpdatePrice';
            a16.Apttus_Config2__ActionName__c = 'UpdatePrice';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Catalog Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 4;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Catalog Item 5 wc8cQbP96RJPR85';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'More';
            a16.Apttus_Config2__ActionName__c = 'More';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Catalog Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 5;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Catalog Item 6 hUwu2qi4o4M9Wbl';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Finalize';
            a16.Apttus_Config2__ActionName__c = 'Finalize';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Catalog Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 6;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 5 7VOZwCpcOliBplA';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Reprice';
            a16.Apttus_Config2__ActionName__c = 'Reprice';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 5;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 6 dQDGhrUYKOvBRZ6';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Save';
            a16.Apttus_Config2__ActionName__c = 'Save';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 6;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 7 NJDfcIHJiUPXVGA';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'QuickSave';
            a16.Apttus_Config2__ActionName__c = 'QuickSave';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 7;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 8 HJRlFI45mMYwyDJ';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'SaveAndReload';
            a16.Apttus_Config2__ActionName__c = 'SaveAndReload';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 8;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 9 nA2WGtIEZ7ERMhY';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'SubmitForApproval';
            a16.Apttus_Config2__ActionName__c = 'SubmitForApproval';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'NGDefault';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 9;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 7 LHe2TEQB7EPUkBZ';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'QuickSave';
            a16.Apttus_Config2__ActionName__c = 'QuickSave';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 7;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 8 kXSH59FFFd8T8SK';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'SaveAndReload';
            a16.Apttus_Config2__ActionName__c = 'SaveAndReload';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 8;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 9 IPS6VUitybvekSs';
            a16.Apttus_Config2__ActionArea__c = 'Right';
            a16.Apttus_Config2__ActionLabelName__c = 'SubmitForApproval';
            a16.Apttus_Config2__ActionName__c = 'SubmitForApproval';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 9;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 1 ymGyPyEXWKTR5rf';
            a16.Apttus_Config2__ActionArea__c = 'Left';
            a16.Apttus_Config2__ActionLabelName__c = 'AddMoreProducts';
            a16.Apttus_Config2__ActionName__c = 'AddMoreProducts';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Task';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 1;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Cart Line Item 2 dvTXhArn455BLde';
            a16.Apttus_Config2__ActionArea__c = 'Left';
            a16.Apttus_Config2__ActionLabelName__c = 'InstalledProducts';
            a16.Apttus_Config2__ActionName__c = 'InstalledProducts';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Task';
            a16.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 2;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Catalog Item 7 4u38JpFVkGNRoEL';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'CloseCart';
            a16.Apttus_Config2__ActionName__c = 'CloseCart';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Catalog Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 7;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Catalog Item 8 8tMVdzmnKBmVadf';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Abandon';
            a16.Apttus_Config2__ActionName__c = 'Abandon';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Catalog Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 8;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Catalog Item 9 KZ3hknZoOpnjyCV';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'Save';
            a16.Apttus_Config2__ActionName__c = 'Save';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Catalog Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 9;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Catalog Item 10 aMcKp8EfPitE8PE';
            a16.Apttus_Config2__ActionArea__c = 'Center';
            a16.Apttus_Config2__ActionLabelName__c = 'QuickSave';
            a16.Apttus_Config2__ActionName__c = 'QuickSave';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = false;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Action';
            a16.Apttus_Config2__DisplayType__c = 'Catalog Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = false;
            a16.Apttus_Config2__Sequence__c = 10;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Resolve Config Item 1 jiODc1JecxCFO64';
            a16.Apttus_Config2__ActionArea__c = 'Left';
            a16.Apttus_Config2__ActionLabelName__c = 'CatalogProducts';
            a16.Apttus_Config2__ActionName__c = 'CatalogProducts';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Task';
            a16.Apttus_Config2__DisplayType__c = 'Resolve Config Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 1;
            
            CSD.add(a16); 
            
            a16 = new Apttus_Config2__ConfigCustomDisplayActions__c();
            
            a16.Name = 'Resolve Config Item 2 tHYtZ96c2Cuj4o6';
            a16.Apttus_Config2__ActionArea__c = 'Left';
            a16.Apttus_Config2__ActionLabelName__c = 'GoToPricing';
            a16.Apttus_Config2__ActionName__c = 'GoToPricing';
            a16.Apttus_Config2__ActionPage__c = null;
            a16.Apttus_Config2__ActionParams__c = null;
            a16.Apttus_Config2__ActionStyleClass__c = null;
            a16.Apttus_Config2__ActionType__c = null;
            a16.Apttus_Config2__AlwaysDisplay__c = true;
            a16.Apttus_Config2__Behavior__c = null;
            a16.Apttus_Config2__DisplayAs__c = 'Task';
            a16.Apttus_Config2__DisplayType__c = 'Resolve Config Item';
            a16.Apttus_Config2__Flow__c = 'NewUI';
            a16.Apttus_Config2__IsEnabled__c = true;
            a16.Apttus_Config2__Sequence__c = 2;
                
            CSD.add(a16);
 
            insert CSD;
    }
    
    public void InsertCustomDisplayColumns()
    {
        List<Apttus_Config2__ConfigCustomDisplayColumns__c> CDC = new List<Apttus_Config2__ConfigCustomDisplayColumns__c>();
            
            Apttus_Config2__ConfigCustomDisplayColumns__c a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();

            a17.Name = 'Asset Line Item 6 raEA1Wrhjrcj';
            a17.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__ChargeType__c';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 6;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Asset Line Item 7 vYWBcHATqt29';
            a17.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__SellingTerm__c';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 7;
            a17.Apttus_Config2__StyleClass__c = 'aptQuantity';
            a17.Apttus_Config2__Style__c = 'text-align:right;width:60px;';
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Asset Line Item 8 Paq2r4rR9n8w';
            a17.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__SellingFrequency__c';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 8;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Asset Line Item 9 hrvg9C9jwXmh';
            a17.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__StartDate__c';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 9;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            
            a17.Name = 'Asset Line Item 10 7jxZPtAZAKol';
            a17.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__EndDate__c';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 10;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Price Ramp 5 HnQ4WPf6Ux5p';
            a17.Apttus_Config2__DisplayType__c = 'Price Ramp';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__AdjustmentType__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 5;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Price Ramp 6 QiYYm6REw6rB';
            a17.Apttus_Config2__DisplayType__c = 'Price Ramp';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__AdjustmentAmount__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 6;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Price Ramp 7 nXKj6mrIsBtt';
            a17.Apttus_Config2__DisplayType__c = 'Price Ramp';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__StartDate__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 7;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Price Ramp 8 2wfAZ4wNFrGT';
            a17.Apttus_Config2__DisplayType__c = 'Price Ramp';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__EndDate__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 8;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Asset Line Item 1 lA3cSzAfkoD4';
            a17.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__ProductId__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 1;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Asset Line Item 2 y3aR9PMPlLwa';
            a17.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a17.Apttus_Config2__FieldName__c = 'Name';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 2;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Asset Line Item 3 bWtdeaEb9YlP';
            a17.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__Quantity__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 3;
            a17.Apttus_Config2__StyleClass__c = 'aptQuantity';
            a17.Apttus_Config2__Style__c = 'text-align:right; width:60px;';
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Asset Line Item 4 VaMez5JcKTcK';
            a17.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__AllowedActions__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 4;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Asset Line Item 5 rXd498OBMCDY';
            a17.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__LocationId__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 5;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Asset Line Item 6 xkRIcwb6jQ5t';
            a17.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__ChargeType__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 6;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Asset Line Item 7 aeFgtMNbI6M8';
            a17.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__SellingTerm__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 7;
            a17.Apttus_Config2__StyleClass__c = 'aptQuantity';
            a17.Apttus_Config2__Style__c = 'text-align:right;width:60px;';
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Asset Line Item 8 G8aX6PBgsnXs';
            a17.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__SellingFrequency__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 8;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Asset Line Item 9 16VVVIELEb9R';
            a17.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__StartDate__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 9;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Asset Line Item 10 ivGYcDXIg8sS';
            a17.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__EndDate__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 10;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Asset Line Item 11 qZikFnPEMJme';
            a17.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__NetPrice__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 11;
            a17.Apttus_Config2__StyleClass__c = 'aptCurrency';
            a17.Apttus_Config2__Style__c = 'text-align:right;';
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Asset Line Item 12 hoZFMhrCjc5D';
            a17.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__AssetStatus__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 12;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Asset Line Item 11 awppLhJD9PAd';
            a17.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__NetPrice__c';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 11;
            a17.Apttus_Config2__StyleClass__c = 'aptCurrency';
            a17.Apttus_Config2__Style__c = 'text-align:right;';
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Asset Line Item 12 vJA1ZlcvkK6E';
            a17.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__AssetStatus__c';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 12;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Agreement Price Rule 1 StuTXS3GwEKY';
            a17.Apttus_Config2__DisplayType__c = 'Agreement Price Rule';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__Sequence__c';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 1;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Agreement Price Rule 2 lZWYCCKqKtFv';
            a17.Apttus_Config2__DisplayType__c = 'Agreement Price Rule';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__PriceListItemId__c';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 2;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Agreement Price Rule 3 MFTVlkGQVfcw';
            a17.Apttus_Config2__DisplayType__c = 'Agreement Price Rule';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__ProductId__c';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 3;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Line Item 3 JCJC6vHYfGhz';
            a17.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__BasePrice__c';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 3;
            a17.Apttus_Config2__StyleClass__c = 'aptCurrency';
            a17.Apttus_Config2__Style__c = 'text-align:right';
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Line Item 4 MUXhgSzqfUqI';
            a17.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__OptionPrice__c';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 4;
            a17.Apttus_Config2__StyleClass__c = 'aptCurrency';
            a17.Apttus_Config2__Style__c = 'text-align:right';
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Adjustment Line Item 1 64KC75l3bP9C';
            a17.Apttus_Config2__DisplayType__c = 'Adjustment Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__Type__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 1;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Agreement Price Rule 4 UvbQwvHdgbym';
            a17.Apttus_Config2__DisplayType__c = 'Agreement Price Rule';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__BundleProductId__c';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 4;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Agreement Price Rule 5 JBHs4saZqGDX';
            a17.Apttus_Config2__DisplayType__c = 'Agreement Price Rule';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__ChargeType__c';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 5;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Agreement Price Tier 1 s9wU2XAkq8ZX';
            a17.Apttus_Config2__DisplayType__c = 'Agreement Price Tier';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__Sequence__c';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 1;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Agreement Price Tier 2 l1o7hc9ZT7vB';
            a17.Apttus_Config2__DisplayType__c = 'Agreement Price Tier';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__TierStartValue__c';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 2;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Agreement Price Tier 3 FMEHWq8RVkvW';
            a17.Apttus_Config2__DisplayType__c = 'Agreement Price Tier';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__TierEndValue__c';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 3;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Line Item 5 FIqzmzKGEBW7';
            a17.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__Quantity__c';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 5;
            a17.Apttus_Config2__StyleClass__c = 'aptQuantity';
            a17.Apttus_Config2__Style__c = 'text-align:right; width:60px;';
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Line Item 6 HKD1xmVElsYM';
            a17.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__PriceUom__c';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 6;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Line Item 7 ZT4IzR33M5R1';
            a17.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__SellingTerm__c';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 7;
            a17.Apttus_Config2__StyleClass__c = 'aptQuantity';
            a17.Apttus_Config2__Style__c = 'text-align:right; width:60px;';
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Line Item 8 LcN5VjsjmvyG';
            a17.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__SellingFrequency__c';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 8;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Line Item 9 ZLmaOb5ma2iH';
            a17.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__ExtendedPrice__c';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 9;
            a17.Apttus_Config2__StyleClass__c = 'aptCurrency';
            a17.Apttus_Config2__Style__c = 'text-align:right';
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Adjustment Line Item 2 LitWGBQgLsYj';
            a17.Apttus_Config2__DisplayType__c = 'Adjustment Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__AdjustmentAppliesTo__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 2;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Adjustment Line Item 3 pbAYR8gaLFXp';
            a17.Apttus_Config2__DisplayType__c = 'Adjustment Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__AdjustmentType__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 3;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Adjustment Line Item 4 JhVBw2PazzHn';
            a17.Apttus_Config2__DisplayType__c = 'Adjustment Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__AdjustmentAmount__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 4;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Adjustment Line Item 5 GPi3RJXbRqhy';
            a17.Apttus_Config2__DisplayType__c = 'Adjustment Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__AdjustmentAmount__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 5;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Adjustment Line Item 6 h6YBZY7w1HyU';
            a17.Apttus_Config2__DisplayType__c = 'Adjustment Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__IncentiveCode__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 6;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Agreement Price Tier 4 EhzV1Omq8h9e';
            a17.Apttus_Config2__DisplayType__c = 'Agreement Price Tier';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__PeriodStartDate__c';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 4;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Agreement Price Tier 5 7uniOGzexdme';
            a17.Apttus_Config2__DisplayType__c = 'Agreement Price Tier';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__PeriodEndDate__c';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 5;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Agreement Price Tier 6 eq4DQGrRVaRJ';
            a17.Apttus_Config2__DisplayType__c = 'Agreement Price Tier';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__TierRate__c';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 6;
            a17.Apttus_Config2__StyleClass__c = 'aptCurrency';
            a17.Apttus_Config2__Style__c = 'text-align:right';
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Line Item 10 p9Kwyo2IgUP7';
            a17.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__AdjustmentType__c';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 10;
            a17.Apttus_Config2__StyleClass__c = 'aptAdjustmentType';
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Line Item 11 HzD67rXfaDPo';
            a17.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__AdjustmentAmount__c';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 11;
            a17.Apttus_Config2__StyleClass__c = 'aptAdjustment';
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Line Item 12 c5ePD8ialVel';
            a17.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__AdjustedPrice__c';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 12;
            a17.Apttus_Config2__StyleClass__c = 'aptCurrency';
            a17.Apttus_Config2__Style__c = 'text-align:right';
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Line Item 13 pJwJuI8sFVCg';
            a17.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__NetPrice__c';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 13;
            a17.Apttus_Config2__StyleClass__c = 'aptCurrency';
            a17.Apttus_Config2__Style__c = 'text-align:right';
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Line Item 14 kSN1NaYalfUK';
            a17.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__NetAdjustmentPercent__c';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 14;
            a17.Apttus_Config2__StyleClass__c = 'aptPercentage';
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Mass Update 1 lR6AfKyPuVZC';
            a17.Apttus_Config2__DisplayType__c = 'Mass Update';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__Quantity__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 1;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Mass Update 2 rPZLnoY6eD6T';
            a17.Apttus_Config2__DisplayType__c = 'Mass Update';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__AdjustmentType__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 2;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Mass Update 3 ah2h2sthhZck';
            a17.Apttus_Config2__DisplayType__c = 'Mass Update';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__AdjustmentAmount__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 3;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Mass Update 4 DtMTsaVZhd4T';
            a17.Apttus_Config2__DisplayType__c = 'Mass Update';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__LocationId__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 4;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Line Item 1 2vA3a3WMAcVQ';
            a17.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__ProductId__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = 'width:200px;';
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 1;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Agreement Price Tier 8 pjgrsI1geuuc';
            a17.Apttus_Config2__DisplayType__c = 'Agreement Price Tier';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__AdjustmentType__c';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 8;
            a17.Apttus_Config2__StyleClass__c = 'aptAdjustmentType';
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Agreement Price Tier 7 geP2z1tOQLFq';
            a17.Apttus_Config2__DisplayType__c = 'Agreement Price Tier';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__FlatPrice__c';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 7;
            a17.Apttus_Config2__StyleClass__c = 'aptCurrency';
            a17.Apttus_Config2__Style__c = 'text-align:right';
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Agreement Price Tier 9 CDNQGNKYjGnz';
            a17.Apttus_Config2__DisplayType__c = 'Agreement Price Tier';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__AdjustmentAmount__c';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 9;
            a17.Apttus_Config2__StyleClass__c = 'aptAdjustment';
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Line Item 1 QUBtaDSYJQJW';
            a17.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__ProductId__c';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = 'width:200px;';
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 1;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Line Item 2 livyICCg4YEh';
            a17.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__ChargeType__c';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 2;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Total Item 1 EKCm7M6G7qJX';
            a17.Apttus_Config2__DisplayType__c = 'Cart Total Item';
            a17.Apttus_Config2__FieldName__c = 'Name';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 1;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Total Item 2 yOx3DQBREcSt';
            a17.Apttus_Config2__DisplayType__c = 'Cart Total Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__ChargeType__c';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 2;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Total Item 3 LiZCpNW867gL';
            a17.Apttus_Config2__DisplayType__c = 'Cart Total Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__Frequency__c';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 3;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Total Item 4 dYO86aQTWyqd';
            a17.Apttus_Config2__DisplayType__c = 'Cart Total Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__OptionPrice__c';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 4;
            a17.Apttus_Config2__StyleClass__c = 'aptCurrency';
            a17.Apttus_Config2__Style__c = 'text-align:right';
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Total Item 5 GNqnElblZooF';
            a17.Apttus_Config2__DisplayType__c = 'Cart Total Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__ExtendedPrice__c';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 5;
            a17.Apttus_Config2__StyleClass__c = 'aptCurrency';
            a17.Apttus_Config2__Style__c = 'text-align:right';
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Line Item 2 xlwYoKjtZmth';
            a17.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__ChargeType__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 2;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Line Item 3 dvzT1AmDHGiU';
            a17.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__ListPrice__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 3;
            a17.Apttus_Config2__StyleClass__c = 'aptCurrency';
            a17.Apttus_Config2__Style__c = 'text-align:right';
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Line Item 4 Ljwom37TC9OQ';
            a17.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__BasePrice__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 4;
            a17.Apttus_Config2__StyleClass__c = 'aptCurrency';
            a17.Apttus_Config2__Style__c = 'text-align:right';
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Line Item 5 yn3SrA33r8XE';
            a17.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__OptionPrice__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 5;
            a17.Apttus_Config2__StyleClass__c = 'aptCurrency';
            a17.Apttus_Config2__Style__c = 'text-align:right';
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Total Item 6 crEqcDxrW9Vx';
            a17.Apttus_Config2__DisplayType__c = 'Cart Total Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__AdjustmentType__c';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 6;
            a17.Apttus_Config2__StyleClass__c = 'aptAdjustmentType';
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Total Item 7 kZVuDbQyOQe5';
            a17.Apttus_Config2__DisplayType__c = 'Cart Total Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__AdjustmentAmount__c';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 7;
            a17.Apttus_Config2__StyleClass__c = 'aptAdjustment';
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Total Item 8 OQ7CIDhiGDD2';
            a17.Apttus_Config2__DisplayType__c = 'Cart Total Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__AdjustedPrice__c';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 8;
            a17.Apttus_Config2__StyleClass__c = 'aptCurrency';
            a17.Apttus_Config2__Style__c = 'text-align:right';
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Total Item 9 X2qurMoTNWLu';
            a17.Apttus_Config2__DisplayType__c = 'Cart Total Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__NetPrice__c';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 9;
            a17.Apttus_Config2__StyleClass__c = 'aptCurrency';
            a17.Apttus_Config2__Style__c = 'text-align:right';
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Total Item 10 nWoydBfF9jEG';
            a17.Apttus_Config2__DisplayType__c = 'Cart Total Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__NetAdjustmentPercent__c';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 10;
            a17.Apttus_Config2__StyleClass__c = 'aptPercentage';
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Line Item 6 DuPIfkTcZIqr';
            a17.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__Quantity__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 6;
            a17.Apttus_Config2__StyleClass__c = 'aptQuantity';
            a17.Apttus_Config2__Style__c = 'text-align:right; width:60px;';
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Line Item 7 HzPzxSu57NUV';
            a17.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__StartDate__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 7;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Line Item 8 MTKLWzhfeKmy';
            a17.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__EndDate__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 8;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Line Item 9 PPFQrnWChQbh';
            a17.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__PriceUom__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 9;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Line Item 10 PEAco2aIfimy';
            a17.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__SellingTerm__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 10;
            a17.Apttus_Config2__StyleClass__c = 'aptQuantity';
            a17.Apttus_Config2__Style__c = 'text-align:right; width:60px;';
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Line Item 11 49SC8nZuwEw7';
            a17.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__SellingFrequency__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 11;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Line Item 12 oA1hlkjdoDGj';
            a17.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__BaseExtendedPrice__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 12;
            a17.Apttus_Config2__StyleClass__c = 'aptCurrency';
            a17.Apttus_Config2__Style__c = 'text-align:right';
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Line Item 13 ZyZE8d9evsVz';
            a17.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__ExtendedPrice__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 13;
            a17.Apttus_Config2__StyleClass__c = 'aptCurrency';
            a17.Apttus_Config2__Style__c = 'text-align:right';
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Line Item 14 4w7rjnO8yvhe';
            a17.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__AdjustmentType__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 14;
            a17.Apttus_Config2__StyleClass__c = 'aptAdjustmentType';
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Asset Line Item 1 uJ8Us4Of9ano';
            a17.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__ProductId__c';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 1;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Asset Line Item 2 hjPDoblMGXUv';
            a17.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a17.Apttus_Config2__FieldName__c = 'Name';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 2;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Asset Line Item 3 YFvjGc3SRATu';
            a17.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__Quantity__c';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 3;
            a17.Apttus_Config2__StyleClass__c = 'aptQuantity';
            a17.Apttus_Config2__Style__c = 'text-align:right; width:60px;';
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Asset Line Item 4 TMBh1FlHxON9';
            a17.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__AllowedActions__c';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 4;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Asset Line Item 5 aawUrSC5PG6e';
            a17.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__LocationId__c';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 5;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Line Item 15 xGyH9PnrVGH9';
            a17.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__AdjustmentAmount__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 15;
            a17.Apttus_Config2__StyleClass__c = 'aptAdjustment';
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Line Item 16 qhZUuhcQBia5';
            a17.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__AdjustedPrice__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 16;
            a17.Apttus_Config2__StyleClass__c = 'aptCurrency';
            a17.Apttus_Config2__Style__c = 'text-align:right';
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Line Item 17 5o8XAcxuFtBu';
            a17.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__NetPrice__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 17;
            a17.Apttus_Config2__StyleClass__c = 'aptCurrency';
            a17.Apttus_Config2__Style__c = 'text-align:right';
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Line Item 18 tKEfSX6hAWRb';
            a17.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__NetAdjustmentPercent__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 18;
            a17.Apttus_Config2__StyleClass__c = 'aptPercentage';
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            /*a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Line Item 19 FNQVnZlSAmZr';
            a17.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a17.Apttus_Config2__FieldName__c = 'APT_Options_Total_price__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 19;
            a17.Apttus_Config2__StyleClass__c = 'aptPercentage';
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);*/
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Asset Line Item 6 i9MWnme3SsIJ';
            a17.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__ChargeType__c';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 6;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Asset Line Item 7 YI6banzRugJx';
            a17.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__SellingTerm__c';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 7;
            a17.Apttus_Config2__StyleClass__c = 'aptQuantity';
            a17.Apttus_Config2__Style__c = 'text-align:right;width:60px;';
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Asset Line Item 8 dXGryF5XYsA7';
            a17.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__SellingFrequency__c';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 8;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Asset Line Item 9 YWX7HqWTbPgz';
            a17.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__StartDate__c';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 9;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Asset Line Item 10 hhirqr7Rru9F';
            a17.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__EndDate__c';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 10;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Line Item 20 4CjeHaL9TLcM';
            a17.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__LocationId__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 20;
            a17.Apttus_Config2__StyleClass__c = 'aptCurrency';
            a17.Apttus_Config2__Style__c = 'text-align:right';
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Asset Line Item 11 Dhn7sB1Q64Ln';
            a17.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__NetPrice__c';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 11;
            a17.Apttus_Config2__StyleClass__c = 'aptCurrency';
            a17.Apttus_Config2__Style__c = 'text-align:right;';
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Asset Line Item 12 AjVhpt6TqwMK';
            a17.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__AssetStatus__c';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 12;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Agreement Price Rule 1 VajJ8pfIqmAB';
            a17.Apttus_Config2__DisplayType__c = 'Agreement Price Rule';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__Sequence__c';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 1;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Agreement Price Rule 2 hcIU1MWLh2Or';
            a17.Apttus_Config2__DisplayType__c = 'Agreement Price Rule';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__PriceListItemId__c';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 2;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Agreement Price Rule 3 XQa1QEmeFMvS';
            a17.Apttus_Config2__DisplayType__c = 'Agreement Price Rule';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__ProductId__c';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 3;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Line Item 1 c3wgAKYQEVn3';
            a17.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__ProductId__c';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = 'width:200px;';
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 1;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Agreement Price Rule 4 qN2fLQO9QQOq';
            a17.Apttus_Config2__DisplayType__c = 'Agreement Price Rule';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__BundleProductId__c';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 4;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Agreement Price Rule 5 AZBRXkfvFQBG';
            a17.Apttus_Config2__DisplayType__c = 'Agreement Price Rule';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__ChargeType__c';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 5;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Agreement Price Tier 1 QWyPQzlL2BrN';
            a17.Apttus_Config2__DisplayType__c = 'Agreement Price Tier';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__Sequence__c';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 1;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Agreement Price Tier 2 mToP8EVZOet4';
            a17.Apttus_Config2__DisplayType__c = 'Agreement Price Tier';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__TierStartValue__c';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 2;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Agreement Price Tier 3 oUNRJbBZf2In';
            a17.Apttus_Config2__DisplayType__c = 'Agreement Price Tier';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__TierEndValue__c';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 3;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Line Item 2 oXFOPScDP9e8';
            a17.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__ChargeType__c';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 2;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Line Item 3 izdiT3PF4ZNq';
            a17.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__BasePrice__c';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 3;
            a17.Apttus_Config2__StyleClass__c = 'aptCurrency';
            a17.Apttus_Config2__Style__c = 'text-align:right';
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Line Item 4 lfGd7gRdlY9Z';
            a17.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__OptionPrice__c';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 4;
            a17.Apttus_Config2__StyleClass__c = 'aptCurrency';
            a17.Apttus_Config2__Style__c = 'text-align:right';
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Line Item 5 PJYTHSLqyz1O';
            a17.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__Quantity__c';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 5;
            a17.Apttus_Config2__StyleClass__c = 'aptQuantity';
            a17.Apttus_Config2__Style__c = 'text-align:right; width:60px;';
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Line Item 6 63fPSXrCzBYm';
            a17.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__PriceUom__c';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 6;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Agreement Price Tier 4 QoJezhIInneo';
            a17.Apttus_Config2__DisplayType__c = 'Agreement Price Tier';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__PeriodStartDate__c';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 4;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Agreement Price Tier 5 T5o9Zfjhizqs';
            a17.Apttus_Config2__DisplayType__c = 'Agreement Price Tier';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__PeriodEndDate__c';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 5;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Agreement Price Tier 6 OCqbQqP67I6O';
            a17.Apttus_Config2__DisplayType__c = 'Agreement Price Tier';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__TierRate__c';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 6;
            a17.Apttus_Config2__StyleClass__c = 'aptCurrency';
            a17.Apttus_Config2__Style__c = 'text-align:right';
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Agreement Price Tier 7 QM7hrCCJRSKI';
            a17.Apttus_Config2__DisplayType__c = 'Agreement Price Tier';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__FlatPrice__c';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 7;
            a17.Apttus_Config2__StyleClass__c = 'aptCurrency';
            a17.Apttus_Config2__Style__c = 'text-align:right';
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Agreement Price Tier 8 5bxIYSbSlfD2';
            a17.Apttus_Config2__DisplayType__c = 'Agreement Price Tier';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__AdjustmentType__c';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 8;
            a17.Apttus_Config2__StyleClass__c = 'aptAdjustmentType';
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Agreement Price Tier 9 oia5OWPgEPqA';
            a17.Apttus_Config2__DisplayType__c = 'Agreement Price Tier';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__AdjustmentAmount__c';
            a17.Apttus_Config2__Flow__c = 'NewUI';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 9;
            a17.Apttus_Config2__StyleClass__c = 'aptAdjustment';
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Line Item 7 knYL7F2KLoTG';
            a17.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__SellingTerm__c';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 7;
            a17.Apttus_Config2__StyleClass__c = 'aptQuantity';
            a17.Apttus_Config2__Style__c = 'text-align:right; width:60px;';
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Line Item 8 nLbqIQ2FS7xQ';
            a17.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__SellingFrequency__c';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 8;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Line Item 9 U53ImNGA7ZXY';
            a17.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__ExtendedPrice__c';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 9;
            a17.Apttus_Config2__StyleClass__c = 'aptCurrency';
            a17.Apttus_Config2__Style__c = 'text-align:right';
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Line Item 10 bCXS8fF83lE3';
            a17.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__AdjustmentType__c';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 10;
            a17.Apttus_Config2__StyleClass__c = 'aptAdjustmentType';
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Line Item 11 86VU4I5UBIBp';
            a17.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__AdjustmentAmount__c';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 11;
            a17.Apttus_Config2__StyleClass__c = 'aptAdjustment';
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Line Item 12 6pjS5nykhlxa';
            a17.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__AdjustedPrice__c';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 12;
            a17.Apttus_Config2__StyleClass__c = 'aptCurrency';
            a17.Apttus_Config2__Style__c = 'text-align:right';
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Total Item 1 CrWOfBKPmfua';
            a17.Apttus_Config2__DisplayType__c = 'Cart Total Item';
            a17.Apttus_Config2__FieldName__c = 'Name';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 1;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Total Item 2 UslxMBaGMZXu';
            a17.Apttus_Config2__DisplayType__c = 'Cart Total Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__ChargeType__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 2;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Total Item 3 BWtTL7p6s6uS';
            a17.Apttus_Config2__DisplayType__c = 'Cart Total Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__Frequency__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 3;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Total Item 4 wtKWs97rUp7c';
            a17.Apttus_Config2__DisplayType__c = 'Cart Total Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__OptionPrice__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 4;
            a17.Apttus_Config2__StyleClass__c = 'aptCurrency';
            a17.Apttus_Config2__Style__c = 'text-align:right';
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Total Item 5 PndAixeTOsgN';
            a17.Apttus_Config2__DisplayType__c = 'Cart Total Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__ExtendedPrice__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 5;
            a17.Apttus_Config2__StyleClass__c = 'aptCurrency';
            a17.Apttus_Config2__Style__c = 'text-align:right';
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Total Item 6 fvEwUGaSTOdn';
            a17.Apttus_Config2__DisplayType__c = 'Cart Total Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__AdjustmentType__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 6;
            a17.Apttus_Config2__StyleClass__c = 'aptAdjustmentType';
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Line Item 13 cLDZVK9iXrfy';
            a17.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__NetPrice__c';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 13;
            a17.Apttus_Config2__StyleClass__c = 'aptCurrency';
            a17.Apttus_Config2__Style__c = 'text-align:right';
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Line Item 14 REcC18faSg23';
            a17.Apttus_Config2__DisplayType__c = 'Cart Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__NetAdjustmentPercent__c';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 14;
            a17.Apttus_Config2__StyleClass__c = 'aptPercentage';
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Total Item 1 3xQYcZ9oJMNS';
            a17.Apttus_Config2__DisplayType__c = 'Cart Total Item';
            a17.Apttus_Config2__FieldName__c = 'Name';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 1;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Total Item 2 kRxGJamfbaXt';
            a17.Apttus_Config2__DisplayType__c = 'Cart Total Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__ChargeType__c';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 2;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Total Item 3 2RMTYjLCFY9N';
            a17.Apttus_Config2__DisplayType__c = 'Cart Total Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__Frequency__c';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 3;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Total Item 4 vAZhqX7CHS6n';
            a17.Apttus_Config2__DisplayType__c = 'Cart Total Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__OptionPrice__c';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 4;
            a17.Apttus_Config2__StyleClass__c = 'aptCurrency';
            a17.Apttus_Config2__Style__c = 'text-align:right';
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Total Item 7 2WWMgwE2V75G';
            a17.Apttus_Config2__DisplayType__c = 'Cart Total Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__AdjustmentAmount__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 7;
            a17.Apttus_Config2__StyleClass__c = 'aptAdjustment';
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Total Item 8 BSgDzPAdsWkM';
            a17.Apttus_Config2__DisplayType__c = 'Cart Total Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__AdjustedPrice__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 8;
            a17.Apttus_Config2__StyleClass__c = 'aptCurrency';
            a17.Apttus_Config2__Style__c = 'text-align:right';
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Total Item 9 WQdJpjHlRp4M';
            a17.Apttus_Config2__DisplayType__c = 'Cart Total Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__NetPrice__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 9;
            a17.Apttus_Config2__StyleClass__c = 'aptCurrency';
            a17.Apttus_Config2__Style__c = 'text-align:right';
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Total Item 10 9r2o9ZIgE4yc';
            a17.Apttus_Config2__DisplayType__c = 'Cart Total Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__NetAdjustmentPercent__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 10;
            a17.Apttus_Config2__StyleClass__c = 'aptPercentage';
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Price Ramp 1 wZaAGHF395L6';
            a17.Apttus_Config2__DisplayType__c = 'Price Ramp';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__Quantity__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 1;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Total Item 5 qpC2J4JDf2yC';
            a17.Apttus_Config2__DisplayType__c = 'Cart Total Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__ExtendedPrice__c';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 5;
            a17.Apttus_Config2__StyleClass__c = 'aptCurrency';
            a17.Apttus_Config2__Style__c = 'text-align:right';
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Total Item 6 JbRqkSxFm35y';
            a17.Apttus_Config2__DisplayType__c = 'Cart Total Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__AdjustmentType__c';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 6;
            a17.Apttus_Config2__StyleClass__c = 'aptAdjustmentType';
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Total Item 7 bQ6hxtHfPG99';
            a17.Apttus_Config2__DisplayType__c = 'Cart Total Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__AdjustmentAmount__c';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 7;
            a17.Apttus_Config2__StyleClass__c = 'aptAdjustment';
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Total Item 8 P1AwQ96fZtzO';
            a17.Apttus_Config2__DisplayType__c = 'Cart Total Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__AdjustedPrice__c';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 8;
            a17.Apttus_Config2__StyleClass__c = 'aptCurrency';
            a17.Apttus_Config2__Style__c = 'text-align:right';
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Total Item 9 GOGsVTCm6SIA';
            a17.Apttus_Config2__DisplayType__c = 'Cart Total Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__NetPrice__c';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 9;
            a17.Apttus_Config2__StyleClass__c = 'aptCurrency';
            a17.Apttus_Config2__Style__c = 'text-align:right';
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Price Ramp 2 QyS3YUeN59Gv';
            a17.Apttus_Config2__DisplayType__c = 'Price Ramp';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__SellingTerm__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 2;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Price Ramp 3 XtnLMB3r2fgn';
            a17.Apttus_Config2__DisplayType__c = 'Price Ramp';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__SellingFrequency__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = true;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 3;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Price Ramp 4 joEYv2KYEcqH';
            a17.Apttus_Config2__DisplayType__c = 'Price Ramp';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__ExtendedPrice__c';
            a17.Apttus_Config2__Flow__c = 'NGDefault';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 4;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Cart Total Item 10 aZnCLB5WDuCb';
            a17.Apttus_Config2__DisplayType__c = 'Cart Total Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__NetAdjustmentPercent__c';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 10;
            a17.Apttus_Config2__StyleClass__c = 'aptPercentage';
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Asset Line Item 1 7Xw3Iz3ev9Mc';
            a17.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__ProductId__c';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 1;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Asset Line Item 2 HKI8i4R4l56S';
            a17.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a17.Apttus_Config2__FieldName__c = 'Name';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 2;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Asset Line Item 3 DWiK5AZ2CCDW';
            a17.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__Quantity__c';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 3;
            a17.Apttus_Config2__StyleClass__c = 'aptQuantity';
            a17.Apttus_Config2__Style__c = 'text-align:right; width:60px;';
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Asset Line Item 4 aDoMkmiLkw6Q';
            a17.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__AllowedActions__c';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 4;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            a17 = new Apttus_Config2__ConfigCustomDisplayColumns__c();
            
            a17.Name = 'Asset Line Item 5 dNOjFhbGUnKP';
            a17.Apttus_Config2__DisplayType__c = 'Asset Line Item';
            a17.Apttus_Config2__FieldName__c = 'Apttus_Config2__LocationId__c';
            a17.Apttus_Config2__Flow__c = 'Default';
            a17.Apttus_Config2__HeaderStyle__c = null;
            a17.Apttus_Config2__IsEditable__c = false;
            a17.Apttus_Config2__IsPricePoint__c = false;
            a17.Apttus_Config2__IsSortable__c = false;
            a17.Apttus_Config2__Sequence__c = 5;
            a17.Apttus_Config2__StyleClass__c = null;
            a17.Apttus_Config2__Style__c = null;
            CDC.add(a17);
            
            insert CDC;
    }

}