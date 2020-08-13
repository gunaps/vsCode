public class Inputmode
{
    public ApexPages.StandardController con{get;set;}

    public Inputmode(ApexPages.StandardController controller) {
    con = controller;
    }

    public boolean checkmode{get;set;}
    public PageReference Cancel1()
    {    
    checkmode= false;
    //PageReference p = new PageReference('/apex/AccountChannelDiscountPage?id'+ApexPages.currentPage().getParameters().get('id'));
    if(!Test.isRunningTest()){
     con.reset();
     }
   // p.setredirect(true);
        return null;
     }       


  
 }