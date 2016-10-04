public with sharing class ConstructPhoneNumberValidation {
	
	Public class Values{
        Public string NewgarageHomePhone;
    Public string NewGarageWorkPhone;
    Public string NewBillToHomePhone;
    Public string NewBilltoWorkPhone;
    Public string NewMobilePhone;
    Public  string OldgarageHomePhone;
    Public  string OldGarageWorkPhone;
    Public   string OldBillToHomePhone;
    Public   string OldBilltoWorkPhone;
    Public   string OldMobilePhone;
    public boolean homephoneGarageConfirmed;
        public boolean WorkphoneGarageConfirmed;
        public boolean MobilePhoneConfirmed;
        public boolean HomephoneBilltoConfirmed;
        public boolean WorkphoneBilltoConfirmed;
	}

	
	Public static string  changeinPhoneValues(Values Val)
	{
		string resultstring = '';
		boolean isGarHomephonechanged = TFSC_Utils.CompareValues(val.OldgarageHomePhone,val.NewgarageHomePhone);
		if(isGarHomephonechanged && val.homephoneGarageConfirmed!= true)
		{
			resultstring = resultstring +'1'+val.NewgarageHomePhone+',';
            System.debug('***garHomePhone: '+resultstring);
		}
        System.debug('***isGarHomephonechanged: '+isGarHomephonechanged);
		boolean isGarWorkPhoneChanged = TFSC_Utils.CompareValues(val.OldGarageWorkPhone,val.NewGarageWorkPhone);
				if(isGarWorkPhoneChanged && val.WorkphoneGarageConfirmed != true)
		{
			resultstring = resultstring +'1'+val.NewGarageWorkPhone+',';
            System.debug('***garWorkPhone: '+resultstring);
		}
        System.debug('***isGarWorkPhoneChanged: '+isGarWorkPhoneChanged);
		boolean isMobilePhoneChanged = TFSC_Utils.CompareValues(val.OldMobilePhone,val.NewMobilePhone);
			
				if(isMobilePhoneChanged && val.MobilePhoneConfirmed!= true)
		{
			resultstring = resultstring +'1'+val.NewMobilePhone+',';
            System.debug('***MobilePhone: '+resultstring);
		}
				boolean isBilltoHomePhoneChanged = TFSC_Utils.CompareValues(val.OldBillToHomePhone,val.NewBillToHomePhone);
			
				if(isBilltoHomePhoneChanged && val.HomephoneBilltoConfirmed!= true)
		{
			resultstring = resultstring +'1'+val.NewBillToHomePhone+',';
            System.debug('***BillHomePhn: '+resultstring);
		}
        
      
			boolean isBilltoWorkPhoneChg = TFSC_Utils.CompareValues(val.OldBilltoWorkPhone,val.NewBilltoWorkPhone);
			
				if(isBilltoWorkPhoneChg && val.WorkphoneBilltoConfirmed!= true)
		{
			resultstring = resultstring +'1'+val.NewBilltoWorkPhone+',';
            System.debug('***BillWorkPhn: '+resultstring);
		}

		resultstring = resultstring.removeend(',');
		return resultstring;
		
	}
	
    
    
}