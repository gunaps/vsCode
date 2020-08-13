public class APTSMD_ChangeProductImageController {
    public List<product2> productToUpdateList = new List<product2>();
    public List<Folder> listid =  new List<Folder>();
    public APTSMD_ChangeProductImageController () {
        listid=[select id from Folder where name =:'Apttus Images'];
        if(listid.isEmpty()) {
           listid = [select id from Folder where name =:'My Personal Documents']; 
        }
    } 
    
    
    public void removeImageIcon(List<Attachment> attachmentListFromTrigger) {
        set<id> productIdSet = new Set<id>();
        for(Attachment attachmentOld : attachmentListFromTrigger) {
            if(string.valueOf(attachmentOld.parentId).indexOf('01t') == 0) {
                productIdSet.add(attachmentOld.parentId);
            }
        }
        List<product2> prodList = new List<product2>();
        prodList = [select id,APTSMD_Image__c from product2 where id in:productIdSet];
        for(product2 prod : prodList) {
            prod.APTSMD_Image__c = '';
            productToUpdateList.add(prod);
        }
        if(!productToUpdateList.isEmpty()) {
            update productToUpdateList;
        }  
    }
    
    public void ProcessDocument(List<Attachment> attachmentNewList) {
        for(Attachment attachmentNew : attachmentNewList) {
            Document myDoc=new Document();
            if(string.valueOf(attachmentNew.parentId).indexOf('01t') == 0) {
                String IMAGE_TAG = '<img height="80" width="80"  src=https://';
                String SERVLET_TAG = '/servlet/servlet.FileDownload?file=';
                String CLOSE_TAG = ' class="richText"> ';
                
                Product2 prod = [select id, APTSMD_Image__c from product2 where id=:attachmentNew.parentId];
                List<Document> documentList = new List<Document>() ;
                
                documentList = [select id,folderId,body,Type,name from Document where Name=:prod.id];
                if(documentList.isEmpty()) {
                    myDoc.folderId=listid[0].id;
                    myDoc.name= prod.id;
                    mydoc.body = attachmentNew.body;
                    mydoc.Type = 'jpeg';
                    mydoc.ContentType = 'image/jpeg';
                    insert myDoc;
                } else {
                    mydoc = documentList[0];
                    mydoc.body = attachmentNew.body;
                    update mydoc;

                }
                String imgUrl= IMAGE_TAG + getHost() + SERVLET_TAG + getImageId(mydoc.id) + CLOSE_TAG;  
                //string imgurl = '<img height="80" width="80"  src=https://c.na34.visual.force.com/servlet/servlet.FileDownload?file='+getImageId(mydoc.id) + CLOSE_TAG; 
                //system.debug('*****'+imgUrl);
                prod.APTSMD_Image__c = imgUrl;
                productToUpdateList.add(prod);
                
            }
        }
        if(!productToUpdateList.isEmpty()) {
            update productToUpdateList;
        }  
    }
    
    public String getHost() {
        String Instance;
        List<String> parts = System.URL.getSalesforceBaseUrl().getHost().split('\\.');
        if (parts.size() == 3) Instance = parts[0];
        else if (parts.size() == 5) Instance = parts[1];
        else if (parts.size() == 4) Instance = parts[0]+ '.' +parts[1];
        else Instance = null;
        
       return Instance + '.salesforce.com';
    }
     public String getImageId(String str) {
        if (!SystemUtil.nullOrEmpty(str)) {
            return str.substring(0, 15);
        }
        return '';
    }
}