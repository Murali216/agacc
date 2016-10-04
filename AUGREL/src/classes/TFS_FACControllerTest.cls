@isTest
public class TFS_FACControllerTest {
      private static void createBaseData(){
    Id persAccId = TFSC_Utils.getRecordTypeIdFromDeveloperNameAndsObjectName('Customer', 'Account');
      

      Account personAcct = new Account(FirstName='FName',LastName ='LName',RecordTypeId=persAccId, Social_Security_Number__pc='11111111');
      insert personAcct;



      Collateral__c car = new Collateral__c(Vehicle_Identification_Number__c ='11111111111111111111',Make__c='Toyota', Model_Name__c='Camry',Model_Year__c='2015');
      insert car;

      Financial_Account__c fa = insertFA(car);    
      
      Financial_Account_Customer__c personfac = insertFAC(fa, personAcct);
          
  }
    
       private static Financial_Account__c insertFA(Collateral__c car) {
        
        String randomString = TFSC_TestUtils.generateRandomString(6);
        
        Financial_Account__c financialAccount = new Financial_Account__c(Financial_Account_Number__c = '1111111111', Collateral__c=car.Id,Finance_Account_Status__c='Active', CO_Host_Account_Number__c='00070411111111110001' );
        financialAccount.Collection_List_Number_1__c = '1704'; // for FPD
        financialAccount.History_Counter_Days_Past_Due__c = '10';
        insert financialAccount;        
       
        return financialAccount;
    }
    
        private static Financial_Account_Customer__c insertFAC(Financial_Account__c fa, Account acc) {
        
        String randomString = TFSC_TestUtils.generateRandomString(6);
        
        Financial_Account_Customer__c fac = new Financial_Account_Customer__c(Financial_Account__c = fa.Id, Account__c = acc.Id, Mailing_Postal_Code_Garage__c='11111' );
    fac.Borrower_Position__c = 'Primary';
        fac.Borrower_Status__c = 'Active';
        fac.Mailing_State_BillTo__c = 'CO';        
        fac.Work_Phone_Garage__c = '1111111111';
        fac.Mobile_Phone__c = '1111111111';
        fac.Home_Phone_Garage__c = '1111111111';
        fac.Work_Phone_Bill_To__c = '1111111111';
        fac.HomePhone_BillTo__c = '1111111111';
        fac.Borrower_Status__c = 'Active';
        fac.Customer_Role_Type__c = 'test';
        fac.FA_Role_Status__c = 'test';
            fac.Servicing_Email__c = 'OldTest@toyota.com';
    fac.Financial_Account_Customer__c = 'test2' + TFSC_TestUtils.generateRandomString(4);


        insert fac;        
       
        return fac;
    }
    
 @Istest   static  void testMethodGeneral()
    {
        createBaseData();
                Financial_Account__c  finAccount = [SELECT Id, Financial_Account_Number__c, Finance_Account_Product_Type__c FROM 
        Financial_Account__c WHERE Financial_Account_Number__c = '1111111111' LIMIT 1];
        
                Financial_Account_Customer__c  finAccountCustomer = [SELECT Id, Account__r.LastName, Account__r.FirstName, Borrower_Position__c,Servicing_Email__c,Work_Phone_Garage__c,Mobile_Phone__c,Home_Phone_Garage__c,Work_Phone_Bill_To__c,HomePhone_BillTo__c FROM Financial_Account_Customer__c WHERE 
        Financial_Account__c = :finAccount.Id  LIMIT 1];        
        ApexPages.StandardController stdController = new ApexPages.StandardController(finAccountCustomer);
        TFS_FACController FACController = new TFS_FACController(stdController);
        Pagereference pageref  = page.TFS_FACPage_VF ;
        
        system.debug('before setting email: '+finAccountCustomer.Servicing_Email__c);
        finAccountCustomer.Servicing_Email__c = 'Test123@toyota.com';
        system.debug('After setting email: '+finAccountCustomer.Servicing_Email__c);

        Test.setCurrentPage(pageRef); 
        Test.startTest();
        FACController.getPaymentNotRecvdEmail();
        FACController.getpaymentNotRecvdTxt();
        FACController.OldEmailId = 'OldTest1@toyota.com';

    
           //FACController.NewEmailId = 'Test1234@toyota.com' ;
           
        FACController.save();
       // FACController.getFACByDynamicSOQL(finAccount.id);
        Test.stopTest();
        
        
        
        
        
    }
    
    
    
    
    

}