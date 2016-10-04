/*
#########################################################################################
Project Name..........: TFS Forms Implementation
File..................: Forms_ValidationHelper
Version...............: 1.0
Created by............: Charitha_Seelam,Kaavya_Kanna,Pranav_Prasun,Geetha_muthukuru
Created Date..........: 10/12/201 
Last Modified by......: Charitha_Seelam
Last Modified Date....: 10/26/2015
Description...........: validationHelper is a helper class in which Forms_BaseValidator is an inner interface class
                        which has an abstract method used to validate the data as per the datatype class which is 
                        going to implement the interface.

Change Request History:
27/11/2015,Pranav    :  Removed the email Validation code
##########################################################################################
*/
public class Forms_ValidationHelper {

    public Forms_BaseValidator validator;
    public Forms_ValidationHelper(Forms_BaseValidator validator){
        this.validator = validator;
    }
    public boolean isValid(String inputField){
        return validator.isValid(inputField);
    }
    // interface for validation implmentation strategy 
    public interface Forms_BaseValidator {
        boolean isValid(String inputField);
    }
    // Implementation to validate integer 
    public class Forms_IntegerValidator implements Forms_BaseValidator {
        public boolean isValid(String inputField){
        try{
                Integer.valueOf(inputField);
            }catch(Exception e){
                System.debug('Forms_ValidationHelper::DecimalValidator::invalid Integer value'+inputField);
                return false;
            }
            return true;
        }
    }    
            
    
    // Implementation to validate String field 
    public class Forms_StringValidator implements Forms_BaseValidator{
        public boolean isValid(String inputField){
            return (inputField != null && inputField.trim().length() > 0);
        }
    } 
    /* Class Name:Forms_CurrencyValidator
       Class Description:  Implementation to validate currency field 
    */
    public class Forms_CurrencyValidator implements Forms_BaseValidator{

        public boolean isValid(String inputField){
            String strMyRegEx = Forms_Constant.CURRENCYREGEX;
            Pattern myPattern = Pattern.compile(strMyRegEx);
            Matcher myMatcher = myPattern.matcher(inputField); 
            return myMatcher.matches();
        }
    }    
    /* Class Name: Forms_DecimalValidator 
       Class Description: Implementation to validate Decimal field 
    */  
    public class Forms_DecimalValidator implements Forms_BaseValidator{
        public boolean isValid(String inputField){
            try{
                Decimal.valueOf(inputField);
            }catch(Exception e){
                System.debug('Forms_ValidationHelper::DecimalValidator::invalid Decimal value'+inputField);
                return false;
            }
            return true;
        }
    } 
    /* Class Name: Forms_DateValidator 
       Class Description: Implementation to validate date field 
    */  
    public class Forms_DateValidator implements Forms_BaseValidator{
        public boolean isValid(String inputField){
            try{
                Date.valueOf(inputField);
            }catch(Exception e){
                System.debug('Forms_ValidationHelper::DecimalValidator::invalid Date value'+inputField);
                return false;
            }
            return true;
           
        }
    }
    /* Class Name: Forms_UrlValidator 
       Class Description: Implementation to validate Website/URL field 
    */ 
    public class Forms_UrlValidator implements Forms_BaseValidator{
        public boolean isValid(String inputField){
            String strMyRegEx = Forms_Constant.WEBSITEREGEX;
            Pattern myPattern = Pattern.compile(strMyRegEx);
            Matcher myMatcher = myPattern.matcher(inputField);
            return myMatcher.matches();
        }
    }
    /* Class Name: Forms_PhoneValidator 
       Class Description:   Implementation to validate Phone field
    */
    public class Forms_PhoneValidator implements Forms_BaseValidator{
        public boolean isValid(String inputField){
            String strMyRegEx = Forms_Constant.PHONEREGEX;
            Pattern myPattern = Pattern.compile(strMyRegEx);
            Matcher myMatcher = myPattern.matcher(inputField);
            return myMatcher.matches();
        }
    }
    
}