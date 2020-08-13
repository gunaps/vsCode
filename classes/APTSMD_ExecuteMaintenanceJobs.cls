public with sharing class APTSMD_ExecuteMaintenanceJobs{
    public static void executeAllJobs(){
        executeAttributesUpdateJob();
        executeBundleUpdateJob();
        executeHierarchyViewUpdateJob();
        executeCriteriaUpdateJob();
        executeProductConstraintViewUpdateJob();
        executeProductFilterUpdateJob();
        executePriceListItemSequenceUpdateJob();
    }
    
    public static void executeAttributesUpdateJob(){
        try{
            Apttus_Config2.AttributesUpdateJob auj = new Apttus_Config2.AttributesUpdateJob();
            Database.executeBatch(auj);
        }
        catch(Exception ex){
            system.debug('###Exception:' + ex);
        }
    }
    
    public static void executePriceListItemSequenceUpdateJob(){
        try{
            Apttus_Config2.PriceListItemSequenceUpdateJob pisuj = new Apttus_Config2.PriceListItemSequenceUpdateJob();
            Database.executeBatch(pisuj);
        }
        catch(Exception ex){
            system.debug('###Exception:' + ex);
        }
    }
    
    public static void executeBundleUpdateJob(){
        try{
            List<Id> productIds = new List<Id>();
            for(Product2 product : [select Id from Product2 where IsActive = true And Apttus_Config2__ConfigurationType__c = 'Bundle']){
                productIds.add(product.Id);
            }
            
            Apttus_Config2.BundleUpdateJob buj = new Apttus_Config2.BundleUpdateJob(productIds);
            Database.executeBatch(buj);
        }
        catch(Exception ex){
            system.debug('###Exception:' + ex);
        }
    }
    
    public static void executeHierarchyViewUpdateJob(){
        for(Apttus_Config2__ClassificationName__c category : [select Id from Apttus_Config2__ClassificationName__c ]){
            try{
                Apttus_Config2.HierarchyViewUpdateJob hvuj = new Apttus_Config2.HierarchyViewUpdateJob(category.Id);
                Database.executeBatch(hvuj);
            }
            catch(Exception ex){
                system.debug('###Exception:' + ex);
            }
        }
    }
    
    public static void executeCriteriaUpdateJob(){
        try{
            Apttus_Config2.CriteriaUpdateJob cuj = new Apttus_Config2.CriteriaUpdateJob(new List<String>{'All'});
            Database.executeBatch(cuj);
        }
        catch(Exception ex){
            system.debug('###Exception:' + ex);
        }
    }
    
    public static void executeProductConstraintViewUpdateJob(){
        try{
            Apttus_Config2.ProductConstraintViewUpdateJob pcvuj = new Apttus_Config2.ProductConstraintViewUpdateJob();
            Database.executeBatch(pcvuj);
        }
        catch(Exception ex){
            system.debug('###Exception:' + ex);
        }
    }
    
    public static void executeProductFilterUpdateJob(){
        try{
            Apttus_Config2.ProductFilterUpdateJob pfuj = new Apttus_Config2.ProductFilterUpdateJob();
            Database.executeBatch(pfuj);
        }
        catch(Exception ex){
            system.debug('###Exception:' + ex);
        }
    }
    
}