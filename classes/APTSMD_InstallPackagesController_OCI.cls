public with sharing class APTSMD_InstallPackagesController_OCI{
    public Integer progessCounter {get; set;}
    public Integer installCounter {get; set;}
    public String userNameInput {get; set;}
    public String passwordInput {get; set;}
    public String aptUserNameInput {get; set;}
    public String aptPasswordInput {get; set;}
    public Integer progressBar {get; set;}
    public List<PackageWrapper> packageWrapperList {get; set;}
    public List<String> packageList {get; set;}
    public Boolean loggedIn {get; set;}
    public Boolean processComplete {get; set;}
    public Boolean installUnmanagedCode {get; set;}
    public String environmentType {get; set;}
    public String selectedInstallationType {get; set;}
    public String completeMessage {get; set;}
    public Integer totalItemsForInstallation {get; set;}
    
    private APTSMD_PartnerServices.LoginResult loginResult;
    private Map<String, String> packageNameNSMap;
    private Map<String, String> packageNamePasswordMap;
    private Map<String, List<String>> packageNameVersionsMap;
    public List<PackageWrapper> packageWrapperUpdateList {get; set;}
    
    public APTSMD_InstallPackagesController_OCI(){
        completeMessage = 'Congratulations! Your org setup is complete. Please login to your target org to continue.';
        loggedIn = false;
        processComplete = false;
        installUnmanagedCode = false;
        totalItemsForInstallation = 20;
        packageList = new List<String>();
        packageNameVersionsMap = new Map<String, List<String>>();
        packageWrapperList = new List<PackageWrapper>();
        packageWrapperUpdateList = new List<PackageWrapper>();
        packageNameNSMap = new Map<String, String>();
        packageNameNSMap.put('Apttus Contract Management','Apttus');
        packageNameNSMap.put('Apttus Proposal Management','Apttus_Proposal');
        packageNameNSMap.put('Apttus Configuration & Pricing','Apttus_Config2');
        packageNameNSMap.put('Apttus Quote/Proposal-Configuration Integration','Apttus_QPConfig');
        packageNameNSMap.put('Apttus CPQ Api','Apttus_CPQApi');
        
        packageNameNSMap.put('Apttus CPQ Admin','Apttus_CPQAdmin');
        packageNameNSMap.put('Proposal Progress Bar','Apttus_CPQApi');
        
        
        packageNameNSMap.put('Apttus Contract-Configuration Integration','Apttus_CMConfig');
        
        
        packageNameNSMap.put('Apttus Quote/Proposal-Contract Integration','Apttus_QPComply');
        packageNameNSMap.put('Apttus Quote/Proposal-Asset Integration','Apttus_QPAsset');
        packageNameNSMap.put('Apttus DocuSign Api','Apttus_DocuApi');
        packageNameNSMap.put('Apttus Contract DocuSign Integration','Apttus_CMDSign');
        packageNameNSMap.put('Apttus Quote DocuSign Integration','Apttus_QPDSign'); 
        packageNameNSMap.put('Apttus Approvals Management','Apttus_Approval');
        packageNameNSMap.put('Apttus CPQ Approvals Management','Apttus_CQApprov');
        packageNameNSMap.put('Apttus Quote/Proposal-Approvals Management','Apttus_QPApprov');
        //packageNameNSMap.put('Apttus Custom Approvals Management 1.0','Apttus_CUApprov');
        
        packageNameNSMap.put('Apttus Deal Maximizer Setup','Apttus_DealMgr');
        packageNameNSMap.put('Apttus Deal Maximizer','Apttus_DealOpti');
        packageNameNSMap.put('Apttus X-Author™ For Excel','Apttus_XApps');
        packageNameNSMap.put('Apttus X-Author™ Designer For Excel','Apttus_XAppsDS');
        
        //packageNameNSMap.put('Apttus X-Author™ For Excel (Admin)','Apttus_XAAdmin');
        
        
        packageNamePasswordMap = new Map<String, String>();
        packageNamePasswordMap.put('Apttus Contract Management','installapttus');
        packageNamePasswordMap.put('Apttus Proposal Management','installapttus');
        packageNamePasswordMap.put('Apttus Configuration & Pricing','installapttus');
        packageNamePasswordMap.put('Apttus Quote/Proposal-Configuration Integration','installapttus');
        packageNamePasswordMap.put('Apttus CPQ Api','installapttus');
        
        packageNamePasswordMap.put('Apttus CPQ Admin','installapttus');
        
        packageNamePasswordMap.put('Apttus Contract-Configuration Integration','installapttus');
        
        packageNamePasswordMap.put('Apttus Quote/Proposal-Asset Integration','installapttus');
        packageNamePasswordMap.put('Apttus DocuSign Api','installapttus');
        packageNamePasswordMap.put('Apttus Contract DocuSign Integration','installapttus');
        packageNamePasswordMap.put('Apttus Quote DocuSign Integration','installapttus');
        packageNamePasswordMap.put('Apttus Approvals Management','installapttus');
        packageNamePasswordMap.put('Apttus CPQ Approvals Management','installapttus');
        packageNamePasswordMap.put('Apttus Quote/Proposal-Approvals Management','installapttus');
        //packageNamePasswordMap.put('Apttus Custom Approvals Management 1.0','installapttus');
        
        packageNamePasswordMap.put('Apttus Deal Maximizer Setup','installapttus');
        packageNamePasswordMap.put('Apttus Deal Maximizer','installapttus');
        packageNamePasswordMap.put('Apttus X-Author™ For Excel','installxapps1');
        packageNamePasswordMap.put('Apttus X-Author™ Designer For Excel','installxapps1');
        
        //packageNamePasswordMap.put('Apttus X-Author™ For Excel (Admin)','installxapps1');

        
        //Package List to maintain order
        packageList.add('Apttus Contract Management');
        packageList.add('Apttus Proposal Management');
        packageList.add('Apttus Configuration & Pricing');
        packageList.add('Apttus Quote/Proposal-Configuration Integration');
        packageList.add('Apttus CPQ Api');
        
        packageList.add('Apttus CPQ Admin');
        
        packageList.add('Apttus Contract-Configuration Integration');
        
        packageList.add('Apttus Quote/Proposal-Asset Integration');
        packageList.add('Apttus DocuSign Api');
        packageList.add('Apttus Contract DocuSign Integration');
        packageList.add('Apttus Quote DocuSign Integration');
        packageList.add('Apttus Approvals Management');
        packageList.add('Apttus CPQ Approvals Management');
        packageList.add('Apttus Quote/Proposal-Approvals Management');
        //packageList.add('Apttus Custom Approvals Management 1.0');
        
        packageList.add('Apttus Deal Maximizer Setup');
        packageList.add('Apttus Deal Maximizer');
        packageList.add('Apttus X-Author™ For Excel');
        packageList.add('Apttus X-Author™ Designer For Excel'); 
        //packageList.add('Apttus X-Author™ For Excel (Admin)');      
    }
    
    public void retrieveAllPackageVersions(){
        try{
            APTSMD_PartnerServices.LoginResult loginResponse = handleLogin('sbhatt@apttus.com', 'Billgets7$yson9e5uAv8Rexugslqmcog3N', null);
            APTSMD_PartnerServices.Soap service = new APTSMD_PartnerServices.Soap();
            service.SessionHeader = new APTSMD_PartnerServices.SessionHeader_element();
            service.SessionHeader.sessionId = loginResponse.sessionId;
            service.endpoint_x = loginResponse.ServerUrl.split('/services')[0] + '/services/Soap/u/31.0';
            
            Map<String,APTSMD_PartnerServicesSobject.sObject_x_PackageVersion> returnMap = new Map<String,APTSMD_PartnerServicesSobject.sObject_x_PackageVersion>();
            APTSMD_PartnerServices.QueryResult_PackageVersion qr = service.queryPackageVersion('Select ID, Package_Name__c, sfLma__Version__c from sfLma__Package_Version__c Where Show_On_Customer_Portal__c = true');
            for(APTSMD_PartnerServicesSobject.sObject_x_PackageVersion pv : qr.records){
                if(packageNameVersionsMap.containsKey(pv.Package_Name)){
                    List<String> currentVersions = packageNameVersionsMap.get(pv.Package_Name);
                    currentVersions.add(pv.sfLma_Version);
                    packageNameVersionsMap.put(pv.Package_Name, currentVersions);
                }else{
                    packageNameVersionsMap.put(pv.Package_Name, new List<String>{pv.sfLma_Version});
                }
            }
            
            system.debug('###packageNameVersionsMap:' + packageNameVersionsMap);
            
            for(String packageName : packageList){
                List<String> packageVersionList = packageNameVersionsMap.get(packageName);
                packageVersionList.sort();
                List<String> packageVersionListDescSorted = new List<String>();
                for(Integer index = packageVersionList.size(); index > 0; index--){
                    packageVersionListDescSorted.add(packageVersionList[index - 1]);
                }
                packageWrapperList.add(new PackageWrapper(packageName, packageNameNSMap.get(packageName), packageNamePasswordMap.get(packageName), packageVersionListDescSorted));
            }
        }catch(Exception e){
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR,'Failed to retrieve package details: ' + e));
            return;
        }
    }
    
    public void installOrUpgradePackages()
    {
        if(selectedInstallationType == 'New'){
            installAllPackages();
        }else if(selectedInstallationType == 'Update'){
            updatePackages();
        }else{
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR,'Please choose the type of installation.'));
        }
        
        if(progessCounter > totalItemsForInstallation){
            processComplete = true;
        }
        system.debug('###processComplete:' + processComplete);
        
    }
    
    public void installAllPackages()
    {   
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
        
        system.debug('###progessCounter:' + progessCounter);
        system.debug('###installCounter:' + installCounter);
        system.debug('###endpoint:' + endpoint);
        system.debug('###endpointCustomWS:' + endpointCustomWS);
                
        if(progessCounter == null){
            progessCounter = 1;
        }
        
        if(installCounter == null){
            installCounter = 1;
        }
        
        if(progessCounter < 19){
            if(installCounter == progessCounter){
                if(!retrieveInstalledPackages(endpoint, sessionId, packageWrapperList[progessCounter - 1].packageNS)){
                    installSinglePackage(packageWrapperList[progessCounter - 1].packageNS, packageWrapperList[progessCounter - 1].selectedVersion, packageWrapperList[progessCounter - 1].packagePassword, endpoint, sessionId);
                    system.debug('###Installation started for ' + packageWrapperList[progessCounter - 1].packageName + ' version ' + + packageWrapperList[progessCounter - 1].selectedVersion);
                }
                installCounter++;
            }
            else if(retrieveInstalledPackages(endpoint, sessionId, packageWrapperList[progessCounter - 1].packageNS)){
                system.debug('###' + packageWrapperList[progessCounter - 1].packageName + ' Installed');
                progessCounter++;
            }else{
                system.debug('###Installation in progress for ' + packageWrapperList[progessCounter - 1].packageName + ' version ' + packageWrapperList[progessCounter - 1].selectedVersion);
            }
        }
        
        if(progessCounter == 19){
            if(!installUnmanagedCode){
                system.debug('###Unmanaged Package Installation is not required');
                installCounter++;
                progessCounter++;
            }else{
                if(installCounter == 19){
                    if(!checkForDeploymentStatus(endpoint, sessionId)){
                        deployZip(endpoint, sessionId);
                    }
                    installCounter++;
                }
                else if(checkForDeploymentStatus(endpoint, sessionId)){
                    progessCounter++;
                    system.debug('###Unmanaged Package Installed');
                }
            }
        }
        
        if(progessCounter == 20){
            if(!installUnmanagedCode){
                system.debug('###Custom Setup is not required');
                progessCounter++;
            }else{
                progessCounter++;
                handleCustomSetup(endpointCustomWS, sessionId);
            }
        }
        
        progressBar = (Integer)(progessCounter - 1) * 100/totalItemsForInstallation;
    }
    
    public void updatePackages()
    {   completeMessage = 'Your package upgragation is initiated. Please login to your target org to verify and continue.';
    
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
        
        preparePackageUpdateList();
        
        loggedIn = true;
        String sessionId = loginResult.sessionId;
        String endpoint = loginResult.ServerUrl.split('/services')[0] + '/services/Soap/m/31.0';
        
        system.debug('###progessCounter:' + progessCounter);
        system.debug('###endpoint:' + endpoint);
                
        if(progessCounter == null){
            progessCounter = 1;
        }
        
        if(progessCounter <= totalItemsForInstallation){
            installSinglePackage(packageWrapperUpdateList[progessCounter - 1].packageNS, packageWrapperUpdateList[progessCounter - 1].selectedVersion, packageWrapperUpdateList[progessCounter - 1].packagePassword, endpoint, sessionId);
            system.debug('###Upgradation started for ' + packageWrapperUpdateList[progessCounter - 1].packageName + ' version ' + + packageWrapperUpdateList[progessCounter - 1].selectedVersion);
            progessCounter++;
        }
        
        progressBar = (Integer)(progessCounter - 1) * 100/totalItemsForInstallation;
    }
    
    private void preparePackageUpdateList(){
        if(packageWrapperUpdateList.size() > 0){
            return;
        }
        for(PackageWrapper pw : packageWrapperList){
            if(pw.installationRequired){
                packageWrapperUpdateList.add(pw);
            }
        }
        
        totalItemsForInstallation = packageWrapperUpdateList.size();
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
                    system.debug('Full Details: ' + pName);
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
        
        system.debug('###APTSMD_CustomSetupWebService class not found.');
        
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
    public static void deployZip(String endpoint, String sessionId)
    {   
        Document inputZipfile = [Select Id, Name, Body From Document Where Name = 'Unmanaged Code (CPQ)'];
        String zipData = EncodingUtil.base64Encode(inputZipfile.Body); 
        
        APTSMD_OCI_MetadataService.MetadataPort service = createService(endpoint, sessionId);
        APTSMD_OCI_MetadataService.DeployOptions deployOptions = new APTSMD_OCI_MetadataService.DeployOptions();
        deployOptions.allowMissingFiles = false;
        deployOptions.autoUpdatePackage = false;
        deployOptions.checkOnly = false;
        deployOptions.ignoreWarnings = false;
        deployOptions.performRetrieve = false;
        deployOptions.purgeOnDelete = false;
        deployOptions.rollbackOnError = true;
        deployOptions.runTests = null;
        deployOptions.singlePackage = true;
        deployOptions.testLevel = 'NoTestRun';
        
        try {
            service.deploy(zipData, deployOptions);
        }catch(Exception e) 
        {
           system.debug(e);
        }
    }
    
    @future(callout=true)
    public static void handleCustomSetup(String endpoint, String sessionId)
    {   
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
    
    private static APTSMD_OCI_MetadataService.MetadataPort createService(String endpoint, String sessionId)
    {
        APTSMD_OCI_MetadataService.MetadataPort service = new APTSMD_OCI_MetadataService.MetadataPort();
        service.SessionHeader = new APTSMD_OCI_MetadataService.SessionHeader_element();
        service.SessionHeader.sessionId = sessionId;
        service.endpoint_x = endpoint;
        return service;
    }
    
    private static void handleSaveResults(APTSMD_OCI_MetadataService.SaveResult saveResult)
    {
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
    
    public List<SelectOption> getEnvironments() {
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Production','Production'));
        options.add(new SelectOption('Sandbox','Sandbox'));

        return options;
    }
    
    public List<SelectOption> getInstallationType() {
        List<SelectOption> options = new List<SelectOption>(); 
        options.add(new SelectOption('New','Setup New Org')); 
        options.add(new SelectOption('Update','Update Existing Packages')); 
        
        return options; 
    }
    
    public class PackageWrapper{
        public String packageName {get; set;}
        public String packageNS {get; set;}
        public String packagePassword {get; set;}
        public String selectedVersion {get; set;}
        public List<SelectOption> availableVersions {get; set;}
        public Boolean installationRequired {get; set;}
        
        public PackageWrapper(String packageName, String packageNS, String packagePassword, List<String> versionNumberList){
            availableVersions = new List<SelectOption>();
            this.packageName = packageName;
            this.packageNS = packageNS;
            this.packagePassword = packagePassword;
            for(String vNum : versionNumberList){
                availableVersions.add(new SelectOption(createVersionNumber(vNum),vNum));
            }
        }
        
        private String createVersionNumber(String vNum){
            String[] versionElements = vNum.split('\\.');
            if(versionElements[1].length() == 1){
                return versionElements[0] + '.' + String.valueOf(Integer.valueOf(versionElements[2].split(' ')[0]));
            }
            
            return vNum;
        }
    }
    
}