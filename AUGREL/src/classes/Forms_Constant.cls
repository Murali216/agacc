/*
#########################################################################################
Project Name..........: TFS Forms Implementation
File..................: Forms_Constant
Version...............: 1.0
Created by............: Geetha
Created Date..........: 10/27/2015 
Last Modified by......: Pranav
Last Modified Date....: 11/17/2015 
Description...........: All the constant fields are mapped in this class


Change Request History:
##########################################################################################
Manga Karumuri  02/12/2015   Added Reciepient ID Constant
 */

Public class Forms_Constant{
  //------------------------------------------------------------------------------------------------------------------------------------//
  //                            Forms_RequestProcessor
  //------------------------------------------------------------------------------------------------------------------------------------//
  public static final string FAILURE = 'Failure';
  public static final string ACCOUNTNUMBER = 'accountnumber';
  public static final string FORMNUMBER = 'formnumber';
  public static final string FORMTYPE = 'formtype';
  public static final string DISPATCHNAME = 'DispatchName';
  public static final string SOURCESYSTEM = 'sourcesystem';
  public static final string CREATIONDATE = 'creationdate';
  public static final string DEVICENAME = 'DeviceName';
  public static final string EFFECTIVESTATECODE = 'effectivestatecode';
  public static final string RECIPIENT = 'recipient';
  public static final string REQUESTID= 'requestid';
  public static final string TARGETSYSTEM = 'targetsystem';
  public static final string ISCERTIFIEDMAIL = 'IsCertifiedMail';
  public static final string ISLEGALEnvelope = 'IsLegalEnvelope';
  public static final string NUMBEROFCOPIES = 'NumberOfCopies';
  public static final string ISRETURNENVELOPEREQUIRED = 'IsReturnEnvelopeRequired';
  public static final string EFFECTIVESTATENAME = 'effectiveStateName'; 
  public static final string DOCUMENTTYPE= 'documentType'; 
  public static final string RECIPIENTID= 'externalid'; 
  public static final string ASSETMISCTYPE= 'assetMiscType';
  public static final string THIRDMISCTYPE= 'thirdmisctype';
  public static final string THIRDMISCBKFL= 'BKFL';
  public static final string ASSETMISCLICPL= 'LICPL';
  public static final String SCHEDULEIDENTIFIER='ScheduleIdentifier';
  public static final String QUOTATIONIDENTIFIER='TerminationQuoteIdentifier';
  public static final String RESCHEDULESEQUENCENUMBER='RescheduleSequenceNumber';
  public static final String ENTITYKEY='entitykey';
  public static final String AGREEMENTNUMBER='agreementNumber';
  public static final String SCHEDULENUMBER='scheduleNumber';
  public static final String SCHEDULENUMBER_VALUE='1';
  public static final String QUOTATIONNUMBER='quotationNumber'; 
  public static final String BILLINGADDRESSNUMBER='billingAddressNumber';
  public static final String THIRDPARTYNUMBER='thirdPartyNumber';
  public static final String THIRDPARTYBILLINGADDRESSNUMBER ='ThirdPartyBillingAddressNumber';
 
    
    
    
  //------------------------------------------------------------------------------------------------------------------------------------//
  //                            Forms_RequestProcessor
  //------------------------------------------------------------------------------------------------------------------------------------//
  public static final string FORMREQUEST= 'Form_Request__c';
  public static final string DOCUMENTREQUESTLINEITEM ='Document_Request_Line_Item__c';
  public static final string ALFA = 'ALFA';
  //------------------------------------------------------------------------------------------------------------------------------------//
  //                            Forms_ValidatorHelper
  //------------------------------------------------------------------------------------------------------------------------------------//
  public static final string DECIMALREGEX='([0-9]*.[0-9]*)';
  public static final string CURRENCYREGEX= '([0-9]*.[0-9]*)';
  public static final string DATEREGEX= '((19|20)\\d\\d)-(0?[1-9]|1[012])-(0?[1-9]|[12][0-9]|3[01]) \\d{2}:\\d{2}:\\d{2}';
  public static final string WEBSITEREGEX = '((http|https):\\/\\/[A-Za-z\\.]*\\.(com|org|net))';
  public static final string PHONEREGEX= '(([0-9]{3})-([0-9]{3})-([0-9]{4}))';

  //------------------------------------------------------------------------------------------------------------------------------------//
  //                            Forms_DataSelector
  //------------------------------------------------------------------------------------------------------------------------------------//
  public static final string REQUEST_NAME = 'request.xml';
  public static final string SFDC='SFDC';
  //------------------------------------------------------------------------------------------------------------------------------------//
  //                            Forms_DocumentRequestDataMapping
  //------------------------------------------------------------------------------------------------------------------------------------//
  public static final string RESPONSE='Response';
  public static final string DOCUMENTREQUEST = 'Document_Request__c';
  //------------------------------------------------------------------------------------------------------------------------------------//
  //                            Forms_CalloutHandler
  //------------------------------------------------------------------------------------------------------------------------------------//
  public static final string LIVE='LIVE';
  public static final string DEVELOPMENT='DEVELOPMENT';
  //------------------------------------------------------------------------------------------------------------------------------------//
  //                            Forms_WebServiceExecutor
  //------------------------------------------------------------------------------------------------------------------------------------//
  public static final string REQUEST='Request'; 
  //------------------------------------------------------------------------------------------------------------------------------------//
  //                            Forms_DataAggregationHelper
  //------------------------------------------------------------------------------------------------------------------------------------//
  public static final String DISPATHLINEITEMTYPE='Dispatch';
  public static final String EXPENSELINEITEMTYPE='Expense Type';
  public static final String INSUFFICIENTFUNDSTYPE='Insufficient Funds';  
  public static final String DISPATCHNETWORKPRINT='Network print';
  public static final String PRODUCTCODE ='productcode';
  public static final String NAMELINECOBUYER='nameline2';
  public static final String NAMELINECOLEASEE='coLeaseenameline2';
  public static final String LINEITEMCOCUSTOMERS='Co-Customers';

  
  //------------------------------------------------------------------------------------------------------------------------------------//
  //                           Forms_DataValidator
  //------------------------------------------------------------------------------------------------------------------------------------//  
   public static final String CHECKBOX='Checkbox';
   public static final String SUCCESS='Success';  
   //Deceased Flag
   public static final String DECEASEDFLAG='DEA';

   public Forms_Constant() {}
}