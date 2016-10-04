@isTest
private class Forms_CalloutResponseTest {

    static testMethod void successResponse() {
        List<String> endPointList = new List<String>();
        endPointList.add('https://salesforce.com/TerminationQuoteService.loadQuote');
        endPointList.add('https://salesforce.com/AssetService.loadAsset');
        endPointList.add('https://salesforce.com/rescheduleenquiryservice.loadrescheduleinformation');
        endPointList.add('https://salesforce.com/thirdpartyservice.loadthirdparty');
        endPointList.add('https://salesforce.com/agreementsecurityservice.listsecuritysforagreement');
        endPointList.add('https://salesforce.com/thirdpartyservice.listthirdpartysforexternalreference');
        endPointList.add('https://salesforce.com/scheduleenquiryservice.listchargesummariesforschedule');
        endPointList.add('https://salesforce.com/scheduleenquiryservice.loadfinancialsummaryforschedule');
        endPointList.add('https://salesforce.com/scheduleenquiryservice.loadschedule');
        endPointList.add('https://salesforce.com/invoiceservice.listinvoicesforschedule');
        endPointList.add('https://salesforce.com/scheduleenquiryservice.loadfinancialstodateforschedule');
        endPointList.add('https://salesforce.com/ThirdPartyAlertService.listActiveBillingAddressAlerts');
        endPointList.add('https://salesforce.com/UserService.load');
        
        
        //Forms_TestDataCreation.formsServiceCreation();
        HttpRequest request = new HttpRequest();
        HttpResponse response = new HttpResponse();
        Http http = new Http();
        List<String> serviceList = new List<String>();
        for(String endPoint : endPointList){
            request.setEndPoint(endPoint);
            request.setMethod('POST');
            response = new Forms_CalloutResponse().respond(request);
            system.assertEquals(response.getStatusCode(), 200);
        }
    }
    static testMethod void failureResponse() {
        List<String> endPointList = new List<String>();
        endPointList.add('https://salesforce.com/TerminationQuoteService.loadQuoteDummy');
        
        //Forms_TestDataCreation.formsServiceCreation();
        HttpRequest request = new HttpRequest();
        HttpResponse response = new HttpResponse();
        Http http = new Http();
        List<String> serviceList = new List<String>();
        for(String endPoint : endPointList){
            request.setEndPoint(endPoint);
            request.setMethod('POST');
            response = new Forms_CalloutResponse().respond(request);
            system.assertEquals(response.getStatusCode(), 404);
        }
    }
}