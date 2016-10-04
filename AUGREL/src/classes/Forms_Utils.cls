/*
######################################################################################################################
Project Name..........: TFS Forms Implementation
File..................: Forms_Utils
Version...............: 1.0
Created by............: Hanumantha
Created Date..........: 10/12/2015
Last Modified by......: Manga
Last Modified Date....: 11/16/2015
Description...........: This class is made to implement simple utility methods to be used across all classes.

Change Request History:
Pranav              :   Enhanced the code and per to remove Hardcodes, Variable Naming, method descriptions included.
Charitha s  12/01/2015  removed the input parameters from getRequestId(Map<String,String>) to getRequestId() method signature as the 
                        method is not using the inputMap
Charitha S  12/09/2015  Added two methods which will give the decrypted password and username used for authentication to connect to services.
Balaji   J  14/01/2016  Added two methods calculateOutstandingLeaseBalance and calculateSalesTaxOnOutstandingLeaseBalance for calculation of Balances.
######################################################################################################################
 */

public class Forms_Utils {

    public static final String estateOf = 'Estate-';
    public static final String strCustomerType = '0001';
    public static String type = null;
    public static Map<String, Schema.SObjectType> schemaMap = null;
    public static Schema.SObjectType docReqSchema = null;
    public static Map<String, Schema.SObjectField> fieldMap;

    public static void gettingAllMetaDataFields(String objType)
    { 
        type= objType;
        schemaMap = Schema.getGlobalDescribe();
        DocReqSchema = schemaMap.get(type);
        fieldMap = DocReqSchema.getDescribe().fields.getMap(); 
    } 
    /*Method Name: executionTime
    Method Signature/Inputs: startDate(DateTime),endDate(DateTime), className(String), methodName(String)
    Method Return Type/outputs: NULL
    Method Description: This method is to calculate the time difference of the input parameters.
     */

    public static void executionTime(DateTime startDate,DateTime endDate,String className,string methodName)
    { 
        // System.debug(className+'::'+methodName+':: start Date Time is='+startDate);  
        // System.debug(className+'::'+methodName+'::endDateTime is='+endDate);
        Integer intMinDiff = (startdate.time().minute())-(endDate.time().minute());
        Integer intSecDiff = (startdate.time().second())-(endDate.time().second());
        Integer intMilliSecDiff = (startdate.time().millisecond())-(endDate.time().millisecond());
        // System.debug(className+'::'+methodName+':: start and end time min difference'+intMinDiff );
        // System.debug(className+'::'+methodName+':: start and end time sec difference'+intSecDiff );
        System.debug(className+'::'+methodName+':: start and end time millisec difference'+intMilliSecDiff );
    } 

    /* Method Name: convertAccountNumber
    Method Signature/Inputs: accountNumber (String)
    Method Return Type/outputs: accountNumber (String) 
    Method Description: This method is to convert 10 digits account number to 17 digits account number.
     */
    public static String convertAccountNumber(String accountNumber,String productType){

        String strBankNumber=''; 
        if(productType==null || productType.trim().length()==0){
            return accountNumber;
        }
        productType = productType.trim();   
        if(productType.equalsIgnoreCase('CLSD_EN_LS')||productType.equalsIgnoreCase('ONE_PAY_LS')||productType.equalsIgnoreCase('OPEN_EN_LS')){
            return accountNumber;       
        }    
        if(productType.equalsIgnoreCase('BANK_700')){
            strBankNumber = '700';
        }else if(productType.equalsIgnoreCase('BANK_800')){
            strBankNumber = '800';  
        }else if(productType.equalsIgnoreCase('PRE_CMP_LN')|| productType.equalsIgnoreCase('RET_BAL_LN') || productType.equalsIgnoreCase('RET_SIM_LN')){
            strBankNumber = '704';
        }else{
            return accountNumber;
        }
        accountNumber = strBankNumber+accountNumber+strCustomerType;
        return accountNumber;
    }

    /*Method Name: handleDeceasedReceipent
    Method Signature/Inputs: deceasedIndicator(String), recipientName (String)
    Method Return Type/outputs: instance of Form Validation Result object. 
    Method Description: This method is to append Estate- based on deceased indicator.
     */
    public static String handleDeceasedReceipent(String receipientName, String deceasedIndicator){
        if(deceasedIndicator != null && deceasedIndicator.equalsIgnoreCase(Forms_Constant.DECEASEDFLAG)){
            receipientName = estateOf +' '+receipientName;
        }
        return receipientName;
    }

    /* Method Name: getLanguagePreference
    Method Signature/Inputs: Language(String)
    Method Return Type/outputs: LanguagePreference(String)
    Method Description: This method retrieves language preference. 
     */

    public static String getLanguagePreference(String language){
        String strLanguagePreference = 'en';
        try{  
            if(language != null && language.equalsIgnoreCase('spanish')){
                strLanguagePreference = 'es';
            }
        }catch(Exception e){
            System.debug('FORMS_UTILS::GetLanguagePreference::'+e.getMessage());
        }
        return strLanguagePreference;
    }

    /* Method Name: getRequestId
    Method Signature/Inputs: 
    Method Return Type/outputs: String
    Method Description: This method is to used to return the requestID.
     */
    public static String getRequestId(){
        return String.valueOf(DateTime.Now().getTime());
    }


   public static String decryptUserName(){
        String secretString = Label.TFSF_SecretKey;
        Blob cryptoKey = EncodingUtil.base64Decode(secretString);

        String encryptedString = Label.TFSF_UserName;
        Blob encryptedData = EncodingUtil.base64Decode(encryptedString);

        //Decrypt the data - the first 16 bytes contain the initialization vector
        Blob decryptedData = Crypto.decryptWithManagedIV('AES256', cryptoKey, encryptedData);
        String userName = decryptedData.tostring();
        return userName;
    }      
    public static String decryptPassword() {
        
        String secretString = Label.TFSF_SecretKey;
        Blob cryptoKey = EncodingUtil.base64Decode(secretString);

        String encryptedString = Label.TFSF_Password;
        Blob encryptedData = EncodingUtil.base64Decode(encryptedString);

        //Decrypt the data - the first 16 bytes contain the initialization vector
        Blob decryptedData = Crypto.decryptWithManagedIV('AES256', cryptoKey, encryptedData);
        String password = decryptedData.tostring();
        return password;
    } 

    /* Method Name: throwSoapFault
    Method Signature/Inputs: Forms_Validation_Result__c result
    Method Return Type/outputs: String
    Method Description: This method is to used to return the SoapFault STring. this
    is invoked from Forms_RequestProcessor when System exception occurs -from catch block
    and also when validation error occurs in Forms_DataValidator.
    */
    public static String throwSoapFault(Forms_Validation_Result__c result)  {    
        return  '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">'+
       +'<soapenv:Body>'+
          +'<soapenv:Fault>'+
             +'<faultcode>'+result.Error_Code__c+'</faultcode>'+
             +'<faultstring>'+result.ErrorMessage__c+'</faultstring>'+
          +'</soapenv:Fault>'+
      +' </soapenv:Body>'+
      +'</soapenv:Envelope>';

    } 
    
    public static String getDayOfMonth(Date dt){
        return String.valueOf(dt.day());
    }
}