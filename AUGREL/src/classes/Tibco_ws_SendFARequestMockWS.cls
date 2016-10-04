@isTest
global class Tibco_ws_SendFARequestMockWS implements WebServiceMock {   
	global void doInvoke(
           Object stub,
           Object request,
           Map<String, Object> response,
           String endpoint,
           String soapAction,
           String requestName,
           String responseNS,
           String responseName,
           String responseType) {
        // start - specify the response you want to send
		
		Tibco_ws_SendFARequest ws = new Tibco_ws_SendFARequest();
		WS_ClosedFinancialAccountResSync.ProcessService_element ps = new WS_ClosedFinancialAccountResSync.ProcessService_element();
		WS_ClosedFinancialAccountReqSync.ClosedFinancialAccountReqSync_element request_x = new WS_ClosedFinancialAccountReqSync.ClosedFinancialAccountReqSync_element();
        
        Map<String, WS_ClosedFinancialAccountResSync.ClosedFinancialAccountResBODType_element> response_map_x = new Map<String, WS_ClosedFinancialAccountResSync.ClosedFinancialAccountResBODType_element>();
        WS_ClosedFinancialAccountResSync.ClosedFinancialAccountResBODType_element response_x = new WS_ClosedFinancialAccountResSync.ClosedFinancialAccountResBODType_element();
		WS_ClosedFinancialAccountResSync.ClosedFinancialAccountResBODType CFAResBOD = new WS_ClosedFinancialAccountResSync.ClosedFinancialAccountResBODType();
		WS_ResultBOD.ResultBODType ResBOD = new WS_ResultBOD.ResultBODType();
		
		ResBod.ResultCode = 100;
		ResBod.ResultDesc = 'SUCCESS';
		ResBod.ResultString = 'SUCCESS';
		CFAResBOD.ResultBOD = ResBOD;
		ps.ClosedFinancialAccountResBOD = CFAResBOD;
		
		response_x.ProcessService = ps;
        response.put('response_x', response_x); 
   }
}