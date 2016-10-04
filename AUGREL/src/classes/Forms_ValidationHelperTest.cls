/*
#########################################################################################
Project Name..........: TFS Forms Implementation
File..................: Forms_ValidationHelperTest
Version...............: 1.0
Created by............: Charitha_Seelam
Created Date..........: 10/08/2015 
Last Modified by......: Charitha_Seelam
Last Modified Date....: 11/26/2015
Description...........: Test Class to test the Forms_ValidationHelper methods

Change Request History:
##########################################################################################
*/

@isTest
Public class Forms_ValidationHelperTest
{ 
  
  Static testmethod void test_ValidateHelper()
  {
        
    Forms_ValidationHelper.Forms_BaseValidator validator = (Forms_ValidationHelper.Forms_BaseValidator)(Type.forName('Forms_ValidationHelper.Forms_StringValidator')).newInstance();
    Forms_ValidationHelper vldHelper = new Forms_ValidationHelper(validator);
    Boolean isValid = vldHelper.isValid('TestString');
    Boolean isInvalid =vldHelper.isvalid('');
    System.assertEquals(true,isValid);
    System.assertEquals(false,isInvalid);
    
    Forms_ValidationHelper.Forms_BaseValidator integerValidator = (Forms_ValidationHelper.Forms_BaseValidator)(Type.forName('Forms_ValidationHelper.Forms_IntegerValidator')).newInstance();
    vldHelper = new Forms_ValidationHelper(integerValidator );
    isValid = vldHelper.isValid('12345');
    isInvalid = vldHelper.isValid('testString');
    System.assertEquals(true,isValid);
    System.assertEquals(false,isInvalid);
    
    Forms_ValidationHelper.Forms_BaseValidator currencyValidator = (Forms_ValidationHelper.Forms_BaseValidator)(Type.forName('Forms_ValidationHelper.Forms_CurrencyValidator')).newInstance();
    vldHelper = new Forms_ValidationHelper(currencyValidator);
    isValid = vldHelper.isValid('12345.00');
    isInvalid = vldHelper.isValid('testString');
    System.assertEquals(true,isValid);
    System.assertEquals(false,isInvalid);
    
    Forms_ValidationHelper.Forms_BaseValidator decimalValidator = (Forms_ValidationHelper.Forms_BaseValidator)(Type.forName('Forms_ValidationHelper.Forms_DecimalValidator')).newInstance();
    vldHelper = new Forms_ValidationHelper(decimalValidator );
    isValid = vldHelper.isValid('12345.00');
    isInvalid = vldHelper.isValid('12345.ytu');
    System.assertEquals(true,isValid);
    System.assertEquals(false,isInvalid);
    
    Forms_ValidationHelper.Forms_BaseValidator dateValidator = (Forms_ValidationHelper.Forms_BaseValidator)(Type.forName('Forms_ValidationHelper.Forms_DateValidator')).newInstance();
    vldHelper = new Forms_ValidationHelper(dateValidator);
    isValid = vldHelper.isValid('2015-10-29 00:00:00');
    isInvalid = vldHelper.isValid('20-10-2890');
    System.assertEquals(true,isValid);
    System.assertEquals(false,isInvalid);
    
    Forms_ValidationHelper.Forms_BaseValidator phoneValidator = (Forms_ValidationHelper.Forms_BaseValidator)(Type.forName('Forms_ValidationHelper.Forms_PhoneValidator')).newInstance();
    vldHelper = new Forms_ValidationHelper(phoneValidator);
    isValid = vldHelper.isValid('994-958-2874');
    isInvalid = vldHelper.isValid('20-10-2890');
    System.assertEquals(true,isValid);
    System.assertEquals(false,isInvalid);
    
    Forms_ValidationHelper.Forms_BaseValidator urlValidator = (Forms_ValidationHelper.Forms_BaseValidator)(Type.forName('Forms_ValidationHelper.Forms_UrlValidator')).newInstance();
    vldHelper = new Forms_ValidationHelper(urlValidator);
    isValid = vldHelper.isValid('https://www.salesforce.com');
    isInvalid = vldHelper.isValid('httpstuyguy://www.salesforce.com');
    System.assertEquals(true,isValid);
    System.assertEquals(false,isInvalid);

  } 
  
  
}