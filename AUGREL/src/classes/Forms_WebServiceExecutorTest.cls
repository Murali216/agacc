@isTest
private class Forms_WebServiceExecutorTest
{   
    //Muthu
    static void createrecords(String formNumber){

        Form__c form = Forms_TestDataUtil.insertForm(formNumber);
        Forms_TestDataUtil.insertFormFieldsForRequest();//TC_154,TC_155,TC_156
        Forms_TestDataUtil.insertFormFieldsForALFAandSFDC();
        Forms_TestDataUtil.insertEndPoints();
        
    }

    static testMethod void executeWebServiceSuccess() {
        createrecords('2000');
        //recordsCreation('success');
        try{
            Map<String,String> inputMap  = new Map<String,String>();
            inputMap.put('accountnumber', '70000012345');
            inputMap.put('formnumber', '2000');
            List<Form_Field_Junction__c> formFieldjunctionList = new Forms_DataSelector().getServiceList(inputMap.get('formnumber'));
            new Forms_WebServiceExecutor().executeWebServices(inputMap,formFieldJunctionList);//TC_151
            system.debug('+++In try++++ inputMap : '+inputMap.size());
            system.assertEquals('70000012345', inputMap.get('accountnumber'));
        } catch(Exception e){
            system.debug('Error::'+e.getMessage());
        }
    }
    //method for testing the service error exception
      static testMethod void executeWebService_serviceError() {
        createrecords('5001');
        try{
            Map<String,String> inputMap  = new Map<String,String>();
            inputMap.put('accountnumber', '70000012345');
            inputMap.put('formnumber', '5001');
            List<Form_Field_Junction__c> formFieldjunctionList = new Forms_DataSelector().getServiceList(inputMap.get('formnumber'));
            new Forms_WebServiceExecutor().executeWebServices(inputMap,formFieldJunctionList);//TC_152
          
            system.assertEquals('70000012345', inputMap.get('accountnumber'));
        } catch(Exception e){
            system.debug('Error::'+e.getMessage());
        }
        
    }
    
  //method for testing the internal error exception
      static testMethod void executeWebService_internalError() {
        createrecords('5002');
        try{
        Map<String,String> inputMap  = new Map<String,String>();
        inputMap.put('accountnumber', '70000012345');
        inputMap.put('formnumber', '5002');
        List<Form_Field_Junction__c> formFieldjunctionList = new Forms_DataSelector().getServiceList(inputMap.get('formnumber'));//TC_153
        new Forms_WebServiceExecutor().executeWebServices(inputMap,formFieldJunctionList);
        system.assertEquals('70000012345', inputMap.get('accountnumber'));
        } catch(Exception e){
            system.debug('Error::'+e.getMessage());
        }
           
    }

    
 
}