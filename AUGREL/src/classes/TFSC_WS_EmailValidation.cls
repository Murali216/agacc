public class TFSC_WS_EmailValidation {
    
        /*Description: This Class is constructing the Request structure for Request wrapper from wsdl generated class,
    which will be sent in the callout.*/    
    public class EmailValidation_RequestParams{
        public String Email;
    }
    
        /*Description: This class is declaring Status and ErrorCode, which are set in this class 
    StatusDescriptionService, StatusNbrService and ResultCode will be getting from response.*/  
    public class EmailValidation_StatusParams{
        public Integer ServiceStatusNbr{get;set;} 
        public String ServiceStatusDescription{get;set;} 
        public Integer ResultCode {get;set;}
        public String Status{get;set;} // SUCCESS or FAIL
        public String error{get;set;}
        
    }
    
            public class EmailValidation_ResponseValues{
            public Integer reasonCode{get;set;}
            public string reasonDescription{get;set;}
        public String HygieneResult{get;set;} // SUCCESS or FAIL
        public boolean NetProtected{get;set;} // Populated only if Status = FAIL 
            public String NetProtectedBy{get;set;}
            public String SourceIdentifier{get;set;}
              public String Email{get;set;}
            public String LocalPart{get;set;}
            public string DomainPart{get;set;}    
        public String DomainKnowledge {get;set;}
        public String AddressKnowledge {get;set;}
                public datetime IronStdTimeStamp {get;set;}
    }
    
        /*Description: This class with constructer holds the status and the response values in a list. */   
    public class EmailValidation_ResponseParams{
        
                public EmailValidation_ResponseValues responseValues {get;set;}
        public EmailValidation_StatusParams StatusParams {get;set;}
        public  EmailValidation_ResponseParams(){
            this.statusParams = new EmailValidation_StatusParams();
            this.responseValues = new EmailValidation_ResponseValues();
            
    }

    }
        
    Private Static TFSC_WS_EmailValidationtReqSync.EmailValidationReqSync_element ConstructRequest(EmailValidation_RequestParams request_Params)
    {
        TFSC_WS_EmailValidationtReqSync.EmailValidationReqSync_element RequestDoc = new TFSC_WS_EmailValidationtReqSync.EmailValidationReqSync_element();
        RequestDoc.ProcessService = New TFSC_WS_EmailValidationtReqSync.ProcessService_element();
         RequestDoc.ProcessService.ServiceApplicationArea = New  TFSC_WS_EmailServiceApplicationArea.ServiceApplicationAreaType();
        RequestDoc.ProcessService.EmailValidationReqBOD = New TFSC_WS_EmailValidationtReqSync.EmailValidationReqBODType();
        RequestDoc.ProcessService.EmailValidationReqBOD.VerifyEmail = new TFSC_WS_EmailValidationtReqSync.VerifyEmailType();
        
        
        requestDoc.ProcessService.ServiceApplicationArea.ConversationID = TFSC_Utils.getGUID();
        requestDoc.ProcessService.ServiceApplicationArea.MessageType = 'REQ';
        requestDoc.ProcessService.ServiceApplicationArea.Mode = null;
        requestDoc.ProcessService.ServiceApplicationArea.RefToSequenceNo = null;
        requestDoc.ProcessService.ServiceApplicationArea.SenderID = null;
        requestDoc.ProcessService.ServiceApplicationArea.SentTimeStamp = Datetime.valueOf(datetime.now());
        requestDoc.ProcessService.ServiceApplicationArea.SequenceNo = null;
        requestDoc.ProcessService.ServiceApplicationArea.ServiceType = null;
        requestDoc.ProcessService.ServiceApplicationArea.TargetID = null;
        requestDoc.ProcessService.ServiceApplicationArea.VersionNo = null;   
        
        
        RequestDoc.ProcessService.EmailValidationReqBOD.VerifyEmail.EmailAddress = request_Params.Email;
         RequestDoc.ProcessService.EmailValidationReqBOD.VerifyEmail.Timeout = 10;    
         
        return RequestDoc;
    }
    
    Public Static  EmailValidation_ResponseParams ValidateEmail(EmailValidation_RequestParams EmailValidation_RequestParams)
    {
        
        system.debug('****EmailValidation_RequestParams: '+EmailValidation_RequestParams);
        TFSC_WS_EmailValidationtReqSync.EmailValidationReqSync_element requestDoc = ConstructRequest(EmailValidation_RequestParams);
        
        EmailValidation_ResponseParams response = new EmailValidation_ResponseParams();
        TFSC_WS_EmailValidationResSync.ProcessService_element ResponseDoc = New TFSC_WS_EmailValidationResSync.ProcessService_element() ;
        TFSC_WS_EmailValidationImpl.ReceiveEmailValidationRequest request =New TFSC_WS_EmailValidationImpl.ReceiveEmailValidationRequest();
        request = setEndPointURL(request);
        request = setAuthDetails(request);
       
        
                try{
        
            //Invoke service
            System.debug('*Before Web Service call *');
            responseDoc  = Request.EmailValidation(requestDoc.ProcessService);
            System.debug('*Web Service Invoked Successfully *');
            System.debug('*Web Service Response *:' + responseDoc);

            //Parse Response
            //response = parseResponse(responseDoc);
            response = parseResponse(responseDoc);
            System.debug('***** Parsed Response Successfully *****');
        }
        catch(exception e){

            System.debug('***** Exception Occured - ' + e + ' *****');
            
            system.debug('*Exception type caught*:'+e.getTypeName());
            system.debug('*Exception message*:'+e.getMessage());
        }
        System.debug('***** Parsed Response  *****' + response);
        return response;
    }
        private static TFSC_WS_EmailValidationImpl.ReceiveEmailValidationRequest setAuthDetails(
    TFSC_WS_EmailValidationImpl.ReceiveEmailValidationRequest stub) {        
        String username;
        String password;
        String authCred;
        Map<String,String> inputHttpHeaders_x = new Map<String,String>();
        stub.inputHttpHeaders_x = inputHttpHeaders_x;
        username = System.UserInfo.getOrganizationId();
        password = username;      
        System.debug(username + ':' + password);
        Blob authCredBlob = Blob.valueOf(username + ':' + password);
        authCred = EncodingUtil.base64Encode(authCredBlob);
        stub.inputHttpHeaders_x.put('Authorization', 'Basic '+authCred);
        return stub;    
    }
    
        private static TFSC_WS_EmailValidationImpl.ReceiveEmailValidationRequest setEndPointURL(TFSC_WS_EmailValidationImpl.ReceiveEmailValidationRequest stub){
        
        //stub.endpoint_x = https://intsvcs-test1.services.toyotafinancial.com/phonenumbervalidation
        stub.endpoint_x = Label.email_validation_EndPoint;
        //stub.endpoint_x = 'https://intsvcs-stg.services.toyotafinancial.com/TFS/Services/PhoneValidation';
        
        return stub;
    }
    
Private Static EmailValidation_ResponseParams parseResponse(TFSC_WS_EmailValidationResSync.ProcessService_element ResponseDoc)
{
    EmailValidation_ResponseParams responseparams = new EmailValidation_ResponseParams();
    responseparams.statusParams  = new EmailValidation_StatusParams();
    responseparams.responseValues = new EmailValidation_ResponseValues();
        responseParams.StatusParams.Status = 'SUCCESS';
        responseParams.StatusParams.ServiceStatusNbr=201;

    
    if(ResponseDoc.ResultBOD.ResultCode == 0)
    {
        
       if(ResponseDoc.ResultBOD !=null && responsedoc.EmailValidationResBOD.ValidateEmailResult.ServiceStatus !=null)
       {
 			responseParams.StatusParams.ResultCode = ResponseDoc.ResultBOD.ResultCode;
            responseParams.StatusParams.Status = ResponseDoc.ResultBOD.ResultDesc;
           responseParams.StatusParams.ServiceStatusNbr = ResponseDoc.EmailValidationResBOD.ValidateEmailResult.ServiceStatus.StatusNbr;
           responseParams.StatusParams.ServiceStatusDescription = ResponseDoc.EmailValidationResBOD.ValidateEmailResult.ServiceStatus.StatusDescription;
       }
                    else{
                system.debug('No Transactions*');
                responseParams.StatusParams.Status = 'FAIL';
                responseParams.StatusParams.Error = responseDoc.ResultBOD.ResultCode + ': ' + responseDoc.ResultBOD.ResultDesc;
            }
        if(ResponseDoc.EmailValidationResBOD.ValidateEmailResult.ServiceResult!= null)
        {
            //responseparams.responseValues.ReasonCode = ResponseDoc.EmailValidationResBOD.ValidateEmailResult.ServiceResult.Reason.Code;
            //responseparams.responseValues.ReasonDescription = ResponseDoc.EmailValidationResBOD.ValidateEmailResult.ServiceResult.Reason.Description;
            responseparams.responseValues.HygieneResult = ResponseDoc.EmailValidationResBOD.ValidateEmailResult.ServiceResult.HygieneResult;
            //responseparams.responseValues.NetProtected = ResponseDoc.EmailValidationResBOD.ValidateEmailResult.ServiceResult.NetProtected;
			//responseparams.responseValues.NetProtectedBy = ResponseDoc.EmailValidationResBOD.ValidateEmailResult.ServiceResult.NetProtectedBy;
            //responseparams.responseValues.SourceIdentifier = ResponseDoc.EmailValidationResBOD.ValidateEmailResult.ServiceResult.SourceIdentifier;
            //responseparams.responseValues.Email = ResponseDoc.EmailValidationResBOD.ValidateEmailResult.ServiceResult.Email;
              // responseparams.responseValues.LocalPart = ResponseDoc.EmailValidationResBOD.ValidateEmailResult.ServiceResult.LocalPart;
            //responseparams.responseValues.DomainPart = ResponseDoc.EmailValidationResBOD.ValidateEmailResult.ServiceResult.DomainPart;
            responseparams.responseValues.IronStdTimeStamp = ResponseDoc.EmailValidationResBOD.ValidateEmailResult.ServiceResult.IronStandardCertifiedTimestamp;
              //responseparams.responseValues.DomainKnowledge = ResponseDoc.EmailValidationResBOD.ValidateEmailResult.ServiceResult.DomainKnowledge;
            //responseparams.responseValues.AddressKnowledge = ResponseDoc.EmailValidationResBOD.ValidateEmailResult.ServiceResult.AddressKnowledge;
          
            
        }
        
        

    }
    else
    {
        responseParams.StatusParams.Status = 'FAIL';
        responseParams.StatusParams.Error = responseDoc.ResultBOD.ResultCode + ': ' + responseDoc.ResultBOD.ResultDesc ;
    }
    
    
    
    
    return responseparams;
}

}