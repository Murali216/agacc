/**
	* Tibco_ws_SendFARequestTest - <description>
	* Created by BrainEngine Cloud Studio
	* @author: Clayton Bruckert
	* @version: 1.0
*/

@isTest
private class Tibco_ws_SendFARequestTest {	
	static testMethod void invokeTest() {
    	Test.startTest();
		      	
    	test.setMock(WebServiceMock.class, new Tibco_ws_SendFARequestMockWS());
		string strResult = Tibco_ws_SendFARequest.SendRequest('', Datetime.now(), '', '');
       
       	Test.StopTest();
	}
}