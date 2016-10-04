/**
    * Tibco Closed Account Service - Sends a SOAP outbound message to process a created App
    * Used to call Tibco so that they can create FA in Salesforce
    * @author: Abhishek Ballabh
    * @version: 1.0
*/

Global with sharing class Tibco_ws_SendFARequest{
    
    
    Webservice static string SendRequest(String FANumber, Datetime AccountCloseDate, String Branch, String Accounttype){
        String result = '';
        
        
        /*
        if(FANumber != null){
            list<Financial_Account__c> FAs = [
                            SELECT 
                                Id
                            FROM Financial_Account__c 
                            WHERE Financial_Account_Number__c =: FANumber];
                            
               System.Debug('FAs'+FAs);
               
               //If(FAs.size() == 0)
          */
               If(1 == 1)
               
               {
           
               System.debug('Entered the loop to send request');
                String SendResult = '';
                SendResult = SendReq(FANumber, AccountCloseDate,  Branch,  Accounttype );
                if(SendResult==''){
                    result = 'Failed to Send Request';
                }else{
                    result = SendResult;
                }
                
                }else {
                    result='FA Exists';
                }
             //}
        
        return result;
        
    }
    
    private static String SendReq( String FANumber, Datetime AccountCloseDate, String Branch, String Accounttype){
                
        String username;
        String password;
        String authCred;
        String FinalResult;
        WS_ClosedAccountLookupImpl.ReceiveClosedAccountLookupRequest stub = new WS_ClosedAccountLookupImpl.ReceiveClosedAccountLookupRequest();
        Map<String,String> inputHttpHeaders_x = new Map<String,String>();
        stub.timeout_x = 50000;
        
        Blob authCredBlob = Blob.valueOf(System.UserInfo.getOrganizationId() + ':' + System.UserInfo.getOrganizationId());
        authCred = EncodingUtil.base64Encode(authCredBlob);
        inputHttpHeaders_x.put('Authorization', 'Basic '+authCred);
        stub.inputHttpHeaders_x = inputHttpHeaders_x;
        
        WS_ClosedFinancialAccountResSync.ProcessService_element result = new WS_ClosedFinancialAccountResSync.ProcessService_element();
        try 
            {
                
                WS_ClosedFinancialAccountReqSync.ProcessService_element PS = BuildProcesselement(FANumber,AccountCloseDate,Branch, Accounttype);
                System.debug('*** Sending request:' + PS);
                result = stub.ClosedAccountLookup(PS);            
                System.debug('*** Result Code: ' + result.ClosedFinancialAccountResBOD.ResultBOD.ResultCode);  
                System.debug('*** Result Desc: ' + result.ClosedFinancialAccountResBOD.ResultBOD.ResultDesc);      
                System.debug('*** Result BOD: ' + result.ClosedFinancialAccountResBOD.ResultBOD); 
                FinalResult= result.ClosedFinancialAccountResBOD.ResultBOD.ResultDesc;         
                              
                         
            }
            catch (System.CalloutException ex)
            {
                System.debug('*** Error invoking Closed Account WS: ' + ex);
               
                System_Message__c LogError = new System_Message__c();
                LogError.Type__c = 'Handle Error';
                LogError.Title__c = 'Fiserv WS Call Out';
                LogError.Notify_User__c = false;
                finalResult = 'Exception Received';
                
                insert LogError;                
            }
            //return result.ClosedFinancialAccountResBOD.ResultBOD.ResultDesc;
            return FinalResult;
    }
    
    private static WS_ServiceApplicationArea.ServiceApplicationAreaType BuildServiceAppArea(String FANumber){
        WS_ServiceApplicationArea.ServiceApplicationAreaType result = new WS_ServiceApplicationArea.ServiceApplicationAreaType();
        
        result.ConversationID = '123ABCD';
        result.MessageType='REQ';
        result.Mode='Synchronous';
        result.SenderID='SFDC';
        Datetime CurrentTime = Datetime.now();
        System.debug('*** Current Time is: '+CurrentTime);
        result.SentTimeStamp=CurrentTime;
        result.ServiceType='ProcessCreditApplication';
        result.TargetID='SFDC';
        result.VersionNo=12.0;
        
        return result;      
    }
    
    private static WS_ClosedFinancialAccountReqSync.ClosedFinancialAccountReqBODType BuildClosedAccount(String FANumber, Datetime AccountCloseDate, String Branch, String Accounttype){
        WS_ClosedFinancialAccountReqSync.ClosedFinancialAccountReqBODType result = new WS_ClosedFinancialAccountReqSync.ClosedFinancialAccountReqBODType();
       
        result.ClosedFinancialAccountNumber = FaNumber;
        result.AccountClosedDate=AccountCloseDate;
        result.Branch=Branch;
        result.AccountType=Accounttype;
        
        return result;      
    }
    //Create the XML tags ProcessServiceElement
     private static WS_ClosedFinancialAccountReqSync.ProcessService_element BuildProcesselement(String FANumber, Datetime AccountCloseDate, String Branch, String Accounttype){
        WS_ClosedFinancialAccountReqSync.ProcessService_element result = new WS_ClosedFinancialAccountReqSync.ProcessService_element();
        WS_ServiceApplicationArea.ServiceApplicationAreaType SA = BuildServiceAppArea(FANumber);
        WS_ClosedFinancialAccountReqSync.ClosedFinancialAccountReqBODType CA = BuildClosedAccount(FANumber,AccountCloseDate,Branch, Accounttype);
        result.serviceapplicationarea=SA;
        result.ClosedFinancialAccountReqBOD=CA;
        return result;      
    }
    
    
  
    
    
}