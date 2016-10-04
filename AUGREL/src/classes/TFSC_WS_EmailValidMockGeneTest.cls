@isTest
global  class TFSC_WS_EmailValidMockGeneTest implements webServiceMock{
     global void doInvoke(
        Object stub,
        Object request,
        Map<String,object> response,
        String endpoint,
        String soapAction,
        String requestName,
        String responseNS,
        String responseName,
        String responseType) 
     {
         
         System.debug('Here1');
         TFSC_WS_EmailValidationtReqSync.EmailValidationReqSync_element emailSync= new TFSC_WS_EmailValidationtReqSync.EmailValidationReqSync_element();
         emailSync.ProcessService = new TFSC_WS_EmailValidationtReqSync.ProcessService_element();
         emailSync.ProcessService.EmailValidationReqBOD = new TFSC_WS_EmailValidationtReqSync.EmailValidationReqBODType();
         emailSync.ProcessService.EmailValidationReqBOD.VerifyEmail = new TFSC_WS_EmailValidationtReqSync.VerifyEmailType();
         emailSync.ProcessService.EmailValidationReqBOD.VerifyEmail.EmailAddress = 'murali216@gmail.com';
         
         system.debug('Here2');
             
         TFSC_WS_EmailValidationResSync.EmailValidationResSync_element responseDoc = new TFSC_WS_EmailValidationResSync.EmailValidationResSync_element();
         responseDoc.ProcessService = New TFSC_WS_EmailValidationResSync.ProcessService_element();
         responseDoc.ProcessService.ResultBOD = New TFSC_WS_EmailValidationResultBOD.ResultBODType();
         responseDoc.ProcessService.EmailValidationResBOD = new TFSC_WS_EmailValidationResBOD.EmailValidationResBODType();
         responseDoc.ProcessService.EmailValidationResBOD.ValidateEmailResult = New TFSC_WS_EmailValidationResBOD.SIWsOutputOfVerifyEmailRecord();
         responseDoc.ProcessService.EmailValidationResBOD.ValidateEmailResult.ServiceStatus = New TFSC_WS_EmailValidationResBOD.SIWsStatus();
         responseDoc.ProcessService.EmailValidationResBOD.ValidateEmailResult.ServiceResult = New TFSC_WS_EmailValidationResBOD.VerifyEmailRecord();
         
         System.debug('Here3');
         if(emailSync.ProcessService.EmailValidationReqBOD.VerifyEmail.EmailAddress !=null)
         {
            System.debug('Here4');
             responseDoc.ProcessService.ResultBOD.ResultCode = 0;
             responseDoc.ProcessService.ResultBOD.ResultDesc = 'Test';
            
            responseDoc.ProcessService.EmailValidationResBOD.ValidateEmailResult.ServiceStatus.StatusNbr = 211;
             responseDoc.ProcessService.EmailValidationResBOD.ValidateEmailResult.ServiceStatus.StatusDescription = 'Valid Email';	
            responseDoc.ProcessService.EmailValidationResBOD.ValidateEmailResult.ServiceResult.HygieneResult = 'Safe US';
             responseDoc.ProcessService.EmailValidationResBOD.ValidateEmailResult.ServiceResult.NetProtected = false;
             responseDoc.ProcessService.EmailValidationResBOD.ValidateEmailResult.ServiceResult.LocalPart = 'Murali216';
             responseDoc.ProcessService.EmailValidationResBOD.ValidateEmailResult.ServiceResult.DomainPart = 'gmail.com';
             System.debug('Here5');
              
         }
         system.debug('TestCalss responseDoc: '+responseDoc);
         response.put('response_x', responseDoc); 
         
     }

}