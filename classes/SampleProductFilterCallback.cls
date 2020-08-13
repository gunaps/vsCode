global with sharing class SampleProductFilterCallback implements Apttus_Config2.CustomClass.IProductFilterCallback {

/**
* Callback to return part of SOQL filter clause
* This filter is used in listing catalog products
* @param parsms is the CustomClass.ActionParams thatcontains accountIds, locationIds when available
* @return The query filter is like the following.
* Name LIKE 'A%' AND Quantity__c > 100
* Id IN ('000123', '000124')
*/

Apttus_Config2__ProductConfiguration__c prodConfig;

global String getProductFilterExpr(Apttus_Config2.CustomClass.ActionParams params) {
//String query = 'Name != \'Ultimate CPQ\' and Name != \'Apttus Intelligent Cloud\'';
//return query;

        String query = '';
        system.debug('@@@ ConfigurationId >>>>>>>>>>   : '+ params.ConfigurationId); 
        prodConfig = [select Apttus_Config2__AccountId__c from Apttus_Config2__ProductConfiguration__c where id=:params.ConfigurationId limit 1];
        system.debug('@@@ prodConfig>>>>>>>>>>   : '+ prodConfig ); 
        system.debug('@@@ prodConfig>>>>>>>>>>   : '+ prodConfig.Apttus_Config2__AccountId__c );
        
        List<Id> listAccount = new List<Id>();
        listAccount.add(prodConfig.Apttus_Config2__AccountId__c);
        Apttus_Config2.CPQStruct.QueryAssetsRequestDO request = new Apttus_Config2.CPQStruct.QueryAssetsRequestDO();
        request.AccountIds = listAccount;
        Apttus_Config2.CPQStruct.QueryAssetsResponseDO response = Apttus_Config2.AssetService.getAssetLineItems(request);
        List<Apttus_Config2__AssetLineItem__c> listItems = response.AssetLineItems;

        
        
        List<Apttus_Config2__AssetLineItem__c> listItemsProdID  = [select Apttus_Config2__ProductId__c from Apttus_Config2__AssetLineItem__c where id in :listItems];
        
        integer i=0;
        for(Apttus_Config2__AssetLineItem__c s : listItemsProdID ){
                        if(i==0)
                            query  = 'ID != \''+ s.Apttus_Config2__ProductId__c +'\'';
                         else
                            query  = query   + ' and ID != \''+ s.Apttus_Config2__ProductId__c +'\'';
                        i++;
        }
        
        system.debug('@@@ query>>>>>>>>>>   : '+ query);
        return query;

}

/**
* Callback to return part of SOQLfilter clause
* This filter is used in listing option products
* @param parsms is the CustomClass.ActionParams that contains accountIds, locationIds when available
* @return The query filter is like the following.
* Name LIKE 'A%' AND Quantity__c > 100
* Id IN ('000123', '000124')
*/
global String getOptionFilterExpr(Apttus_Config2.CustomClass.ActionParams params) {
return '(ComponentProductId__r.Name !=\'OptionX\' and ParentProductId__r.Name=\'ProdA\') or (ParentProductId__r.Name!=\'ProdA\')';
}
}