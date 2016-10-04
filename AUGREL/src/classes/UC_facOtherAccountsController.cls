public with sharing class UC_facOtherAccountsController {
	
	/*  Written 12/14/2015 for R7  */
	/*  Code is a spin off from existing code in Collections Console */
  
    public Id faId	;		// current FA Id
    public string facSSN = '';	// SSN of Customer
    public string facTIN = '' ;   // TIN of Customer
    
    public List<Financial_Account__c> listOfAccounts {get; set;}
    public Integer openOtherAccountCount{get;set;}
    public Integer closedOtherAccountCount{get;set;}
    public boolean hasOtherAccounts  {get; set;}
    public boolean displayRelatedFAsPopup {get; set;}
    public boolean initialized = false;
    public integer listOfAccountsSize {get; set;}
    public List<string> ids  {get; set;}
 
      public String parms { 
        get;
        set {
            parms = value;
            if (!initialized) {
            	List<string> parmArray = parms.split(';');
            
            	faId = parmArray[0];
            	if (parmArray.size() > 1)
            		facSSN = parmArray[1];
            	if (parmArray.size() > 2)
            		facTIN = parmArray[2];
            		
               	getOtherAccounts();
                
                initialized = true;
            system.debug('+++ parmArray: ' + parmArray);
            
           
            
            }
            
        }
    }  
    private void getOtherAccounts() {
    	displayRelatedFAsPopup = false;
  		hasOtherAccounts = false;
        closedOtherAccountCount = 0;
        openOtherAccountCount = 0;
        String SSN = cleanOutBadSSNs(facSSN);
        String TIN = cleanOutBadSSNs(facTIN);

        system.debug('++++SSN: ' +SSN);
        
        system.debug('++++TIN: ' +TIN);
         
        List<Id> otherAccountIds = new List<Id>();  
        	
    	if(SSN != '' || TIN != '') {
            for(Financial_Account_Customer__c fac : 
                   [select id, Financial_Account__r.Finance_Account_Status__c, Financial_Account__c
                    from Financial_Account_Customer__c
                    where (
                        (Account__r.Social_Security_Number__pc <> '' and Account__r.Social_Security_Number__pc = :SSN)
                        or 
                        (Account__r.Tax_Identification_Number__c  <> '' and Account__r.Tax_Identification_Number__c = :TIN)
                        )
                    	and Financial_Account__c <> :faId 
                        and (not Financial_Account_Customer__c like '%Inactive%')
                   		limit 100]) {
                   			
			                otherAccountIds.add(fac.Financial_Account__c);
			                
			                if(fac.Financial_Account__r.Finance_Account_Status__c == 'Open') 
			                    openOtherAccountCount++;
			                else if(fac.Financial_Account__r.Finance_Account_Status__c == 'Close'  ||
			                		fac.Financial_Account__r.Finance_Account_Status__c == 'Closed') 
			                    closedOtherAccountCount++;
 			}
            
       
    	} 
    	
        system.debug('++++other Account Ids: ' +otherAccountIds);
        if(openOtherAccountCount > 0 || closedOtherAccountCount > 0){
            hasOtherAccounts = true;
            setRelatedFAs(otherAccountIds);
        }   	
   }
     public void setRelatedFAs(List<Id> relatedAccountIds){
    	
        //List<FaWrapper> listOfAccounts = new List<FaWrapper>();       // this doesn't work in components ????
        listOfAccounts =  [ SELECT Id, Finance_Account_Status__c, Financial_Account_Number__c,
                            Collateral__c, Collateral__r.Model_Year__c, Collateral__r.Make__c, Collateral__r.Model_Name__c
                            FROM Financial_Account__c
                            WHERE Id in :relatedAccountIds
                            ORDER BY Finance_Account_Status__c,Financial_Account_Number__c ASC NULLS LAST ];
   
            system.debug('+++ list of Accounts: ' + listOfAccounts);
            system.debug('+++ list of Accounts size: ' + listOfAccountsSize);
    }
   
   private String cleanOutBadSSNs(String ssn) {
        //if(ssn == '999999999') {
        if(Pattern.matches('(0{9}|1{9}|2{9}|3{9}|4{9}|5{9}|6{9}|7{9}|8{9}|9{9})',ssn)){
            ssn = '';
        }
        return ssn;
    }   
    
     public PageReference closePopup(){
        displayRelatedFAsPopup = false;
        return null;
    }
      
    public PageReference showTopPopup(){
        displayRelatedFAsPopup = true;
        return null;
    }     
    
    /*
    public class FaWrapper {
        
        public String recordId{get;set;}
        public String Finance_Account_Status{get;set;}
        public String Financial_Account_Number{get;set;}
        public String Collateral{get;set;}
        public String Collateral_Model_Year{get;set;}
        public String Collateral_Make{get;set;}
        public String Collateral_Model_Name{get;set;}
        
        
        public FaWrapper(Financial_Account__c fa) {
            recordId                = fa.Id;
            Finance_Account_Status  = fa.Finance_Account_Status__c; 
            Financial_Account_Number = fa.Financial_Account_Number__c;
            Collateral              = fa.Collateral__c;
            Collateral_Model_Year   = fa.Collateral__r.Model_Year__c;
            Collateral_Make         = fa.Collateral__r.Make__c;
            Collateral_Model_Name   = fa.Collateral__r.Model_Name__c;
        }
    
    }
    */
 
}