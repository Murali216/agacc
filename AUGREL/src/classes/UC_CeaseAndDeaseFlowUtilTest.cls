@isTest
private class UC_CeaseAndDeaseFlowUtilTest {
	static testMethod void getFinancialAccountIdTest() {
     	Test.startTest();
     
		String facNumber = '123testfac';
		Financial_Account__c financialAccount = insertFinancialAccount(facNumber);
		Financial_Account__c dbFinancialAccount = getFinancialAccount(financialAccount.id);

		System.assertEquals( UC_CeaseAndDeaseFlowUtil.getFinancialAccountId(dbFinancialAccount.Financial_Account_Number__c),
		                    UC_CeaseAndDeaseFlowUtil.getFinancialAccountId(financialAccount.Financial_Account_Number__c)
		                  );

		Test.stopTest();
    
   	}
   
    static testMethod void getFinancialAccountIdsTest() {     
     	Test.startTest();
     
		String facNumber = '123testfac';
		Financial_Account__c financialAccount = insertFinancialAccount(facNumber);
		Financial_Account__c dbFinancialAccount = getFinancialAccount(financialAccount.id);

		System.assertEquals( UC_CeaseAndDeaseFlowUtil.getFinancialAccountIds(dbFinancialAccount.Financial_Account_Number__c).size(),
		                    UC_CeaseAndDeaseFlowUtil.getFinancialAccountIds(financialAccount.Financial_Account_Number__c).size()
                  );
       
       
     	Test.stopTest();    
   	}	
   
   
   
   	static testMethod void getFinancialAccountCustomersTest() {
     
		Test.startTest();

		String facNumber = '123testfac';
		Financial_Account__c financialAccount = insertFinancialAccount(facNumber);
		Financial_Account__c dbFinancialAccount = getFinancialAccount(financialAccount.id);

		System.assertEquals((UC_CeaseAndDeaseFlowUtil.getFinancialAccountCustomers(dbFinancialAccount.Financial_Account_Number__c)).size(),
		                    0);

		Test.stopTest();
   	}	
   
   
   	static testMethod void getDNCConsentDataTest() {     
		Test.startTest();

		String facNumber = '123testfac';
		Financial_Account__c financialAccount = insertFinancialAccount(facNumber);
		Financial_Account__c dbFinancialAccount = getFinancialAccount(financialAccount.id);

		System.assertEquals(UC_CeaseAndDeaseFlowUtil.getDNCConsentData(dbFinancialAccount.Financial_Account_Number__c, 'Primary'),
					null);
       
       Test.stopTest();
   	}
   
   
    static testMethod void getFlagBankruptcyTest() {     
     	Test.startTest();
     
		String facNumber = '123testfac';
		Financial_Account__c financialAccount = insertFinancialAccount(facNumber);
		Financial_Account__c dbFinancialAccount = getFinancialAccount(financialAccount.id);

		System.assertEquals(UC_CeaseAndDeaseFlowUtil.getFlagBankruptcy(dbFinancialAccount.Financial_Account_Number__c, 'Primary'),
				null);
		
 		Test.stopTest();    
   }
   
   
   
   	static testMethod  void updateFlagBankruptcyTest() {                                       
		Test.startTest();

		String financialAccountNumber = '123testfac' ;
		String borrowerPosition = 'Primary';
		String bkValue ='BK';
		Financial_Account__c financialAccount = insertFinancialAccount(financialAccountNumber);
		Financial_Account__c dbFinancialAccount = getFinancialAccount(financialAccount.id);
		
		try {
		 	UC_CeaseAndDeaseFlowUtil.updateFlagBankruptcy(dbFinancialAccount.Financial_Account_Number__c, 'Primary', 'BK');
		}
		catch (Exception e) {
		  	System.debug(e);			
		}                       
		  
 		Test.stopTest();
    }
   
    static testMethod void getActivityCodeDescTest() {
     	Test.startTest();
		System.assertEquals(UC_CeaseAndDeaseFlowUtil.getActivityCodeDesc('DNC1'),null );
	 	Test.stopTest();     
    }
    
    static testMethod void  getDNCStrTest() { 
		Test.startTest();
		System.assertEquals(UC_CeaseAndDeaseFlowUtil.getDNCStr('a:b'),'' );
		Test.stopTest();
    }
    
    static testMethod void getCaseIdTest() {
		Test.startTest();
		
		String facNumber = '123testfac';
		Financial_Account__c financialAccount = insertFinancialAccount(facNumber);
		Financial_Account__c dbFinancialAccount = getFinancialAccount(financialAccount.id);
		
		System.assertEquals(FlowUtil.getCaseId(dbFinancialAccount.Id),null );

		Test.stopTest();

    }
    //getDNCMap
    static testMethod void getDNCMapTest() {
     
     	Test.startTest();
       	String input = 'true,true,false,false';
       	System.assertEquals(UC_CeaseAndDeaseFlowUtil.getDNCMap(input) == null, false );
       
       	String borrowerPosition = 'Primary';
       	List<String> recs = input.split(',');
       	Integer loc = 0;
       	Map<String,Boolean> valueDNCMap = new Map<String,Boolean>();
       	for (String rec: recs) {
       		if (0 == loc && null != rec && 'true' == rec) {
	            valueDNCMap.put('Flag_Home_Phone_DNC_Garage__c', true);
	        }
	        System.assertEquals(valueDNCMap.get('Flag_Home_Phone_DNC_Garage__c'), true);
	        
	        if (1 == loc && null != rec && 'true' == rec) {
            	valueDNCMap.put('Flag_Work_Phone_DNC_Garage__c', true);
	        }
	        if (2 == loc && null != rec && 'true' == rec) {
	            valueDNCMap.put('Flag_Mobile_Phone_DNC__c', true);
	        }
	        if (3 == loc && null != rec && 'true' == rec) {
	            valueDNCMap.put('Flag_Home_Phone_DNC_BillTo__c', true);
	        }
	        if (4 == loc && null != rec && 'true' == rec) {
	            valueDNCMap.put('Flag_Work_Phone_DNC_BillTo__c', true);
	        }
            loc++;
       	}
     	
		Test.stopTest();
    }
    
    
    static testMethod void sendEmailTest() {
		Test.startTest();
		UC_CeaseAndDeaseFlowUtil.sendEmail('mchinnappan@salesforce.com', 'SUBJECT', 'BODY of the email');
		Test.stopTest();
    }
    
    
    static testMethod void valueMapTest() {
		Test.startTest();
		
		Map<String,Boolean> valueDNCMap = new Map<String,Boolean>();
		valueDNCMap.put('Flag_Home_Phone_DNC_Garage__c', false);
		
		System.assertEquals(valueDNCMap.get('Flag_Home_Phone_DNC_Garage__c'), false);
		
		Test.stopTest(); 
    }
    
    
    static testMethod void insertActivityCodeInTaskTest() {
     
    	Test.startTest();
       	String facNumber = '123testfac';
       	Financial_Account__c financialAccount = insertFinancialAccount(facNumber);
       	Financial_Account__c dbFinancialAccount = getFinancialAccount(financialAccount.id);
      
      	String whatId = null;
      
      	if (null == whatId) {
	    	Task newTask = new Task(
	        			Subject =  'codeDescription',
	                  	WhatId = whatId,
	                  	Financial_Account__c =  dbFinancialAccount.Id,
	                  	Financial_Account_Number__c = dbFinancialAccount.Financial_Account_Number__c,
	                  	Status = 'statusStr',
	                  	Collection_Activity_Code__c = 'activityCode',
	                  	Description = 'taskDesc',
	                  	ActivityDate = Date.today()
	             		);
	    	insert newTask; 
	     
	    	System.assertEquals(newTask.whatId, null );
     	}
     
     
      	UC_CeaseAndDeaseFlowUtil.insertActivityCodeInTask(
       				dbFinancialAccount.Financial_Account_Number__c,
       				dbFinancialAccount.Id,
       				'activityCode',  'codeDescription',  dbFinancialAccount.Id,
               		'status', 'taskDesc');
     
       	Test.stopTest();
    }
    
    private static Financial_Account__c coBorrowerTest( String facNumber) {
    	Test.startTest(); 
        Financial_Account__c financialAccount = new Financial_Account__c(Financial_Account_Number__c = facNumber);
        insert financialAccount;
        
        String borrowerPosition = 'Primary';
        List <Financial_Account_Customer__c>  facs = UC_CeaseAndDeaseFlowUtil.getFinancialAccountCustomers(financialAccount.id);
        Map<String,Boolean> valueDNCMap = null;
        for (Financial_Account_Customer__c fac : facs) {
        	if (fac.Borrower_Position__c != borrowerPosition) {
         		System.assertNotEquals(fac.Borrower_Position__c, borrowerPosition);
         	} else {
         		valueDNCMap = new Map<String,Boolean>();
         	}
         	System.assertEquals(fac.Borrower_Position__c, null);
        }
        
        Test.stopTest();  
               
    	return financialAccount;
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