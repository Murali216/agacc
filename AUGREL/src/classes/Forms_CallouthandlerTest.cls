/*
#########################################################################################
Project Name..........: TFS Forms Implementation
File..................: Forms_CallouthandlerTest
Version...............: 1.0
Created by............: INFOSYS TECHNOLOGIES
Created Date..........: 11/02/2015 
Last Modified by......: thenmozhi
Last Modified Date....: 11/27/2015
Description...........: This test class has been written for Forms_CallouthandlerTest to fetching multiple dispatch modes  and languages details for specific forms
Change Request History:
thenmozhi       27/11/2015   Added comments in header and methods
Pranav           02/12/2015   Added the method descriptions.
##########################################################################################
 */
@isTest
private class Forms_CallouthandlerTest{
    
    /*
      Method Name: developmentCalloutSuccess
      Method Signature/Inputs: VOID
      Method Return Type/outputs: VOID
      Method Description:This method is used to test the service callout error
     */
    static testMethod void developmentCalloutSuccess(){
       // String Endpoint='www.login.salesforce.com';
        String endpoint='https://salesforce.com/AgreementSecurityService.listSecuritysForAgreement';
        String method='POST';
        String responseType='DEVELOPMENT';
        String inputXML='<?xml version="1.0" encoding="UTF-8"?><request>'+
                            '<accountnumber>70400100000010001</accountnumber>'+
                            '</request>';
        HttpRequest fakeRequest = new HttpRequest();
        fakeRequest.setMethod(method); 
        fakeRequest.setEndPoint(endPoint);       
        fakeRequest.setBody(inputXML);
                  
        HttpResponse fakeResponse = new Forms_CalloutResponse().respond(fakeRequest); 
        Forms_RequestMock mockResponse = new  Forms_RequestMock(fakeResponse);                  
        HttpResponse response = new HttpResponse();
        Test.setMock(HttpCalloutMock.class, mockResponse);
        response = new Forms_CalloutHandler().makeCallout(endpoint,method,inputXML,responseType);//TC_162
        //System.assertEquals(Endpoint, request.getEndpoint());
        system.assertEquals(response.getStatusCode(), 200);
    }
    /*
      Method Name: developmentCalloutError
      Method Signature/Inputs: VOID
      Method Return Type/outputs: VOID
      Method Description:This method is used to test the service callout error
     */
    static testMethod void developmentCalloutError(){
       // String Endpoint='www.login.salesforce.com';
        String endpoint='https://salesforce.com/AgreementSecurityService.listSecuritysForAgreementDummy';
        String method='POST';
        String responseType='DEVELOPMENT';
        String inputXML='<?xml version="1.0" encoding="UTF-8"?><request>'+
                            '<accountnumber>70400100000010001</accountnumber>'+
                            '</request>';
        HttpRequest fakeRequest = new HttpRequest();
        fakeRequest.setMethod(method); 
        fakeRequest.setEndPoint(endPoint);       
        fakeRequest.setBody(inputXML);
                  
        HttpResponse fakeResponse = new Forms_CalloutResponse().respond(fakeRequest); 
        Forms_RequestMock mockResponse = new  Forms_RequestMock(fakeResponse);                  
        HttpResponse response = new HttpResponse();
        Test.setMock(HttpCalloutMock.class, mockResponse);
        response = new Forms_CalloutHandler().makeCallout(endpoint,method,inputXML,responseType);//TC_163
        //System.assertEquals(Endpoint, request.getEndpoint());
        system.assertEquals(response.getStatusCode(), 404);
    }    
   
   /*
      Method Name: liveCallout
      Method Signature/Inputs: VOID
      Method Return Type/output: VOID
      Method Description:This method is used to test the response of service callout.
     */
    static testMethod void liveCallout(){
       // String Endpoint='www.login.salesforce.com';
        String endpoint='https://salesforce.com/AgreementSecurityService.listSecuritysForAgreement';
        String method='POST';
        String responseType='LIVE';
        String inputXML='<?xml version="1.0" encoding="UTF-8"?><request>'+
                            '<accountnumber>70400100000010001</accountnumber>'+
                            '</request>';
        HttpRequest fakeRequest = new HttpRequest();
        fakeRequest.setMethod(method); 
        fakeRequest.setEndPoint(endPoint);       
        fakeRequest.setBody(inputXML);
                  
        HttpResponse fakeResponse = new Forms_CalloutResponse().respond(fakeRequest); 
        Forms_RequestMock mockResponse = new  Forms_RequestMock(fakeResponse);                  
        HttpResponse response = new HttpResponse();
        Test.setMock(HttpCalloutMock.class, mockResponse);
        response = new Forms_CalloutHandler().makeCallout(endpoint,method,inputXML,responseType);//TC_161
        system.assertEquals(response.getStatusCode(), 200);
        //System.assertEquals(Endpoint, request.getEndpoint());
    }
    /*
      Method Name: liveCalloutError
      Method Signature/Inputs: VOID
      Method Return Type/output: VOID
      Method Description:This method is used to test the error from fake response of service callout.
     */
    static testMethod void liveCalloutError(){
       // String Endpoint='www.login.salesforce.com';
        String endpoint='https://salesforce.com/AgreementSecurityService.listSecuritysForAgreementDummy';
        String method='POST';
        String responseType='LIVE';
        String inputXML='<?xml version="1.0" encoding="UTF-8"?><request>'+
                            '<accountnumber>70400100000010001</accountnumber>'+
                            '</request>';
        HttpRequest fakeRequest = new HttpRequest();
        fakeRequest.setMethod(method); 
        fakeRequest.setEndPoint(endPoint);       
        fakeRequest.setBody(inputXML);
                  
        HttpResponse fakeResponse = new Forms_CalloutResponse().respond(fakeRequest); 
        Forms_RequestMock mockResponse = new  Forms_RequestMock(fakeResponse);                  
        HttpResponse response = new HttpResponse();
        Test.setMock(HttpCalloutMock.class, mockResponse);
        response = new Forms_CalloutHandler().makeCallout(endpoint,method,inputXML,responseType);//TC_163
        system.assertEquals(response.getStatusCode(), 404);
        //System.assertEquals(Endpoint, request.getEndpoint());
    }
 
}