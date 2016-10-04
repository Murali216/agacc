/**
	* UC_UpdateCaseController - Controller for updating Cases
	* Created by BrainEngine Cloud Studio
	* @author: Clayton Bruckert
	* @version: 1.0
*/

public with sharing class UC_UpdateCaseController{
	public Case thisCase {get; set;}
    public boolean saveSuccessful {get; set;}
    public boolean pageIsVisible {get; set;}
	public Boolean showTitleUpdate {get; Set;}
	public Boolean showControlButtons {get; Set;}
	private ApexPages.StandardController thisCon;
	
	public Title__c thisTitle {get; Set;}
	public Financial_Account_Customer__c PrimaryBorrower {get; Set;}
	public Financial_Account_Customer__c CoBorrower {get; Set;}
	public Financial_Account__c FA {get; Set;}
	
	public UC_UpdateCaseController(ApexPages.StandardController con){
		thisCon = con;
		init();
	}
	
	private void init(){
		pageIsVisible=true;
		showControlButtons = true;
		showTitleUpdate = false;
		saveSuccessful = false;
		
		thisCase = [Select Authorization_Received__c, Customer_Communications__c, Estimated_Mail_Date__c, Mailing_Account__c, CaseNumber,
							Payoff_Date__c, Payoff_Method__c, Send_To__c, Send_to_Name_Address__c, Tracking_Number__c, Financial_Account__c, 
							Financial_Account_Customer__c, Service_Type__c 
					FROM Case 
					WHERE Id =: thisCon.getId()];
		
		try {
            PrimaryBorrower = [select Id  
						from Financial_Account_Customer__c  
						where Financial_Account__c =: thisCase.Financial_Account__c 
            				and Customer_Role_Type__c = '0-Primary Borrower' 
							and Borrower_Status__c = 'Active' limit 1];
        }
        catch(exception e){}
        
        try {CoBorrower = [select Id,Customer_Full_Name__c  
						from Financial_Account_Customer__c 
						where Financial_Account__c =: thisCase.Financial_Account__c 
            				and  Customer_Role_Type__c = '6-Co-Borrower' 
							and Borrower_Status__c = 'Active'  limit 1];
        }
        catch(exception e){}
		
        try {FA = [select id 
						from Financial_Account__c 
						where id =: thisCase.Financial_Account__c];
        }
        catch(exception e){}
		//
		System.debug('*** retrieved borrower: '+PrimaryBorrower);
		System.debug('*** retrieved coborrower: '+CoBorrower);
		System.debug('*** retrieved fa: '+FA);
	}
	// on page actions
	// Title Update Actions
    public void updateTitle() {
	    showTitleUpdate=true;
		
		List<Title__c> relatedTitles = [select Title_State__c, Title_Type__c, Title_Notes__c, Collateral__r.name, Payoff_Date__c, 
							Customer_Communications__c, Hold_Reason__c, Title_Status__c, Payoff__c, Estimated_Mail_Date__c, 
							APO_Received__c, Send_To__c , Title_Send_To_Address__c, Mail_Acct_Num__c, Tracking_Number__c	
					FROM title__c 
					WHERE Id IN (SELECT title__c FROM financial_account__c WHERE id =: thisCase.Financial_Account__c)];
		if(relatedTitles.size()>0){
			thisTitle = relatedTitles[0];
			System.debug('**** the selected title is: ' + relatedTitles);
			// update case values
			thisCase.Payoff_Method__c = thisTitle.Payoff__c;
			thisCase.Payoff_Date__c = thisTitle.Payoff_Date__c;
			
			CalcEstMailingDate();
		}else{
			String message = 'The current FA has no primary title assigned to it \b Please assign a title and try again.';
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, message));
			showTitleUpdate = false;
			showControlButtons = false;
		}
    }
    public void SendToUpdate(){
		UC_NewCase_SendTo AddUpdate = new UC_NewCase_SendTo(thisCase, PrimaryBorrower, CoBorrower, FA);
		AddUpdate.FillAddress();
	}
	public void CalcEstMailingDate(){
		//even if Est Mail Date is populated this will set the date
		System.debug('**** hold reason: ' + ThisTitle.Hold_Reason__c);
		if(thisTitle != null){
			if(ThisCase.Payoff_Date__c==null && ThisTitle.Hold_Reason__c!=null){
				ThisCase.Estimated_Mail_Date__c = null;
			}else if(ThisTitle.Title_Status__c=='Ready to be Released'){
				ThisCase.Estimated_Mail_Date__c = date.today().addDays(1);
			}else if(ThisTitle.Title_Status__c=='Released'){
				ThisCase.Estimated_Mail_Date__c = date.today();
			}else{
				if(thisTitle.Hold_Reason__c!='') ThisCase.Estimated_Mail_Date__c = DecideOnMailingDate();
			}	
		}
	}
	private Date DecideOnMailingDate(){
		date result = Date.today();
		
		LIST<UC_Title_Update_Est_Mailing__c> mailingRules = [Select Id, Name, Hold_Reason__c, Days_to_Add__c, Title_State__c 
					from UC_Title_Update_Est_Mailing__c 
					WHERE Hold_Reason__c =: thisTitle.Hold_Reason__c];
		if(mailingRules != null){
			System.debug('**** the mailing rules are: '+mailingRules);
			if(mailingRules.size()==1){
				// if there is only one rule then add the days, but if the days is blank return null
				if(mailingRules[0].Days_to_Add__c>0){
					return thisCase.Payoff_Date__c.addDays((integer)mailingRules[0].Days_to_Add__c);
				}else{
					return null;
				}
			}else if(mailingRules.size()>1){
				// for multiple rules on a single hold reason: Look through the list for a matching state and then return. 
				// If no state matches return the value of the record with a blank state
				for (UC_Title_Update_Est_Mailing__c mailRule: mailingRules){
					if(thisTitle.Title_State__c == mailRule.Title_State__c){
						result = thisCase.Payoff_Date__c.addDays((integer)mailRule.Days_to_Add__c);
						return result;
					}else if(mailRule.Title_State__c == null){
						result = thisCase.Payoff_Date__c.addDays((integer)mailRule.Days_to_Add__c);
					}
				}
			}else{
				return null;
			}
		}else{
			return null;
		}
		return result;
	}
	// on page buttons
	public void cancelCase(){}
	public PageReference updateCase(){
    	// if this is a title release then update the title fields
		if(showTitleUpdate){
			thisTitle.Payoff_Date__c = thisCase.Payoff_Date__c;
			thisTitle.Payoff__c = thisCase.Payoff_Method__c;
			thisTitle.Customer_Communications__c = thisCase.Customer_Communications__c;
			thisTitle.Estimated_Mail_Date__c = thisCase.Estimated_Mail_Date__c;
			if(thisCase.Authorization_Received__c == 'Yes - Written' || thisCase.Authorization_Received__c == 'Yes - Verbal') thisTitle.APO_Received__c = 'Yes';
			if(thisCase.Authorization_Received__c == 'No') thisTitle.APO_Received__c = 'No';
			if(thisCase.Authorization_Received__c == 'N/A') thisTitle.APO_Received__c = 'N/A';
			thisTitle.Send_To__c = thisCase.Send_To__c;
			thisTitle.Title_Send_To_Address__c = thisCase.Send_to_Name_Address__c;
			thisTitle.Mail_Acct_Num__c = thisCase.Mailing_Account__c;
			thisTitle.Tracking_Number__c = thisCase.Tracking_Number__c;
		}
		
		// update the case
         
        savePoint sp = Database.setSavepoint();
        Case caseBeforeInsert = thisCase.clone(false, true);   // in case there is an error in this is deep clone.
        system.debug('+++ caseBeforeInsert1: ' + caseBeforeInsert);
	
            
        if (doUpdate()){
        }else{            
            Database.rollback(sp);
            system.debug('+++ caseBeforeInsert2: ' + caseBeforeInsert);
            thisCase = caseBeforeInsert;
            system.debug('+++ Case Restored: ' + thisCase);
        }
  
		return null;
	}
    public boolean doUpdate() {
          
        try{
        	System.debug('**** the updated Case: '+thisCase);
           	update thisCase; 
			
			if(showTitleUpdate) update thisTitle;
              
        	System.debug('**** the updated Title__c: '+thistitle);
           SaveSuccessful = true; 
           return true;  

        } catch(System.Exception ex){
           string message = ex.getMessage().replace('First exception on row 0; first error: FIELD_CUSTOM_VALIDATION_EXCEPTION,','');
           message = message.replace(': []','');
  
            system.debug('exception: ' + ex);
            system.debug('message: ' + message);          
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, message));
            system.debug('apexPages.message: ' +new ApexPages.Message(ApexPages.Severity.ERROR, message) );

             SaveSuccessful = false;
            
            system.debug('+++ Save Successful: ' + SaveSuccessful);
            return false;
        }
    } 
}