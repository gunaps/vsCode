public without sharing class MNC_TrackingController{
    private list<ApexClass> classlist;
    private list<ApexTrigger> triggerlist;
    private list<apexpage> pagelist;
    private list<ApexComponent> componentslist;
    private list<EmailTemplate> emailtemplatelist;
    private list<Report> reportlist;
    private list<Dashboard> dashboardlist;
    public string fromDate {get;set;}
    public string toDate {get;set;}
    public string componenttype{get;set;}
    public string componentname{get;set;}
    public Map<String,string> comList {get;set;}
    public Map<String,String> compareFieldDataType;
    
    public list<trackerWrapper> listTracker{get;set;}
    
    private String fromDt;   
    private String toDt;
    private  DateTime dtFromDate ;
    private  DateTime dtToDate;
    public  Attachment attachment {get;set;}
    public boolean isGenerated{get;set;}
    public string hours{get;set;}
        
    public class trackerWrapper{
        public boolean IsChecked{get;set;}
        public string comptype{get;set;}
        public string componame{get;set;}
        public DateTime lasdtmodifieddate{get;set;}
        public string lastmodifiedby{get;set;}
    }
    public MNC_TrackingController(){
        //doGetData();
        isGenerated = false;
        componentname = '';
        compareFieldDataType = new Map<String,String> ();
        compareFieldDataType.put('ApexClass','MetaDataType');
        compareFieldDataType.put('ApexTrigger','MetaDataType');
        compareFieldDataType.put('ApexPage','MetaDataType'); 
        compareFieldDataType.put('ApexComponent','MetaDataType');
        compareFieldDataType.put('ConnectedApp','MetaDataType');
        compareFieldDataType.put('CustomLabel','MetaDataType');
        compareFieldDataType.put('CustomTab','MetaDataType');
        compareFieldDataType.put('CustomField','MetaDataType'); 
        compareFieldDataType.put('CustomObject','MetaDataType');
        compareFieldDataType.put('CustomObjectTranslation','MetaDataType');
        compareFieldDataType.put('CustomApplication','MetaDataType');
        compareFieldDataType.put('Dashboard','QueryType');
        compareFieldDataType.put('ValidationRule','MetaDataType');
        compareFieldDataType.put('StaticResource','MetaDataType');
        compareFieldDataType.put('Layout','MetaDataType');
        compareFieldDataType.put('RecordType','MetaDataType');
        compareFieldDataType.put('ReportType','MetaDataType');
        compareFieldDataType.put('Report','QueryType');
        compareFieldDataType.put('RemoteSiteSetting','MetaDataType');
        compareFieldDataType.put('EmailTemplate','QueryType');
        compareFieldDataType.put('Group','MetaDataType');  
        compareFieldDataType.put('Letterhead','MetaDataType'); 
        compareFieldDataType.put('PermissionSet','MetaDataType'); 
        compareFieldDataType.put('Profile','MetaDataType'); 
        compareFieldDataType.put('Queue','MetaDataType'); 
        compareFieldDataType.put('QuickAction','MetaDataType'); 
        compareFieldDataType.put('Flow','MetaDataType');  
        compareFieldDataType.put('WebLink','MetaDataType');      
        compareFieldDataType.put('WorkflowRule','MetaDataType');  
        compareFieldDataType.put('WorkflowFieldUpdate','MetaDataType'); 
        compareFieldDataType.put('WorkflowAlert','MetaDataType');  
    }
    
    //Code for use metadataservice api   
    public static MetadataService.MetadataPort createService() 
    { 
        MetadataService.MetadataPort service = new MetadataService.MetadataPort(); 
        service.SessionHeader = new MetadataService.SessionHeader_element(); 
        service.SessionHeader.sessionId = UserInfo.getSessionId(); 
        return service;     
    }
    
    public void doGetData(){
        listTracker = new List<trackerWrapper>();
        
        if(string.isNotEmpty(hours)){
            dtFromDate = datetime.now().addhours(-integer.valueof(hours));
            dtToDate = datetime.now();
            
            fromDt = dtFromDate.format('yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'');
            toDt = dtToDate.format('yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'');
        }
        else{
            if(string.isnotempty(fromDate))
            {
                String[] d = fromDate.split('/');
                string tempString = fromDate.replace('/',',');
                date mydate = date.parse(fromDate);
                //DateTime myDate = DateTime.newInstance(Integer.valueOf(d[2]), Integer.valueOf(d[1]), Integer.valueOf(d[0]), 00, 00, 00);  
                //Time myTime = Time.newInstance(00, 00, 00);
                dtFromDate = myDate;
            }
            else
                dtFromDate = DateTime.newInstance(01,01,2000,00,00,00);
            if(string.isnotempty(toDate))
            {
                String[] d = toDate.split('/');
                date mydate = date.parse(toDate);
                //Integer.valueOf(d[2]), Integer.valueOf(d[1]), Integer.valueOf(d[0]), 00, 00, 00); 
                //Time myTime = Time.newInstance(00, 00, 00);
                dtToDate = myDate;
            }
            else
                dtToDate = system.now();
            
            fromDt = dtFromDate.format('yyyy-MM-dd\'T\'HH:mm:Ss\'Z\'');
            toDt = dtToDate.format('yyyy-MM-dd\'T\'HH:mm:Ss\'Z\'');
        }
        string apexclass = '';        
        
        MetadataService.MetadataPort service = createService();
        List<MetadataService.ListMetadataQuery> queries;
        MetadataService.FileProperties[] fileProperties;
        if (componenttype=='All'){
            for(String componant : compareFieldDataType.keySet()){
                if( compareFieldDataType.get(componant) == 'MetaDataType'){
                    queries = new List<MetadataService.ListMetadataQuery>();
                    MetadataService.ListMetadataQuery queryWorkflow = new MetadataService.ListMetadataQuery();
                    queryWorkflow.type_x = componant;
                    queries.add(queryWorkflow);
                    
                    fileProperties = service.listMetadata(queries, 30);
                    if (fileProperties != null ) {
                        for(MetadataService.FileProperties fileProperty : fileProperties){
                            if(fileProperty.lastModifiedDate >= dtFromDate && fileProperty.lastModifiedDate <= dtToDate && fileProperty.manageableState == 'unmanaged'){
                                  trackerWrapper trackerWrapper = new trackerWrapper();
                                trackerWrapper.isChecked = false;
                                trackerWrapper.comptype = componant;
                                trackerWrapper.componame = fileProperty.fullName;
                                trackerWrapper.lasdtmodifieddate = fileProperty.lastModifiedDate;
                                trackerWrapper.lastmodifiedby= fileProperty.lastModifiedByName ;
                                listTracker.add(trackerWrapper);            
                            }
                        }
                    }
                }   else {
                    if(componant == 'EmailTemplate') {
                        
                        if(string.isNotEmpty(componentname))
                            apexclass = 'SELECT NamespacePrefix, Name,lastModifiedBy.name,LastModifiedDate from EmailTemplate  where Name like '  +'\'%' + componentname +'\'%' + ' and  =' + '\'' +'\'' + ' and LastModifiedDate>= ' + fromDt +   ' and LastModifiedDate<= ' + toDt +   '  ORDER BY LastModifiedDate ASC';
                        else
                            apexclass = 'Select NamespacePrefix, Name, LastModifiedDate, lastModifiedBy.Name From EmailTemplate  where NamespacePrefix =' + '\'' +'\'' + ' and LastModifiedDate>= ' + fromDt +   ' and LastModifiedDate<= ' + toDt +   '  ORDER BY LastModifiedDate ASC';
                        
                        system.debug('apexclass:'+apexclass);
                        emailtemplatelist = Database.query(apexclass );
                        
                        for(EmailTemplate apexc : emailtemplatelist){    
                            trackerWrapper trackerWrapper = new trackerWrapper();
                            trackerWrapper.isChecked = false;
                            trackerWrapper.comptype = 'EmailTemplate';
                            trackerWrapper.componame = apexc.Name;
                            trackerWrapper.lasdtmodifieddate = apexc.LastModifiedDate;
                            trackerWrapper.lastmodifiedby= apexc.lastModifiedBy.Name;
                            listTracker.add(trackerWrapper);
                        }
                    } else if(componant == 'Report') {
                        
                        if(string.isNotEmpty(componentname))
                            apexclass = 'SELECT NamespacePrefix, Name,lastModifiedBy.name,LastModifiedDate from Report  where Name like '  +'\'%' + componentname +'\'%' + ' and  =' + '\'' +'\'' + ' and LastModifiedDate>= ' + fromDt +   ' and LastModifiedDate<= ' + toDt +   '  ORDER BY LastModifiedDate ASC';
                        else
                            apexclass = 'Select NamespacePrefix, Name, LastModifiedDate, lastModifiedBy.Name From Report  where NamespacePrefix =' + '\'' +'\'' + ' and LastModifiedDate>= ' + fromDt +   ' and LastModifiedDate<= ' + toDt +   '  ORDER BY LastModifiedDate ASC';
                        
                        system.debug('apexclass:'+apexclass);
                        reportlist = Database.query(apexclass );
                        
                        for(Report apexc : reportlist){    
                            trackerWrapper trackerWrapper = new trackerWrapper();
                            trackerWrapper.isChecked = false;
                            trackerWrapper.comptype = 'Report';
                            trackerWrapper.componame = apexc.Name;
                            trackerWrapper.lasdtmodifieddate = apexc.LastModifiedDate;
                            trackerWrapper.lastmodifiedby= apexc.lastModifiedBy.Name;
                            listTracker.add(trackerWrapper);
                        }
                    } else if(componant == 'Dashboard') {
                        
                        if(string.isNotEmpty(componentname))
                            apexclass = 'SELECT NamespacePrefix, Title,lastModifiedBy.name,LastModifiedDate from Dashboard  where Name like '  +'\'%' + componentname +'\'%' + ' and  =' + '\'' +'\'' + ' and LastModifiedDate>= ' + fromDt +   ' and LastModifiedDate<= ' + toDt +   '  ORDER BY LastModifiedDate ASC';
                        else
                            apexclass = 'Select NamespacePrefix, Title, LastModifiedDate, lastModifiedBy.Name From Dashboard  where NamespacePrefix =' + '\'' +'\'' + ' and LastModifiedDate>= ' + fromDt +   ' and LastModifiedDate<= ' + toDt +   '  ORDER BY LastModifiedDate ASC';
                        
                        system.debug('apexclass:'+apexclass);
                        dashboardlist = Database.query(apexclass );
                        
                        for(Dashboard apexc : dashboardlist){    
                            trackerWrapper trackerWrapper = new trackerWrapper();
                            trackerWrapper.isChecked = false;
                            trackerWrapper.comptype = 'Dashboard';
                            trackerWrapper.componame = apexc.Title;
                            trackerWrapper.lasdtmodifieddate = apexc.LastModifiedDate;
                            trackerWrapper.lastmodifiedby= apexc.lastModifiedBy.Name;
                            listTracker.add(trackerWrapper);
                        }
                    }
                }
            }
        } else {
            if( compareFieldDataType.get(componenttype) == 'MetaDataType'){
                queries = new List<MetadataService.ListMetadataQuery>();
                MetadataService.ListMetadataQuery queryWorkflow = new MetadataService.ListMetadataQuery();
                queryWorkflow.type_x = componenttype;
                queries.add(queryWorkflow);
                
                fileProperties = service.listMetadata(queries, 30);
                
                for(MetadataService.FileProperties fileProperty : fileProperties){
                    if(fileProperty.lastModifiedDate >= dtFromDate && fileProperty.lastModifiedDate <= dtToDate){
                        trackerWrapper trackerWrapper = new trackerWrapper();
                        trackerWrapper.isChecked = false;
                        trackerWrapper.comptype = componenttype;
                        trackerWrapper.componame = fileProperty.fullName;
                        trackerWrapper.lasdtmodifieddate = fileProperty.lastModifiedDate;
                        trackerWrapper.lastmodifiedby= fileProperty.lastModifiedByName ;
                        listTracker.add(trackerWrapper);            
                    }
                }
            }   else  if(componenttype == 'EmailTemplate') {
                
                if(string.isNotEmpty(componentname))
                    apexclass = 'SELECT NamespacePrefix, Name,lastModifiedBy.name,LastModifiedDate from EmailTemplate  where Name like '  +'\'%' + componentname +'\'%' + ' and  =' + '\'' +'\'' + ' and LastModifiedDate>= ' + fromDt +   ' and LastModifiedDate<= ' + toDt +   '  ORDER BY LastModifiedDate ASC';
                else
                    apexclass = 'Select NamespacePrefix, Name, LastModifiedDate, lastModifiedBy.Name From EmailTemplate  where NamespacePrefix =' + '\'' +'\'' + ' and LastModifiedDate>= ' + fromDt +   ' and LastModifiedDate<= ' + toDt +   '  ORDER BY LastModifiedDate ASC';
                
                system.debug('apexclass:'+apexclass);
                emailtemplatelist = Database.query(apexclass );
                
                for(EmailTemplate apexc : emailtemplatelist){    
                    trackerWrapper trackerWrapper = new trackerWrapper();
                    trackerWrapper.isChecked = false;
                    trackerWrapper.comptype = 'EmailTemplate';
                    trackerWrapper.componame = apexc.Name;
                    trackerWrapper.lasdtmodifieddate = apexc.LastModifiedDate;
                    trackerWrapper.lastmodifiedby= apexc.lastModifiedBy.Name;
                    listTracker.add(trackerWrapper);
                }
            } else if(componenttype == 'Report') {
                
                if(string.isNotEmpty(componentname))
                    apexclass = 'SELECT NamespacePrefix, Name,lastModifiedBy.name,LastModifiedDate from Report  where Name like '  +'\'%' + componentname +'\'%' + ' and  =' + '\'' +'\'' + ' and LastModifiedDate>= ' + fromDt +   ' and LastModifiedDate<= ' + toDt +   '  ORDER BY LastModifiedDate ASC';
                else
                    apexclass = 'Select NamespacePrefix, Name, LastModifiedDate, lastModifiedBy.Name From Report  where NamespacePrefix =' + '\'' +'\'' + ' and LastModifiedDate>= ' + fromDt +   ' and LastModifiedDate<= ' + toDt +   '  ORDER BY LastModifiedDate ASC';
                
                system.debug('apexclass:'+apexclass);
                reportlist = Database.query(apexclass );
                
                for(Report apexc : reportlist){    
                    trackerWrapper trackerWrapper = new trackerWrapper();
                    trackerWrapper.isChecked = false;
                    trackerWrapper.comptype = 'Report';
                    trackerWrapper.componame = apexc.Name;
                    trackerWrapper.lasdtmodifieddate = apexc.LastModifiedDate;
                    trackerWrapper.lastmodifiedby= apexc.lastModifiedBy.Name;
                    listTracker.add(trackerWrapper);
                }
            } else if(componenttype == 'Dashboard') {
                
                if(string.isNotEmpty(componentname))
                    apexclass = 'SELECT NamespacePrefix, Title,lastModifiedBy.name,LastModifiedDate from Dashboard  where Name like '  +'\'%' + componentname +'\'%' + ' and  =' + '\'' +'\'' + ' and LastModifiedDate>= ' + fromDt +   ' and LastModifiedDate<= ' + toDt +   '  ORDER BY LastModifiedDate ASC';
                else
                    apexclass = 'Select NamespacePrefix, Title, LastModifiedDate, lastModifiedBy.Name From Dashboard  where NamespacePrefix =' + '\'' +'\'' + ' and LastModifiedDate>= ' + fromDt +   ' and LastModifiedDate<= ' + toDt +   '  ORDER BY LastModifiedDate ASC';
                
                system.debug('apexclass:'+apexclass);
                dashboardlist = Database.query(apexclass );
                
                for(Dashboard apexc : dashboardlist){    
                    trackerWrapper trackerWrapper = new trackerWrapper();
                    trackerWrapper.isChecked = false;
                    trackerWrapper.comptype = 'Dashboard';
                    trackerWrapper.componame = apexc.Title;
                    trackerWrapper.lasdtmodifieddate = apexc.LastModifiedDate;
                    trackerWrapper.lastmodifiedby= apexc.lastModifiedBy.Name;
                    listTracker.add(trackerWrapper);                   
                }
            }
        }
    }
    
    
    public void generateXML()
    {
        Map<string, List<string>> mapTracker = new Map<string, List<string>>();
        String XML='';
        XML='<?xml version="1.0" encoding="UTF-8"?><Package xmlns="http://soap.sforce.com/2006/04/metadata">\n';
        for(trackerWrapper var: listTracker)
        {
            if(var.isChecked == true)
            {
                if(mapTracker.containskey(var.comptype)){
                    List<string> listcomps = mapTracker.get(var.comptype);
                    listcomps.add(var.componame);
                    mapTracker.put(var.comptype,listcomps);
                }
                else{
                    List<string> listcomps = new List<string>(); 
                    listcomps.add(var.componame);                          
                    mapTracker.put(var.comptype,listcomps);
                }                   
            }
        }
        
        for(String var:mapTracker.keyset())
        {
            List<string> listcomp = mapTracker.get(var);
            XML = XML+'<types>\n';
            for(string compName : listcomp){
                XML=XML+'<members>' + compName+'</members>\n';
            }
            XML=XML+'<name>' + var +'</name>\n';
            XML = XML+'</types>\n';
            
        }
        XML = XML+'<version>25.0</version></Package>'; 
        //Generate_Package_XML__c obj=new Generate_Package_XML__c();
        //insert obj;
        attachment = new Attachment();
        attachment.Body = blob.valueof(XML);
        attachment.Description = '';
        attachment.Name = 'Package.xml';
        //attachment.parentId=obj.Id;
        upsert attachment;
        
        isGenerated = true;
        
        ApexPages.Message Message = new ApexPages.Message(Apexpages.Severity.Info, 'Package.xml file created successfully.');
        ApexPages.addMessage(Message);
    }     
}