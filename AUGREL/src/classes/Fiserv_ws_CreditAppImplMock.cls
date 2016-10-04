/**
	* Fiserv_ws_CreditAppImplMock - <description>
	* Created by BrainEngine Cloud Studio
	* @author: Clayton Bruckert
	* @version: 1.0
*/

global with sharing class Fiserv_ws_CreditAppImplMock implements WebServiceMock {   
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
        Fiserv_ws_SendCreditApp ws = new Fiserv_ws_SendCreditApp();
		Fiserv_SubmitCreditAppResSync.ProcessCreditApplicationRes_element ps = new Fiserv_SubmitCreditAppResSync.ProcessCreditApplicationRes_element();
		Fiserv_SubmitCreditAppReqSync.ProcessCreditApplicationReq_element request_x = new Fiserv_SubmitCreditAppReqSync.ProcessCreditApplicationReq_element();
        
        //Map<String, Fiserv_SubmitCreditAppResSync.ProcessCreditApplicationRes_element> response_x = new Map<String, Fiserv_SubmitCreditAppResSync.ProcessCreditApplicationRes_element>();
		//Fiserv_SubmitCreditAppResSync.ProcessCreditApplicationRes_element pcaResponse = new Fiserv_SubmitCreditAppResSync.ProcessCreditApplicationRes_element();
		//Fiserv_SubmitCreditAppResSync.ProcessCreditApplicationRes_element SCAResBod = new Fiserv_SubmitCreditAppResSync.ProcessCreditApplicationRes();
		Fiserv_ResultBOD.ResultBODType ResBod = new Fiserv_ResultBOD.ResultBODType();
		
		ResBod.ResultCode = '100';
		ResBod.ResultDesc = 'SUCCESS';
		ResBod.ResultString = 'SUCCESS';
		ps.ResultBOD = ResBOD;
		//ps.ClosedFinancialAccountResBOD = CFAResBOD;
			   
		//response_x.ProcessService = ps;
        response.put('response_x', ps); 
   }
}