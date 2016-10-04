/**
* @author       Abhishek Ballabh     
* @date         11/24/2015
* @description  
*   
*    Class to send web service request to Fiserv to support Next Best Offer for Visual Flow - Refinance Eligibility
*/

global with sharing class FlowWebServiceFiserv implements Process.Plugin {
    public Boolean CoBConsent;
	public Boolean PrConsent;
	public String guid;
	public String financialAccountNumber;
	
    global Process.PluginResult invoke(Process.PluginRequest request) {
        //perform service requests here
        String SuccessMessage = '';
        financialAccountNumber = (String) request.inputParameters.get('vFinanceAccountId');
        CoBConsent=(Boolean) request.inputParameters.get('vCoConsent');
        PrConsent=(Boolean) request.inputParameters.get('vPrConsent');
        guid=(String) request.inputParameters.get('vIntegrationid');
        
        Map<String,Object> result = new Map<String,Object>(); 
        // create unique value which will be used as an external ID for a new case created in the flow
        
        //Blob b = Crypto.GenerateAESKey(128);
        //String hexKey = EncodingUtil.ConvertTohex(b);
        //String guid = hexKey.SubString(0,8)+ '-' + hexKey.SubString(8,12) + '-' + hexKey.SubString(12,16) + '-' + hexKey.SubString(16,20) + '-' + hexKey.substring(20) + '-' + Datetime.now().format('yyyy-MM-dd\'T\'hh:mm:ss\'Z\'');
        //system.debug('*** generated guid: ' + guid);
        
        // Call the web service and return the answers to the flow
        System.debug('*** '+financialAccountNumber + '   ' + guid +'   ' + CoBConsent);
        String Status = makeCallout();
        String FinalStatus= 'Data Transfer to TFSB/Fiserv:'+Status;
        String CaseStatus=Status;
        
        If(Status== null)
         {
         FinalStatus='Data Request to TFSB/Fiserv Failed. Please send screenshot with Account details to Help Desk (TFS_NOW1) to report.';  
         CaseStatus='Error';
         }Else{
        If(Status.touppercase()=='SUCCESS')
         {
         FinalStatus='Data Transfer to TFSB/Fiserv: Success';
         CaseStatus = 'Success';
         }
        If(Status.touppercase()=='ERROR')
         {
         FinalStatus='Data Transfer  to FiServ: Failed';
         CaseStatus='Error';
         }
         }
         
        
        
        result.put('oStatus',FinalStatus);       
        result.put('oReferenceId', guid);
        result.put('oCaseStatus', CaseStatus);
        
        return new Process.PluginResult(result);   
    
    }

   // Returns the describe information for the interface   
   // this function describe to the flow which data the plugin need to receive
   global Process.PluginDescribeResult describe()   {
   
      Process.PluginDescribeResult result = new Process.PluginDescribeResult(); 
      
      result.Name = 'FlowWebServiceFiserv';  
      result.Tag = 'WebService';  
        
      result.inputParameters =new List<Process.PluginDescribeResult.InputParameter>();  
       
      result.inputParameters.add(  
      new Process.PluginDescribeResult.InputParameter('vFinanceAccountId',  
         Process.PluginDescribeResult.ParameterType.STRING, true));  
         
          result.inputParameters.add(  
      new Process.PluginDescribeResult.InputParameter('vCaseId',  
         Process.PluginDescribeResult.ParameterType.STRING, true));  
         
         result.inputParameters.add(  
      new Process.PluginDescribeResult.InputParameter('vCoConsent',  
         Process.PluginDescribeResult.ParameterType.Boolean, true)); 
         
         result.inputParameters.add(  
      new Process.PluginDescribeResult.InputParameter('vPrConsent',  
         Process.PluginDescribeResult.ParameterType.Boolean, true)); 
         result.inputParameters.add(  
      new Process.PluginDescribeResult.InputParameter('vIntegrationid',  
         Process.PluginDescribeResult.ParameterType.String, true)); 
         
     
      // output
      
       result.outputParameters = new List<Process.PluginDescribeResult.outputParameter>(); 
       
        
     
       result.outputParameters.add( new Process.PluginDescribeResult.OutputParameter('oStatus', Process.PluginDescribeResult.ParameterType.STRING)); 
       result.outputParameters.add( new Process.PluginDescribeResult.OutputParameter('oReferenceId', Process.PluginDescribeResult.ParameterType.STRING)); 
       result.outputParameters.add( new Process.PluginDescribeResult.OutputParameter('oCaseStatus', Process.PluginDescribeResult.ParameterType.STRING)); 
       
       
     
      return result;
 
   }
   
	public string makeCallout(){
		string strResult = 'SUCCESS';
		if(!Test.isRunningTest()){
			Fiserv_ws_SendCreditApp.CreditApplication(financialAccountNumber, guid, CoBConsent,PrConsent);	
		}
		return strResult;
	}
  
   
   
  }