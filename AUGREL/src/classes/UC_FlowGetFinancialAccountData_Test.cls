/**
	* UC_FlowGetFinancialAccountData_Test - <description>
	* Created by BrainEngine Cloud Studio
	* @author: Clayton Bruckert
	* @version: 1.0
*/

@isTest
private class UC_FlowGetFinancialAccountData_Test {
	static testMethod void invokeTest() {
		Test.startTest();
    	String facNumber = '123testfac';
     	//Create test FA
       	Financial_Account__c financialAccount = insertFinancialAccount(facNumber);
       	Financial_Account__c dbFinancialAccount = getFinancialAccount(financialAccount.id);
       	//create related FA's
       	insertFinancialAccountCustomer (financialAccount, 'Primary');
       	insertFinancialAccountCustomer (financialAccount, 'Co-X');
       	//prep for Virtual Flow
		Map<String,Object> inputParams = new Map<String,Object>();
       	Map<String,Object> outputParams = new Map<String,Object>();
       	// start the Virtual Flow
       	inputParams.put('vFinanceAccountId',facNumber);
       	UC_FlowGetFinancialAccountData fgfad = new UC_FlowGetFinancialAccountData();
       	Process.PluginRequest request = new Process.PluginRequest(inputParams);
       	try{
         	fgfad.describe();
        	fgfad.invoke(request);
       	}catch (Exception e){
        	System.Debug(e);
        }
		Test.StopTest();
    }
    
    private static void insertFinancialAccountCustomer(Financial_Account__c financialAccount, String borrowerPosition) {
     	Account acct = new Account(Name  = 'Test Account');
     	insert acct;
     
     	Financial_Account_Customer__c newFac = new Financial_Account_Customer__c (
        			Borrower_Position__c = borrowerPosition
           			,Financial_Account__c = financialAccount.Id
      				,Election_Overall_Consent__c ='Y'
			        ,Flag_Home_Phone_DNC_Garage__c = true
          			,Flag_Home_Phone_DNC_BillTo__c = true
          			,Flag_Work_Phone_DNC_Garage__c = true
           			,Flag_Work_Phone_DNC_BillTo__c = true
           			,Flag_Mobile_Phone_DNC__c = true
		        	,Account__c = acct.Id
		           	,Borrower_Status__c = 'Active'
		           	,Customer_Role_Type__c = 'test'
		           	,FA_Role_Status__c = 'test'
		           	,Financial_Account_Customer__c = 'test2' + TFSC_TestUtils.generateRandomString(4) 
                   );
        insert newFac;
    }
   
   	private static Financial_Account__c insertFinancialAccount( String facNumber) {
        
        Financial_Account__c financialAccount = new Financial_Account__c(Financial_Account_Number__c = facNumber);
        insert financialAccount;
        
       
       
        return financialAccount;
    }
    
    private static Financial_Account__c getFinancialAccount(String id) {
        Financial_Account__c financialAccount = [ SELECT id, Financial_Account_Number__c FROM Financial_Account__c WHERE id=:id];
        
        return financialAccount;
    }
}