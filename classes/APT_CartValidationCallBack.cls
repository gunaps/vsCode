global with sharing class APT_CartValidationCallBack implements Apttus_Config2.CustomClass.IValidationCallback2 {
    
    private static final String CALLER_PAGE_CARTDETAILVIEW = 'CartDetailView';       
    
    /**
        * Callback to validate the line items in the cart
        * @param cart the cart object to validate
        * @return the validation result
        Added new comment
     */
    global Apttus_Config2.CustomClass.ValidationResult validateCart(Apttus_Config2.ProductConfiguration cart) {
        system.debug('*** validation call back > start ***');
        Apttus_Config2.CustomClass.ValidationResult result = new Apttus_Config2.CustomClass.ValidationResult(true); 
        try { 
            list <Apttus_Config2.LineItem> allLines = cart.getLineItems();
            list<Apttus_Config2__LineItem__c> allLineItems = getLineItems(allLines); 

           
           
           system.debug('*** validation call back > start ***+++++++++++++++++++++++ Account ==>>>'+ allLineItems[0].Apttus_Config2__ConfigurationId__r.Apttus_Config2__AccountId__c +' --- Account Name =>>'+allLineItems[0].Apttus_Config2__ConfigurationId__r.Apttus_Config2__AccountId__r.Name+'Base Prod:'+allLineItems[0].APT_Same_Quantity_Product_1__c);    
               
           Integer q = 0;
           String baseProduct = allLineItems[0].APT_Same_Quantity_Product_1__c;
           String accId = allLineItems[0].Apttus_Config2__ConfigurationId__r.Apttus_Config2__AccountId__c;
           Integer setQ = 0;
           try {
               setQ = [select Apttus_Config2__Quantity__c from Apttus_Config2__AssetLineItem__c where Apttus_Config2__AccountId__c =:accId and Name =:baseProduct ][0].Apttus_Config2__Quantity__c.intValue();
           } catch(DmlException e) {
                  // DmlException handling code here.
                  System.debug('The following exception has occurred:  DmlException' + e.getMessage());

           } catch(Exception e) {
                   // Generic exception handling code here.
                   System.debug('The following exception has occurred: Exception ' + e.getMessage());

            } finally {
                   // Perform some clean up.
            } 
            
           Integer cond = -1; 
           Integer totalQ = 0; 
            
            if(setQ > 0 ){
                system.debug('*** validation call back > In the Asset Base product is present ***+++++++++++++++++++++++' +baseProduct + ' =>> With the quantity of ----- >> ' + setQ);
            }/*else if(setQ !=0 && [select Apttus_Config2__Quantity__c from Apttus_Config2__AssetLineItem__c where Apttus_Config2__AccountId__c =:accId and Name = 'X-Author' ][0].Apttus_Config2__Quantity__c.intValue() > 0) {
                
            }*/else {
                system.debug('*** validation call back > In the Asset Base product is not present ***+++++++++++++++++++++++' +baseProduct);
            } 
           
            
           for(Apttus_Config2__LineItem__c lineItem : allLineItems)
            {
                system.debug('*** validation call back > start ***+++++++++++++++++++++++' +lineItem.Apttus_Config2__ProductId__r.Name );
                
                system.debug('*** validation call back > Assettttttt ***+++++++++++++++++++++++' +lineItem.Apttus_Config2__AssetId__c +' => Asset ->>> '+ lineItem.Apttus_Config2__AssetLineItemId__c +' ++++ -- Asset Quantity ]]]] >>> '+lineItem.Apttus_Config2__AssetQuantity__c);
                
                
                system.debug('*** validation call back > start INNNNNNNNNNNNNN MAINNNNN ***+++++++++++++++++++++++' +lineItem.Apttus_Config2__ProductId__r.Name +'THIS IS IMP 1 => '+lineItem.APT_Same_Quantity_Product_1__c + ' THIS IS IMP 2 => '+lineItem.APT_Same_Quantity_Product_2__c);

                
               /* if(q==0 && ( lineItem.Apttus_Config2__ProductId__r.Name =='Sprint CPQ' || lineItem.Apttus_Config2__ProductId__r.Name =='X-Author' ) )
                {
                   system.debug('*** validation call back > start INNNNNNNNNNNNNN 1 ***+++++++++++++++++++++++' +lineItem.Apttus_Config2__ProductId__r.Name );
                   q = lineItem.Apttus_Config2__Quantity__c.intValue();
                   system.debug('*** validation call back > start INNNNNNNNNNNNNN 1 ***+++++++++++++++++++++++' + q );
                }else if(q!=0 && ( lineItem.Apttus_Config2__ProductId__r.Name =='Sprint CPQ' || lineItem.Apttus_Config2__ProductId__r.Name =='X-Author' )){
                   system.debug('*** validation call back > start INNNNNNNNNNNNNN 2 ***+++++++++++++++++++++++' +lineItem.Apttus_Config2__ProductId__r.Name );

                   lineItem.Apttus_Config2__Quantity__c = q;
                   system.debug('*** validation call back > start INNNNNNNNNNNNNN 2 ***+++++++++++++++++++++++' + lineItem.Apttus_Config2__Quantity__c );
                }else{
                
                 system.debug('*** validation call back > start ***+++++++++++++++++++++++ ELSEEEEEEEE' );
                }*/
         
         
                // Base product is in asset so add addon with the same quantity........
               
                
                if(setQ > 0 && lineItem.Apttus_Config2__LineType__c != 'Option' && (lineItem.Apttus_Config2__ProductId__r.Name == lineItem.APT_Same_Quantity_Product_1__c || lineItem.Apttus_Config2__ProductId__r.Name == lineItem.APT_Same_Quantity_Product_2__c )){
                    
                    
                    if(lineItem.Apttus_Config2__ProductId__r.Name == lineItem.APT_Same_Quantity_Product_1__c){
                        //Base product 
                        cond++;                        
                    }else{
                        //Addon Product
                        cond++;
                    }
                    
                    if(cond == 0){
                        
                                if(lineItem.Apttus_Config2__ProductId__r.Name == lineItem.APT_Same_Quantity_Product_1__c){
                                    //only Base product in cart
                                    system.debug('*** validation call back > only Base product in cart ***+++++++++++++++++++++++ ' );
                                    totalQ = lineItem.Apttus_Config2__Quantity__c.intValue() + setQ;
                                    system.debug('*** validation call back > only Base product in cart and as well as in Asset so totalQ ***+++++++++++++++++++++++ ' + totalQ );
                                    
                                }else{
                                    //only Addon Product in cart
                                    system.debug('*** validation call back > only Addon Product in cart ***+++++++++++++++++++++++ ' );
                                    
                                    
                                    system.debug('*** validation call back > In the Asset Base product is present  ***+++++++++++++++++++++++' +baseProduct + ' =>> With the quantity of ----- >> ' + setQ);
                                    String errorMSG = 'Please select the same quantity for "'+lineItem.APT_Same_Quantity_Product_1__c+'"[In Asset = '+setQ+'] and '+lineItem.APT_Same_Quantity_Product_2__c+'" products.';  
                                    if(setQ != lineItem.Apttus_Config2__Quantity__c.intValue()){
                                      result.Messages.add(new ApexPages.Message(ApexPages.Severity.ERROR, errorMSG)); 
                                      result.isSuccess =  false;
                                      q=0;
                                      system.debug('*** validation call back > start INNNNNNNNNNNNNN 3 ERROOROOR ***+++++++++++++++++++++++' +lineItem.Apttus_Config2__ProductId__r.Name );
                                      //lineItem.Apttus_Config2__Quantity__c = q;
                                      system.debug('*** validation call back > start INNNNNNNNNNNNNN 3 ***+++++++++++++++++++++++' + lineItem.Apttus_Config2__Quantity__c );
                                      return result;
                                    } 
                                    
                                    
                                }
                        
                    }else if(cond == 1){
                        //Both in cart
                        system.debug('*** validation call back > Both products in cart ***+++++++++++++++++++++++ ' );
                        
                                if(lineItem.Apttus_Config2__ProductId__r.Name == lineItem.APT_Same_Quantity_Product_1__c){
                                    //only Base product in cart
                                    system.debug('*** validation call back > only Base product added after addon product in cart ***+++++++++++++++++++++++ ' );
                                    totalQ = lineItem.Apttus_Config2__Quantity__c.intValue() + setQ;
                                    system.debug('*** validation call back > only Base product in cart and as well as in Asset so totalQ ***+++++++++++++++++++++++ ' + totalQ );
                                    
                                }else{
                                    //only Addon Product in cart
                                    system.debug('*** validation call back > only addon product added after base product in cart ***+++++++++++++++++++++++ ' +lineItem.Apttus_Config2__Quantity__c.intValue());
                                    system.debug('*** validation call back > only Base product in cart and as well as in Asset so totalQ ***+++++++++++++++++++++++ ' + totalQ );
                                    String errorMSG = 'Please select the same quantity for "'+lineItem.APT_Same_Quantity_Product_1__c+'"[As In Asset and Cart = '+totalQ+'] and '+lineItem.APT_Same_Quantity_Product_2__c+'" products.';  
                                    if(totalQ != lineItem.Apttus_Config2__Quantity__c.intValue()){
                                      result.Messages.add(new ApexPages.Message(ApexPages.Severity.ERROR, errorMSG)); 
                                      result.isSuccess =  false;
                                      q=0;
                                      system.debug('*** validation call back > start INNNNNNNNNNNNNN 3 ERROOROOR ***+++++++++++++++++++++++' +lineItem.Apttus_Config2__ProductId__r.Name );
                                      //lineItem.Apttus_Config2__Quantity__c = q;
                                      system.debug('*** validation call back > start INNNNNNNNNNNNNN 3 ***+++++++++++++++++++++++' + lineItem.Apttus_Config2__Quantity__c );
                                      return result;
                                    } 
                                    
                                    
                                    
                                }
                        
                        
                    }else {
                        system.debug('*** validation call back > Both products in cart ELSEEEE part  ***+++++++++++++++++++++++ ' +cond );
                    }
                    

                    
                }else{
                    
                
                
                
                           //Make the quantity same for both the products on cart -------------- 
                            
                           if(q==0 && lineItem.Apttus_Config2__LineType__c != 'Option' && ( lineItem.Apttus_Config2__ProductId__r.Name == lineItem.APT_Same_Quantity_Product_1__c || lineItem.Apttus_Config2__ProductId__r.Name == lineItem.APT_Same_Quantity_Product_2__c ) )
                            {
                               system.debug('*** validation call back > start INNNNNNNNNNNNNN 1 ***+++++++++++++++++++++++' +lineItem.Apttus_Config2__ProductId__r.Name +'THIS IS IMP 1 => '+lineItem.APT_Same_Quantity_Product_1__c + ' THIS IS IMP 2 => '+lineItem.APT_Same_Quantity_Product_2__c);
                               q = lineItem.Apttus_Config2__Quantity__c.intValue();
                               system.debug('*** validation call back > start INNNNNNNNNNNNNN 1 ***+++++++++++++++++++++++' + q );
                            }else if(q!=0 && lineItem.Apttus_Config2__LineType__c != 'Option' && ( lineItem.Apttus_Config2__ProductId__r.Name == lineItem.APT_Same_Quantity_Product_1__c || lineItem.Apttus_Config2__ProductId__r.Name == lineItem.APT_Same_Quantity_Product_2__c )){
                               system.debug('*** validation call back > start INNNNNNNNNNNNNN 2 ***+++++++++++++++++++++++' +lineItem.Apttus_Config2__ProductId__r.Name );
                               //lineItem.Apttus_Config2__Quantity__c = q;
                               system.debug('*** validation call back > start INNNNNNNNNNNNNN 2 ***+++++++++++++++++++++++' + lineItem.Apttus_Config2__Quantity__c );
                               
                               String errorMSG = 'Please select the same quantity for "'+lineItem.APT_Same_Quantity_Product_1__c+'" and '+lineItem.APT_Same_Quantity_Product_2__c+'" products.';  
                               if(q!=lineItem.Apttus_Config2__Quantity__c.intValue()){
                                  result.Messages.add(new ApexPages.Message(ApexPages.Severity.ERROR, errorMSG)); 
                                  result.isSuccess =  false;
                                  q=0;
                               system.debug('*** validation call back > start INNNNNNNNNNNNNN 3 ERROOROOR ***+++++++++++++++++++++++' +lineItem.Apttus_Config2__ProductId__r.Name );
                               //lineItem.Apttus_Config2__Quantity__c = q;
                               system.debug('*** validation call back > start INNNNNNNNNNNNNN 3 ***+++++++++++++++++++++++' + lineItem.Apttus_Config2__Quantity__c );
                                  
                                  return result;
                               }
                               
                            }else{
                            
                             system.debug('*** validation call back > start ***+++++++++++++++++++++++ ELSEEEEEEEE' );
                            }
                
                }

            }
           
            
        } catch(Exception ex) {
            result.Messages.add(new ApexPages.Message(ApexPages.Severity.ERROR, ex.getMessage()));
            System.debug('Ex.getmessage(): ' + ex.getmessage());
            result.isSuccess =  false;
        }
        return result;
   }
  
    /** Gets the list of product line items associated with the Battery line
      @param cart the cart object
     @return the list of line item objects
    **/
    private static List<Apttus_Config2__LineItem__c> getLineItems(List<Apttus_Config2.LineItem> allLines) {
        list<Apttus_Config2__LineItem__c> lineItems = new list<Apttus_Config2__LineItem__c>();
        // iterate thru the cart and get the line items matching the battery code1 
        for (Apttus_Config2.LineItem lineItemMO : allLines) {
            lineItems.add(lineItemMO.getLineItemSO());
        }
        
        return lineItems;
    }  
   
    /**
        Must implement methods of Apttus_Config2.CustomClass.IValidationCallback2
    **/
    global Apttus_Config2.CustomClass.ValidationResult validateAssetItems(Apttus_Config2.ProductConfiguration cart,List<Apttus_Config2__TempRenew__c> lstTemp) {
        Apttus_Config2.CustomClass.ValidationResult result;
        return result;
    }    
    /**
        Method to validate ramp line items
    **/
    global Apttus_Config2.CustomClass.ValidationResult validateRampLineItems(Apttus_Config2.ProductConfiguration cart,List<Apttus_Config2.LineItem> lstLI) {
        Apttus_Config2.CustomClass.ValidationResult result;
        return result;
    }
  }