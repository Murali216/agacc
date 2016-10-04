@isTest
private class TFSC_WS_ValidatePhoneNumberTest {    
    
    /*Description: This method covers the main validatePhoneNumber callout method using the TFSC_WS_PhoneNumValidMockGeneTest, 
    where all the repsonse values are se, this covers the callout part of the class */
    public static testmethod void testValidatePhoneNumb(){
        TFSC_WS_ValidatePhoneNumber.PhoneNumberValidation_RequestParams request = new TFSC_WS_ValidatePhoneNumber.PhoneNumberValidation_RequestParams();
        TFSC_WS_ValidatePhoneNumber.PhoneNumberValidation_ResponseParams res = new TFSC_WS_ValidatePhoneNumber.PhoneNumberValidation_ResponseParams();
        TFSC_WS_ValidatePhoneNumber.PhoneNumberValidation_ResponseParams res1 = new TFSC_WS_ValidatePhoneNumber.PhoneNumberValidation_ResponseParams();
        
        request.phoneNumber='19154008138';
        TFSC_WS_ValidatePhoneNumber.PhoneNumberValidation_StatusParams status = new TFSC_WS_ValidatePhoneNumber.PhoneNumberValidation_StatusParams();
        status.status= 'test';
        status.error = 'Null';
        status.StatusNbrService =211;
        status.StatusDescriptionService = 'test';
        status.ResultCode =0;
        
        Test.startTest();
        Test.setMock(WebServiceMock.class, new  TFSC_WS_PhoneNumValidMockGeneTest());
        res = TFSC_WS_ValidatePhoneNumber.validatePhoneNumber(request);
        //res1 = TFSC_WS_ValidatePhoneNumber.parseResponse();
        Test.stopTest();
    }
    
    /*Description: This method ocvers the last invoking method*/
    Public static testMethod void testInvokingMethod(){
    TFSC_WS_ValidatePhoneNumber.ValidatePhone valid = new TFSC_WS_ValidatePhoneNumber.ValidatePhone('19154008138', true);
    TFSC_WS_ValidatePhoneNumber.ValidatePhone validRepeat = new TFSC_WS_ValidatePhoneNumber.ValidatePhone('15104687130', true);
    list <TFSC_WS_ValidatePhoneNumber.ValidatePhone> phoneList= new list <TFSC_WS_ValidatePhoneNumber.ValidatePhone>();
    phoneList.add(valid);
    phoneList.add(validRepeat);
    Test.startTest();
    Test.setMock(WebServiceMock.class, new  TFSC_WS_PhoneNumValidMockGeneTest());
    TFSC_WS_ValidatePhoneNumber.isValid(phoneList);
    Test.stopTest();
        
    }
}