@isTest
public class TFSC_WS_EmailValidationTest {
 @isTest public static void testValidateEmail()
 {
     TFSC_WS_EmailValidation.EmailValidation_RequestParams request = new TFSC_WS_EmailValidation.EmailValidation_RequestParams();
     TFSC_WS_EmailValidation.EmailValidation_ResponseParams response = new TFSC_WS_EmailValidation.EmailValidation_ResponseParams();
     request.Email = 'Murali216@gmail.com';
         TFSC_WS_EmailValidation.EmailValidation_StatusParams status = new TFSC_WS_EmailValidation.EmailValidation_StatusParams();
     status.status= 'test';
     status.error = Null;
             status.ServiceStatusNbr =211;
        status.ServiceStatusDescription = 'test';
        status.ResultCode =0;
     
     Test.startTest();
     test.setMock(WebServiceMock.class, new TFSC_WS_EmailValidMockGeneTest());
     system.debug('Before Test Call');
           response = TFSC_WS_EmailValidation.ValidateEmail(request);
     system.debug('After Test Call');
     Test.stopTest();
 }
    
}