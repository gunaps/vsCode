public class PopulateQSTCPQData {

    Product2 prod1, prod2, prod3;
    Apttus_Config2__ClassificationName__c cat1, cat2;
    Apttus_Config2__ClassificationHierarchy__c catHierarchy1, catHierarchy2;
    Apttus_Config2__ProductClassification__c prodClassification1, prodClassification2, prodClassification3;
    Apttus_Config2__ProductOptionGroup__c prodOptGroup1;
    Apttus_Config2__ProductOptionComponent__c prodOptComponent1;
    Apttus_Config2__PriceList__c priceList1;
    Apttus_Config2__PriceListCategory__c priceListCat1;
    Apttus_Config2__PriceListItem__c PLI1, PLI2, PLI3;
    
    public void main() {
    
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
        
    }


    public void setupProduct(){
        
        
        //Product-1
        Product2 pr1 = new Product2();
        pr1.name = 'QST Sample Bundle Product';
        pr1.IsActive = TRUE;
        pr1.Apttus_Config2__ConfigurationType__c = 'Bundle';
        pr1.Apttus_Config2__HasAttributes__c = FALSE;
        pr1.Apttus_Config2__HasDefaults__c = FALSE;
        pr1.Apttus_Config2__HasOptions__c = TRUE;
        pr1.Apttus_Config2__HasSearchAttributes__c = FALSE;
        pr1.Apttus_Config2__Customizable__c = TRUE;
        pr1.ProductCode = 'QST-Bundle';
        pr1.Apttus_Config2__Uom__c = 'Each';
        prod1 = pr1;
        insert prod1;
        
        
        //Product-2
        pr1 = new Product2();
        pr1.name = 'QST Sample Standalone Product';
        pr1.IsActive = TRUE;
        pr1.Apttus_Config2__ConfigurationType__c = 'Standalone';
        pr1.Apttus_Config2__HasAttributes__c = FALSE;
        pr1.Apttus_Config2__HasDefaults__c = FALSE;
        pr1.Apttus_Config2__HasOptions__c = FALSE;
        pr1.Apttus_Config2__HasSearchAttributes__c = FALSE;
        pr1.Apttus_Config2__Customizable__c = FALSE;
        pr1.ProductCode = 'QST-Standalone';
        pr1.Apttus_Config2__Uom__c = 'Each';
        prod2 = pr1;
        insert prod2;

        
        //Product-3
        pr1 = new Product2();
        pr1.name = 'QST Sample Option Product';
        pr1.IsActive = TRUE;
        pr1.Apttus_Config2__ConfigurationType__c = 'Option';
        pr1.Apttus_Config2__HasAttributes__c = FALSE;
        pr1.Apttus_Config2__HasDefaults__c = FALSE;
        pr1.Apttus_Config2__HasOptions__c = FALSE;
        pr1.Apttus_Config2__HasSearchAttributes__c = FALSE;
        pr1.Apttus_Config2__Customizable__c = FALSE;
        pr1.ProductCode = 'QST-Option';
        pr1.Apttus_Config2__Uom__c = 'Each';
        prod3 = pr1;
        insert prod3;

    }
    
    
    public void setupCategory() {
    
        //Category-1
        Apttus_Config2__ClassificationName__c categoryObj = new Apttus_Config2__ClassificationName__c();
        categoryObj.name = 'QST Sample Option Group Category';
        categoryObj.Apttus_Config2__Active__c = TRUE;
        categoryObj.Apttus_Config2__HierarchyLabel__c = 'QST Sample Option Group Category';
        categoryObj.Apttus_Config2__Type__c = 'Option Group';
        cat1 = categoryObj;
        insert cat1;
        
        //Category-2
        categoryObj = new Apttus_Config2__ClassificationName__c();
        categoryObj.name = 'QST Sample Offering Category';
        categoryObj.Apttus_Config2__Active__c = TRUE;
        categoryObj.Apttus_Config2__HierarchyLabel__c = 'QST Sample Offering Category';
        categoryObj.Apttus_Config2__Type__c = 'Offering';
        cat2 = categoryObj;
        insert cat2;
        
    }


    public void setupCategoryHierarchy() {
        
        //Category Hierarchy-1
        Apttus_Config2__ClassificationHierarchy__c catHierarchy = new Apttus_Config2__ClassificationHierarchy__c();
        catHierarchy.Name = 'QST Sample Option Group Category';
        catHierarchy.Apttus_Config2__DefaultSearchCategory__c = FALSE;
        catHierarchy.Apttus_Config2__ExpandedByDefault__c = FALSE;
        catHierarchy.Apttus_Config2__HideAllSearchFilters__c = FALSE;
        catHierarchy.Apttus_Config2__IncludeInTotalsView__c = TRUE;
        catHierarchy.Apttus_Config2__IsHidden__c = FALSE;
        catHierarchy.Apttus_Config2__IsPicklist__c = FALSE;
        catHierarchy.Apttus_Config2__Label__c = 'QST Sample Option Group Category';
        catHierarchy.Apttus_Config2__Left__c = 1;
        catHierarchy.Apttus_Config2__Level__c = 0;
        catHierarchy.Apttus_Config2__MaxOptions__c = 1;
        catHierarchy.Apttus_Config2__MinOptions__c = 1;
        catHierarchy.Apttus_Config2__Modifiable__c = TRUE;
        catHierarchy.Apttus_Config2__Right__c = 2;
        
        catHierarchy.Apttus_Config2__HierarchyId__c = cat1.id;
        
        catHierarchy1 = catHierarchy;
        insert catHierarchy1;
        
        
        Apttus_Config2__ClassificationHierarchy__c catHierarchy21 = new Apttus_Config2__ClassificationHierarchy__c();
        //Category Hierarchy-2
        catHierarchy21.Name = 'QST Sample Offering Category';
        catHierarchy21.Apttus_Config2__DefaultSearchCategory__c = FALSE;
        catHierarchy21.Apttus_Config2__ExpandedByDefault__c = FALSE;
        catHierarchy21.Apttus_Config2__HideAllSearchFilters__c = FALSE;
        catHierarchy21.Apttus_Config2__IncludeInTotalsView__c = TRUE;
        catHierarchy21.Apttus_Config2__IsHidden__c = FALSE;
        catHierarchy21.Apttus_Config2__IsPicklist__c = FALSE;
        catHierarchy21.Apttus_Config2__Label__c = 'QST Sample Offering Category';
        catHierarchy21.Apttus_Config2__Left__c = 1;
        catHierarchy21.Apttus_Config2__Level__c = 0;
        catHierarchy21.Apttus_Config2__MaxOptions__c = 1;
        catHierarchy21.Apttus_Config2__MinOptions__c = 1;
        catHierarchy21.Apttus_Config2__Modifiable__c = TRUE;
        catHierarchy21.Apttus_Config2__Right__c = 2;
        
        catHierarchy21.Apttus_Config2__HierarchyId__c = cat2.id;
        
        catHierarchy2 = catHierarchy21;
        insert catHierarchy2;
        
    }
    

    public void setupProductClassification(){
     
        //productClassification-1
        Apttus_Config2__ProductClassification__c prodClassification = new Apttus_Config2__ProductClassification__c();
        prodClassification.Apttus_Config2__Default__c = FALSE;
        prodClassification.Apttus_Config2__DefaultQuantity__c = 1;
        prodClassification.Apttus_Config2__MaxQuantity__c = 1;
        prodClassification.Apttus_Config2__MinQuantity__c = 0;
        prodClassification.Apttus_Config2__Modifiable__c = TRUE;
        
        prodClassification.Apttus_Config2__ProductId__c = prod3.id;
        prodClassification.Apttus_Config2__ClassificationId__c = catHierarchy1.id;
        
        prodClassification1 = prodClassification;
        insert prodClassification1;
        
        
        //productClassification-2
        prodClassification = new Apttus_Config2__ProductClassification__c();
        prodClassification.Apttus_Config2__Default__c = FALSE;
        prodClassification.Apttus_Config2__DefaultQuantity__c = 1;
        prodClassification.Apttus_Config2__MaxQuantity__c = 1;
        prodClassification.Apttus_Config2__MinQuantity__c = 0;
        prodClassification.Apttus_Config2__Modifiable__c = TRUE;
        prodClassification.Apttus_Config2__ProductId__c = prod1.id;
        prodClassification.Apttus_Config2__ClassificationId__c = catHierarchy2.id;
        
        prodClassification2 = prodClassification;
        insert prodClassification2;
        
        
        //productClassification-3
        prodClassification = new Apttus_Config2__ProductClassification__c();
        prodClassification.Apttus_Config2__Default__c = FALSE;
        prodClassification.Apttus_Config2__DefaultQuantity__c = 1;
        prodClassification.Apttus_Config2__MaxQuantity__c = 1;
        prodClassification.Apttus_Config2__MinQuantity__c = 0;
        prodClassification.Apttus_Config2__Modifiable__c = TRUE;
        
        prodClassification.Apttus_Config2__ProductId__c = prod2.id;
        prodClassification.Apttus_Config2__ClassificationId__c = catHierarchy2.id;
        
        prodClassification3 = prodClassification;
        insert prodClassification3;
        
    }
    
    
    public void setupProductOptionGroup() {
        
        //Product Option Group-1
        Apttus_Config2__ProductOptionGroup__c productOptionGroup = new Apttus_Config2__ProductOptionGroup__c();
        productOptionGroup.Apttus_Config2__OptionGroupId__c = catHierarchy1.ID;
        productOptionGroup.Apttus_Config2__IsHidden__c = FALSE;
        productOptionGroup.Apttus_Config2__IsLeaf__c = TRUE;
        productOptionGroup.Apttus_Config2__IsPicklist__c = FALSE;
        productOptionGroup.Apttus_Config2__Left__c = 1;
        productOptionGroup.Apttus_Config2__Level__c = 0;
        productOptionGroup.Apttus_Config2__MaxOptions__c = 1;
        productOptionGroup.Apttus_Config2__MinOptions__c = 1;
        productOptionGroup.Apttus_Config2__ModifiableType__c = 'Variable';
        productOptionGroup.Apttus_Config2__Right__c = 2;
        productOptionGroup.Apttus_Config2__RootSequence__c = 1;
        productOptionGroup.Apttus_Config2__Sequence__c = 0;
        
        productOptionGroup.Apttus_Config2__OptionGroupId__c = catHierarchy1.id;
        productOptionGroup.Apttus_Config2__RootOptionGroupId__c = catHierarchy1.id;
        
        productOptionGroup.Apttus_Config2__ProductId__c = prod1.id;
        prodOptGroup1 = productOptionGroup;
        insert prodOptGroup1;
                
    }


    public void setupProductOptionComponent() {
        
        //Product Option Component-1
        Apttus_Config2__ProductOptionComponent__c productOptionComponent = new Apttus_Config2__ProductOptionComponent__c();
        productOptionComponent.Apttus_Config2__AllowCloning__c = FALSE;
        productOptionComponent.Apttus_Config2__Default__c = TRUE;
        productOptionComponent.Apttus_Config2__Modifiable__c = TRUE;
        productOptionComponent.Apttus_Config2__RelationshipType__c = 'Option';
        productOptionComponent.Apttus_Config2__Required__c = TRUE;
        productOptionComponent.Apttus_Config2__Sequence__c = 1;
        
        productOptionComponent.Apttus_Config2__ProductOptionGroupId__c = prodOptGroup1.id;
        productOptionComponent.Apttus_Config2__ParentProductId__c = prod1.id;
        productOptionComponent.Apttus_Config2__ComponentProductId__c = prod3.id;
        
        prodOptComponent1 = productOptionComponent;
        insert prodOptComponent1;
        
    }


    public void setupPriceList() {
        
        //PriceList-1
        Apttus_Config2__PriceList__c priceList = new Apttus_Config2__PriceList__c();
        priceList.Name = 'QST Sample Price List';
        priceList.Apttus_Config2__Type__c = 'Standard';
        priceList.Apttus_Config2__Active__c = TRUE;
        priceList1 = priceList;
        insert priceList1;

    }
    
    
    public void setupPriceListCategory() {
        
        //PriceListCategory-1
        Apttus_Config2__PriceListCategory__c priceListCategory = new Apttus_Config2__PriceListCategory__c();
        
        priceListCategory.Apttus_Config2__PriceListId__c = priceList1.id;
        priceListCategory.Apttus_Config2__HierarchyId__c = cat2.id;
        
        priceListCat1 = priceListCategory;
        insert priceListCat1;
        
    }
    
    
    public void setupPriceListItem() {
        
        //PLI-1
        Apttus_Config2__PriceListItem__c priceListItem = new Apttus_Config2__PriceListItem__c();
        priceListItem.Apttus_Config2__Active__c = TRUE;
        priceListItem.Apttus_Config2__AllocateGroupAdjustment__c = TRUE;
        priceListItem.Apttus_Config2__AllowManualAdjustment__c = TRUE;
        priceListItem.Apttus_Config2__AllowPriceRampOverlap__c = FALSE;
        priceListItem.Apttus_Config2__AllowProration__c = TRUE;
        priceListItem.Apttus_Config2__AutoCascadeQuantity__c = FALSE;
        priceListItem.Apttus_Config2__AutoCascadeSellingTerm__c = FALSE;
        priceListItem.Apttus_Config2__RollupPriceToBundle__c = FALSE;
        priceListItem.Apttus_Config2__ChargeType__c = 'Subscription Fee';
        priceListItem.Apttus_Config2__EnableCommitment__c = FALSE;
        priceListItem.Apttus_Config2__EnablePriceRamp__c = FALSE;
        priceListItem.Apttus_Config2__Frequency__c = 'Monthly';
        priceListItem.Apttus_Config2__IsQuantityReadOnly__c = FALSE;
        priceListItem.Apttus_Config2__IsSellingTermReadOnly__c = FALSE;
        priceListItem.Apttus_Config2__IsUsageTierModifiable__c = FALSE;
        priceListItem.Apttus_Config2__ListPrice__c = 200;
        priceListItem.Apttus_Config2__PriceIncludedInBundle__c = FALSE;
        priceListItem.Apttus_Config2__PriceMethod__c = 'Per Unit';
        priceListItem.Apttus_Config2__PriceType__c = 'Recurring';
        priceListItem.Apttus_Config2__PriceUom__c = 'Each';
        
        priceListItem.Apttus_Config2__PriceListId__c = priceList1.id;
        priceListItem.Apttus_Config2__ProductId__c = prod2.id;
        
        PLI1 = priceListItem;
        insert PLI1;
        
        
        //PLI-2
        priceListItem = new Apttus_Config2__PriceListItem__c();
        priceListItem.Apttus_Config2__Active__c = TRUE;
        priceListItem.Apttus_Config2__AllocateGroupAdjustment__c = TRUE;
        priceListItem.Apttus_Config2__AllowManualAdjustment__c = TRUE;
        priceListItem.Apttus_Config2__AllowPriceRampOverlap__c = FALSE;
        priceListItem.Apttus_Config2__AllowProration__c = TRUE;
        priceListItem.Apttus_Config2__AutoCascadeQuantity__c = FALSE;
        priceListItem.Apttus_Config2__AutoCascadeSellingTerm__c = FALSE;
        priceListItem.Apttus_Config2__RollupPriceToBundle__c = FALSE;
        priceListItem.Apttus_Config2__ChargeType__c = 'Subscription Fee';
        priceListItem.Apttus_Config2__EnableCommitment__c = FALSE;
        priceListItem.Apttus_Config2__EnablePriceRamp__c = FALSE;
        priceListItem.Apttus_Config2__Frequency__c = 'Monthly';
        priceListItem.Apttus_Config2__IsQuantityReadOnly__c = FALSE;
        priceListItem.Apttus_Config2__IsSellingTermReadOnly__c = FALSE;
        priceListItem.Apttus_Config2__IsUsageTierModifiable__c = FALSE;
        priceListItem.Apttus_Config2__ListPrice__c = 300;
        priceListItem.Apttus_Config2__PriceIncludedInBundle__c = FALSE;
        priceListItem.Apttus_Config2__PriceMethod__c = 'Per Unit';
        priceListItem.Apttus_Config2__PriceType__c = 'Recurring';
        priceListItem.Apttus_Config2__PriceUom__c = 'Each';
        
        priceListItem.Apttus_Config2__PriceListId__c = priceList1.id;
        priceListItem.Apttus_Config2__ProductId__c = prod1.id;
        
        PLI2 = priceListItem;
        insert PLI2;
        
        
        //PLI-3
        priceListItem = new Apttus_Config2__PriceListItem__c();
        priceListItem.Apttus_Config2__Active__c = TRUE;
        priceListItem.Apttus_Config2__AllocateGroupAdjustment__c = TRUE;
        priceListItem.Apttus_Config2__AllowManualAdjustment__c = TRUE;
        priceListItem.Apttus_Config2__AllowPriceRampOverlap__c = FALSE;
        priceListItem.Apttus_Config2__AllowProration__c = TRUE;
        priceListItem.Apttus_Config2__AutoCascadeQuantity__c = FALSE;
        priceListItem.Apttus_Config2__AutoCascadeSellingTerm__c = FALSE;
        priceListItem.Apttus_Config2__RollupPriceToBundle__c = FALSE;
        priceListItem.Apttus_Config2__ChargeType__c = 'Subscription Fee';
        priceListItem.Apttus_Config2__EnableCommitment__c = FALSE;
        priceListItem.Apttus_Config2__EnablePriceRamp__c = FALSE;
        priceListItem.Apttus_Config2__Frequency__c = 'Monthly';
        priceListItem.Apttus_Config2__IsQuantityReadOnly__c = FALSE;
        priceListItem.Apttus_Config2__IsSellingTermReadOnly__c = FALSE;
        priceListItem.Apttus_Config2__IsUsageTierModifiable__c = FALSE;
        priceListItem.Apttus_Config2__ListPrice__c = 100;
        priceListItem.Apttus_Config2__PriceIncludedInBundle__c = FALSE;
        priceListItem.Apttus_Config2__PriceMethod__c = 'Per Unit';
        priceListItem.Apttus_Config2__PriceType__c = 'Recurring';
        priceListItem.Apttus_Config2__PriceUom__c = 'Each';
        
        priceListItem.Apttus_Config2__PriceListId__c = priceList1.id;
        priceListItem.Apttus_Config2__ProductId__c = prod3.id;
        
        PLI3 = priceListItem;
        insert PLI3;
       
    }

}