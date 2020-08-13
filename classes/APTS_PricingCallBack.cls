global with sharing class APTS_PricingCallBack implements Apttus_Config2.CustomClass.IPricingCallback3 {

    private Apttus_Config2.ProductConfiguration cart = null;
    private Apttus_Config2.CustomClass.PricingMode mode = null;
    private List < Apttus_Config2__LineItem__c > allAttachedLineItems;
    private Account accountSO;
    private Opportunity oppSO;

    private boolean runChannelDiscountPricing;
    private Apttus_Proposal__Proposal__c proposalSO;
    private Apttus_Config2__ProductConfiguration__c configSO;

    private String typeOfAccount;
    private boolean accountIsPremium;
    private Integer accountStandardDiscountRate;
    private Integer accountPremiumDiscountRate;
    private APTS_TC_EMEAPricingCallback tcPricingCallBack;

    global void start(Apttus_Config2.ProductConfiguration prodConfig) {
        system.debug('<<Start() method called: ' + prodConfig + '>>');

        try {
            // Perform some database operations that 
            //   might cause an null pointer exception.

            this.cart = prodConfig;
            this.configSO = cart.getConfigSO();
          /*  this.proposalSO = [SELECT Id, Name, Apttus_Proposal__Opportunity__c, Apttus_Proposal__Account__c FROM Apttus_Proposal__Proposal__c WHERE Id =: configSO.Apttus_QPConfig__Proposald__c];
            if (proposalSO.Apttus_Proposal__Account__c != null) {
                this.accountSO = [SELECT Id, Name, Type, Is_Premium__c, Standard_Discount_Rate__c, Premium_Discount_Rate__c FROM Account WHERE Id =: proposalSO.Apttus_Proposal__Account__c];
            } else {
                this.oppSO = [SELECT Id, Name, AccountId FROM Opportunity WHERE Id =: proposalSO.Apttus_Proposal__Opportunity__c];
                this.accountSO = [SELECT Id, Name, Type, Is_Premium__c, Standard_Discount_Rate__c, Premium_Discount_Rate__c FROM Account WHERE Id =: oppSO.AccountId];
            }
            //this.oppSO = [SELECT Id, Name, AccountId FROM Opportunity WHERE Id = :proposalSO.Apttus_Proposal__Opportunity__c];  
            //this.accountSO = [SELECT Id, Name, Type, Is_Premium__c, Standard_Discount_Rate__c, Premium_Discount_Rate__c FROM Account WHERE Id = :oppSO.AccountId]; 
            //this.accountSO = [SELECT Id, Name, Type, Is_Premium__c, Standard_Discount_Rate__c, Premium_Discount_Rate__c FROM Account WHERE Id = :proposalSO.Apttus_Proposal__Account__c];  
            system.debug('<<Accountttttt => Name ' + accountSO.Name);
            system.debug(accountSO.Type);
            typeOfAccount = accountSO.Type;
            system.debug(accountSO.Is_Premium__c);
            accountIsPremium = accountSO.Is_Premium__c;
            system.debug(accountSO.Standard_Discount_Rate__c);
            accountStandardDiscountRate = Integer.valueOf(accountSO.Standard_Discount_Rate__c);
            system.debug(accountSO.Premium_Discount_Rate__c);
            accountPremiumDiscountRate = Integer.valueOf(accountSO.Premium_Discount_Rate__c);


            tcPricingCallBack = new APTS_TC_EMEAPricingCallback();
            tcPricingCallBack.start(cart);*/


        } catch (DmlException e) {
            // DmlException handling code here.
            System.debug('The following exception has occurred:  DmlException' + e.getMessage());

        } catch (Exception e) {
            // Generic exception handling code here.
            System.debug('The following exception has occurred: Exception ' + e.getMessage());

        } finally {
            // Perform some clean up.
        }

    }

    global void setMode(Apttus_Config2.CustomClass.PricingMode mode) {
        this.mode = mode;
        system.debug('<<setMode() method called for ' + mode + ' mode>>');
    }

    global void beforePricing(Apttus_Config2.ProductConfiguration.LineItemColl itemColl) {
        system.debug('<<beforePricing() method called for ' + mode + ' mode>>');

        /*for (Apttus_Config2.LineItem configLineItem: itemColl.getAllLineItems()) {
            Apttus_Config2__LineItem__c item = configLineItem.getLineItemSO();
            system.debug('<<<< beforePricing() -' + this.mode + ' : ' + ' for Product: ' + item.Apttus_Config2__ProductId__c);
        }*/

    }

    global void onPriceItemSet(Apttus_Config2__PriceListItem__c itemSO, Apttus_Config2.LineItem lineItemMO) {
        system.debug('<< onPriceItemSet() -' + this.mode + ' called >>');
        Apttus_Config2__LineItem__c item = lineItemMO.getLineItemSO();
        item.APTS_Contract_Price__c = itemSO.Apttus_Config2__ListPrice__c*80/100;
        system.debug('<<<< onPriceItemSet() -' + this.mode + ' : ' + ' for Product: ' + item.Apttus_Config2__ProductId__c);
       /* system.debug('<<<< onPriceItemSet() -' + this.mode + ' : ' + ' for Product List Price old : ' + itemSO.Apttus_Config2__ListPrice__c);
        system.debug('<<<< onPriceItemSet() -' + this.mode + ' : ' + ' for accountStandardDiscountRate : ' + accountStandardDiscountRate);
        system.debug('<<<< onPriceItemSet() -' + this.mode + ' : ' + ' for accountStandardDiscountRate : ' + accountPremiumDiscountRate);

        if (typeOfAccount == 'Channel Distributor' && accountIsPremium) {
            itemSO.Apttus_Config2__ListPrice__c = itemSO.Apttus_Config2__ListPrice__c * (1 - (((double) accountPremiumDiscountRate) / 100));
            system.debug('<<<< onPriceItemSet() -' + this.mode + ' : ' + ' In accountIsPremium ');
        } else if (typeOfAccount == 'Channel Distributor') {
            itemSO.Apttus_Config2__ListPrice__c = itemSO.Apttus_Config2__ListPrice__c * (1 - (((double) accountStandardDiscountRate) / 100));
            system.debug('<<<< onPriceItemSet() -' + this.mode + ' : ' + ' In accountIs NOT Premium ');
        } else {
            system.debug('<<<< onPriceItemSet() -' + this.mode + ' : ' + ' typeOfAccount IS NOT Channel Distributor');
        }

        system.debug('<<<< onPriceItemSet() -' + this.mode + ' : ' + ' for Product List Price new : ' + itemSO.Apttus_Config2__ListPrice__c);*/
    }

    global void beforePricingLineItem(Apttus_Config2.ProductConfiguration.LineItemColl itemColl,
        Apttus_Config2.LineItem lineItemMO) {

        system.debug('<< beforePricingLineItem() -' + this.mode + ' called >>');
       /* for (Apttus_Config2.LineItem configLineItem: itemColl.getAllLineItems()) {
            Apttus_Config2__LineItem__c item = configLineItem.getLineItemSO();
            system.debug('<<<< beforePricingLineItem() -' + this.mode + ' for Product: ' + item.Apttus_Config2__ProductId__c);

        }*/
    }

    global void afterPricing(Apttus_Config2.ProductConfiguration.LineItemColl itemColl) {
        system.debug('<< afterPricing() -' + this.mode + ' called >>');
       /* for (Apttus_Config2.LineItem configLineItem: itemColl.getAllLineItems()) {
            Apttus_Config2__LineItem__c item = configLineItem.getLineItemSO();
            system.debug('<<<< afterPricing()' + this.mode + ' for Product: ' + item.Apttus_Config2__ProductId__c);
            tcPricingCallBack.afterPricing(itemColl);

        }*/
    }

    global void afterPricingLineItem(Apttus_Config2.ProductConfiguration.LineItemColl itemColl,
        Apttus_Config2.LineItem lineItemMO) {

        system.debug('<< afterPricingLineItem() -' + this.mode + ' called >>');
      /*  if (Mode == Apttus_Config2.CustomClass.PricingMode.ADJUSTMENT) {



            double sumOfListPrice = 0;
            double sumOfNetPrice = 0;
            for (Apttus_Config2.LineItem configLineItem: itemColl.getAllLineItems()) {
                Apttus_Config2__LineItem__c item = configLineItem.getLineItemSO();
                system.debug('<<<< afterPricingLineItem() -' + this.mode + ' for Product: ' + item.Apttus_Config2__ProductId__c);
                if (item.Apttus_Config2__HasOptions__c && item.Apttus_Config2__LineType__c == 'Product/Service') {
                    system.debug('<<<< afterPricingLineItem() -' + this.mode + ' for Product Bundle: ');
                    system.debug('<<<< afterPricingLineItem() -' + this.mode + ' for Product Bundle: ' + item.Apttus_Config2__LineNumber__c);
                    system.debug('<<<< afterPricingLineItem() -' + this.mode + ' for Product: Apttus_Config2__BasePrice__c ' + item.Apttus_Config2__BasePrice__c);
                    try {
                        system.debug('<<<< afterPricingLineItem() -' + this.mode + ' for Product: APT_Options_Total_price__c ' + item.APT_Options_Total_price__c);
                        sumOfListPrice = item.Apttus_Config2__BasePrice__c + item.APT_Options_Total_price__c;
                    } catch (DmlException e) {
                        // DmlException handling code here.
                        System.debug('The following exception has occurred:  DmlException' + e.getMessage());

                    } catch (Exception e) {
                        // Generic exception handling code here.
                        System.debug('The following exception has occurred: Exception ' + e.getMessage());

                    } finally {
                        // Perform some clean up.
                    }
                    system.debug('<<<< afterPricingLineItem() -' + this.mode + ' for Product: sumOfListPrice ' + sumOfListPrice);

                }

            }
            tcPricingCallBack.afterPricingLineItem(itemColl, lineItemMO);
        }*/
    }

    global void finish() {
        system.debug('<< finish() method called>>');
    }
}