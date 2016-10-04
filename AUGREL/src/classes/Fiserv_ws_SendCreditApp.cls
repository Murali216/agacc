/**
    * Fiserv_ws_SendCreditApp - Sends a SOAP outbound message to process a created App
    * Used as a plugin for: Refinance Pitch Eligibility - Auto Loyalty
    * @author: Clayton Bruckert
    * @version: 1.0
*/

public with sharing class Fiserv_ws_SendCreditApp{
    
    
    public static string CreditApplication(String FANumber, String CaseId, boolean Consent, boolean PrConsent){
        String result = '';
        
        if(FANumber != null){
            list<Financial_Account_Customer__c> FACs = [
                            SELECT 
                                Customer_Role_Type__c,
                                Financial_Account_Number__c,
                                account__r.firstname,
                                account__r.lastname,
                                account__r.Middle_Name__pc,
                                account__r.Name_Suffix__pc,
                                account__r.IsPersonAccount,
                                Home_Phone_Garage__c,
                                financial_account__r.collateral__R.Model_Name__c,
                                financial_account__r.collateral__R.Model_Year__c,
                                financial_account__r.collateral__R.Make__c,
                                financial_account__r.collateral__R.Body_Style__c,
                                financial_account__r.Dealership__r.name,
                                financial_account__r.Dealer_Code__c,
                                financial_account__r.Dealership__r.BillingState,
                                financial_account__r.Payoff_Amount_Net__c
                            FROM Financial_Account_Customer__c 
                            WHERE Financial_Account_Number__c =: FANumber];
            System.debug('*** Number of FACs returned: '+FACs.size());
           
           Financial_account_customer__c FACp = new Financial_account_customer__c() ;
           Financial_account_customer__c FACc = new Financial_account_customer__c() ;
           FACc= null;
         //Sort Primary and co-applicant in different list 
           for(Financial_Account_Customer__c ThisFACall: FACS)
           {
               if(ThisFACall.Customer_Role_Type__c == '0-Primary Borrower')
               {
                   FACp = ThisFACall;
               }
               if(ThisFACall.Customer_Role_Type__c == '6-Co-Borrower')
               {
                   FACc=ThisFACall;
               }
           
           }
       
            //for(Financial_Account_Customer__c ThisFAC: FACs){
               if(FACp!= null)
               {
                String SendResult = '';
                SendResult = SendReq(FACp,FACc, CaseID, Consent,PrConsent);
                if(SendResult==''){
                    result = 'Failed to Send Request';
                }else{
                    result = SendResult;
                }
                }else if(FACc!= null)
                {
                String SendResult = '';
                SendResult = SendReq(FACc,FACp, CaseID, Consent,PrConsent);
                if(SendResult==''){
                    result = 'Failed to Send Request';
                }else{
                    result = SendResult;
                }
                }
            //}       
        }
        
        return result;
        
    }
    
    private static String SendReq(Financial_Account_Customer__c FAC,Financial_Account_Customer__c FACc, String CaseID, boolean Consent, boolean PrConsent){
                
        String username;
        String password;
        String authCred;
        Fiserv_ProcessCreditApplication.ProcessCreditApplication stub = new Fiserv_ProcessCreditApplication.ProcessCreditApplication();
        Map<String,String> inputHttpHeaders_x = new Map<String,String>();
        /*stub.clientCertName_x = System.UserInfo.getOrganizationId();
        stub.clientCertPasswd_x = stub.clientCertName_x;*/
        stub.timeout_x = 50000;
        
        Blob authCredBlob = Blob.valueOf(System.UserInfo.getOrganizationId() + ':' + System.UserInfo.getOrganizationId());
        authCred = EncodingUtil.base64Encode(authCredBlob);
        inputHttpHeaders_x.put('Authorization', 'Basic '+authCred);
        stub.inputHttpHeaders_x = inputHttpHeaders_x;
        
        Fiserv_ResultBOD.ResultBODType result = new Fiserv_ResultBOD.ResultBODType();
        try 
            {
                Fiserv_ServiceApplicationArea.ServiceApplicationAreaType SA = BuildServiceAppArea(CaseID);
                Fiserv_SubmitCreditAppReqSync.ApplicationArea_element AA = BuildStarAppArea();
                Fiserv_SubmitCreditAppReqSync.DataArea_element DA = BuildStarDataArea(FAC,FACc, CaseId, Consent,PrConsent);
                
                System.debug('*** DA: ' + DA);
                result = stub.SubmitApp(SA, AA, DA);            
                System.debug('*** ResultCode: ' + result.ResultCode);               
                System.debug('*** ResultDesc: ' + result.ResultDesc);               
                System.debug('*** ResultString: ' + result.ResultString);               
            }
            catch (System.CalloutException ex)
            {
                System.debug('*** Error invoking Feserv WS: ' + ex);
                System.debug('*** ResultCode: ' + result.ResultCode);               
                System.debug('*** ResultDesc: ' + result.ResultDesc);               
                System.debug('*** ResultString: ' + result.ResultString);
                
                System_Message__c LogError = new System_Message__c();
                LogError.Type__c = 'Handle Error';
                LogError.Title__c = 'Fiserv WS Call Out';
                LogError.Description__c = 'FA Id:'+FAC.Id +' Description: '+ result.ResultCode + result.ResultDesc + ': ' + result.ResultString ;
                LogError.Notify_User__c = false;
                
                insert LogError;                
            }
            return result.ResultDesc;
    }
    // this method had been made redundant
    /*
    private static Fiserv_SubmitCreditAppReqSync.ProcessCreditApplicationReq_element BuildProcessService(Financial_Account_Customer__c FAC, String CaseID){
        Fiserv_SubmitCreditAppReqSync.ProcessCreditApplicationReq_element ProcessService = new Fiserv_SubmitCreditAppReqSync.ProcessCreditApplicationReq_element();
        
        ProcessService.ServiceApplicationArea = BuildServiceAppArea(CaseID);
        //ProcessService.ProcessCreditApplication = BuildProcessCreditApplication(FAC);
        //ProcessService.ProcessApplicationExtension = BuildProcessAppExtension();
        
        return ProcessService;
    }
    */
    private static Fiserv_ServiceApplicationArea.ServiceApplicationAreaType BuildServiceAppArea(String CaseId){
        Fiserv_ServiceApplicationArea.ServiceApplicationAreaType result = new Fiserv_ServiceApplicationArea.ServiceApplicationAreaType();
        
        result.ConversationID = CaseId;
        result.MessageType='TSBCreditApplicationRequest';
        result.Mode='Synchronous';
        result.SenderID='TSB';
        Datetime CurrentTime = Datetime.now();
        System.debug('*** Current Time is: '+CurrentTime);
        result.SentTimeStamp=CurrentTime;
        result.ServiceType='ProcessCreditApplication';
        result.TargetID='E4QAC';
        result.VersionNo=1.0;
        
        return result;      
    }
    // this method had been made redundant
    /*
    private static Fiserv_SubmitCreditAppReqSync.ProcessCreditApplication BuildProcessCreditApplication(Financial_Account_Customer__c FAC){
        Fiserv_SubmitCreditAppReqSync.ProcessCreditApplication result = new Fiserv_SubmitCreditAppReqSync.ProcessCreditApplication();
        
        result.ApplicationArea = BuildStarAppArea();
        result.DataArea = BuildStarDataArea(FAC);
        
        return result;
    }
    */
    private static Fiserv_SubmitCreditAppReqSync.ApplicationArea_element BuildStarAppArea(){
        Fiserv_SubmitCreditAppReqSync.ApplicationArea_element result = new Fiserv_SubmitCreditAppReqSync.ApplicationArea_element();
        
        Fiserv_SubmitCreditAppReqSync.Sender_element Star_AA_Sender = new Fiserv_SubmitCreditAppReqSync.Sender_element();
        Star_AA_Sender.LogicalId='www.TFS.com';
        Star_AA_Sender.Component='SALESFORCE / TFS TIBCO';
        Star_AA_Sender.Task='UnderwritingCreditApplication';
        Star_AA_Sender.CreatorNameCode='TSB';
        Star_AA_Sender.SenderNameCode='TSB';
        Star_AA_Sender.Language='en-US';        
        result.Sender = Star_AA_Sender;
        //
        System.debug('*** Datetime that is being passed: '+Datetime.now().format('yyyy-MM-dd\'T\'hh:mm:ss\'Z\''));
        result.CreationDateTime = Datetime.now().format('yyyy-MM-dd\'T\'hh:mm:ss\'Z\'');
        result.BODId='1234567890';
        //
        Fiserv_SubmitCreditAppReqSync.Destination_element Star_AA_Destination = new Fiserv_SubmitCreditAppReqSync.Destination_element();
        Star_AA_Destination.DestinationNameCode='TSB';
        result.Destination = Star_AA_Destination;
        
        return result;
    }
    private static Fiserv_SubmitCreditAppReqSync.DataArea_element BuildStarDataArea(Financial_Account_Customer__c FAC,Financial_Account_Customer__c FACc, String CaseId, boolean Consent, boolean PrConsent){
        Fiserv_SubmitCreditAppReqSync.DataArea_element result = new Fiserv_SubmitCreditAppReqSync.DataArea_element();
        
        // Process
        Fiserv_SubmitCreditAppReqSync.Process_element Star_DA_Process = new Fiserv_SubmitCreditAppReqSync.Process_element();
        result.Process = Star_DA_Process;
        result.CreditApplication = BuildStar(FAC,FACc, CaseId, Consent,PrConsent);
        
        return result;
        
    }
    private static Fiserv_SubmitCreditAppReqSync.CreditApplication_element BuildStar(Financial_Account_Customer__c FAC, Financial_Account_Customer__c FACc, String CaseId, Boolean Consent, Boolean PrConsent){
        Fiserv_SubmitCreditAppReqSync.CreditApplication_element result = new Fiserv_SubmitCreditAppReqSync.CreditApplication_element();
        
        result.Header = BuildStarHeader(FAC, CaseId);
        result.Detail = BuildStarDetail(FAC,FACc, Consent,PrConsent);
        result.ProcessApplicationExtension = BuildProcessAppExtension(FAC);
        
        return result;
    }
    private static Fiserv_SubmitCreditAppReqSync.Header_element BuildStarHeader(Financial_Account_Customer__c FAC, String CaseId){
        Fiserv_SubmitCreditAppReqSync.Header_element result = new Fiserv_SubmitCreditAppReqSync.Header_element();
        
        //
        Fiserv_SubmitCreditAppReqSync.Dealer_element Star_DA_CA_Dealer = new Fiserv_SubmitCreditAppReqSync.Dealer_element();
        //if(FAC.financial_account__r.collateral__R.Make__c.toUpperCase() == 'LEXUS'){
        if(FAC.financial_account__r.Dealer_code__c.left(1) == '6'  || (FAC.financial_account__r.Dealership__r.BillingState =='GA' || 
        FAC.financial_account__r.Dealership__r.BillingState =='FL' || FAC.financial_account__r.Dealership__r.BillingState =='SC' || 
        FAC.financial_account__r.Dealership__r.BillingState =='NC' || FAC.financial_account__r.Dealership__r.BillingState =='AL')){
            Star_DA_CA_Dealer.PartyId = '0000000002';
            Star_DA_CA_Dealer.OrganizationId = '0000000002';
        }else{
            Star_DA_CA_Dealer.PartyId = '0000000001';
            Star_DA_CA_Dealer.OrganizationId = '0000000001';
        }
        //
        Fiserv_SubmitCreditAppReqSync.FinanceCompany_element FinCo = new Fiserv_SubmitCreditAppReqSync.FinanceCompany_element();
        FinCo.PartyId = 'TSB';
        //
        result.Dealer = Star_DA_CA_Dealer;
        result.FinanceCompany = FinCo; 
        result.DocumentDateTime = Datetime.now();
        result.ApplicationStatus = 'P';
        result.DocumentId = CaseId;
        
        return result;
    }
    private static Fiserv_SubmitCreditAppReqSync.Detail_element BuildStarDetail(Financial_Account_Customer__c FAC,Financial_Account_Customer__c FACc, boolean Consent, boolean PrConsent){
        Fiserv_SubmitCreditAppReqSync.Detail_element result = new Fiserv_SubmitCreditAppReqSync.Detail_element();
        
        result.CreditVehicle = BuildStarCreditVehicle(FAC);
        if(FAC.Customer_Role_Type__c == '0-Primary Borrower'){
            result.IndividualApplicant = BuildStarApplicant(FAC, PrConsent);
            if(FACc!= null)
            {
            result.Co_Applicant = BuildStarCoApplicant(FACc, false, Consent); 
            }else{
            result.Co_Applicant = BuildStarCoApplicant(FACc, true, Consent); 
            }
        }else if(FAC.Customer_Role_Type__c == '6-Co-Borrower'){
            result.Co_Applicant = BuildStarCoApplicant(FAC, false, Consent);        
            result.IndividualApplicant = BuildStarApplicant(FAC, PrConsent);
        }
        result.Financing = BuildStarFin(FAC);
        
        return result;
    }
    private static Fiserv_SubmitCreditAppReqSync.CreditVehicle_element BuildStarCreditVehicle(Financial_Account_Customer__c FAC){
        Fiserv_SubmitCreditAppReqSync.CreditVehicle_element result = new Fiserv_SubmitCreditAppReqSync.CreditVehicle_element();
        
        result.Model = FAC.financial_account__r.collateral__R.Model_Name__c;
        result.ModelYear = FAC.financial_account__r.collateral__R.Model_Year__c;
        result.Make = FAC.financial_account__r.collateral__R.Make__c;
        result.SaleClass = 'Used';
        result.BodyStyle = FAC.financial_account__r.collateral__R.Body_Style__c;
        
        return result;
    }
    private static Fiserv_SubmitCreditAppReqSync.IndividualApplicant_element BuildStarApplicant(Financial_Account_Customer__c FAC, Boolean UseDefault){
        Fiserv_SubmitCreditAppReqSync.IndividualApplicant_element result = new Fiserv_SubmitCreditAppReqSync.IndividualApplicant_element();
        //
        LIST<Fiserv_SubmitCreditAppReqSync.Address_element> Addresses = new LIST<Fiserv_SubmitCreditAppReqSync.Address_element>();
        Addresses.add(BuildAddress(FAC, UseDefault));
        //
        Fiserv_SubmitCreditAppReqSync.AlternatePartyIds_element ThisAPI = new Fiserv_SubmitCreditAppReqSync.AlternatePartyIds_element();
        ThisAPI.AssigningPartyId = 'NationalId';
        ThisAPI.Id = '1'; 
        //
        String RequestMode;
        if(UseDefault){
            RequestMode = '';
        }else{
            RequestMode = 'No Consent';
        }
        //
        result.PartyId = '1';
        result.AlternatePartyIds = ThisAPI;
        result.PersonName = BuildPersonName(FAC, RequestMode);
        result.Address = Addresses;
        result.Contact = BuildContact(FAC, UseDefault);
        result.Employer = BuildEmployer(FAC, UseDefault);
        
        return result;
    }
    private static Fiserv_SubmitCreditAppReqSync.Co_Applicant_element BuildStarCoApplicant(Financial_Account_Customer__c FAC, Boolean UseDefault, Boolean Consent){
        Fiserv_SubmitCreditAppReqSync.Co_Applicant_element result = new Fiserv_SubmitCreditAppReqSync.Co_Applicant_element();
        
        Fiserv_SubmitCreditAppReqSync.AlternatePartyIds_element ThisAPI = new Fiserv_SubmitCreditAppReqSync.AlternatePartyIds_element();
        ThisAPI.AssigningPartyId = 'NationalId';
        ThisAPI.Id = '1'; 
        //
        result.PartyId = '1';
        result.AlternatePartyIds = ThisAPI;
        String RequestMode;
        if(Consent){
            RequestMode = '';
        } else {
            if(UseDefault){
                RequestMode = 'Default';
            }else{
                RequestMode = 'No Consent';
            }
        }
        result.PersonName = BuildPersonName(FAC, RequestMode);
        result.Address = BuildAddress(FAC, Consent);
        result.Contact = BuildContact(FAC, Consent);
        result.Employer = BuildEmployer(FAC, UseDefault);
        
        return result;
    }
    private static Fiserv_SubmitCreditAppReqSync.Financing_element BuildStarFin(Financial_Account_Customer__c FAC){
        Fiserv_SubmitCreditAppReqSync.Financing_element result = new Fiserv_SubmitCreditAppReqSync.Financing_element();
        
        //
        Double UseAmount = 0;
        if(FAC.financial_account__r.Payoff_Amount_Net__c != null){
            UseAmount=FAC.financial_account__r.Payoff_Amount_Net__c;
        }
        //
        result.FinanceType = '1';
        result.currency_x = 1;
        result.PaymentAmount = 0;
        result.FinalAmount = UseAmount;
        result.NetAmountFinanced = UseAmount;
        result.length = 48;
        
        return result;
    }
    private static Fiserv_SubmitCreditAppReqSync.PersonName_element BuildPersonName(Financial_Account_Customer__c FAC, String RequestMode){
        Fiserv_SubmitCreditAppReqSync.PersonName_element result = new Fiserv_SubmitCreditAppReqSync.PersonName_element();
        
        if(RequestMode == 'Default'){
            result.GivenName = 'NA';
            result.FamilyName = 'NA';   
        } else if(RequestMode == 'No Consent'){
            result.GivenName = 'YES';
            result.FamilyName = 'YES';
        }else{
            result.GivenName = FAC.account__r.firstname;
            result.MiddleName = FAC.account__r.Middle_Name__pc;
            result.FamilyName = FAC.account__r.lastname;
            if(FAC.account__r.Name_Suffix__pc != null){result.Suffix = FAC.account__r.Name_Suffix__pc.toUpperCase();}
        }
        
        return result;
    }
    private static Fiserv_SubmitCreditAppReqSync.Address_element BuildAddress(Financial_Account_Customer__c FAC, Boolean UseDefault){
        Fiserv_SubmitCreditAppReqSync.Address_element result = new Fiserv_SubmitCreditAppReqSync.Address_element();
        
        if(UseDefault){
            result.qualifier = 'HomeAddress';
            result.AddressLine = '';
            result.City = 'None';
            result.StateOrProvince = '';
            result.Country = 'US';
            result.PostalCode = '';
            
                     
        }else{
            result.qualifier = 'HomeAddress';
            result.City = 'None';
            result.Country = 'US';             
        }
        
        return result;
    }
    private static LIST<Fiserv_SubmitCreditAppReqSync.Contact_element> BuildContact(Financial_Account_Customer__c FAC, Boolean UseDefault){
        LIST<Fiserv_SubmitCreditAppReqSync.Contact_element> result = new LIST<Fiserv_SubmitCreditAppReqSync.Contact_element>();
        
        Fiserv_SubmitCreditAppReqSync.Contact_element ThisContact = new Fiserv_SubmitCreditAppReqSync.Contact_element();
        ThisContact.Telephone = BuildTelephone(FAC, UseDefault);
        result.add(ThisContact);
        
        return result;
    }
    private static Fiserv_SubmitCreditAppReqSync.Employer_element BuildEmployer(Financial_Account_Customer__c FAC, Boolean UseDefault){
        Fiserv_SubmitCreditAppReqSync.Employer_element result = new Fiserv_SubmitCreditAppReqSync.Employer_element();
        //income
        Fiserv_SubmitCreditAppReqSync.Income_element ThisIncome = new Fiserv_SubmitCreditAppReqSync.Income_element();
        ThisIncome.currency_x = 'USD';
        ThisIncome.period = 'YR';
        ThisIncome.income = 100;
        //
        result.Income = ThisIncome;
        result.Occupation = 'Not Supplied';
        result.EmploymentCode = 'Current';
        
        return result;
    }
    
    private static Fiserv_SubmitCreditAppReqSync.Telephone_element BuildTelephone(Financial_Account_Customer__c FAC, Boolean UseDefault){
        Fiserv_SubmitCreditAppReqSync.Telephone_element result = new Fiserv_SubmitCreditAppReqSync.Telephone_element();
        
        if(UseDefault){
            result.desc_x = 'Day Phone';
            result.exten = 'String';
            result.number_x = FAC.Home_Phone_Garage__c; 
            
        }else{
            result.desc_x = 'Day Phone';
            result.exten = 'String';
            result.number_x = 'NA';        
        }
        
        return result;
    }
    private static Fiserv_ProcessApplicationExtension.ProcessApplicationExtension_element BuildProcessAppExtension(Financial_Account_Customer__c FAC){
        Fiserv_ProcessApplicationExtension.ProcessApplicationExtension_element result = new Fiserv_ProcessApplicationExtension.ProcessApplicationExtension_element();
        
        result.Loan = BuildPAELoan(FAC);
        List<String> DealerNames = new List<String>();
        DealerNames.add(FAC.financial_account__r.Dealership__r.name);
        result.Entity = BuildPAEEntityList(DealerNames);
        
        return result;
    }
    private static Fiserv_ProcessApplicationExtension.Loan_element BuildPAELoan(Financial_Account_Customer__c FAC){
        Fiserv_ProcessApplicationExtension.Loan_element result = new Fiserv_ProcessApplicationExtension.Loan_element();
        
        Fiserv_ProcessApplicationExtension.LoanApplication_element PAE_Loan_App = new Fiserv_ProcessApplicationExtension.LoanApplication_element();
        PAE_Loan_App.LoanPurpCd = '2';
        PAE_Loan_App.IntPayFrequencyCd = '5';
        //if(FAC.financial_account__r.collateral__R.Make__c.toUpperCase() == 'LEXUS'){
         if(FAC.financial_account__r.Dealer_code__c.left(1) == '6' || (FAC.financial_account__r.Dealership__r.BillingState =='GA' || 
        FAC.financial_account__r.Dealership__r.BillingState =='FL' || FAC.financial_account__r.Dealership__r.BillingState =='SC' || 
        FAC.financial_account__r.Dealership__r.BillingState =='NC' || FAC.financial_account__r.Dealership__r.BillingState =='AL')){
            PAE_Loan_App.ProductCd = '111';
        }else {
            PAE_Loan_App.ProductCd = '110';
        }
        PAE_Loan_App.LoanOrigIdentifier = '5';
        PAE_Loan_App.ExistingLien = 0;
        Fiserv_ProcessApplicationExtension.LoanProduct_element PAE_Loan_Prod = new Fiserv_ProcessApplicationExtension.LoanProduct_element();
        PAE_Loan_Prod.CoreProductCd = '5';
        //
        result.LoanApplication = PAE_Loan_App;
        result.LoanProduct = PAE_Loan_Prod;
        
        return result;
    }
    private static List<Fiserv_ProcessApplicationExtension.Entity_element> BuildPAEEntityList(List<String> DealerNames){
        List<Fiserv_ProcessApplicationExtension.Entity_element> result = new List<Fiserv_ProcessApplicationExtension.Entity_element>();
        
        for(String Dealer: DealerNames){
            Fiserv_ProcessApplicationExtension.Entity_element ThisEntity = new Fiserv_ProcessApplicationExtension.Entity_element();
            ThisEntity.OriginalDealerName = Dealer;
            result.add(ThisEntity);
        }
        
        return result;
    }
}