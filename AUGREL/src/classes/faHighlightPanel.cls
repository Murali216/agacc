global with sharing class faHighlightPanel {


  public  Financial_Account__c FA {get; set;}
  public  Financial_Account_Customer__c FAC {get; set;}
  public  Financial_Account_Customer__c CoBorrower {get; set;}
  public  string privacyIcon {get; set;}
  public  string accountStatusIcon {get; set;}
  public  string accountStatusMsg  {get; set;}
  public  string titleTrackerIcon  {get; set;}
  public  List<Case> authorizedParty {get; set;}
  public  boolean hasAuthorizedParties {get; set;}

  public List<Boolean> canDialPrimary {get; set;}
  public List<Boolean> canDialCoborrower{get; set;}
  public string PrimarySSNType {get; set;}
  public string CoborrowerSSNType {get; set;}
  
  //W-000584 April, 2016
  public List<notification__c> notifications {get; set;}
  public boolean hasNotifications {get; set;}
       
  public faHighlightPanel(ApexPages.StandardController controller) {

	canDialPrimary  = new List<Boolean>{false, false, false};
	canDialCoborrower  = new List<Boolean>{false, false, false};
	
	
    Id FAId = ApexPages.currentPage().getParameters().get('Id');
    FA = [select Payment_Date_Past_Due__c,Finance_Account_Product_Type__c,  Name, Payment_Date_Last__c, Finance_Account_Status__c,
        Payment_Amount_Last__c, Payment_Term_Remaining__c, Payment_Date_Next__c, Maturity_Date__c, code_edit_message__c,
        Payoff_Amount_Gross__c, Payoff_Amount_Net__c, Payoff_Good_Thru_Date__c, Dealership__r.name, Dealership__r.phone, Total_Amount_Due__c,
        Collateral__r.Vehicle_Identification_Number__c,Collateral__r.Model_Year__c, Collateral__r.Model_Name__c, flag_do_not_call__c,
        Collateral__r.Make__c, recordType.Name, dealership__c, Title_Tracker__c, Title__r.Title_Status__c, Payment_Amount_Scheduled__c,
        Payment_Amount_Past_due__c, Charges_Late__c, Charges_Miscellaneous__c, Revised_Maturity_Date__c,Payoff_Amount_Retail_or_lease__c
        from Financial_Account__c where Id = :FAId limit 1];

    try {
      this.FAC = [select  Id,Customer_Full_Name__c, Mailing_Street1__c, Mailing_Street2__c, Mailing_City__c, Mailing_State__c, Mailing_Zip__c, Borrower_Position__c, Mobile_Phone__c, 
              Servicing_Email__c, account__r.Social_Security_Number__pc, Flag_Office_Of_Foreign_Asset_Control__c,
              Privacy_Election_Third_Party_Sharing__c, Privacy_Election_Telemarketing__c,Home_Phone_Garage__c,Work_Phone_Garage__c,
              Privacy_Election_FCRA_Sharing__c, Privacy_Election_FCRA_Sharing_Source__c, Privacy_Election_Dealership__c, 
              Privacy_Election_DealershipSource__c, Privacy_Election_Affiliate_Sharing__c, Privacy_Election_Affiliate_Marketing__c, 
              Privacy_Elect_Affiliate_Sharing_Source__c, Privacy_Elect_3rd_Party_Sharing_Source__c, Privacy_Elec_Affiliate_Marketing_Source__c,
              Account__r.Tax_Identification_Number__c, 
              Home_Phone_No_Call_Reason_Code_Garage__c,  Home_Phone_No_Call_Reason_Garage__c, 
              Mobile_Phone_No_Call_Reason_Code__c, Mobile_Phone_No_Call_Reason__c,
              Work_Phone_NoCall_Reason_Code_Garage__c, Work_Phone_No_Call_Reason_Garage__c,
              Mailing_Postal_Code_Garage__c
            from Financial_Account_Customer__c 
            where Financial_Account__c =  : fa.Id and Customer_Role_Type__c = '0-Primary Borrower' and Borrower_Status__c = 'Active' limit 1];
            
      		 canDialPrimary = TFSC_Utils.getListDisplayFACNumbers(this.FAC);
      		 PrimarySSNType = (FAC.account__r.Social_Security_Number__pc!= null) ? 'SSN' : 'TIN';
      		 	
    }
    catch(exception e){FAC = new Financial_Account_Customer__c();}
    
    try {
               
      this.CoBorrower = [select  Id,Customer_Full_Name__c, Mailing_Street1__c, Mailing_Street2__c, Mailing_City__c, Mailing_State__c, Mailing_Zip__c, Borrower_Position__c, Mobile_Phone__c, 
              Servicing_Email__c, account__r.Social_Security_Number__pc, Flag_Office_Of_Foreign_Asset_Control__c,
              Privacy_Election_Third_Party_Sharing__c, Privacy_Election_Telemarketing__c, Home_Phone_Garage__c, Work_Phone_Garage__c,
              Privacy_Election_FCRA_Sharing__c, Privacy_Election_FCRA_Sharing_Source__c, Privacy_Election_Dealership__c, 
              Privacy_Election_DealershipSource__c, Privacy_Election_Affiliate_Sharing__c, Privacy_Election_Affiliate_Marketing__c, 
              Privacy_Elect_Affiliate_Sharing_Source__c, Privacy_Elect_3rd_Party_Sharing_Source__c, Privacy_Elec_Affiliate_Marketing_Source__c,
              Account__r.Tax_Identification_Number__c, 
              Home_Phone_No_Call_Reason_Code_Garage__c,  Home_Phone_No_Call_Reason_Garage__c, 
              Mobile_Phone_No_Call_Reason_Code__c, Mobile_Phone_No_Call_Reason__c,
              Work_Phone_NoCall_Reason_Code_Garage__c, Work_Phone_No_Call_Reason_Garage__c,
              Mailing_Postal_Code_Garage__c
                from Financial_Account_Customer__c 
                where Financial_Account__c =  : fa.Id and  Customer_Role_Type__c = '6-Co-Borrower' and Borrower_Status__c = 'Active'  limit 1];
    
      
      		 canDialCoborrower = TFSC_Utils.getListDisplayFACNumbers(this.CoBorrower);
      		 CoborrowerSSNType = (Coborrower.account__r.Social_Security_Number__pc != null) ? 'SSN' : 'TIN';
    }
    catch(exception e){coBorrower = new Financial_Account_Customer__c();}
    
    //setup privacy values
	    string privacyValues  = '';
	    if (fa.flag_do_not_call__c == null)
	      privacyValues += 'In|';
	    else
	      privacyValues += fa.flag_do_not_call__c + '|';
	      
	    if (fac.Id != null)
	      privacyValues += privacy(fac);
	    if (coBorrower.Id != null)
	      privacyValues += privacy(coBorrower);  
	  
	    //determine privacy icon
	    if   (privacyValues.containsignoreCase('Out|') || privacyValues.containsignoreCase('Yes|')|| privacyValues.containsignoreCase('Y|')  )
	      privacyIcon = 'red';
	    else if (privacyValues.containsignoreCase('Pnd|') || privacyValues.containsignoreCase('Null|'))
	      privacyIcon = 'yellow';
	    else
	      privacyIcon = 'green';
    // end privacy values
     
    //determine account status icon/message
	    try {
	      accountStatusIcon =  UC_Account_Status__c.getInstance(fa.code_edit_message__c).icon__c.toUpperCase();
	      accountStatusMsg =  UC_Account_Status__c.getInstance(fa.code_edit_message__c).Salesforce_Message__c.toUpperCase();
	    }
	    catch(exception e){}
    
    // get authorized parties W-000118
	    authorizedParty = [select Authorized_Third_Party__c, Authorization_Type__c, Authorization_Expiration__c, Good_Thru_Date__c,
	                         	  Type_of_Authorization_Granted__c, Description
	                       from Case
	                       where financial_account__c = :fa.Id 
	                       and   action__c = 'Edit Profile'
	                       and   service_request_type__c = 'Authorized Party'
	                       and   (good_thru_date__c = null or good_thru_date__c >= :date.today()) ];     
	  
	    if (authorizedParty.size() > 0)
	    	hasAuthorizedParties = true;
    
        //system.debug('*** fa: ' + FA);
        //system.debug('*** faC: ' + FAC); 
        //system.debug('*** Coborrower: ' + Coborrower);
        //system.debug('*** dealer name/phone: ' + fa.Dealership__r.name +'/'+ fa.Dealership__r.phone);
        //system.debug('**** canDialPrimary: ' + canDialPrimary);
	
	//determine title tracker icon W-000472
		titleTrackerIcon = '';
		if(fa.Finance_Account_Status__c == 'Close'){
			if(FA.Title__r.Title_Status__c != null){
				String ts = FA.Title__r.Title_Status__c;
				//System.debug('**** fa title status: '+ts);
				if(ts == 'Pending-Not Yet Received' || ts == 'Held' || ts == 'Ready to be Transferred' || ts == 'Transferred'){
					titleTrackerIcon = 'yellow';
				}else{
					LIST<Case> matchingCases = [Select ContactId 
									from Case 
									WHERE Financial_Account__c =: FA.id
									AND Status != 'Resolved'
									AND Service_Request_Type__c IN ('Discrepant', 'Duplicate Request', 'Follow Up', 'State Transfer', 'Recall', 
															'PIF ELT Rejects', 'Titled in Error', 'Substitution of Collateral', 'Update Title')];
					//System.debug('**** matchingCases.size(): '+matchingCases.size());
					if(matchingCases.size()>0) titleTrackerIcon = 'yellow';
				}
			}		
		}
	// end Title Tracker
	
	//W-000584 - April, 2016 - FA Notifications
	notifications = [select Id,name, start_date__c, expiration_date__c, notification_content__c, priority_flag__c
					 from notification__c
					 where financial_account__c = :fa.Id
					 and (start_date__c = null or start_date__c <= today)
					 and (expiration_date__c = null or expiration_date__c > today) 
					 order by priority_flag__c desc, expiration_date__c desc nulls first];
					 
	if (notifications.size() > 0) hasNotifications = true;
	
  }
  
  private string privacy(Financial_Account_Customer__c fac) {

    
    string values = '';
    if (fac.Privacy_Election_Third_Party_Sharing__c == null)
      values += 'Null|';
    else
      values += fac.Privacy_Election_Third_Party_Sharing__c + '|';


    if (fac.Privacy_Election_Affiliate_Marketing__c == null)
      values += 'Null|';
    else
      values += fac.Privacy_Election_Affiliate_Marketing__c + '|';
      
    if (fac.Privacy_Election_Dealership__c == null)
      values += 'Null|';
    else
      values += fac.Privacy_Election_Dealership__c + '|';
      
    if (fac.Privacy_Election_Telemarketing__c == null)
      values += 'Null|';
    else
      values += fac.Privacy_Election_Telemarketing__c + '|';
      
    if (fac.Flag_Office_Of_Foreign_Asset_Control__c == null)
      values += 'In|';    // null value is green
    else
      values += fac.Flag_Office_Of_Foreign_Asset_Control__c + '|';
      
    if (fac.Privacy_Election_Affiliate_Sharing__c == null)
      values += 'Null|';
    else
      values += fac.Privacy_Election_Affiliate_Sharing__c + '|';
      
    if (fac.Privacy_Election_FCRA_Sharing__c == null)
      values += 'Null|';
    else
      values += fac.Privacy_Election_FCRA_Sharing__c + '|';
            

   system.debug('+++++ values: '+values);
    return values;

  }



}