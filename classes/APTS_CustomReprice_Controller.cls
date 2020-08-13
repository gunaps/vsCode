public with sharing class APTS_CustomReprice_Controller {
    
    public String productConfigId;
    public String quoteId;
    public String configRequestId;
    public string currentFlow;
    
    public APTS_CustomReprice_Controller(){
        productConfigId = Apexpages.currentPage().getParameters().get('id');
        quoteId = Apexpages.currentPage().getParameters().get('retId');
        configRequestId = Apexpages.currentPage().getParameters().get('configRequestId');
        currentFlow = Apexpages.currentPage().getParameters().get('currentFlow');

    }
    
    public void ChangeStatus(){
        System.debug('********************** In ChangeStatus method : Product Config Ids ' + productConfigId);
        //getting all cart line items
        List<Apttus_Config2__LineItem__c> cartLineItems = new List<Apttus_Config2__LineItem__c>();
        try {
            if (!String.isEmpty(productConfigId)){
                cartLineItems = [select ID,Apttus_Config2__PricingStatus__c 
                                from Apttus_Config2__LineItem__c
                                where  
                                Apttus_Config2__ConfigurationId__c = :productConfigId];
                System.debug('*************************** Total Cart Line Items :  ' + cartLineItems.size());
                if (!cartLineItems.isEmpty()){
                      for (Apttus_Config2__LineItem__c objVar : cartLineItems){
                        objVar.Apttus_Config2__PricingStatus__c = 'Pending';
                      }
                        Update cartLineItems; // Updating Status IN Line Item Ext Obj
                    }                                           

                }

        }
        catch(Exception ex){
             
        }
    } 
    public Pagereference redirectToCart(){
    
        PageReference cartDetailPage;
        if (currentFlow  == 'Default')
        {
        cartDetailPage = System.Page.Apttus_Config2__CartDetailView;
        }
        else
        {
        cartDetailPage = System.Page.Apttus_Config2__Cart;        
        }
        cartDetailPage.getParameters().put('Id', productConfigId);
        cartDetailPage.getParameters().put('configRequestId', configRequestId);
        return cartDetailPage;
    }
}