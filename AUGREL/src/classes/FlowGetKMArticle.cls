/**
* @author       Abhishek Ballabh     
* @date         11/24/2015
* @description  
*   
*    Class to send web service request to Fiserv to support Next Best Offer for Visual Flow - Refinance Eligibility
*/

global with sharing class FlowGetKMArticle implements Process.Plugin {
    
    global Process.PluginResult invoke(Process.PluginRequest request) {
    
    //perform service requests here
    
    String ArticleNumber = (String) request.inputParameters.get('vArticleNumber');
    system.debug('Article Number passed by flow: '+articleNumber);
    String Articlescreen1;
    String Articlescreen2;
    Map<String,Object> result = new Map<String,Object>();  
    
    List<How_To_A__kav> Articles = [SELECT key_information__c,Process_Steps__c FROM How_To_A__kav WHERE Language = 'en_US' and isLatestVersion = true and PublishStatus = 'Online' and Articlenumber =:Articlenumber];
    for(How_To_A__kav Article : Articles){
            Articlescreen1 = Article.key_information__c;
            Articlescreen2 = Article.Process_Steps__c;
        }
    
    
    Blob b = Crypto.GenerateAESKey(128);
        String hexKey = EncodingUtil.ConvertTohex(b);
        String guid = hexKey.SubString(0,8)+ '-' + hexKey.SubString(8,12) + '-' + hexKey.SubString(12,16) + '-' + hexKey.SubString(16,20) + '-' + hexKey.substring(20) + '-' + Datetime.now().format('yyyy-MM-dd\'T\'hh:mm:ss\'Z\'');
    
    
    result.put('oArticle1',Articlescreen1);
    result.put('oArticle2',Articlescreen2);
    result.put('oIntegrationid',guid);
    
    
     
     return new Process.PluginResult(result);   
    
    }

   // Returns the describe information for the interface   
   // this function describe to the flow which data the plugin need to receive
   global Process.PluginDescribeResult describe()   {
   
      Process.PluginDescribeResult result = new Process.PluginDescribeResult(); 
      
      result.Name = 'FlowGetKnowledgeArticle';  
      result.Tag = 'Name';  
        
      result.inputParameters =new List<Process.PluginDescribeResult.InputParameter>();  
       
      result.inputParameters.add(  
      new Process.PluginDescribeResult.InputParameter('vArticleNumber',  
         Process.PluginDescribeResult.ParameterType.STRING, true));  
         
     
      // output
      
       result.outputParameters = new List<Process.PluginDescribeResult.outputParameter>(); 
       
        
     
       result.outputParameters.add( new Process.PluginDescribeResult.OutputParameter('oArticle1', Process.PluginDescribeResult.ParameterType.STRING)); 
       result.outputParameters.add( new Process.PluginDescribeResult.OutputParameter('oArticle2', Process.PluginDescribeResult.ParameterType.STRING)); 
       result.outputParameters.add( new Process.PluginDescribeResult.OutputParameter('oIntegrationid', Process.PluginDescribeResult.ParameterType.STRING)); 
             
       
     
      return result;
 
   }
   
  
  
   
   
  }