/*
#########################################################################################
Project Name          : TFS Forms Implementation
File                  : Forms_Fetch_CustomSetting
Version               : 1.0
Created by            : Pranav
Created Date          : 10/27/2015 
Last Modified by      : Pranav
Last Modified Date    : 10/28/2015 
Description           : This class is used to fetch various values from the custom settings to be used in the classes.

Change Request History:
Manga Karumuri  15/12/2015   created new method fetchstatusCode()
##########################################################################################

 */

public class Forms_Fetch_CustomSetting {

    /* Method Name: fetchErrorCode
    Method Signature/Inputs: settingName(string)
    Method Return Type/outputs: ErrorCode(String)
    Method Description: This method to fetch error code of input settingName from custom setting.
     */
    public static String fetchErrorCode(String settingName){
        return Forms_ErrorMessages__c.getValues(settingName).Error_code__c;
    }

    /* Method Name: fetchErrorMessage
    Method Signature/Inputs: settingName(string)
    Method Return Type/outputs: ErrorMessage(String)
    Method Description: This method to fetch error message of input settingName from custom setting.
     */
    public static String fetchErrorMessage(String settingName){
        return Forms_ErrorMessages__c.getValues(settingName).Error_Message__c;
    }  

    /* Method Name: fetchErrorDescription
    Method Signature/Inputs: settingName(string)
    Method Return Type/outputs: ErrorDescription(String)
    Method Description: This method to fetch error description of input settingName from custom setting.
     */
    public static String fetchErrorDescription(String settingName){
        return Forms_ErrorMessages__c.getValues(settingName).Error_Description__c;
    } 

    public static List<Forms_StatusCodes__c> fetchstatusCode(){

        return Forms_StatusCodes__c.getAll().values();
    } 
    
}