public with sharing class TFSC_MMRCheck 
{
  
    @InvocableMethod(label='MMRCheck' description='Returns 0')
    
    public static List<Integer> MMRCheck(List<Integer> MMR)
        {
        String MMRVal=String.valueof(MMR[0]);
        List<Integer> MMRCheckVar=new List<Integer>();
        if(MMRVal==null)
        {
        integer var1=0;
        MMRCheckVar.add(var1);              
        }
        else
        {
        integer var2=1;
        MMRCheckVar.add(var2);
        }
        return MMRCheckVar;  
        }
}