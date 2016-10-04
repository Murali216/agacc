/**
    * TFSC_WS_CreateClosedDemographicsV1 - Tibco consumes this Webservice to create FA in Salesforce
    * Consumed by Tibco ONLY for Closed Account Creation 
    * @author: Abhishek Ballabh
    * @version: 1.0
*/

global class TFSC_WS_CreateClosedDemographicsV1 {
        
    public enum operation {CREATE}
    
    public static List <Account> UpsertAccountList;
    public static List <Financial_Account__c> upsertFAList;
    public static List <Financial_Account_Customer__c> insertFACList;
    public static List <Financial_Account_Customer__c> updateFACList;
    public static List <Collateral__c> upsertCollateralList;
    public static List <Title__c> InsertTitleList;
    
    
    global class CreateUpdateDemographicsRequest {
            
    webservice Account[] account;
    webservice Boolean modifyAccount;
    webservice DemographicsAndCollateralDetails[] demographicsAndCollateralDetails;
    webservice Title__c[] Title; 

    }
     
    global class DemographicsAndCollateralDetails {
        
    webservice TFSC_WS_CreateClosedDemographicsV1.operation operation;
    webservice Financial_Account__c financialAccount;
    webservice Boolean modifyFinancialAccount;
    webservice Financial_Account_Customer__c financialAccountCustomer;
    webservice Boolean modifyFinancialAccountCustomer;
    webservice Collateral__c collateral;
    webservice Boolean modifyCollateral;   
    
    
    } 
    
    
    global class CreateUpdateDemographicsResponse {
    
    webservice String status;
    webservice String error;

    }   
    
    global class ApplicationException extends Exception{}
    global class AccountException extends Exception{}
    global class FAException extends Exception{}
    global class FACException extends Exception{}
    global class CollateralException extends Exception{}
    global class TitleException extends Exception{}
    
    public class CUDExternalIDs{
    
    String accountNumber;
    String UCID;
    String financialAccountNumber;
    String facID;
    String VIN;
        
    }
    
    
    webservice static CreateUpdateDemographicsResponse createUpdateDemographics(CreateUpdateDemographicsRequest demographicsReq)
    {
         
        // Declarations
        Account account;
        Financial_Account__c financialAccount;
        Financial_Account_Customer__c financialAccountCustomer;
        Collateral__c collateral; 
        Title__c Title;      
        Boolean modifyAccount;
        Boolean modifyFinancialAccount;
        Boolean modifyFinancialAccountCustomer;
        Boolean modifyCollateral;   
        List <DemographicsAndCollateralDetails> demographicsAndCollateralList;
        DemographicsAndCollateralDetails demographicsAndCollateral;
        CreateUpdateDemographicsResponse demographicsResp = new CreateUpdateDemographicsResponse();
        String status = 'SUCCESS';
        String error;
        CUDExternalIDs extIds;
        UpsertAccountList = new List <Account>() ;
        
         System.debug('***** demographicsReq - ' + demographicsReq + '*****');
        

        //Extract account attributes and clean the record

         for(Integer i=0; i<demographicsReq.Account.size(); i++){
        if(demographicsReq.account != null){
            system.debug('**** Detail of Account: '+demographicsReq.account);
            //account = cleanseAccount(demographicsReq.account[i]);  
            UpsertAccountList.add(demographicsReq.account[i]);        
        }

        
        else{
            demographicsResp.status = 'FAIL' ;
            demographicsResp.error = 'Missing account details in request';
            System.debug('***** Missing account details in request *****');
            throw new AccountException('Missing account details in request');
        }
    }
        
        // Initialize Lists
        upsertFAList = new List <Financial_Account__c>() ;
        insertFACList = new List <Financial_Account_Customer__c>();
        updateFACList = new List <Financial_Account_Customer__c>() ;
        upsertCollateralList = new List <Collateral__c>();
        insertTitleList = new List <Title__c>();
   
        
        System.debug('***** Initializing Savepoint *****');
        Savepoint sp = Database.setSavepoint();
        
        try{
            
            extIds = new CUDExternalIDs();
            //extIds.accountNumber = account.Account_Number__c;
           //extIds.UCID = account.Universal_Customer_Id__c;
            
            
            if(UpsertAccountList.size()>0){
            upsert UpsertAccountList Account_number__c;
            System.debug('***** Upsert account completed successfully ***** '+UpsertAccountList);
        }
            
            
            if(demographicsReq.demographicsAndCollateralDetails != null){
                
                demographicsAndCollateralList = demographicsReq.demographicsAndCollateralDetails;           
                System.debug('***** Number of demographicsAndCollateralDetails records - ' + demographicsAndCollateralList.size() + '*****');
                for(Integer i=0; i<demographicsAndCollateralList.size(); i++){
                    
                    demographicsAndCollateral = demographicsAndCollateralList.get(i);       

                    System.debug('***** Operation for demographicsAndCollateralDetails record ' + i + ' - ' + demographicsAndCollateral.operation + ' *****');
                    
                    financialAccount = demographicsAndCollateral.financialAccount;
                    financialAccountCustomer = demographicsAndCollateral.financialAccountCustomer;
                    collateral = demographicsAndCollateral.collateral;
                    //ABTitle = demographicsAndCollateral.Title;
                    
                    if(collateral != null){
                        extIds.VIN = collateral.Vehicle_Identification_Number__c;
                        upsertCollateralList.add(collateral);
                        System.debug('***** Added Collateral to upsertCollateralList *****');
                    }
                    
                    if(financialAccount != null){
                        financialAccount = cleanseFinancialAccount(financialAccount);
                        extIds.financialAccountNumber = financialAccount.Financial_Account_Number__c;
						System.debug('**** extIds: '+ extIds);
						System.debug('**** financialAccount.Collateral__r.Vehicle_Identification_Number__c: '+ financialAccount.Collateral__r.Vehicle_Identification_Number__c);
                        financialAccount.Collateral__r.Vehicle_Identification_Number__c = extIds.VIN;
                        upsertFAList.add(financialAccount);
                        System.debug('***** Added FA to upsertFAList *****');
                    }
                    
                    if(financialAccountCustomer != null){                       
                        financialAccountCustomer = cleanseFinancialAccountCustomer(financialAccountCustomer);
                        extIds.facID = financialAccountCustomer.Financial_Account_Customer__c;
                        List <Financial_Account_Customer__c> existingFACList;
                        
                        System.debug('*** financialAccountCustomer: '+financialAccountCustomer);						
                        System.debug('*** financialAccountCustomer.Universal_Customer_Id__c: '+financialAccountCustomer.Universal_Customer_Id__c);
						System.debug('*** financialAccountCustomer.Customer_Role_Type__c: '+financialAccountCustomer.Customer_Role_Type__c);
						System.debug('*** financialAccountCustomer.Financial_Account__r.Financial_Account_Number__c: '+financialAccountCustomer.Financial_Account__r.Financial_Account_Number__c);
                        if(financialAccountCustomer.Universal_Customer_Id__c == null || financialAccountCustomer.Customer_Role_Type__c == null || financialAccountCustomer.Financial_Account__r.Financial_Account_Number__c ==null)
                            {
                                System.debug('***** Missing UCID or Customer Role Type or Financial Account Number *****');
                                throw new FACException('Missing UCID or Customer Role Type or Financial Account Number');
                            }
                        
                        if((demographicsAndCollateral.operation == TFSC_WS_CreateClosedDemographicsV1.operation.CREATE) )
                        {
                           
                            existingFACList = [Select Id from Financial_Account_Customer__c 
                                                where 
                                                Universal_Customer_Id__c = :financialAccountCustomer.Universal_Customer_Id__c 
                                                and 
                                                Customer_Role_Type__c = :financialAccountCustomer.Customer_Role_Type__c 
                                                and 
                                                Financial_Account__r.Financial_Account_Number__c = :financialAccountCustomer.Financial_Account__r.Financial_Account_Number__c 
                                                limit 1];       
                            }
                            
                            
                           // Check to see if the Email is Valid    
                        if(financialAccountCustomer.Marketing_Email__c != null)
                        {
                          string sEmail = financialAccountCustomer.Marketing_Email__c;
                          if(checkEmail (sEmail))
                          {
                            //Use Email
                          }
                          else {
                          
                            financialAccountCustomer.Marketing_Email__c = null;
                          }
                        }      
                            
                            
                            
                        if(existingFACList.size() == 0)
                            {
                                System.debug('***** No existing FAC record found .. Adding record to insertFACList *****');
                                insertFACList.add(financialAccountCustomer);
                                System.debug('***** Added FAC to insertFACList *****');
                            }
                         
                        else
                            {
                                System.debug('***** Found existing FAC record .. Adding record to updateFACList *****');
                                Financial_Account_Customer__c existingFAC = existingFACList.get(0);
                                financialAccountCustomer.Id = existingFAC.Id;
                                System.debug('***** Existing FAC Id - ' + existingFAC.Id + ' *****');
                                updateFACList.add(financialAccountCustomer);
                                System.debug('***** Added FAC to updateFACList *****');
                            }
                    }
                    
                    
                
                    
                }
                
                
                //Perform DML Operations

                if(upsertCollateralList.size() > 0) {
                    System.debug('***** Number of Collaterals before de-dup - ' + upsertCollateralList.size() + ' *****');                    
                    upsertCollateralList = deDuplicateCollateralList(upsertCollateralList);
                    System.debug('***** Number of Collaterals after de-dup - ' + upsertCollateralList.size() + ' *****');                    
                    upsert upsertCollateralList Vehicle_Identification_Number__c;
                    System.debug('***** Upserted Collaterals Successfully *****');                       
                }

                if(upsertFAList.size() > 0) {
                    System.debug('***** Number of FAs before de-dup - ' + upsertFAList.size() + ' *****'); 
                    upsertFAList = deDuplicateFinancialAccountList(upsertFAList);
                    System.debug('***** Number of FAs after de-dup - ' + upsertFAList.size() + ' *****');     
                    upsert upsertFAList Financial_Account_Number__c;
                    System.debug('***** Upserted Financial Accounts Successfully *****');   
                }   
                    
                if(insertFACList.size() > 0) {
                    insert insertFACList;
                    System.debug('***** Inserted Financial Account Customers Successfully *****');  
                }
                
                
                    
                if(updateFACList.size() > 0) {
                    update updateFACList;
                    System.debug('***** Updated Financial Account Customers Successfully *****');   
                }
            }
            if(demographicsReq.Title != null){
				for(Integer i=0; i<demographicsReq.Title.size(); i++){
        			system.debug('**** Detail of Title: '+demographicsReq.Title);
        			insertTitleList.add(demographicsReq.Title[i]);        
        		}				
			}


                   if(insertTitleList.size() >0){
                       
                   Upsert insertTitleList Legacy_Id__c;
                   System.debug('***** Added Title to SFDC *****');
                    }
                    // Reset External Ids
                    extIds.financialAccountNumber = null;
                    extIds.facID = null;
                    extIds.VIN = null;

                    

        }
        
        catch(Exception e){
            
            status = 'FAIL';
            System.debug('***** Exception Occured - ' + e + ' *****');
            error = e.getTypeName() + ': ' + e.getMessage();
            
            demographicsResp.status = status ;
            demographicsResp.error = error;
        
            Database.rollback(sp);
            System.debug('***** Transaction Rolled Back - *****');
            return demographicsResp;

        }
        

        demographicsResp.status = status ;
        demographicsResp.error = error;
        return demographicsResp;
    }
    
    public static String getOperation(TFSC_WS_CreateClosedDemographicsV1.operation operation){
        
        String operationString;
        if(operation == TFSC_WS_CreateClosedDemographicsV1.operation.CREATE)
            operationString = 'CREATE';
       
            
        return operationString;
    }
    
    public static Financial_Account__c cleanseFinancialAccount(Financial_Account__c reqFA){
        
        Financial_Account__c financialAccount = reqFA;
        reqFA.Id = null;
        return financialAccount;
    }
    
    public static Financial_Account_Customer__c cleanseFinancialAccountCustomer(Financial_Account_Customer__c reqFAC){
        
        Financial_Account_Customer__c financialAccountCustomer = reqFAC;
        reqFAC.Id = null;
        return financialAccountCustomer;
    }
    
    public static Collateral__c cleanseCollateral(Collateral__c reqCollateral){
        
        Collateral__c collateral = reqCollateral;
        reqCollateral.Id = null;
        return collateral;
    }
    
    
        
    public static List <Collateral__c> deDuplicateCollateralList(List <Collateral__c> collateralList)
    {
        Map<String, Collateral__c> collateralMap = new Map<String, Collateral__c>();            
        for(Collateral__c collateral : collateralList)
            {
                collateralMap.put(collateral.Vehicle_Identification_Number__c, collateral);
             }

        List <Collateral__c> uniqueCollateralList = collateralMap.values(); 
        return uniqueCollateralList;
    } 
    
    
    
    
    
    public static List <Financial_Account__c> deDuplicateFinancialAccountList(List <Financial_Account__c> FAList)
    {
        Map<String, Financial_Account__c> FAMap = new Map<String, Financial_Account__c>();            
        for(Financial_Account__c FA : FAList)
            {
                FAMap.put(FA.Financial_Account_Number__c, FA);
             }

        List <Financial_Account__c> uniqueFAList = FAMap.values(); 
        return uniqueFAList;
    } 
    
    
     public static Boolean  checkEmail(String semail)
    {
       String InputString = semail;
       String emailRegex ='([a-zA-Z0-9_\\-\\.]+)@((\\[a-z]{1,3}\\.[a-z]{1,3}\\.[a-z]{1,3}\\.)|(([a-zA-Z0-9\\-]+\\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})';
       Pattern MyPattern = Pattern.compile(emailRegex);
       Matcher MyMatcher =  MyPattern.matcher(InputString);
       
       if(!MyMatcher.matches()||semail.startsWith('.'))
       {
         //invalid email
         return False;
       }
       else
       {
        //valid email
        return TRUE;
       }
    }// end checkEmail
    
    

}