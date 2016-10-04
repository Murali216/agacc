public with sharing class TFSC_ActivityTriggerAfterHandler implements TFSC_TriggerDispatcher.Handler {
	
	/* Handler for TFS_Activity__c after insert */
	
	public void handle(){
		execute(trigger.new);
	}
	
	public void execute(List<TFS_Activity__c> activityList) {

	 //system.debug('++++++TFSC_ActivityTriggerAfterHandler')	;

		Set<Id> caseIds = new Set<Id>();
		for (TFS_Activity__c act : activityList) {
			if (act.case__c != null)
				caseIds.add(act.case__c);
		}
		
		Map<Id, Case> caseMap = new Map<Id,Case> ([select Id, payment_channel__c from case where id in :caseIds]);

		List<case> caseList = new List<case>();
		
		for (TFS_Activity__c act : activityList){
			if (act.case_action__c == 'Start Process' && act.case_category__c == 'Payments' && act.case_Topic__c == 'Refund'
							&& caseMap.get(act.case__c).payment_channel__c == 'WUSP') {

	 //system.debug('++++++ record meets criteria')	;
	 								
				caseList.add(new Case(Id = act.case__c, status = 'Resolved'));					
			}	
		}	
	 //system.debug('++++++ caseList: ' + caseList)	;
		if (caseList.size() > 0)
			update caseList;
	}

}