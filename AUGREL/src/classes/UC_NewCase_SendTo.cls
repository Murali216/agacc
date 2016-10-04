/**
	* UC_NewCase_SendTo - Helper class for NewCaseController for Send To and Title Release date functionality
	* @author: Clayton Bruckert
	* @version: 1.0
*/

public with sharing class UC_NewCase_SendTo{
    private String Borrower = 'Customer';//11'0-Primary Borrower';
    private String CoBorrower = 'Co-Signer';//'6-Co-Borrower';
    private String OrigDealer = 'Originating Dealer';
    private String Third_Party = '3rd Party';

	Case thisCase;
	Financial_Account_Customer__c thisPrimaryBorrower;
	Financial_Account_Customer__c thisCoBorrower;
	Financial_Account__c thisFA;
	Title__c thisTitle;
	
	public UC_NewCase_SendTo(Case UseCase, Financial_Account_Customer__c UsePrimaryBorrower, Financial_Account_Customer__c UseCoBorrower, Financial_Account__c UseFA){
		thisCase = UseCase;
		if(UsePrimaryBorrower==null){
			thisPrimaryBorrower = new Financial_Account_Customer__c();
		}else{
			thisPrimaryBorrower = UsePrimaryBorrower;	
		}
		if(UseCoBorrower==null){
			thisCoBorrower = new Financial_Account_Customer__c();
		}else{
			thisCoBorrower = UseCoBorrower;	
		}
		if(useFA == null){
			thisFA = new Financial_Account__c();
		}else{
			thisFA = UseFA;	
		}
		System.debug('current fa: '+thisFA);
	}
	
	public void FillAddress(){
        String NewAddress = '';
        System.debug('*** Evaluating: ThisCase.Send_To__c = '+ThisCase.Send_To__c);
        if(thisCase.Send_To__c == Borrower){
            System.debug('*** Entering borrower: '+thisPrimaryBorrower);
			if(thisPrimaryBorrower.id != null){
	            Financial_Account_Customer__c useFAC = [select Customer_Full_Name__c, Mailing_Street1__c, Mailing_Street2__c, Mailing_City__c, Mailing_State__c, Mailing_Zip__c, Mailing_Country_Code_Garage__c
	                        FROM Financial_Account_Customer__c 
	                        WHERE id =: thisPrimaryBorrower.id];
	            NewAddress = FormatAddress(useFAC);
			}
        }else if(thisCase.Send_To__c == 'Co-borrower'){
            System.debug('*** Entering Coborrower: '+thisCoBorrower);
			if(thisCoBorrower.id != null){
	            Financial_Account_Customer__c useFAC = [select Customer_Full_Name__c, Mailing_Street1__c, Mailing_Street2__c, Mailing_City__c, Mailing_State__c, Mailing_Zip__c, Mailing_Country_Code_Garage__c
	                        FROM Financial_Account_Customer__c 
	                        WHERE id =: thisCoBorrower.id];
	            NewAddress = FormatAddress(useFAC);				
			}
        }else if(ThisCase.Send_To__c == OrigDealer){
            System.debug('*** Entering Originating Dealer: '+thisFA);
			if(thisFA.id != null){
	            Account useDealer = [select name, BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry FROM account WHERE Id IN (SELECT Dealership__c FROM financial_account__c WHERE id =: thisFA.id) LIMIT 1];
	            if(useDealer != null) NewAddress = FormatAddress(useDealer);	
			}
        }else if(ThisCase.Send_To__c == Third_Party){
            System.debug('*** 3rd party');
            // as per Req we are handling this option
        }
        
        thisCase.Send_to_Name_Address__c = NewAddress;
         
    }
	
    private String FormatAddress(Financial_Account_Customer__c RelatedObj){
        String result = '';
        if(RelatedObj!=null){
	        result += RelatedObj.Customer_Full_Name__c == null ? '' : RelatedObj.Customer_Full_Name__c;
	        result += RelatedObj.Mailing_Street1__c == null ? '' : '\n' + RelatedObj.Mailing_Street1__c;
	        result += RelatedObj.Mailing_Street2__c == null ? '' : '\n' + RelatedObj.Mailing_Street2__c;
	        result += RelatedObj.Mailing_City__c == null ? ''    : '\n' + RelatedObj.Mailing_City__c;
	        result += RelatedObj.Mailing_State__c == null ? ''   : ', ' + RelatedObj.Mailing_State__c;
	        result += RelatedObj.Mailing_Zip__c == null ? ''     : '   ' + RelatedObj.Mailing_Zip__c;
	        result += RelatedObj.Mailing_Country_Code_Garage__c == null ? '' : '\n' + RelatedObj.Mailing_Country_Code_Garage__c;
		}
        System.debug('*** new address: ' + result);
        return result;
    }
    
    private String FormatAddress(Account RelatedObj){
        String result = '';
        if(RelatedObj!=null){
	        result += RelatedObj.Name == null ? '' : RelatedObj.Name;
	        result += RelatedObj.BillingStreet == null ? '' : '\n' + RelatedObj.BillingStreet;
	        result += RelatedObj.BillingCity == null ? ''    : '\n' + RelatedObj.BillingCity;
	        result += RelatedObj.BillingState == null ? ''   : ', ' + RelatedObj.BillingState;
	        result += RelatedObj.BillingPostalCode == null ? ''     : '   ' + RelatedObj.BillingPostalCode;
	        result += RelatedObj.BillingCountry == null ? '' : '\n' + RelatedObj.BillingCountry;
		}
        System.debug('*** new address: ' + result);     
        return result;
    }
    
}