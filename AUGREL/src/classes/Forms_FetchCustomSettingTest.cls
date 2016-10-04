/*
#########################################################################################
Project Name        : TFS Forms Implementation
File                : Forms_DocumentRequestDataMappingTest
Version             : 1.0
Created by          : Pranav 
Created Date        : 28/10/2015 
Last Modified by    : <NAME>
Last Modified Date  : <MM/DD/YYYY >
Description         : This is a test class to cover exception utility class

Change Request History:
##########################################################################################
*/ 
@isTest
private class Forms_FetchCustomSettingTest
{

  static testMethod void fetchdata_CustomSetting() {
        
        Forms_ErrorMessages__c setting1 = new Forms_ErrorMessages__c();
         setting1.Name = 'System Exception';
         setting1.Error_code__c= '522';
         setting1.Error_Message__c= 'internal error occured';
         setting1.Error_Description__c= 'TestDescription';
         insert setting1;
          system.assertnotequals(setting1,null);
        Forms_ErrorMessages__c setting2 = new Forms_ErrorMessages__c();
         setting2.Name = 'ServiceFailure';
         setting2.Error_code__c= '511';
         setting2.Error_Message__C= 'The service call has encountered an error.';
         setting2.Error_Description__c= 'TestDescription';
         insert setting2;
          system.assertnotequals(setting2,null);
        Forms_ErrorMessages__c setting3 = new Forms_ErrorMessages__c();
         setting3.Name = 'Invalid Input';
         setting3.Error_code__c= '411';
         setting3.Error_Message__C= 'Invalid input data. Please ensure data is available';
         setting3.Error_Description__c= 'TestDescription';         
         insert setting3;
         List<Forms_StatusCodes__c> statusCodes = Forms_Fetch_CustomSetting.fetchstatusCode();  
         system.assertnotequals(setting3,null);
        
       // system.test.startest();      
        try{
        system.debug('+++In try++++');
       // Forms_Fetch_CustomSetting fcusSet = new Forms_Fetch_CustomSetting();
       //initializing test class
        Forms_InternalException fi = new Forms_InternalException();
        Forms_serviceException fs = new Forms_serviceException(); 
        Forms_Fetch_CustomSetting.fetchErrorMessage('System Exception');
        Forms_Fetch_CustomSetting.fetchErrorCode('Invalid Input');
        Forms_Fetch_CustomSetting.fetchErrorDescription('ServiceFailure');
         
        
        }
        catch(Exception e)
        {
        system.debug('*****In Exceptionn ');
        }
      //test.stoptest();   
    }
  
   /*
    Method Name : fetchdata_CustomSettingTest
    Method Signature/Inputs: NULL
    Method Return Type/outputs: NULL
    Method Description: This method is to test the internal custom exception
    */
   static testMethod void fetchdata_CustomSettingTest(){
        try{
        system.debug('+++In try method 2++++');
       // Forms_Fetch_CustomSetting fcusSet = new Forms_Fetch_CustomSetting();
       test.startTest();
       //initializing test class
        Forms_InternalException fi = new Forms_InternalException();
        Forms_serviceException fs = new Forms_serviceException(); 
        throw new Forms_InternalException();
        Forms_Fetch_CustomSetting.fetchErrorMessage('System Exception');
        Forms_Fetch_CustomSetting.fetchErrorCode('Invalid Input');
        Forms_Fetch_CustomSetting.fetchErrorDescription('ServiceFailure'); 
        //List<Forms_StatusCodes__c> statusCodes = Forms_Fetch_CustomSetting.fetchstatusCode();  
        }
        catch(Forms_InternalException e1){
        system.debug('*****In InteranlExceptionn ');
        }
        catch(Exception e){
        system.debug('*****In Exceptionn ');
        }
      test.stoptest();
    }
   
   /*
    Method Name : Forms_servicexceptionclassTest
    Method Signature/Inputs: NULL
    Method Return Type/outputs: NULL
    Method Description:This method is to cover the Forms_serviceException method.
    */
    static testmethod void Forms_servicexceptionclassTest(){
    Forms_ServiceException serException = new Forms_ServiceException ();
    serException.sampleMethod(); 
    }
    
    /*
    Method Name : servicExceptionClassTest
    Method Signature/Inputs: NULL
    Method Return Type/outputs: NULL
    Method Description : This method is to cover Forms_InternalException class.
    */
    static testmethod void servicExceptionClassTest(){
    Forms_InternalException intException = new Forms_InternalException ();
    intException.sampleMethod(); 
    }
}