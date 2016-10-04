public with sharing class FACObjectHistoryController {  
    //Protected Members
    private static final DescribeSObjectResult oFACObjectSchema = Schema.SObjectType.Financial_Account_Customer__c;
    private static final Map<string, Schema.SObjectField> mapFields = oFACObjectSchema.fields.getMap();

    //Properties
    public Id FACObjectId {get;set;}
    public integer PageSize {get;set;}
    public boolean AllowShowMore {get;set;}

    public List<FACObjectHistory> FACObjectHistories {
        get { return getFACObjectHistory(FACObjectId); }
    }

    //Constructors

    /**
     * Default Constructor
     */
    public FACObjectHistoryController() {
        PageSize = 5;   
        AllowShowMore = true;
    }

    //Public Methods
    public void showMore() {
        PageSize += 5;
    }

    //Private Methods

    /**
     * Returns FACObject History records associated to the current FACObject
     *
     * @param   FACObjectId     the FACObject__c record id to retrieve
     * @return  a list of FACObjectHistory objects
     */
    private List<FACObjectHistory> getFACObjectHistory(Id FACObjectId) {
        List<FACObjectHistory> listFACObjectHistory = new List<FACObjectHistory>();

        if (FACObjectId != null) {
            DateTime dLastCreatedDate = null;

            integer limitPlusOne = PageSize + 1;

            List<Financial_Account_Customer__History> listEntityHistory = [SELECT Id, Field, NewValue, OldValue, CreatedDate, CreatedById, CreatedBy.Name FROM Financial_Account_Customer__History WHERE ParentId = :FACObjectId ORDER BY CreatedDate DESC, Id DESC LIMIT :limitPlusOne];
            AllowShowMore = (listEntityHistory.size() == limitPlusOne);

            for (Financial_Account_Customer__History oHistory : listEntityHistory) {
                FACObjectHistory oFACObjectHistory = new FACObjectHistory(oHistory);

                if (mapFields.containsKey(oHistory.Field)) {
                    oFACObjectHistory.FieldLabel = mapFields.get(oHistory.Field).getDescribe().Label;
                }

                if (dLastCreatedDate == oHistory.CreatedDate) {
                    oFACObjectHistory.ShowDateAndUser = false;
                }
                else {
                    oFACObjectHistory.ShowDateAndUser = true;
                }

                listFACObjectHistory.add(oFACObjectHistory);
                dLastCreatedDate = oHistory.CreatedDate;

                if (listFACObjectHistory.size() == PageSize) break;
            }
        }

        return listFACObjectHistory;
    }

    //Internal Classes

    /**
     * Data structure representing a FACObject History record for display
     */
    public class FACObjectHistory {
        //Properties
        public boolean ShowDateAndUser {get;set;}
        public string FieldLabel {get;set;}
        public Financial_Account_Customer__History History {get; private set;}

        public string ActionFormat {
            get { return getActionFormat(); }
        }

        public FACObjectHistory(Financial_Account_Customer__History oHistory) {
            History = oHistory;
        }

        //Constructors
        public FACObjectHistory() {
            showDateAndUser = true;
        }

        //Private Methods
        private string getActionFormat() {
            string sActionFormat = '';

            if (History != null) {
                sActionFormat = 'Record {0}.';

                if (History.newValue != null && History.oldValue == null) {
                    sActionFormat = 'Changed <strong>{1}</strong> to <strong>{3}</strong>.';    
                }
                else if (History.newValue != null && History.oldValue != null) {
                    sActionFormat = 'Changed <strong>{1}</strong> from {2} to <strong>{3}</strong>.';   
                }
                else if (History.Field != null && History.Field.equalsIgnoreCase('created')) {
                    sActionFormat = 'Created.';
                }
            }

            return sActionFormat;
        }
    }
}