/* ************************************************************
@Name: APTSMD_InstallPackagesController
@Author: Shubham Bhatt (Apttus PS)
@CreateDate: 12th November 2016
@Description: Install all packages with one click.
@UsedBy: PS CPQ Quick Start Project 
//****************************************************************** */

public with sharing class APTSMD_InstallPackagesController{
    
    public Integer progessCounter {get; set;}
    public Integer installCounter {get; set;}
    public String userNameInput {get; set;}
    public String passwordInput {get; set;}
    public Integer progressBar {get; set;}
    public List<PackageWrapper> packageWrapperList {get; set;}
    public Boolean loggedIn {get; set;}
    public Boolean processComplete {get; set;}   
    public Boolean justDeployment {get; set;}
    public Boolean checkOnly {get; set;}
    public Boolean installUnmanagedCode {get; set;}
    public String runSpecificTest {get; set;}
    public List<String> selectedPackageList {get; set;}
    public String environmentType {get; set;}
    public String selectedInstallationType {get; set;}
    public String completeMessage {get; set;}
    public Integer totalItemsForInstallation {get; set;}
    private APTSMD_PartnerServices.LoginResult loginResult;
    public String packageType {get; set;}
    public String runTestType {get; set;}
    Public Integer finalCall {get; set;}
    public Map<String,APT_OneClickInstallerPackages__mdt> oneClickmtdMap {get;set;}
    public List<APT_OneClickInstallerPackages__mdt> packageDetails {get;set;}
    
    
    //CONSTRUCTOR
    public APTSMD_InstallPackagesController(){
        
        selectedInstallationType = 'New';
        completeMessage = 'Congratulations! Package installation in your target org  has been completed successfully. Please login to your target org in order to continue.';
        packageType = 'CPQ';
        runTestType = 'NoTestRun';
        loggedIn = false;
        processComplete = false;
        installUnmanagedCode = false;
        totalItemsForInstallation = 09;
        finalCall = 0;
        justDeployment = false;
        checkOnly = false;
        runSpecificTest = '';
        
        selectedPackageList = new List<String>();
        oneClickmtdMap = new Map<String,APT_OneClickInstallerPackages__mdt>();
        
        packageDetails = [select ID,APT_Package_Password__c,APT_Package_NameSpace__c,APT_CLM_Package__c,APT_CPQ_Package__c,APT_Package_Name__c,
                          APT_Sequence_Number__c,APT_Version_Number__c from APT_OneClickInstallerPackages__mdt ORDER BY APT_Sequence_Number__c ASC];
        updateList();
    }
    
    public void updateList(){
        selectedPackageList = new List<String>();
        oneClickmtdMap = new Map<String,APT_OneClickInstallerPackages__mdt>();
        for(APT_OneClickInstallerPackages__mdt mtdObj : packageDetails)
        {
            if(packageType == 'CPQ' && mtdObj.APT_CPQ_Package__c)
            {  
                selectedPackageList.add(mtdObj.APT_Package_Name__c);
                oneClickmtdMap.put(mtdObj.APT_Package_Name__c,mtdObj);
            }
            else if(packageType == 'CLM' && mtdObj.APT_CLM_Package__c)
            {
                selectedPackageList.add(mtdObj.APT_Package_Name__c);
                oneClickmtdMap.put(mtdObj.APT_Package_Name__c,mtdObj);
            }
            
            if(installUnmanagedCode ){
                completeMessage = 'Congratulations! Package installation in your target org  has been completed successfully. Please login to your target org in order to continue. For checking the status of metadata installation please go to Target ORG -> Setup -> Deployment status.';
            }
            
            if(justDeployment ){
                completeMessage = 'Congratulations! We are processing your metadata installation. Please login to your target org in order to continue. For checking the status of metadata installation please go to Target ORG -> Setup -> Deployment status.';            
            }
        }
    }
    
    public void retrieveAllPackages(){
        try{
          packageWrapperList = new List<PackageWrapper>();
          updateList();
          totalItemsForInstallation = selectedPackageList.size() + 2;
          for(String packageName : selectedPackageList)
          {
              packageWrapperList.add(new PackageWrapper(packageName, oneClickmtdMap.get(packageName).APT_Package_NameSpace__c, oneClickmtdMap.get(packageName).APT_Package_Password__c, oneClickmtdMap.get(packageName).APT_Version_Number__c ));
          }
                  
        }
        catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR,'Failed to retrieve package details: ' + e));
            return;
        }
    }
    
    public void installOrUpgradePackages(){
        installAllPackages();
        if(progessCounter > totalItemsForInstallation){
            processComplete = true;
        }
    }
    
    public void installAllPackages(){   
        if(loginResult == null){
            String loginURL = null;
            if(environmentType == 'Sandbox'){
                loginURL = 'https://test.salesforce.com/services/Soap/u/32.0';
            }
            try{
                loginResult = handleLogin(userNameInput, passwordInput, loginURL);
            }catch(Exception e){
                ApexPages.addMessages(e);
                return;
            }
        }
        
        loggedIn = true;
        String sessionId = loginResult.sessionId;
        String endpoint = loginResult.ServerUrl.split('/services')[0] + '/services/Soap/m/31.0';
        String endpointCustomWS = loginResult.ServerUrl.split('/services')[0] + '/services/Soap/class/APTSMD_CustomSetupWebService';
        if(progessCounter == null){
            progessCounter = 1;
        }
        if(installCounter == null){
            installCounter = 1;
        }
        totalItemsForInstallation = selectedPackageList.size() + 2;
        Integer a = totalItemsForInstallation - 1;
        
        if(justDeployment ){
           
        if(!checkForDeploymentStatus(endpoint, sessionId)){
            system.debug('fgh'+packageType);
            system.debug('#fgh111'+checkOnly);
            system.debug('#fgh222'+runTestType );
            system.debug('#fgh333'+runSpecificTest);
            deployZip(endpoint, sessionId,packageType,checkOnly,runSpecificTest,runTestType );
            processComplete = true;
            system.debug('gghp under 1');
        }
        
        }else{
        
        
        if(progessCounter < (totalItemsForInstallation - 1)){
            if(installCounter == progessCounter){
                if(!retrieveInstalledPackages(endpoint, sessionId, packageWrapperList[progessCounter - 1].packageNS)){
                    installSinglePackage(packageWrapperList[progessCounter - 1].packageNS, packageWrapperList[progessCounter - 1].selectedVersion, packageWrapperList[progessCounter - 1].packagePassword, endpoint, sessionId);
                }
                installCounter++;
            }
            else if(retrieveInstalledPackages(endpoint, sessionId, packageWrapperList[progessCounter - 1].packageNS)){
                progessCounter++;
            }else{
            }
        }
        Integer ab = totalItemsForInstallation - 1;
        if(progessCounter == (totalItemsForInstallation - 1)){
            if(!installUnmanagedCode){
                installCounter++;
                progessCounter++;
            }else{
                if(installCounter == (totalItemsForInstallation - 1)){
                    if(!checkForDeploymentStatus(endpoint, sessionId)){
                        system.debug('fgh'+packageType);
                        deployZip(endpoint, sessionId,packageType,false,null,'NoTestRun');
                        
                        progessCounter++;
                        system.debug('gghp under 1');
                    }
                    installCounter++;
                    system.debug('ggh under 2' +installCounter );
                }
                else if(checkForDeploymentStatus(endpoint, sessionId)){
                    system.debug('fgh Finally Entered in ');
                    progessCounter++;
                }
            }
        }
        
        
        Integer abc = totalItemsForInstallation;
        if(progessCounter ==  totalItemsForInstallation ){
            if(!installUnmanagedCode){
                progessCounter++;
            }else{
                progessCounter++;
                //handleCustomSetup(endpointCustomWS, sessionId);
            }
        }
        
        progressBar = (Integer)(progessCounter -1) * 100/totalItemsForInstallation;        
        
        
        }

        
    }
    
    
    private APTSMD_PartnerServices.LoginResult handleLogin(String userName, String password, String endpoint){
        APTSMD_PartnerServices.Soap service = new APTSMD_PartnerServices.Soap();
        if(endpoint != null){
            service.endpoint_x = endpoint;
        }
        try {
            return service.login(userName, password);
        }catch(Exception e) 
        {
           throw e;
        }
    }
    
    private Boolean retrieveInstalledPackages(String endpoint, String sessionId, String checkForPackage) {
        APTSMD_OCI_MetadataService.MetadataPort service = createService(endpoint, sessionId);
        Set<String> installPackagesSet = new Set<String>();
        try {
            APTSMD_OCI_MetadataService.ListMetadataQuery query = new APTSMD_OCI_MetadataService.ListMetadataQuery();
            query.type_x = 'InstalledPackage';
            double asOfVersion = 28.0;
            APTSMD_OCI_MetadataService.FileProperties[] packages = service.listMetadata(new APTSMD_OCI_MetadataService.ListMetadataQuery[] {query}, asOfVersion);
            if (packages != null) {
                for (APTSMD_OCI_MetadataService.FileProperties pName : packages) {
                    installPackagesSet.add(pName.fullName);
                }
            }
        } catch (TypeException te) {
            system.debug(te);
            ApexPages.addMessages(te); 
        }
        return installPackagesSet.contains(checkForPackage);
    }
    
    private Boolean checkForDeploymentStatus(String endpoint, String sessionId) {
        APTSMD_OCI_MetadataService.MetadataPort service = createService(endpoint, sessionId);
        Set<String> installPackagesSet = new Set<String>();
        try {
            APTSMD_OCI_MetadataService.ListMetadataQuery query = new APTSMD_OCI_MetadataService.ListMetadataQuery();
            query.type_x = 'ApexClass';
            double asOfVersion = 35.0;
            APTSMD_OCI_MetadataService.FileProperties[] packages = service.listMetadata(new APTSMD_OCI_MetadataService.ListMetadataQuery[] {query}, asOfVersion);
            if (packages != null) {
                for (APTSMD_OCI_MetadataService.FileProperties pName : packages) {
                    if(pName.fullName == 'APTSMD_CustomSetupWebService'){
                        return true;
                    }
                }
            }
        } catch (TypeException te) {
            system.debug(te);
            ApexPages.addMessages(te); 
        }
        return false;
    }
    
    @future(callout=true)
    private static void installSinglePackage(String packageName, String packageVersion, String packagePassword, String endpoint, String sessionId){
        APTSMD_OCI_MetadataService.InstalledPackage installedPackage = new APTSMD_OCI_MetadataService.InstalledPackage();
        installedPackage.password = packagePassword;
        installedPackage.versionNumber = packageVersion;
        installedPackage.fullName = packageName;      
        // Install the package
        APTSMD_OCI_MetadataService.MetadataPort service = createService(endpoint, sessionId);
        try {
            List<APTSMD_OCI_MetadataService.SaveResult> results = service.createMetadata(new APTSMD_OCI_MetadataService.Metadata[] { installedPackage });
            handleSaveResults(results[0]);
        }catch(Exception e) 
        {
           system.debug(e);
        }
    }
    
    @future(callout=true)
    public static void deployZip(String endpoint, String sessionId,String bcde, Boolean checkOnly,String runSpecificTest,String runTestType  ){ 
       
        Document inputZipfile = [Select Id, Name, Body From Document Where Name = 'Unmanaged Code (CPQ)'];
    
        if(bcde == 'CPQ')
            { 
                inputZipfile = [Select Id, Name, Body From Document Where Name = 'Unmanaged Code (CPQ)'];
            }
        else if(bcde == 'CLM')
            {
                inputZipfile = [Select Id, Name, Body From Document Where Name = 'Unmanaged Code (CLM)'];
            }
            
        //Document inputZipfile = [Select Id, Name, Body From Document Where Name = 'Unmanaged Code (CPQ)'];
        String zipData = EncodingUtil.base64Encode(inputZipfile.Body); 
        
        APTSMD_OCI_MetadataService.MetadataPort service = createService(endpoint, sessionId);
        APTSMD_OCI_MetadataService.DeployOptions deployOptions = new APTSMD_OCI_MetadataService.DeployOptions();
        deployOptions.allowMissingFiles = false;
        deployOptions.autoUpdatePackage = false;
        deployOptions.checkOnly = checkOnly;  //true
        deployOptions.ignoreWarnings = false;
        deployOptions.performRetrieve = false;
        deployOptions.purgeOnDelete = false;
        deployOptions.rollbackOnError = true;
        //deployOptions.RunTests = new List<String>{'A1', 'Special Customer'};
        if(runSpecificTest == NULL){
           deployOptions.runTests = NULL;
        }else{
           deployOptions.runTests = runSpecificTest.split(',');
        }
        deployOptions.singlePackage = true;
        deployOptions.testLevel = runTestType; 
        //NoTestRun RunSpecifiedTests RunLocalTests RunAllTestsInOrg   https://releasenotes.docs.salesforce.com/en-us/summer15/release-notes/rn_api_meta_new_calls.htm#testlevels
        
        try {
            service.deploy(zipData, deployOptions);
            system.debug('fgh 123 Entered in '); 
        }catch(Exception e) 
        {
           system.debug(e);
        }
    }
    
    @future(callout=true)
    public static void handleCustomSetup(String endpoint, String sessionId){   
        APTSMD_CustomSetupWebServiceClient.APTSMD_CustomSetupWebService apexWebSvc = new APTSMD_CustomSetupWebServiceClient.APTSMD_CustomSetupWebService();
        APTSMD_CustomSetupWebServiceClient.SessionHeader_element sessionHeader = new APTSMD_CustomSetupWebServiceClient.SessionHeader_element();
        sessionHeader.sessionId = sessionId;

        // The Web services have a maximum timeout of 2 minutes. The timeout value
        // is in milliseconds.
        apexWebSvc.timeout_x = 120000;
        apexWebSvc.SessionHeader = sessionHeader;
        apexWebSvc.endpoint_x = endpoint;

        try {
            apexWebSvc.handleCustomSetup();
        }catch(Exception e) 
        {
           system.debug(e);
        }
    }
    
    private static APTSMD_OCI_MetadataService.MetadataPort createService(String endpoint, String sessionId){
        APTSMD_OCI_MetadataService.MetadataPort service = new APTSMD_OCI_MetadataService.MetadataPort();
        service.SessionHeader = new APTSMD_OCI_MetadataService.SessionHeader_element();
        service.SessionHeader.sessionId = sessionId;
        service.endpoint_x = endpoint;
        return service;
    }
    
    private static void handleSaveResults(APTSMD_OCI_MetadataService.SaveResult saveResult){
        // Nothing to see?
        if(saveResult==null || saveResult.success)
            return;
        // Construct error message and throw an exception
        if(saveResult.errors!=null)
        {
            List<String> messages = new List<String>();
            messages.add(
                (saveResult.errors.size()==1 ? 'Error ' : 'Errors ') +
                    'occured processing component ' + saveResult.fullName + '.');
            for(APTSMD_OCI_MetadataService.Error error : saveResult.errors){
                messages.add(
                    error.message + ' (' + error.statusCode + ').' +
                    ( error.fields!=null && error.fields.size()>0 ?
                        ' Fields ' + String.join(error.fields, ',') + '.' : '' ) );
            }
            if(messages.size()>0){
                system.debug('ERROR:' + messages);
            }
        }
        if(!saveResult.success){
            system.debug('ERROR:Request failed with no specified error.');
        }
    }
    
    public List<SelectOption> getEnvironments(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Production','Production'));
        options.add(new SelectOption('Sandbox','Sandbox'));

        return options;
    }
    
    public List<SelectOption> getInstallationType(){
        List<SelectOption> options = new List<SelectOption>(); 
        options.add(new SelectOption('New','Setup New Org')); 
        return options; 
    }
    
    public class PackageWrapper{
        public String packageName {get; set;}
        public String packageNS {get; set;}
        public String packagePassword {get; set;}
        public String selectedVersion {get; set;}
        public Boolean installationRequired {get; set;}
        
        public PackageWrapper(String packageName, String packageNS, String packagePassword,String selectedVersionPar){
            this.packageName = packageName;
            this.packageNS = packageNS;
            this.packagePassword = packagePassword;
            this.selectedVersion = selectedVersionPar;
        }
    }
}