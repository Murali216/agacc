/*
#########################################################################################
Project Name        : TFS Forms Implementation
File                : Forms_ConstantTest
Version             : 1.0
Created by          : Kaavya
Created Date        : 28/10/2015 
Last Modified by    : <NAME>
Last Modified Date  : <MM/DD/YYYY >
Description         : This class is the Test class for Forms_Constant

Change Request History:
##########################################################################################
*/

@isTest
Public class Forms_ConstantTest{

/*
      Method Name: test_constant
      Method Signature/Inputs: VOID
      Method Return Type/outputs: VOID
      Method Description:This method is used to test the code of  Forms_constant class.
*/
 Static testmethod void test_constant(){   
  
    test.starttest();
    new Forms_Constant();
    system.assertEquals(Forms_Constant.FORMNUMBER,'formnumber');
    test.stoptest();
    
 }
}