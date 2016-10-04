@isTest
private class TFSC_MMRCheckTest 
    {
    Static List<Integer> VarChk1= new List<Integer>();         
    static testmethod void MMRCheck1()
    {
        Integer Var1;                 
        VarChk1.add(Var1);   
        Test.startTest();
        List<Integer> DescriptionList = TFSC_MMRCheck.MMRCheck(VarChk1);       
        Test.stopTest();
    }
    static testmethod void MMRCheck2()
    {
        Integer Var2=0;                 
        VarChk1.add(Var2);   
        Test.startTest();
        List<Integer> DescriptionList = TFSC_MMRCheck.MMRCheck(VarChk1);       
        Test.stopTest();
    }
}