/*
#########################################################################################
Project Name..........: TFS Forms Implementation
File..................: <Forms_DataAggregator> 
Version...............: <1.0>
Created by............: INFOSYS TECHNOLOGIES
Created Date..........: <10/14/2015> 
Last Modified by......: <Muthu>
Last Modified Date....: <10/26/2015 >
Description...........: <This class has been written for aggregate salesforce data>


Change Request History:
Thenmozhi        28/11/2015   updated variable declaration inside for loop(49,68,69 line) into top of the page.ie(public String queryConfigkey;
    public String queryConfigvalue;public String[] splitKey;public String sql;)
Balaji J         14/01/2016    Added if condition to calculate OutStandingLeaseBalance and SalesTaxOnOutStandingLeaseBalance for 600-01 Form.

##########################################################################################
 */

public class Forms_DataAggregator{
    //variable Declaration
    public String queryConfigkey;
    public String queryConfigvalue;
    public String[] splitKey;
    public String sql;
    public String complexSql;

    /*
      Method Name:constructQuery
      Method Signature/Inputs:List<Form_Field__c> formFields, Map<String, String> inputMap
      Method Return Type/outputs: responseMap
      Method Description:Iterates form fields and constructs the query and returns the map.
      Ex: objectQueryStringMap['Account']='SELECT Id, Name FROM Account WHERE AccountNumber = 1000 ';
     */
    public Map<String,  String> constructQuery(List<Form_Field__c> formFields, Map<String, String> inputMap){
        Datetime startDate = system.now();
        List<Forms_QueryConfig__c> complexQueryMap =new List<Forms_QueryConfig__c>();
        Map<String,String> queryFields = new Map<String,String>();
        List<Id> queryConfigIdsList = new List<Id>();
        Map<String, Forms_QueryConfig__c> sourceObjectConfigMap = new Map<String, Forms_QueryConfig__c>();
        if(formFields == null || formFields.size() == 0){
            return null;
        }
        for(Form_Field__c formField: formFields){
            queryConfigIdsList.add(formField.Forms_QueryConfig__c);
        }
        system.debug('Forms_DataAggregator::constructQuery::formFields:::'+json.serialize(formFields));
        system.debug('Forms_DataAggregator::constructQuery::queryConfigIdsList:::'+json.serialize(queryConfigIdsList));
        List<Forms_QueryConfig__c> queryConfig =  [SELECT Complex_Query__c,Query__c,Field_APIName__c,ReferenceAttribute__c, Filter_Field__c, Object_APIName__c,DataType__c,Document_Object_Field__c FROM Forms_QueryConfig__c WHERE ID IN :queryConfigIdsList];
        if(queryConfig == null || queryConfig.size() == 0) {
            return null;
        }
        List<String> referenceID = new List<String>();
        Map<String, String> referenceMap = new Map<String, String>();
        for(Forms_QueryConfig__c queryConfigItem : queryConfig){
            if(queryConfigItem.Complex_Query__c==False)
            {
                queryConfigkey =  queryConfigItem.Object_ApiName__c+':'+queryConfigItem.Filter_Field__c+':'+queryConfigItem.ReferenceAttribute__c+':'+queryConfigItem.DataType__c;
                if(queryFields.containsKey(queryConfigkey)){
                    queryConfigvalue = queryFields.get(queryConfigkey)+','+queryConfigItem.Field_APIName__c;
                    queryFields.put(queryConfigkey,queryConfigvalue);
                }else{
                    queryFields.put(queryConfigkey, queryConfigItem.Field_APIName__c);
                }
                referenceID.add(queryConfigItem.Document_Object_Field__c);
                referenceMap.put(queryConfigItem.Object_ApiName__c+':'+queryConfigItem.Field_APIName__c, queryConfigItem.Document_Object_Field__c);
            }
            else if(queryConfigItem.Complex_Query__c==true)
            {
                complexQueryMap.add(queryConfigItem);
                System.debug('Forms_DataAggregator::constructQueryMap::queryconfid ids'+complexQueryMap.size());
            }
        }

        System.debug('Forms_DataAggregator::constructQuery::queryconfid ids'+queryFields);
        Map<String,String> queryList = new Map<String,String>();
        Map<String,String> responseMap = new Map<String,String>();
        for(String objectQuery : queryFields.keySet()){
            splitKey = objectQuery.split(':');
            sql = 'SELECT '+ queryFields.get(objectQuery) + ' FROM '+splitKey[0] + ' WHERE '+splitKey[1]+ '=';

            if(splitKey[3].equals('String') || splitKey[3].equals('Integer') ){
                sql = sql + '\''+inputmap.get(splitKey[2])+'\'';
            }
            System.debug('Forms_DataAggregator::constructQuery :: sql Splitkey' + json.serialize(sql));

            sObject obj = executeQuery(sql);
            String[] requestFields  = (queryFields.get(objectQuery)+'').split(',');
            integer i = 0;
            System.debug('Forms_DataAggregator::constructQuery::requestFields  '+json.serialize(requestFields));
            for(String requestField : requestFields){
                if(obj != null){
                    if(requestField.contains('.')){
                        String[] childReqObj = requestField.split('\\.');

                        if(childReqObj!=null)
                        {
                            String str1 = childReqObj[0];
                            String str2 = childReqObj[1];
                            responseMap.put(referenceMap.get(splitKey[0]+':'+requestField),string.valueOf(obj.getSobject(str1).get(str2)));

                        }
                    }else
                        responseMap.put(referenceMap.get(splitKey[0]+':'+requestField), String.valueOf(obj.get(requestField)));
                }
                i++;
            }
        }
        if(complexQueryMap.size() > 0){
            Map<String,String> complexQueryResult= executeComplexQuery(complexQueryMap,inputmap);
            for(String responseKey: complexQueryResult.keySet()){
                responseMap.put(responseKey, complexQueryResult.get(responseKey));
            }
        }
        System.debug('Forms_DataAggregator::constructQuery::response Map'+json.serialize(responseMap));
        Forms_Utils.executionTime(startDate,system.now(),'Forms_DataAggregator','constructQuery');
        return responseMap;
    }  

    /*
      Method Name: ExecuteComplexQuery
      Method Signature/Inputs:String query
      Method Return Type/outputs: Execute query
      Method Description:Executes the input query and returns the sObject result
     */


    public  Map<String, String> executeComplexQuery(List<Forms_QueryConfig__c> complexQueryMap,Map<String, String> inputMap){
       
        String query; 
        String referenceAttribute;
        Map<String, String> responseMap = new Map<String, String>();
        for(Forms_QueryConfig__c queryConfigItem : complexQueryMap){
            
            List<String> inputList = new List<String>();
            List<String> fieldsList = new List<String>();
            List<String> documentFieldsList = new List<String>();
            query=queryConfigItem.Query__c;
            referenceAttribute=queryConfigItem.ReferenceAttribute__c;
            List<String> referenceAttributeKeyList = new List<String>();
            List<String> referenceAttributeTypeList = new List<String>();
            referenceAttributeKeyList = referenceAttribute.split('\\:');
            system.debug('Forms_DataAggregator::executeComplexQuery::referenceAttributeKeyList'+referenceAttributeKeyList);
            for(String referenceSplitKey : referenceAttribute.split('\\:')){
                inputList.add(referenceSplitKey);
            }
            
            system.debug('Forms_DataAggregator::executeComplexQuery::inputList'+inputList);
            for(String referenceSplitKey : queryConfigItem.Document_Object_Field__c .split('\\:')){
                documentFieldsList.add(referenceSplitKey);
            }
            query=replacePlaceHolderWithValues(query, inputList, inputMap);
            system.debug('Forms_DataAggregator::executeComplexQuery::query'+query);
            String expenseDesc;
            
            
             sObject complexObj=executeQuery(query);
             System.debug('returned object'+complexObj);
             Integer i=0;
             if(complexObj != null){
                for(String fieldApi : queryConfigItem.Field_APIName__c.split('\\:')){
                       if(fieldApi.contains('.')){
                            String[] childReqObj1 = fieldApi.split('\\.');
                            if(childReqObj1!=null){
                                String str1=childReqObj1[0];
                                String str2=childReqObj1[1];
                                responseMap.put(documentFieldsList.get(i), String.valueOf(complexObj.getSobject(str1).get(str2)));
                                System.debug('value to response map'+documentFieldsList.get(i)+'::'+String.valueOf(complexObj.getSobject(str1).get(str2)));
                            }                        
                        }else{                                       
                           responseMap.put(documentFieldsList.get(i), String.valueOf(complexObj.get(fieldApi)));
                        }    
                        i++;
                }
             } 
        }
        return responseMap;
    }

    /*
      Method Name: replacePlaceHolderWithValues
      Method Signature/Inputs:String query,referenceAttribute and inputMap
      Method Return Type/outputs: Replaced query with replacement of '?' character'
      Method Description:.Parses the query and returns the replaced query.
     */
    public String replacePlaceHolderWithValues(String text,List<String> inputList,Map<String, String> inputMap){
        if(text == null || inputList.size() == 0){
            return text;
        }
        if(text.contains('?')){
            String[] splitedString = new String[2];
            splitedString = inputList.get(0).split('\\-');
            if(splitedString.size() == 2){
                String valueToReplace = '\''+inputMap.get(splitedString[1])+'\'';
                if(splitedString[0] != null && splitedString[0].equalsIgnoreCase('string')){
                    text = text.replaceFirst('\\?', '\''+inputMap.get(splitedString[1])+'\'');
                }
                inputList.remove(0);
                return replacePlaceHolderWithValues(text, inputList, inputMap);
            }
        } else {
            return text;
        }  
        return text;
    }


    /*
      Method Name: ExecuteQuery
      Method Signature/Inputs:String query
      Method Return Type/outputs: Execute query
      Method Description:Executes the input query and returns the sObject result
     */
    public sObject executeQuery(String query){
        List<sObject> sObjectResult = Database.Query(query);
        system.debug('Forms_DataAggregator::executeQuery::Query::'+query);

        if(sObjectResult.size() > 0){
            return sObjectResult.get(0);
        } else {
            return null;
        }

    }  

    /*
      Method Name: ExecuteQueryFor323-10
      Method Signature/Inputs:String query
      Method Return Type/outputs: Execute query
      Method Description:Executes the input query and returns the sObject result
     */
    public List<sObject> executeQueryTogetRecords(String query){
        List<sObject> sObjectResult = Database.Query(query);
        if(sObjectResult.size() > 0){
            return sObjectResult;
        } else {
            return null;
        }

    }
    /*
      Method Name: 
      
      ForLookupData
      Method Signature/Inputs:String formId, Map<String, String> inputMap
      Method Return Type/outputs: resultMap
      Method Description:Gets formsId and inputmap as input. Queries formfields and 
                         initiates the queryInternalData and sObjectToResultMap Method and returns the map.
     */    
    public Map<String, String> queryForLookupData(String formId, Map<String, String> inputMap){
        Datetime startDate = system.now();

        Map<String, String> resultMap = new Map<String, String>();
        List<Form_Field__c> formFieldsList = new List<Form_Field__c>();
        try{

            if(String.isNotBlank(formId)){
                List<Form_Field_Junction__c> internalObjectFields = new Forms_DataSelector().getInternalFieldsList(formId); 
                for(Form_Field_Junction__c formFieldJunction :internalObjectFields ){
                    formFieldsList.add(formFieldJunction.Form_Field__r);    
                }
                System.debug('Forms_DataAggregator::queryforLookupdate'+formFieldsList);
                if(formFieldsList.size() > 0){
                   resultMap = constructQuery(formFieldsList, inputMap); 
                }
            }
        } catch(Exception e){
            system.debug('Forms_DataAggregator::queryForLookupData:: Exception::'+e.getLineNumber()+'::'+e.getMessage());
        }
        system.debug('Forms_DataAggregator::queryForLookupData::Result Map '+resultMap);

        Forms_Utils.executionTime(startDate,system.now(),'Forms_DataAggregator','queryForLookupData');
        return resultMap;
    }
    /*
      Method Name: aggregateFormData
      Method Signature/Inputs:Form__c formData, Form_Request__c formRequest, Forms_DocumentDataHolder documentData
      Method Return Type/outputs: resultMap
      Method Description:this method is used to call the Forms_DataAggregatorHelper class which contain aggregateLanguagePreference,aggregateDispatchInformation,document data
     */
    public void aggregateFormData(Form__c formData, Form_Request__c formRequest, Forms_DocumentDataHolder documentData, Map<String, String> dataMap){
        system.debug('++++++++Chekcing the value of dataMap+++++++++'+dataMap); 
        Forms_DataAggregatorHelper helper = new Forms_DataAggregatorHelper(); 
        helper.aggregateDispatchInformation(formData, formRequest, documentData,dataMap);
        helper.aggregateLanguagePreference(formRequest, documentData);
        helper.convertAccountNumber(dataMap,documentData);
        helper.handleDeceasedReceipent(documentData);
        
        
    }
    
    /*
     * * aggregates logical data configuration 
     */
    public Map<String,String> aggregateLogicDate(Map<String,String> dataMap, Map<String,String> resultMap, Forms_DocumentDataHolder documentData){
 
        //Forms_Logic_Config__c,
        List<Form_Field_Junction__c> formFields = Forms_DataSelector.getFieldsList(dataMap.get('formnumber'),'LOGIC');
        System.debug('Forms_DataAggregator::aggregateLogicDate'+formFields);
        List<String> logicConfigList = new List<String>();
        system.debug('Formfieldssize'+formFields.size());
        if(formFields!=null && formFields.size()>0){
            for(Form_Field_Junction__c formField : formFields) {
                if(formField.Form_Field__r.Forms_Logic_Config__c!=null){
                   logicConfigList.add(formField.Form_Field__r.Forms_Logic_Config__c);
                }
            }
        }    
        if(logicConfigList==null || logicConfigList.size()==0){
          return resultMap;    
        }
        List<Forms_LogicConfiguration__c> logicConfig = Forms_DataSelector.getLogicConfiguration(logicConfigList);
        if(logicConfig==null || logicConfig.size()==0){
            return resultMap;
        }
        resultMap = Forms_LogicExecutor.execute(dataMap, logicConfig, resultMap,documentData);
        return resultMap;
    }

}