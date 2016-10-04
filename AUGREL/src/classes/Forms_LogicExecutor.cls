public class Forms_LogicExecutor {
    
    public static Map<String,String> calculateDecimalAddSub(Map<String,String> inputData, Forms_LogicConfiguration__c logicConfigList, Forms_DocumentDataHolder docReqObj){
        try{
            
             
            String res = '';
            String expn=logicConfigList.expression__c;
            if(expn==null && expn.trim().length()==0){
                System.debug('empty expression');
                return inputData;
            }
            expn = expn.trim();
            String docReqField = logicConfigList.Document_Object__c;
            string[] newString = expn.split('(?=[-+*/])');
                    
            double total=0;
            
            for(integer i=0 ;i < newString.size(); i++) {    
                string valueFromMap='';
                if(newString[i].contains('+')) {                   
                    valueFromMap = inputData.get(newString[i].trim().Substring(1));
                    if(valueFromMap!=null && valueFromMap.trim().length()>0)
                    {                       
                        total += decimal.valueOf(valueFromMap);
                        
                    }      
                }
                else if(newString[i].contains('-')) {
                   valueFromMap = inputData.get(newString[i].trim().Substring(1)); 
                   if(valueFromMap!=null && valueFromMap.trim().length()>0)
                        total -= decimal.valueOf(valueFromMap);        
                }
                else {
                    valueFromMap = inputData.get(newString[i]); 
                    if(valueFromMap!=null && valueFromMap.trim().length()>0)               
                        total += decimal.valueOf(valueFromMap);
                }    
            }
        	res = string.ValueOf(total);
            if(docReqField!=null && docReqField.trim().length()>0){
                Document_Request__c docReq = docReqObj.getDocumentRequest();
                docReq.put(docReqField, total);
            }
            inputData.put(logicConfigList.Referecen_Attribute__c,res);
            System.debug('Forms_LogciExecutor:calculateDecimalAddSub::document requst object'+docReqObj);
        }catch(Exception e)    {
            System.debug('calculation error'+e);
        }
        return inputData;
    }
    
    public  static  Map<String,String> execute(Map<String,String> dataMap, List<Forms_LogicConfiguration__c> logicConfigList,Map<String,String> resultMap, Forms_DocumentDataHolder docReqObj){
        
        for(Forms_LogicConfiguration__c logicConfig: logicConfigList) {
           
            String referenceValue = logicConfig.Referecen_Attribute__c;
            String logicCondition = logicConfig.Logic_Condition__c;
            String operator = logicConfig.Operator__c;
            String successValue = logicConfig.successValue__c;
            String failValue = logicConfig.failValue__c;
            String compareValue = logicConfig.value__c;
            String docObjectField = logicConfig.document_object__c;
            
            if(logicCondition.equalsIgnoreCase('IF')){
                String decisionValue = '';
                boolean isSuccess = false;
                if(operator.equalsIgnoreCase('IN')){
                    String[] values = compareValue.split(',');
                    referenceValue = dataMap.get(referenceValue);
                    
                    for(String val : values){
                       if(referenceValue.equalsIgnoreCase(val)){
                          isSuccess = true;
                          decisionValue = dataMap.get(successValue);
                          break;
                       }
                    }
            
                }
                if(!isSuccess){
                    decisionValue = dataMap.get(failValue);
                }
                resultMap.put(docObjectField, decisionValue);
            }
            if(logicCondition.equalsIgnoreCase('ADDSUB')){
                calculateDecimalAddSub(dataMap,logicConfig,docReqObj);
            }
         }
        system.debug('++++in Logic Executor resultMap++++++'+resultMap); 
        return resultMap;
     }
}