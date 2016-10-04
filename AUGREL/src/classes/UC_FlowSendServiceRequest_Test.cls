/**
	* UC_FlowSendServiceRequest_Test - <description>
	* Created by BrainEngine Cloud Studio
	* @author: Clayton Bruckert
	* @version: 1.0
*/

@isTest
private class UC_FlowSendServiceRequest_Test {
	static testMethod void pluginRequestTest() {
    	Test.startTest();
        
       	String facNumber = '123testfac';
     
       	Financial_Account__c financialAccount = insertFinancialAccount(facNumber, 'Lease');
       	Financial_Account__c dbFinancialAccount = getFinancialAccount(financialAccount.id);
       	insertFinancialAccountCustomer (financialAccount, 'Primary');
       	insertFinancialAccountCustomer (financialAccount, 'Co-X');
       	
		UC_FlowSendServiceRequest fssr = new UC_FlowSendServiceRequest();
       	Map<String,Object> inputParams = new Map<String,Object>();
       	Map<String,Object> outputParams = new Map<String,Object>();
       	inputParams.put('vFinanceAccountId',facNumber);
       	inputParams.put('vDNCActionDetails','ALL');
       	inputParams.put('vBKFlag','BK');
       	inputParams.put('vTaskDesc','Attorney Name: ,');
       	inputParams.put('vActivityCode', 'PBNK');
        
       	try {
        	Process.PluginRequest request = new Process.PluginRequest(inputParams);
         	String vDNCActionDetails = (String) request.inputParameters.get('vDNCActionDetails');
         	String vTaskDesc = (String) request.inputParameters.get('vTaskDesc');
         	String vBKFlag = (String) request.inputParameters.get('vBKFlag');
         	Decimal vDMNumber = (Decimal) request.inputParameters.get('vDMNumber');
         	String vActivityCode = (String) request.inputParameters.get('vActivityCode');
         	String vAllConsentDetails = (String) request.inputParameters.get('vAllConsentDetails');
    		
         	System.assertEquals(vDNCActionDetails, 'ALL');
         	System.assertEquals(vBKFlag, 'BK');
         	System.assertEquals(vTaskDesc, 'Attorney Name: ,');
         	System.assertEquals(vActivityCode, 'PBNK');
         
          	vTaskDesc = vTaskDesc.replace('Attorney Name: ,', '').replace('Address: ,','').replace('Phone: ,', '');
         	System.assertEquals(vTaskDesc, '');  
         
         	Process.PluginResult result;
         	result = fssr.invoke(request);
         
        	System.assertNotEquals(result, null);
    	}catch (Exception e) {
         	System.debug(e);
       }      
       Test.StopTest();
    }
    static testMethod void resultTest() {
    	Test.startTest();
     
       	String facNumber = '123testfac';
       	Financial_Account__c financialAccount = insertFinancialAccount(facNumber, 'Lease');
       	Financial_Account__c dbFinancialAccount = getFinancialAccount(financialAccount.id);
       
       	UC_FlowSendServiceRequest fssr = new UC_FlowSendServiceRequest();
       
       try {
        	fssr.describe();
          	fssr.updateSelectivePhonesToDNC(facNumber, 'Primary', null, 'Consent','Alt Contact', 'Comments');
         
          	fssr.updateAllPhonesToDNC(facNumber, true, 'Consent','Alt Contact', 'Comments');
          	Process.PluginRequest request;
           
          	String vTaskDesc = (String) request.inputParameters.get('vTaskDesc');
           	vTaskDesc = vTaskDesc.replace('BK Status: ,', '');
       }catch (Exception e) {
         	System.Debug(e);
       }
       Test.StopTest();
    }    
    static testMethod void invokeTest() {
    	Test.startTest();
      	
		String facNumber = '123testfac';
     
       	Financial_Account__c financialAccount = insertFinancialAccount(facNumber, 'Lease');
       	Financial_Account__c dbFinancialAccount = getFinancialAccount(financialAccount.id);
       	insertFinancialAccountCustomer (financialAccount, 'Primary');
       	insertFinancialAccountCustomer (financialAccount, 'Co-X');
       	Map<String,Object> inputParams = new Map<String,Object>();
       	Map<String,Object> outputParams = new Map<String,Object>();
       
       	inputParams.put('vFinanceAccountId',financialAccount.id);
       	inputParams.put('vDNCActionDetails','ALL');
       	inputParams.put('vBKFlag','BK');
       	inputParams.put('vTaskDesc','Attorney Name: ,');
       	inputParams.put('vActivityCode', 'PBNK');
      	
		UC_FlowSendServiceRequest fssr = new UC_FlowSendServiceRequest();
       	Process.PluginRequest request = new Process.PluginRequest(inputParams);
       	
		try{
         	fssr.invoke(request);
       	}catch (Exception e){
        	System.Debug(e);
        }
       
       	inputParams.put('vFinanceAccountId',financialAccount.id);
       	inputParams.put('vDNCActionDetails','true,false,true,true,false:true,true,true,false,true');
       	inputParams.put('vAllConsentDetails', 'true,false');
       	inputParams.put('vBKFlag','BK');
       	inputParams.put('vTaskDesc','Attorney Name: ,');
       	inputParams.put('vActivityCode', 'PBNK');
       
       	try {
            request = new Process.PluginRequest(inputParams);
            fssr.invoke(request);
       	}catch (Exception e){
        	System.Debug(e);
        }
       
       	Test.StopTest();
    }    
    static testMethod void AttyBKTest() {
    	Test.startTest();
      	
		String facNumber = '123AttyBKfac';
     
       	Financial_Account__c financialAccount = insertFinancialAccount(facNumber, 'Lease');
       	Financial_Account__c dbFinancialAccount = getFinancialAccount(financialAccount.id);
       	insertFinancialAccountCustomer (financialAccount, 'Primary');
       	insertFinancialAccountCustomer (financialAccount, 'Co-X');
       	Map<String,Object> inputParams = new Map<String,Object>();
       	Map<String,Object> outputParams = new Map<String,Object>();
        
       	system.debug('*** the current 123AttyBKfac FA Id is: '+financialAccount.id);
       	
        inputParams.put('vFinanceAccountId',financialAccount.id);
		inputParams.put('Service_Request_Type__c','Address/Phone/Name Update'); 
		inputParams.put('Service_Result__c','Corrected/Updated Information');
		inputParams.put('Category__c','Customer Profile Update');
		inputParams.put('Subject__c','Customer Profile Update Address/Phone/Name Update');
		inputParams.put('Action__c','Edit Profile');
		inputParams.put('Topic__c','Address/Phone/Name Update');
       	inputParams.put('vDNCActionDetails','Atty Rep BK');
       	inputParams.put('vBKFlag','');
       	inputParams.put('vTaskDesc','Attorney Name: ,');
		inputParams.put('Description__c','vCommComments');
      	
		UC_FlowSendServiceRequest fssr = new UC_FlowSendServiceRequest();
       	Process.PluginRequest request = new Process.PluginRequest(inputParams);
       	
		try{
         	fssr.invoke(request);
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
		           	,Financial_Account_Customer__c = 'test23cF1x' + TFSC_TestUtils.generateRandomString(4)
		        	);
        insert newFac;
    }
   
    
    private static Financial_Account__c insertFinancialAccount( String facNumber, String recordTypeName) {
        Financial_Account__c financialAccount = new Financial_Account__c(Financial_Account_Number__c = facNumber);
        financialAccount.RecordTypeId = TFSC_Utils.getRecordTypeIdFromDeveloperNameAndsObjectName(recordTypeName, 'Financial_Account__c');
        insert financialAccount;
        return financialAccount;
    }
    
    private static Financial_Account__c getFinancialAccount(String id) {
    	Financial_Account__c financialAccount = [ SELECT id, Financial_Account_Number__c FROM Financial_Account__c WHERE id=:id];        
        return financialAccount;
    }
}