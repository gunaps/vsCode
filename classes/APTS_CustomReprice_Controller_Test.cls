/*************************************************************  
@Name:  APTS_CustomReprice_Controller_Test
@Author:    Shubham Bhatt& Bhargav Esotiya
@CreateDate:    07-FEB-2017
@Description:   "Custom Reprice Controller Test Class"
@UsedBy:    Test Coverage
@Further Updates:   
Updated On  N/A
Changes N/A
******************************************************************/


@isTest
private class APTS_CustomReprice_Controller_Test {
    private static testMethod void BasicCPQFlowExecution() {
          APTS_TestDataFactory.ExecuteBasicCPQFlow();
          PageReference pref = Page.APTS_CustomReprice;
          Test.setCurrentPage(pref);
          ApexPages.currentPage().getParameters().put('id', APTS_TestDataFactory.objProdConfig.Id);
          ApexPages.currentPage().getParameters().put('currentFlow', 'NGDefault');
          ApexPages.StandardController sc = new ApexPages.standardController(APTS_TestDataFactory.objProdConfig);
          APTS_CustomReprice_Controller controller = new APTS_CustomReprice_Controller();
          controller.ChangeStatus();
          controller.redirectToCart();
    }
}