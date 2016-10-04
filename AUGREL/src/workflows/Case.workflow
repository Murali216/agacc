<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Agent_Review_Lien_Release_Request</fullName>
        <description>Agent Review Lien Release Request</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>unfiled$public/SUPPORTCaseescalationnotificationSAMPLE</template>
    </alerts>
    <alerts>
        <fullName>Case_Email_Notification_when_Training_Publication_Date_is_Modified</fullName>
        <description>Change Control - Case - Email Notification when Training Publication Date is Modified</description>
        <protected>false</protected>
        <recipients>
            <recipient>PG_FOPP</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <recipient>PG_KM</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <recipient>PG_Training</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Training_Publication_Date_Change_Email_Notification</template>
    </alerts>
    <alerts>
        <fullName>Change_Control_Backend_Processing_FOPP</fullName>
        <description>Change Control - Backend Processing - FOPP</description>
        <protected>false</protected>
        <recipients>
            <recipient>PG_FOPP</recipient>
            <type>group</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Change_Control_Backend_Processing_FOPP</template>
    </alerts>
    <alerts>
        <fullName>Change_Control_Backend_Processing_KM</fullName>
        <description>Change Control - Backend Processing - KM</description>
        <protected>false</protected>
        <recipients>
            <recipient>PG_KM</recipient>
            <type>group</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Change_Control_Backend_Processing_KM</template>
    </alerts>
    <alerts>
        <fullName>Change_Control_Backend_Processing_Systems</fullName>
        <description>Change Control - Backend Processing - Systems</description>
        <protected>false</protected>
        <recipients>
            <recipient>PG_Systems</recipient>
            <type>group</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Change_Control_Backend_Processing_Systems</template>
    </alerts>
    <alerts>
        <fullName>Change_Control_Backend_Processing_Training</fullName>
        <description>Change Control - Backend Processing - Training</description>
        <protected>false</protected>
        <recipients>
            <recipient>PG_Training</recipient>
            <type>group</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Change_Control_Backend_Processing_Training</template>
    </alerts>
    <alerts>
        <fullName>Change_Control_Case_is_Declined</fullName>
        <description>Change Control - Change Control Case is Declined</description>
        <protected>false</protected>
        <recipients>
            <field>KM_Parent_Case_Owner__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Case_rejection_Email_to_Case_Owner</template>
    </alerts>
    <alerts>
        <fullName>Change_Control_Change_request_Close_Notification_to_requester</fullName>
        <description>Change Control - Change request Close Notification to requester</description>
        <protected>false</protected>
        <recipients>
            <field>SuppliedEmail</field>
            <type>email</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Change_Control_Change_request_Close_Notification_to_requester</template>
    </alerts>
    <alerts>
        <fullName>Change_Control_Parent_Case_Cancelled_Notification_FOPP</fullName>
        <description>Change Control - Parent Case Cancelled Notification - FOPP</description>
        <protected>false</protected>
        <recipients>
            <recipient>PG_FOPP</recipient>
            <type>group</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Change_Control_Parent_case_is_cancelled</template>
    </alerts>
    <alerts>
        <fullName>Change_Control_Parent_Case_Cancelled_Notification_KM</fullName>
        <description>Change Control - Parent Case Cancelled Notification - KM</description>
        <protected>false</protected>
        <recipients>
            <recipient>PG_KM</recipient>
            <type>group</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Change_Control_Parent_case_is_cancelled</template>
    </alerts>
    <alerts>
        <fullName>Change_Control_Parent_Case_Cancelled_Notification_Systems</fullName>
        <description>Change Control - Parent Case Cancelled Notification - Systems</description>
        <protected>false</protected>
        <recipients>
            <recipient>PG_Systems</recipient>
            <type>group</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Change_Control_Parent_case_is_cancelled</template>
    </alerts>
    <alerts>
        <fullName>Change_Control_Parent_Case_Cancelled_Notification_Training</fullName>
        <description>Change Control - Parent Case Cancelled Notification - Training</description>
        <protected>false</protected>
        <recipients>
            <recipient>PG_Training</recipient>
            <type>group</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Change_Control_Parent_case_is_cancelled</template>
    </alerts>
    <alerts>
        <fullName>Change_Control_Parent_Case_Resume_Notification_KM</fullName>
        <description>Change Control - Parent Case Resume Notification - KM</description>
        <protected>false</protected>
        <recipients>
            <recipient>PG_KM</recipient>
            <type>group</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Change_Control_Parent_case_resumed</template>
    </alerts>
    <alerts>
        <fullName>Change_Control_Parent_Case_Resume_Notification_Systems</fullName>
        <description>Change Control - Parent Case Resume Notification - Systems</description>
        <protected>false</protected>
        <recipients>
            <recipient>PG_Systems</recipient>
            <type>group</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Change_Control_Parent_case_resumed</template>
    </alerts>
    <alerts>
        <fullName>Change_Control_Parent_Case_Resume_Notification_Training</fullName>
        <description>Change Control - Parent Case Resume Notification - Training</description>
        <protected>false</protected>
        <recipients>
            <recipient>PG_Training</recipient>
            <type>group</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Change_Control_Parent_case_resumed</template>
    </alerts>
    <alerts>
        <fullName>Change_Control_Parent_Case_Resumed_Notification_FOPP</fullName>
        <description>Change Control - Parent Case Resumed Notification - FOPP</description>
        <protected>false</protected>
        <recipients>
            <recipient>PG_FOPP</recipient>
            <type>group</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Change_Control_Parent_case_resumed</template>
    </alerts>
    <alerts>
        <fullName>Change_Control_Response_to_Submitter_when_a_new_Change_Control_Case</fullName>
        <description>Change Control - Response to Submitter when a new Change Control Case</description>
        <protected>false</protected>
        <recipients>
            <field>Article_Feedback_Provided_By__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/ChangeControlNewCaseSubmission</template>
    </alerts>
    <alerts>
        <fullName>Change_Control_Send_email_to_KM_team_on_Case_Assignment_Cosmetic</fullName>
        <description>Change Control - Send email to Case Owner on Case Assignment</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/SUPPORTNewassignmentnotificationSAMPLE</template>
    </alerts>
    <alerts>
        <fullName>Change_Control_Send_reminder_email_to_Change_Control_Approval_case_owner</fullName>
        <description>Change Control - Send reminder email to Change Control Approval case owner</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Change_Control_Approval_Reminder</template>
    </alerts>
    <alerts>
        <fullName>Email_Resolution_Team</fullName>
        <description>Email Resolution Team</description>
        <protected>false</protected>
        <recipients>
            <recipient>dickerm@tfs.toyota.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>koeppes@tfs.toyota.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>langgua@tfs.toyota.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>unfiled$public/SUPPORT_Case_escalation_notification_pull_pin_the_account_to_the_1818_list</template>
    </alerts>
    <alerts>
        <fullName>Email_to_KM_team_Band5_has_approved_Change_Control_Case</fullName>
        <description>Change Control - Email to KM team - Band5 has approved Change Control Case</description>
        <protected>false</protected>
        <recipients>
            <recipient>PG_KM</recipient>
            <type>group</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Band5ApprovalNotification</template>
    </alerts>
    <alerts>
        <fullName>Follow_up_with_Customer_regarding_outstanding_information</fullName>
        <description>Follow up with Customer regarding outstanding information.</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>DefaultWorkflowUser</senderType>
        <template>unfiled$public/SUPPORTCaseescalationnotificationSAMPLE</template>
    </alerts>
    <alerts>
        <fullName>LFS_Initiated_Support_Request_Notification_to_Customer</fullName>
        <description>LFS Initiated Support Request Notification to Customer</description>
        <protected>false</protected>
        <recipients>
            <field>ContactId</field>
            <type>contactLookup</type>
        </recipients>
        <senderAddress>noreply_lexusfinancial@toyota.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Customer_Service_Automated/LFS_LFS_Initiated_Support_Request_Notification</template>
    </alerts>
    <alerts>
        <fullName>Late_Charge_Waiver_Greater_than_500</fullName>
        <description>Late Charge Waiver Greater than $500</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Late_Charge_Waiver_Greater_than_500</template>
    </alerts>
    <alerts>
        <fullName>Notify_TFS_Customer_of_Case_Created_on_their_Behalf</fullName>
        <description>Notify TFS Customer of Case Created on their Behalf</description>
        <protected>false</protected>
        <recipients>
            <field>ContactId</field>
            <type>contactLookup</type>
        </recipients>
        <senderAddress>noreply_toyotafinancial@toyota.com</senderAddress>
        <senderType>OrgWideEmailAddress</senderType>
        <template>Customer_Service_Automated/TFS_TFS_Initiated_Support_Request_Notification</template>
    </alerts>
    <alerts>
        <fullName>Notify_parent_case_owner_when_child_case_not_approved_declined_by_target_approva</fullName>
        <description>Change Control - Notify parent case owner when child case not approved/declined by target approval date</description>
        <protected>false</protected>
        <recipients>
            <field>KM_Parent_Case_Owner__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Case_not_Approved_Declined_by_Target_Approval_Date</template>
    </alerts>
    <alerts>
        <fullName>Reminder_1_Day_Prior_to_Implementation_Date</fullName>
        <description>Change Control - Reminder 1 Day Prior to Implementation Date</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Reminder_1_Day_Prior_to_Implementation_Date</template>
    </alerts>
    <alerts>
        <fullName>Reminder_1_Day_Prior_to_Publication_Date</fullName>
        <description>Change Control - Reminder 1 Day Prior to Publication Date</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Reminder_1_Day_Prior_to_Publication_Date</template>
    </alerts>
    <alerts>
        <fullName>Send_Email_to_SOPP_Change_Control_Case_not_approved</fullName>
        <description>Change Control - Send Email to SOPP - Change Control Case not approved</description>
        <protected>false</protected>
        <recipients>
            <field>KM_Parent_Case_Owner__c</field>
            <type>userLookup</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Change_Control_Not_Approved</template>
    </alerts>
    <alerts>
        <fullName>Send_Notification_when_FOPP_Publication_Date_is_Modified</fullName>
        <description>Change Control - Send Notification when FOPP Publication Date is Modified</description>
        <protected>false</protected>
        <recipients>
            <recipient>PG_FOPP</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <recipient>PG_KM</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <recipient>PG_Training</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/FOPP_Publication_Date_Change_Email_Notification</template>
    </alerts>
    <alerts>
        <fullName>Send_Notification_when_Implementation_Date_is_Modified</fullName>
        <description>Change Control - Send Notification when Implementation Date is Modified</description>
        <protected>false</protected>
        <recipients>
            <recipient>PG_FOPP</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <recipient>PG_KM</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <recipient>PG_Training</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Implementation_Date_Change_Email_Notification</template>
    </alerts>
    <alerts>
        <fullName>Send_Notification_when_Implementation_Status_is_Modified_On_Hold_Closed_Withdraw</fullName>
        <description>Change Control - Send Notification when Implementation Status is Modified - On Hold, Closed - Withdrawn or Closed - Deleted</description>
        <protected>false</protected>
        <recipients>
            <recipient>PG_FOPP</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <recipient>PG_KM</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <recipient>PG_Technology</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Implementation_Status_Set_to_On_Hold_Closed_Withdrawn_or_Closed_Deleted</template>
    </alerts>
    <alerts>
        <fullName>Send_Notification_when_KM_Publication_Date_is_Modified</fullName>
        <description>Change Control - Send Notification when KM Publication Date is Modified</description>
        <protected>false</protected>
        <recipients>
            <recipient>PG_FOPP</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <recipient>PG_KM</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <recipient>PG_Training</recipient>
            <type>group</type>
        </recipients>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/KM_Publication_Date_Change_Email_Notification</template>
    </alerts>
    <alerts>
        <fullName>Send_email_to_Case_owner_that_the_request_is_rejected</fullName>
        <description>Change Control - Send email to Case owner that the request is rejected</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Case_rejection_Email_to_Case_Owner</template>
    </alerts>
    <alerts>
        <fullName>Send_email_to_Change_Control_Approval_case_owner</fullName>
        <description>Change Control - Send email to Change Control Approval case owner</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Change_Control_Approva_Request</template>
    </alerts>
    <fieldUpdates>
        <fullName>Append_mmddyyhhmmss_to_Integration_ID</fullName>
        <description>Append &apos;~mmddyyhhmmss&apos; to Integration ID when Collection case is closed</description>
        <field>Integration_ID__c</field>
        <formula>Integration_ID__c &amp; &quot;~&quot; &amp; LPAD(TEXT(MONTH(DATEVALUE(NOW()))),2,&quot;0&quot;) &amp; LPAD(TEXT(DAY(DATEVALUE(NOW()))),2,&quot;0&quot;) &amp; LPAD(RIGHT(TEXT(YEAR(DATEVALUE(NOW()))),2),2,&quot;0&quot;) &amp; MID(TEXT(NOW()),12,2) &amp; MID(TEXT(NOW()),15,2) &amp; MID(TEXT(NOW()),18,2)</formula>
        <name>Append &apos;~mmddyyhhmmss&apos; to Integration ID</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Backend_Processing_Start</fullName>
        <description>Updates Backend Processing Start field when status set to &apos;Submitted for Backend Processing&apos;</description>
        <field>Backend_Processing_Start__c</field>
        <formula>Now()</formula>
        <name>Backend Processing Start</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Case_Create_Subject</fullName>
        <description>Concatenate Service Type and Service Request Type and insert into Subject on case creation.</description>
        <field>Subject</field>
        <formula>IF(
OR(
TEXT(Service_Request_Type__c) = &quot;General Title Inquiry&quot;,
TEXT(Service_Request_Type__c) = &quot;General Registration Inquiry&quot;),
TEXT(Category__c) &amp; &quot; - &quot; &amp; TEXT(Service_Request_Type__c) &amp; &quot; &quot; &amp; Financial_Account_Customer__r.Mailing_State__c,
TEXT(Category__c) &amp; &quot; - &quot; &amp; TEXT(Service_Request_Type__c))</formula>
        <name>Case_Create Subject</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Case_Origin_LFS</fullName>
        <description>Sets the Case Origin to LFS Community</description>
        <field>Origin</field>
        <literalValue>LFS Community</literalValue>
        <name>Case Origin LFS</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Case_Origin_TFS</fullName>
        <description>Sets the Case Origin to TFS Community</description>
        <field>Origin</field>
        <literalValue>TFS Community</literalValue>
        <name>Case Origin TFS</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Case_Status_to_External_Transfer</fullName>
        <description>Update Case Status to External Transfer</description>
        <field>Status</field>
        <literalValue>External Transfer (Closed)</literalValue>
        <name>Case Status to External Transfer</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Case_Status_to_Internal_Transfer</fullName>
        <description>Update case status to Internal Transfer</description>
        <field>Status</field>
        <literalValue>Internal Transfer (Closed)</literalValue>
        <name>Case Status to Internal Transfer</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Change_Ownership_to_Admin</fullName>
        <description>Change ownership on cases to an admin user to prevent editing by standard users</description>
        <field>OwnerId</field>
        <lookupValue>srv_sfdc_eai@tfs.toyota.com</lookupValue>
        <lookupValueType>User</lookupValueType>
        <name>Change Ownership to Admin</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Close_Case_if_no_action_taken</fullName>
        <description>IF no action is taken on a case that has been on Hold for 3 days, this will Close the case</description>
        <field>Status</field>
        <literalValue>Resolved</literalValue>
        <name>Close Case if no action taken</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Contact_Name_to_Quoted_To</fullName>
        <description>Copy Contact Name to Quoted To</description>
        <field>Quoted_To__c</field>
        <formula>LEFT(Contact_Name__c, 20)</formula>
        <name>Contact Name to Quoted To</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Denial_Reason_to_DENY_Code</fullName>
        <description>Update Denial Reason to DENY Code</description>
        <field>Denial_Reason__c</field>
        <literalValue>DENY Code</literalValue>
        <name>Denial Reason to DENY Code</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Ext_Def_TED_Notes</fullName>
        <description>Concatenates Ted Notes and Description</description>
        <field>Description</field>
        <formula>TED_Notes__c &amp; &quot; &quot; &amp; Description</formula>
        <name>Ext &amp; Def - TED Notes</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Front_End_Approval_Process_Start</fullName>
        <description>Updates Front End Approval Process Start field when status set to &apos;Submitted for Approval&apos;</description>
        <field>Front_End_Approval_Process_Start__c</field>
        <formula>Now()</formula>
        <name>Front End Approval Process Start</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Last_Modified_Lan_Id_update</fullName>
        <description>Used to update the Last Modified By custom field with the Lan Id for TIBCO/STARS</description>
        <field>Last_Modified_by_Lan_Id__c</field>
        <formula>$User.Lan_Id__c</formula>
        <name>Last Modified Lan Id Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Lien_Case_Status_Hold</fullName>
        <description>Updates Lien Process Status and moves the Case into the Lien Process Queue</description>
        <field>Status</field>
        <literalValue>Hold</literalValue>
        <name>Lien Case Status &quot;Hold&quot;</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Lien_Case_Status_In_Process</fullName>
        <description>Lien Case moves to In Process</description>
        <field>Status</field>
        <literalValue>In Process</literalValue>
        <name>Lien Case Status &quot;In Process&quot;</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>RL_Capture_Initial_Assignee</fullName>
        <field>RL_Initial_Assignee__c</field>
        <formula>Owner:User.FirstName &amp; &quot; &quot; &amp; Owner:User.LastName</formula>
        <name>RL Capture Initial Assignee</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>RL_Capture_Initial_Assignment_Time</fullName>
        <field>RL_Initial_Assignment_Time__c</field>
        <formula>NOW()</formula>
        <name>RL Capture Initial Assignment Time</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>RL_Capture_Secondary_Assignment_Time</fullName>
        <field>RL_Secondary_Assignment_Time__c</field>
        <formula>NOW()</formula>
        <name>RL Capture Secondary Assignment Time</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>RL_Initial_Pass_Completion_Time</fullName>
        <field>RL_Initial_Pass_Completion_Time__c</field>
        <formula>NOW()</formula>
        <name>RL Initial Pass Completion Time</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>RL_Secondary_Pass_Completion_Time</fullName>
        <field>RL_Secondary_Pass_Completion_Time__c</field>
        <formula>NOW()</formula>
        <name>RL Secondary Pass Completion Time</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>RL_Set_Hold_Status</fullName>
        <field>Status</field>
        <literalValue>On Hold</literalValue>
        <name>RL Set Hold Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>RL_Update_Subject</fullName>
        <description>Updates subject for a rights letter case to the FA# - FormRule (ST)</description>
        <field>Subject</field>
        <formula>IF(ISBLANK(Financial_Account__c), &quot;Rights Letter - Needs Account Lookup&quot;, &quot;Rights Letter - &quot; &amp; Financial_Account__r.Financial_Account_Number__c &amp; &quot; - &quot; &amp; Form_Rule__r.Name &amp; IF(ISNUMBER(RIGHT(Form_Rule__r.Form__c, 1)) &amp;&amp; NOT(RIGHT(Form_Rule__r.Name, 1) = &quot;)&quot;), &quot; (&quot; &amp; RL_State_of_Jurisdiction__c &amp; &quot;)&quot;, &quot;&quot;))</formula>
        <name>RL Update Subject</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Resolved_Web_To_Case</fullName>
        <field>OwnerId</field>
        <lookupValue>WebToCase_Contact_Us_Resolved_Queue</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Resolved Web-To-Case</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Initial_RL_score_value</fullName>
        <field>Initial_RL_Score__c</field>
        <formula>IF(RL_System_Required_Notice_Date_Time__c &lt; NOW(), 900, 
     IF(8 - (DATEVALUE(RL_System_Required_Notice_Date_Time__c) - TODAY()) &lt;= 1, 100, (8 - (DATEVALUE(RL_System_Required_Notice_Date_Time__c) - TODAY())) * 100)
)+
IF(Form_Rule__r.Certified__c, 50, 0)</formula>
        <name>Set Initial RL score value</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Set_Reopened_Flag</fullName>
        <field>Reopened__c</field>
        <literalValue>1</literalValue>
        <name>Set Reopened Flag</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Signature_Required_True</fullName>
        <description>Signature Required = True</description>
        <field>Signature_Required_Checkbox__c</field>
        <literalValue>1</literalValue>
        <name>Signature Required = True</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Start_Process_Update_Payment_Channel</fullName>
        <description>Start a Process Updates Payment Channel to WUSP</description>
        <field>Payment_Channel__c</field>
        <literalValue>WUSP</literalValue>
        <name>Start Process Update Payment Channel</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Start_a_Process_Credit_Dispute_Update</fullName>
        <description>Update the Case Owner to the Credit Dispute Team Queue</description>
        <field>OwnerId</field>
        <lookupValue>Credit_Dispute_Team_Queue</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Start a Process Credit Dispute Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Start_a_Process_Misapplied_Pay_Agent_Rev</fullName>
        <description>Start a Process Misapplied Pay Agent Review - Requires Agent Review and places Case in Resolution Team Queue with a notification</description>
        <field>OwnerId</field>
        <lookupValue>Resolution_Team_Queue</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Start a Process Misapplied Pay Agent Rev</name>
        <notifyAssignee>true</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Start_a_Process_Misapplied_Pay_Status</fullName>
        <description>Start a Process Misapplied Pay Status updates to &quot;In Process&quot;</description>
        <field>Status</field>
        <literalValue>In Process</literalValue>
        <name>Start a Process Misapplied Pay Status</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Start_a_Process_Misapplied_Payment_Owner</fullName>
        <description>Start a Process Misapplied Payment Case Owner updates to Admin Exchange Team Queue</description>
        <field>OwnerId</field>
        <lookupValue>Admin_Exchange_Team_Queue</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Start a Process Misapplied Payment Owner</name>
        <notifyAssignee>true</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Start_a_Process_Pay_Record_Type_Update</fullName>
        <description>Start a Process Payment Record Type Update</description>
        <field>RecordTypeId</field>
        <lookupValue>UC_Payment_Process</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Start a Process Pay Record Type Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Start_a_Process_Refund_Admin</fullName>
        <description>Changes Case Ownership to Admin Exchange TEam</description>
        <field>OwnerId</field>
        <lookupValue>Admin_Exchange_Team_Queue</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Start a Process Refund - Admin</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Start_a_Process_Refund_Escalated</fullName>
        <description>Updates the Case Status to Escalated when a Escalated Reason is selected and the case is saved</description>
        <field>Status</field>
        <literalValue>Escalated</literalValue>
        <name>Start a Process Refund - Escalated</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Start_a_Process_Refund_In_Process</fullName>
        <description>Updated the Status of the Refund Case to In Process once an agent enters in information and saves the case</description>
        <field>Status</field>
        <literalValue>In Process</literalValue>
        <name>Start a Process Refund - In Process</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Start_a_Process_Refund_Resolution_Team</fullName>
        <description>Changes the Case owner to the Resolution Team Queue</description>
        <field>OwnerId</field>
        <lookupValue>Resolution_Team_Queue</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Start a Process Refund - Resolution Team</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Start_a_Process_Refund_Update_From_Acct</fullName>
        <description>Updates the From Account to match the FA</description>
        <field>From_Account__c</field>
        <formula>Financial_Account__r.Name</formula>
        <name>Start a Process Refund Update From Acct#</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Start_a_Process_Title_Record_Type_Update</fullName>
        <description>Start a Process Title Record Type Update</description>
        <field>RecordTypeId</field>
        <lookupValue>UC_Title_Process</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Start a Process Title Record Type Update</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Sub_Status_to_Blank</fullName>
        <description>Updates the sub-status to null</description>
        <field>Sub_Status__c</field>
        <name>Sub Status to Blank</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Sub_Status_to_Waiting_For_Approval</fullName>
        <description>Updates Sub Status to Waiting For Approval</description>
        <field>Sub_Status__c</field>
        <literalValue>Waiting For Approval</literalValue>
        <name>Sub Status to Waiting For Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Sub_Status_to_Waiting_on_Customer</fullName>
        <description>update Case SubStatus to Waiting on Customer</description>
        <field>Sub_Status__c</field>
        <literalValue>Waiting on Customer</literalValue>
        <name>Sub Status to Waiting on Customer</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Transfer_To_AutoVin</fullName>
        <description>Set the Transfer Field to AutoVin</description>
        <field>Transfer_To__c</field>
        <literalValue>AutoVin</literalValue>
        <name>Transfer To AutoVin</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Transfer_To_Provider_Dealer</fullName>
        <description>Set Transfer To to &apos;Provider/Dealer&apos;</description>
        <field>Transfer_To__c</field>
        <literalValue>Provider/Dealer</literalValue>
        <name>Transfer To Provider/Dealer</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Transfer_To_TMIS</fullName>
        <description>Update Transfer To to TMIS</description>
        <field>Transfer_To__c</field>
        <literalValue>TMIS</literalValue>
        <name>Transfer To TMIS</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UC_Title_Owner_CriticalEscalations</fullName>
        <description>Updates Owner of Case to Critical Escalations</description>
        <field>OwnerId</field>
        <lookupValue>Admin_Critical_Escalations</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>UC_Title_Owner_CriticalEscalations</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UC_Title_Owner_CustCore</fullName>
        <description>Updates Owner of Case to Admin - Customer Correspondence</description>
        <field>OwnerId</field>
        <lookupValue>Admin_Customer_Correspondence</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>UC_Title_Owner_CustCore</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UC_Title_Owner_DiscFUp</fullName>
        <description>Updates Owner of Case to Admin - Discrepant &amp; F/Up</description>
        <field>OwnerId</field>
        <lookupValue>Admin_Discrepant_F_Up</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>UC_Title_Owner_DiscFUp</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UC_Title_Owner_Escalations</fullName>
        <description>Updates Owner of Case to Admin - Escalations</description>
        <field>OwnerId</field>
        <lookupValue>Admin_Escalations</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>UC_Title_Owner_Escalations</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UC_Title_Owner_LeaseTerm</fullName>
        <description>Updates Owner of Case to Admin - Lease Term</description>
        <field>OwnerId</field>
        <lookupValue>Admin_Lease_Term</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>UC_Title_Owner_LeaseTerm</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UC_Title_Owner_PIFELTHSBC</fullName>
        <description>Updates Owner of Case to PIF - ELT HSBC</description>
        <field>OwnerId</field>
        <lookupValue>PIF_ELT_HSBC</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>UC_Title_Owner_PIFELTHSBC</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UC_Title_Owner_PIFELTPortal</fullName>
        <description>Updates Owner of Case to PIF - ELT Portal</description>
        <field>OwnerId</field>
        <lookupValue>PIF_ELT_Portal</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>UC_Title_Owner_PIFELTPortal</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UC_Title_Owner_PIFELTReg</fullName>
        <description>Updates Owner of Case to PIF - ELT Regular</description>
        <field>OwnerId</field>
        <lookupValue>PIF_ELT_Regular</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>UC_Title_Owner_PIFELTReg</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UC_Title_Owner_PIFLeaseReg</fullName>
        <description>Updates Owner of Case to PIF - Lease Regular</description>
        <field>OwnerId</field>
        <lookupValue>PIF_Lease_Regular</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>UC_Title_Owner_PIFLeaseReg</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UC_Title_Owner_PIFRetPortal</fullName>
        <description>Updates Owner of Case to PIF - Retail Portal</description>
        <field>OwnerId</field>
        <lookupValue>PIF_Retail_Portal</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>UC_Title_Owner_PIFRetPortal</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UC_Title_Owner_PIFRetReg</fullName>
        <description>Updates Owner of Case to PIF - Retail Regular</description>
        <field>OwnerId</field>
        <lookupValue>PIF_Retail_Regular</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>UC_Title_Owner_PIFRetReg</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UC_Title_Owner_PIFSpec</fullName>
        <description>Updates Owner of Case to Admin - PIF Specialists</description>
        <field>OwnerId</field>
        <lookupValue>Admin_PIF_Specialists</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>UC_Title_Owner_PIFSpec</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UC_Title_Owner_RepoRR</fullName>
        <description>Updates Owner of Case to Admin - Repo/R&amp;R</description>
        <field>OwnerId</field>
        <lookupValue>Admin_Repo_R_R</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>UC_Title_Owner_RepoRR</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UC_Title_Owner_STS</fullName>
        <description>Updates Owner of Case to Admin - State to State</description>
        <field>OwnerId</field>
        <lookupValue>Admin_State_to_State</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>UC_Title_Owner_STS</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UC_Title_Owner_TOETOL</fullName>
        <description>Updates Owner of Case to Admin - TOE/TOL</description>
        <field>OwnerId</field>
        <lookupValue>Admin_TOE_TOL</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>UC_Title_Owner_TOETOL</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>UC_UpdateRunRules</fullName>
        <description>Updates RunRules to False</description>
        <field>RunRules__c</field>
        <literalValue>0</literalValue>
        <name>UC_UpdateRunRules</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Upd_Owner_to_SOP_Queue</fullName>
        <field>OwnerId</field>
        <lookupValue>Planning_and_Ops_Support</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Upd Owner to SOP Queue</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Case_Owner_Group_Field</fullName>
        <description>Updates the &apos;Case Owner Group&apos; field with the original case queue name</description>
        <field>Case_Owner_Group__c</field>
        <formula>Owner:Queue.QueueName</formula>
        <name>Update Case Owner Group Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Case_Status_FrontEndApproved</fullName>
        <description>Updates Change Control Case status to &quot;Front End Approved&quot;</description>
        <field>Status</field>
        <literalValue>Front End Approved</literalValue>
        <name>Update Case Status - FrontEndApproved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Comm_Comments_Authorized_Party</fullName>
        <description>Updates the Communication Comments Field when a Edit Profile Account Profile Update Case is Created</description>
        <field>Communication_Comments__c</field>
        <formula>Authorized_Third_Party__c + &quot; &quot; + TEXT(Authorization_Type__c) + &quot; &quot; + TEXT(Authorization_Expiration__c) + &quot; &quot; + TEXT(Good_Thru_Date__c) + &quot; &quot; + (Other__c) + &quot; &quot; +

IF(INCLUDES(Type_of_Authorization_Granted__c,&quot;Full Authorization&quot;), &quot;Full Authorization,&quot;, &quot;&quot;) +
IF(INCLUDES(Type_of_Authorization_Granted__c,&quot;Discuss all Info&quot;), &quot;Discuss all Info,&quot;, &quot;&quot;) +
IF(INCLUDES(Type_of_Authorization_Granted__c,&quot;Release Payoff Info&quot;), &quot;Release Payoff Info,&quot;, &quot;&quot;) +
IF(INCLUDES(Type_of_Authorization_Granted__c,&quot;Other&quot;), &quot;Other,&quot;, &quot;&quot;)</formula>
        <name>Update Comm Comments Authorized Party</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Complaint_Process_Case_Owner</fullName>
        <description>Updates Complaint Process Case Owner to Resolution Team when Case is escalated.</description>
        <field>OwnerId</field>
        <lookupValue>Resolution_Team_Queue</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Update Complaint Process Case Owner</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Customer_Address_Field</fullName>
        <description>Update Customer Address Field</description>
        <field>Customer_Address__c</field>
        <formula>IF(Financial_Account_Customer__r.Customer_Full_Name__c=&quot;&quot;,&quot;&quot;, Financial_Account_Customer__r.Customer_Full_Name__c + BR()) +
IF(Financial_Account_Customer__r.Mailing_Street_Garage__c=&quot;&quot;,&quot;&quot;, Financial_Account_Customer__r.Mailing_Street_Garage__c + BR()) +
IF(Financial_Account_Customer__r.Mailing_City_Garage__c=&quot;&quot;,&quot;&quot;, Financial_Account_Customer__r.Mailing_City_Garage__c + &quot; &quot; + TEXT(Financial_Account_Customer__r.Mailing_State_Garage__c) + &quot; &quot;) +
IF(Financial_Account_Customer__r.Mailing_Postal_Code_Garage__c=&quot;&quot;,&quot;&quot;, Financial_Account_Customer__r.Mailing_Postal_Code_Garage__c + BR())</formula>
        <name>Update Customer Address Field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Denial_Reason_to_MSTL_Denied</fullName>
        <description>Update Denial Reason to MSTL Denied</description>
        <field>Denial_Reason__c</field>
        <literalValue>MSTL Denied</literalValue>
        <name>Update Denial Reason to MSTL Denied</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Description_for_DDC</fullName>
        <description>Support Request Description custom field limited to 1,990 characters (+10 for case number) to support STARS limits.  Standard Description field being updated because this field is being sent to STARS.</description>
        <field>Description</field>
        <formula>CaseNumber + &apos; | DDC &apos; + LPAD(BLANKVALUE(TEXT(Requested_Due_Date_Day_of_Month__c), &apos;&apos;), 2, &apos;0&apos;) + &apos; | &apos; + Support_Request_Description__c</formula>
        <name>Update Description for DDC</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Description_for_Support_Request</fullName>
        <description>Support Request Description custom field limited to 1,990 characters (+10 for case number) to support STARS limits.  Standard Description field being updated because this field is being sent to STARS.</description>
        <field>Description</field>
        <formula>CaseNumber + &apos; | &apos; + Support_Request_Description__c</formula>
        <name>Update Description for Support Request</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Escalated_Field_on_Case</fullName>
        <description>Updates the escalated field to true</description>
        <field>IsEscalated</field>
        <literalValue>1</literalValue>
        <name>Update Escalated Field on Case</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Front_End_Approval_Process_End</fullName>
        <description>Updates Front End Approval Process End field when status set to &apos;Front End Approved&apos;</description>
        <field>Front_End_Approval_Process_End__c</field>
        <formula>Now()</formula>
        <name>Update Front End Approval Process End</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Lien_Release_Case_Owner</fullName>
        <description>Updates the Lien Process Case Owner to the Lien Release Queue</description>
        <field>OwnerId</field>
        <lookupValue>Lien_Release_Queue</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Update Lien Release Case Owner</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Owner_To_Admin_Discrepant_F_U</fullName>
        <description>Update Owner To Admin - Discrepant &amp; F/U</description>
        <field>OwnerId</field>
        <lookupValue>Admin_Discrepant_F_Up</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Update Owner To Admin - Discrepant &amp; F/U</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Owner_To_Retail_Extension_Queue</fullName>
        <description>Update Owner To Retail Extension Queue</description>
        <field>OwnerId</field>
        <lookupValue>Retail_Extension_Queue</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Update Owner To Retail Extension Queue</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Owner_To_Team_Lead_Queue</fullName>
        <description>Update Owner To Team Lead Queue</description>
        <field>OwnerId</field>
        <lookupValue>Team_Lead_Queue</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Update Owner To Team Lead Queue</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Owner_to_Accounts_Manager_Queue</fullName>
        <description>Update Owner to Accounts Manager Queue</description>
        <field>OwnerId</field>
        <lookupValue>Customer_Accounts_Manager_Queue</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Update Owner to Accounts Manager Queue</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Owner_to_Admin_Holding_Queue</fullName>
        <field>OwnerId</field>
        <lookupValue>Admin_Holding_Queue</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Update Owner to Admin Holding Queue</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Owner_to_Admin_Queue</fullName>
        <description>Update Owner to Admin Queue</description>
        <field>OwnerId</field>
        <lookupValue>Admin_Queue</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Update Owner to Admin Queue</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Owner_to_Credit_Dispute_Team</fullName>
        <description>Update Owner to Credit Dispute Team</description>
        <field>OwnerId</field>
        <lookupValue>Credit_Dispute_Team_Queue</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Update Owner to Credit Dispute Team</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Owner_to_Dealer_Portal_Lease_Payo</fullName>
        <description>Updates Owner to Dealer Portal Lease Payoff.</description>
        <field>OwnerId</field>
        <lookupValue>Dealer_Portal_Lease_Payoff</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Update Owner to Dealer Portal Lease Payo</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Owner_to_Exchange_Team_Queue</fullName>
        <description>Update Case Owner to Admin Exchange Team Queue</description>
        <field>OwnerId</field>
        <lookupValue>Admin_Exchange_Team_Queue</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Update Owner to Exchange Team Queue</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Owner_to_Late_Charge_Waiver_Queue</fullName>
        <description>Update Owner to Late Charge Waiver Queue</description>
        <field>OwnerId</field>
        <lookupValue>Late_Charge_Waiver_Queue</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Update Owner to Late Charge Waiver Queue</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Owner_to_Lease_Deferral_Queue</fullName>
        <description>Update Owner to Lease Deferral Queue</description>
        <field>OwnerId</field>
        <lookupValue>Lease_Deferral_Queue</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Update Owner to Lease Deferral Queue</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Owner_to_Manager_Queue</fullName>
        <description>Updates the owner field to the manager queue</description>
        <field>OwnerId</field>
        <lookupValue>Manager_Queue</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Update Owner to Manager Queue</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Owner_to_Resolution_Team_Queue</fullName>
        <description>Update Owner to Resolution Team Queue</description>
        <field>OwnerId</field>
        <lookupValue>Resolution_Team_Queue</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Update Owner to Resolution Team Queue</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Service_Recipient_Borrower</fullName>
        <description>Updates the Service Recipient to &apos;Borrower/Customer&apos;</description>
        <field>Service_Recipient__c</field>
        <literalValue>Borrower/Customer</literalValue>
        <name>Update Service Recipient Borrower</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Service_Recipient_Co_borrower</fullName>
        <description>Updates the Service Recipient to &apos;Co-borrower/Customer&apos;</description>
        <field>Service_Recipient__c</field>
        <literalValue>Co-Borrower/Customer</literalValue>
        <name>Update Service Recipient Co-borrower</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Service_Result_to_Denied_Ext</fullName>
        <description>Update Service Result to Denied Extension/Deferral Req</description>
        <field>Service_Result__c</field>
        <literalValue>Denied Extension/Deferral Req</literalValue>
        <name>Update Service Result to Denied Ext</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Short_Description</fullName>
        <description>Update short version of Description</description>
        <field>Short_Description__c</field>
        <formula>left(Description,50)</formula>
        <name>Update Short Description</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_To_Hold</fullName>
        <description>Update Status To Hold</description>
        <field>Status</field>
        <literalValue>Hold</literalValue>
        <name>Update Status To Hold</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_To_New</fullName>
        <description>Update Status To New</description>
        <field>Status</field>
        <literalValue>New</literalValue>
        <name>Update Status To New</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_To_Resolved</fullName>
        <description>Update Status To Resolved</description>
        <field>Status</field>
        <literalValue>Resolved</literalValue>
        <name>Update Status To Resolved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_to_Escalated</fullName>
        <description>Updates status on the case to &apos;Escalated&apos;</description>
        <field>Status</field>
        <literalValue>Escalated</literalValue>
        <name>Update Status to Escalated</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Status_to_In_Process</fullName>
        <description>Update Status to In Process</description>
        <field>Status</field>
        <literalValue>In Process</literalValue>
        <name>Update Status to In Process</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Sub_Status_Waiting_For_Approval</fullName>
        <description>Update Sub Status to Waiting For Approval</description>
        <field>Sub_Status__c</field>
        <literalValue>Waiting For Approval</literalValue>
        <name>Update Sub Status Waiting For Approval</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Sub_Status_to_Blank</fullName>
        <description>Update Sub Status to Blank</description>
        <field>Sub_Status__c</field>
        <name>Update Sub Status to Blank</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Sub_Status_to_Request_Approved</fullName>
        <description>Update Sub Status to Request Approved</description>
        <field>Sub_Status__c</field>
        <literalValue>Request Approved</literalValue>
        <name>Update Sub Status to Request Approved</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Sub_Status_to_Request_Denied</fullName>
        <description>Update Sub Status to Request Denied</description>
        <field>Sub_Status__c</field>
        <literalValue>Request Denied</literalValue>
        <name>Update Sub Status to Request Denied</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_Subject</fullName>
        <field>Subject</field>
        <formula>TEXT(Service_Request_Subject__c)</formula>
        <name>Update Subject</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_UC_Complaint_Process_Record_Type</fullName>
        <description>Updates the Case to the UC - Complaint Process Record Type and Complaint Process PageLayout</description>
        <field>RecordTypeId</field>
        <lookupValue>UC_Log_Complaint</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Update UC Complaint Process Record Type</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>uc_title_owner_PIFLeasePortal</fullName>
        <description>Updates Owner of Case to PIF - Lease Portal</description>
        <field>OwnerId</field>
        <lookupValue>PIF_Lease_Portal</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>uc_title_owner_PIFLeasePortal</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>uc_title_owner_PIFRetHSBC</fullName>
        <description>Updates Owner of Case to PIF - Retail HSBC</description>
        <field>OwnerId</field>
        <lookupValue>PIF_Retail_HSBC</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>uc_title_owner_PIFRetHSBC</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>uc_title_owner_heldPIF</fullName>
        <description>Updates Owner of Case to PIF - Held PIF</description>
        <field>OwnerId</field>
        <lookupValue>PIF_Held_PIF</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>uc_title_owner_heldPIF</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <flowActions>
        <fullName>Change_Control_Backend_Processing</fullName>
        <description>This is part of Change Control process and the flow submits backend processing to next group (Training and/or KM) team</description>
        <flow>Change_Control_Backend_Processing_V3</flow>
        <flowInputs>
            <name>vCaseId</name>
            <value>{!Id}</value>
        </flowInputs>
        <label>Change Control - Backend Processing</label>
        <language>en_US</language>
        <protected>false</protected>
    </flowActions>
    <flowActions>
        <fullName>RL_Close_Parent_Case</fullName>
        <flow>RL_Close_Parent_Case</flow>
        <flowInputs>
            <name>sRLChildCase</name>
            <value>{!this}</value>
        </flowInputs>
        <label>RL Close Parent Case</label>
        <language>en_US</language>
        <protected>false</protected>
    </flowActions>
    <flowActions>
        <fullName>RL_Create_Child_Quality_Review_Case</fullName>
        <flow>RL_Create_Rights_Letter_Quality_Review_Case</flow>
        <flowInputs>
            <name>sRLParentCase</name>
            <value>{!this}</value>
        </flowInputs>
        <label>RL Create Child Quality Review Case</label>
        <language>en_US</language>
        <protected>false</protected>
    </flowActions>
    <flowActions>
        <fullName>Update_Children_Cases</fullName>
        <description>Updates all children cases when Parent case owner is changed,</description>
        <flow>Change_Control_Update_Child_Cases</flow>
        <flowInputs>
            <name>vCaseId</name>
            <value>{!Id}</value>
        </flowInputs>
        <flowInputs>
            <name>vChangeOwner</name>
            <value>True</value>
        </flowInputs>
        <flowInputs>
            <name>vOwnerId</name>
            <value>{!OwnerId}</value>
        </flowInputs>
        <label>Update Children Cases</label>
        <language>en_US</language>
        <protected>false</protected>
    </flowActions>
    <flowActions>
        <fullName>Update_Parent_Case_Approval_Count</fullName>
        <description>This flow subtracts by one and updates Parent case approval count for Change Control Case</description>
        <flow>KM_Update_Approval_Count</flow>
        <flowInputs>
            <name>vNewApprovaCount</name>
            <value>{!Parent.KM_approval_Count__c}</value>
        </flowInputs>
        <flowInputs>
            <name>vParentCaseId</name>
            <value>{!Parent.Id}</value>
        </flowInputs>
        <label>Update Parent Case Approval Count</label>
        <language>en_US</language>
        <protected>false</protected>
    </flowActions>
    <flowActions>
        <fullName>Update_children_Cases_Change_Status_Submitted_for_Approval</fullName>
        <description>Change Control - When Parent Case status is changed to Closed - Cancelled or On Hold and prior value is Submitted for Approval, this flow updates all children Case status to &quot;Closed - Cancelled&quot; and adds a case comment</description>
        <flow>Change_Control_Update_Child_Cases_Submitted_for_Approval</flow>
        <flowInputs>
            <name>vCaseId</name>
            <value>{!Id}</value>
        </flowInputs>
        <flowInputs>
            <name>vStatus</name>
            <value>{!Status}</value>
        </flowInputs>
        <label>Update children Cases - Change Status - Submitted for Approval</label>
        <language>en_US</language>
        <protected>false</protected>
    </flowActions>
    <flowActions>
        <fullName>Update_children_Cases_Change_Status_Submitted_to_Backend</fullName>
        <description>Change Control - When Parent Case status is changed to Closed - Cancelled and prior value is Submitted to Backend, this flow Sends email to all Backend processing teams that are affected</description>
        <flow>Change_Control_Update_Child_Cases_Submitted_to_Backend</flow>
        <flowInputs>
            <name>vCaseId</name>
            <value>{!Id}</value>
        </flowInputs>
        <flowInputs>
            <name>vFOPPImpact</name>
            <value>{!KM_FOPP_Impact__c}</value>
        </flowInputs>
        <flowInputs>
            <name>vKMImpact</name>
            <value>{!KM_Impact__c}</value>
        </flowInputs>
        <flowInputs>
            <name>vSystemsImpact</name>
            <value>{!KM_Systems_Impact__c}</value>
        </flowInputs>
        <flowInputs>
            <name>vTrainingImpact</name>
            <value>{!KM_Training_Impact__c}</value>
        </flowInputs>
        <label>Update children Cases - Change Status - Submitted to Backend</label>
        <language>en_US</language>
        <protected>false</protected>
    </flowActions>
    <outboundMessages>
        <fullName>Publish_Case_To_TFS</fullName>
        <apiVersion>30.0</apiVersion>
        <description>Sends Case fields to TFS</description>
        <endpointUrl>https://intsvcs-test1.services.toyotafinancial.com/TFS/Services/ServiceRequest/Case</endpointUrl>
        <fields>Abbreviated_Consent_Date__c</fields>
        <fields>Abbreviated_Consent__c</fields>
        <fields>Acceptable_Payment_Plan__c</fields>
        <fields>AccountId</fields>
        <fields>Action__c</fields>
        <fields>Address_Type__c</fields>
        <fields>Affiliate_Marketing_Privacy__c</fields>
        <fields>All_Privacy_Options__c</fields>
        <fields>Alternate_Address__c</fields>
        <fields>Amount_Waived__c</fields>
        <fields>AssetId</fields>
        <fields>Attorney_If_any__c</fields>
        <fields>Authorization_Received__c</fields>
        <fields>CaseNumber</fields>
        <fields>Category__c</fields>
        <fields>Certified_Used__c</fields>
        <fields>ClosedDate</fields>
        <fields>Collection_Counter_Promises_Broken__c</fields>
        <fields>Collection_Counter_Promises_Kept__c</fields>
        <fields>Collection_Current_Promise_Status__c</fields>
        <fields>Collection_Last_List__c</fields>
        <fields>Collection_List_Description__c</fields>
        <fields>Collection_List_Number_1__c</fields>
        <fields>Collection_List_Number_2__c</fields>
        <fields>Collection_List_Number_3__c</fields>
        <fields>Collection_List_Status_1__c</fields>
        <fields>Collection_List_Status_2__c</fields>
        <fields>Collection_List_Status_3__c</fields>
        <fields>Collection_Number_Of_Months_Past_Due__c</fields>
        <fields>Collection_Recourse_Code__c</fields>
        <fields>Collection_Review_Date__c</fields>
        <fields>Collection_UserID__c</fields>
        <fields>Communication_Comments__c</fields>
        <fields>Complaint_Initiated_By__c</fields>
        <fields>Complaint_Submitted__c</fields>
        <fields>ContactId</fields>
        <fields>CreatedById</fields>
        <fields>CreatedDate</fields>
        <fields>Credit_App_Reporting_Privacy__c</fields>
        <fields>Current_Address_Name__c</fields>
        <fields>Current_Address__c</fields>
        <fields>Current_Care_Of__c</fields>
        <fields>Current_City__c</fields>
        <fields>Current_Email_Address__c</fields>
        <fields>Current_Fax_Number__c</fields>
        <fields>Current_Foreign_Country__c</fields>
        <fields>Current_Home_Number_DNC__c</fields>
        <fields>Current_Home_Number_INVALID__c</fields>
        <fields>Current_Home_Number_MOBILE__c</fields>
        <fields>Current_Home_Number__c</fields>
        <fields>Current_Mileage__c</fields>
        <fields>Current_Mobile_Number_DNC__c</fields>
        <fields>Current_Mobile_Number_INVALID__c</fields>
        <fields>Current_Mobile_Number_MOBILE__c</fields>
        <fields>Current_Mobile_Number__c</fields>
        <fields>Current_State__c</fields>
        <fields>Current_Work_Number_DNC__c</fields>
        <fields>Current_Work_Number_INVALID__c</fields>
        <fields>Current_Work_Number_MOBILE__c</fields>
        <fields>Current_Work_Number__c</fields>
        <fields>Current_Zip_Code_Extn__c</fields>
        <fields>Current_Zipcode__c</fields>
        <fields>Date_of_Complaint__c</fields>
        <fields>Dealer__c</fields>
        <fields>Denial_Reason__c</fields>
        <fields>Description</fields>
        <fields>Edit_Message__c</fields>
        <fields>Electronic_Business_Agreement_Date__c</fields>
        <fields>Electronic_Business_Agreement__c</fields>
        <fields>Finance_Reason__c</fields>
        <fields>Financial_Account_Customer_ID__c</fields>
        <fields>Financial_Account_Customer__c</fields>
        <fields>Financial_Account__c</fields>
        <fields>Good_Thru_Date__c</fields>
        <fields>Gross_Payoff__c</fields>
        <fields>Id</fields>
        <fields>Immediate_Action__c</fields>
        <fields>Integration_ID__c</fields>
        <fields>Interest_Time_Frame__c</fields>
        <fields>IsClosed</fields>
        <fields>IsClosedOnCreate</fields>
        <fields>IsDeleted</fields>
        <fields>IsEscalated</fields>
        <fields>Issue_Category__c</fields>
        <fields>Language_Preference__c</fields>
        <fields>LastModifiedById</fields>
        <fields>LastModifiedDate</fields>
        <fields>LastReferencedDate</fields>
        <fields>LastViewedDate</fields>
        <fields>Last_Comment__c</fields>
        <fields>Last_Modified_by_Lan_Id__c</fields>
        <fields>Mailing_Account__c</fields>
        <fields>Mailing_Address__c</fields>
        <fields>Make__c</fields>
        <fields>Marketing_Comm_Pref_Email__c</fields>
        <fields>Marketing_Comm_Pref_Home_Phone__c</fields>
        <fields>Marketing_Comm_Pref_Mobile_Phone__c</fields>
        <fields>Marketing_Comm_Pref_Text__c</fields>
        <fields>Marketing_Comm_Pref_Work_Phone__c</fields>
        <fields>Net_Payoff__c</fields>
        <fields>New_Address_Name__c</fields>
        <fields>New_Address__c</fields>
        <fields>New_Care_Of__c</fields>
        <fields>New_City__c</fields>
        <fields>New_Country__c</fields>
        <fields>New_Email_Address__c</fields>
        <fields>New_Home_Number_DNC__c</fields>
        <fields>New_Home_Number_INVALID__c</fields>
        <fields>New_Home_Number_MOBILE__c</fields>
        <fields>New_Home_Number__c</fields>
        <fields>New_Mobile_Number_DNC__c</fields>
        <fields>New_Mobile_Number_INVALID__c</fields>
        <fields>New_Mobile_Number_MOBILE__c</fields>
        <fields>New_Mobile_Number__c</fields>
        <fields>New_State__c</fields>
        <fields>New_Work_Number_DNC__c</fields>
        <fields>New_Work_Number_INVALID__c</fields>
        <fields>New_Work_Number_MOBILE__c</fields>
        <fields>New_Work_Number__c</fields>
        <fields>New_Zip_Code_Extn__c</fields>
        <fields>New_Zipcode__c</fields>
        <fields>Online_Flag__c</fields>
        <fields>Origin</fields>
        <fields>Overall_Consent_Date__c</fields>
        <fields>Overall_Consent__c</fields>
        <fields>OwnerId</fields>
        <fields>ParentId</fields>
        <fields>Payment_Amount__c</fields>
        <fields>Payment_Channel__c</fields>
        <fields>Payment_Not_Received_Email__c</fields>
        <fields>Payment_Not_Received_Text__c</fields>
        <fields>Payment_Not_Received__c</fields>
        <fields>Payment_Received_Email__c</fields>
        <fields>Payment_Received_Text__c</fields>
        <fields>Payment_Reminder_Day__c</fields>
        <fields>Payment_Reminder_Email__c</fields>
        <fields>Payment_Reminder_Text__c</fields>
        <fields>Payment_Sent_Date__c</fields>
        <fields>Payoff_Quote__c</fields>
        <fields>Per_Diem__c</fields>
        <fields>Preferred_Contact__c</fields>
        <fields>Priority</fields>
        <fields>Process_Date__c</fields>
        <fields>Program_III__c</fields>
        <fields>Program_II__c</fields>
        <fields>Program_I__c</fields>
        <fields>Purchase_Opt__c</fields>
        <fields>Quoted_To__c</fields>
        <fields>Reason</fields>
        <fields>Reason_For_Waiving_Late_Fee__c</fields>
        <fields>Recipient__c</fields>
        <fields>RecordTypeId</fields>
        <fields>Residual_Value__c</fields>
        <fields>Response_Date_Due__c</fields>
        <fields>SR_First_Name__c</fields>
        <fields>SR_Last_Name_Business_Name__c</fields>
        <fields>Self_Service_Channel__c</fields>
        <fields>Service_Recipient__c</fields>
        <fields>Service_Request_Category__c</fields>
        <fields>Service_Request_Type__c</fields>
        <fields>Service_Request_User_Group__c</fields>
        <fields>Service_Result__c</fields>
        <fields>Service_Type__c</fields>
        <fields>Source_Created_By__c</fields>
        <fields>Source_Created_Date__c</fields>
        <fields>Source_System_Created_By__c</fields>
        <fields>StarsSRNumber__c</fields>
        <fields>Status</fields>
        <fields>Sub_Status__c</fields>
        <fields>Subject</fields>
        <fields>SuppliedCompany</fields>
        <fields>SuppliedEmail</fields>
        <fields>SuppliedName</fields>
        <fields>SuppliedPhone</fields>
        <fields>SystemModstamp</fields>
        <fields>TFS_LFS_Dealer_Privacy__c</fields>
        <fields>TFS_LFS_Information_Email_Address__c</fields>
        <fields>Team_Lead_Name_Ext__c</fields>
        <fields>Telemarketing_Privacy__c</fields>
        <fields>Third_Party_Privacy__c</fields>
        <fields>TransferReason__c</fields>
        <fields>Type</fields>
        <fields>Type__c</fields>
        <fields>Warm_Transfer__c</fields>
        <includeSessionId>true</includeSessionId>
        <integrationUser>outbound.integration@toyota.com</integrationUser>
        <name>Publish Case To TFS</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <rules>
        <fullName>AutoCheque Pre 4%2F1%2F08</fullName>
        <actions>
            <name>Update_Owner_to_Resolution_Team_Queue</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Status_to_In_Process</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>If ACH Effective Date is less than 4/1/2008 system assigns case to &apos;Resolution Team Queue&apos;</description>
        <formula>AND(TEXT(Service_Request_Type__c) = &quot;Autocheque Cancellation&quot;,OR( Financial_Account__r.ACH_Original_Effective_Date__c &lt; DATE(2008,4,1),ISBLANK(Financial_Account__r.ACH_Original_Effective_Date__c)))</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>AutoCheque Queue Assignment</fullName>
        <actions>
            <name>Update_Status_To_Resolved</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Assign Autocheque cancellation cases to the ACH Cancellation Queue</description>
        <formula>AND(TEXT(Service_Request_Type__c) = &quot;Autocheque Cancellation&quot;, Financial_Account__r.ACH_Original_Effective_Date__c &gt; DATE(2008,4,1))</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Band5 Case Approved</fullName>
        <actions>
            <name>Email_to_KM_team_Band5_has_approved_Change_Control_Case</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Type</field>
            <operation>equals</operation>
            <value>Band5 Approval</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Closed - Approved</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Change Control Approval</value>
        </criteriaItems>
        <description>Change Control -  When Band5 case is approved, a notification needs to be set to KM team so they can start working on the change and getting it ready.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Case - Capture Front End Approved Date%2FTime</fullName>
        <actions>
            <name>Update_Front_End_Approval_Process_End</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Front End Approved</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Change Control</value>
        </criteriaItems>
        <description>Change Control - Captures the date/time the case was updated to front end approved</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Case - Capture Submitted for Approval Date%2FTime</fullName>
        <actions>
            <name>Front_End_Approval_Process_Start</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Submitted for Approval</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Change Control</value>
        </criteriaItems>
        <description>Change Control - Captures the date/time the case was submitted for front end approval.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Case - Create Subject</fullName>
        <actions>
            <name>Case_Create_Subject</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Short_Description</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>startsWith</operation>
            <value>UC</value>
        </criteriaItems>
        <description>Concatenate Category and Service Request Type and insert into Subject on case creation. Also updates Short Description field.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Case - Email Notification 1 Day Prior to Implementation Date</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Change Control</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.KM_Implementation_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Change Control - Remind case owner 1 day prior to implementation date</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Reminder_1_Day_Prior_to_Implementation_Date</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Case.KM_Implementation_Date__c</offsetFromField>
            <timeLength>-1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Case - Email Notification 1 Day Prior to Publication Date</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Change Control</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.KM_Publication_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Change Control - Remind case owner 1 day prior to publication date</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Reminder_1_Day_Prior_to_Publication_Date</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Case.KM_Publication_Date__c</offsetFromField>
            <timeLength>-1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Case - Email Notification when FOPP Publication Date is Modified</fullName>
        <actions>
            <name>Send_Notification_when_FOPP_Publication_Date_is_Modified</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Change Control - If FOPP publication date is modified, send email to Case Owner, FOPP Queue, Training Queue and KM Queue</description>
        <formula>NOT( ISBLANK (PRIORVALUE( KM_FOPP_Publication_Date__c ))) &amp;&amp; ISCHANGED( KM_FOPP_Publication_Date__c ) &amp;&amp; RecordType.Name == &quot;Change Control&quot;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Case - Email Notification when Implementation Date is Modified</fullName>
        <actions>
            <name>Send_Notification_when_Implementation_Date_is_Modified</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Change Control - If Implementation date is modified, send email to Case Owner, FOPP Queue, Training Queue and KM Queue</description>
        <formula>NOT( ISBLANK (PRIORVALUE( KM_Implementation_Date__c ))) &amp;&amp; ISCHANGED( KM_Implementation_Date__c ) &amp;&amp; RecordType.Name == &quot;Change Control&quot;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Case - Email Notification when Implementation Status is set to On Hold%2C Closed - Withdrawn or Closed - Deleted</fullName>
        <actions>
            <name>Send_Notification_when_Implementation_Status_is_Modified_On_Hold_Closed_Withdraw</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Change Control - If implementation status  is set to On Hold, Closed - Withdrawn or Closed - Deleted, send email to Case Owner, FOPP Queue, Technology Queue and KM Queue</description>
        <formula>(ISPICKVAL( KM_System_Status__c , &quot;On Hold&quot;) ||    ISPICKVAL( KM_System_Status__c , &quot;Closed - Withdrawn&quot;) ||   ISPICKVAL( KM_System_Status__c , &quot;Closed - Deleted&quot;) ) &amp;&amp;  RecordType.Name == &quot;Change Control&quot;</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Case - Email Notification when KM Publication Date is Modified</fullName>
        <actions>
            <name>Send_Notification_when_KM_Publication_Date_is_Modified</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Change Control - If KM publication date is modified, send email to Case Owner, FOPP Queue, Training Queue and KM Queue</description>
        <formula>NOT( ISBLANK (PRIORVALUE( KM_Publication_Date__c ))) &amp;&amp; ISCHANGED( KM_Publication_Date__c ) &amp;&amp; RecordType.Name == &quot;Change Control&quot;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Case - Email Notification when Training Publication Date is Modified</fullName>
        <actions>
            <name>Case_Email_Notification_when_Training_Publication_Date_is_Modified</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Change Control - If training publication date is modified, send email to Case Owner, FOPP Queue, Training Queue and KM Queue</description>
        <formula>NOT( ISBLANK (PRIORVALUE( KM_Training_Publication_Date__c ))) &amp;&amp; ISCHANGED( KM_Training_Publication_Date__c ) &amp;&amp; RecordType.Name == &quot;Change Control&quot;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Case - Store Original Case Owner</fullName>
        <actions>
            <name>Update_Case_Owner_Group_Field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.ParentId</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Change Control,Change Control Approval</value>
        </criteriaItems>
        <description>Change Control - Store the original owner of the case when it&apos;s created for children cases</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Case - Update Escalated Flag for Change Control Approval Cases if not Approved%2FDeclined by Target Approval Date</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Change Control Approval</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>notEqual</operation>
            <value>Closed - Declined,Closed - Approved,Closed - Cancelled</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.KM_Approval_Target_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Change Control - For child cases, if the case is not approved or declined by the Target Approval Date then we should check the Escalated flag and also send an email to Parent Case Owner</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Notify_parent_case_owner_when_child_case_not_approved_declined_by_target_approva</name>
                <type>Alert</type>
            </actions>
            <actions>
                <name>Update_Escalated_Field_on_Case</name>
                <type>FieldUpdate</type>
            </actions>
            <actions>
                <name>Update_Status_to_Escalated</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Case.KM_Approval_Target_Date__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Case Reopened</fullName>
        <actions>
            <name>Set_Reopened_Flag</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Set a flag on the case when it moves from a closed status to an open one</description>
        <formula>PRIORVALUE(IsClosed) &amp;&amp; !IsClosed</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Change Control - Backend Processing - FOPP Email</fullName>
        <actions>
            <name>Change_Control_Backend_Processing_FOPP</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 7 AND (3 AND 4) OR (5 AND 6)</booleanFilter>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Submitted to Backend</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.KM_FOPP_Impact__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.KM_Backend_Processing_Status__c</field>
            <operation>equals</operation>
            <value>Systems Implementation Date Confirmed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.KM_Systems_Impact__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.KM_Backend_Processing_Status__c</field>
            <operation>equals</operation>
            <value>Submitted to FOPP</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.KM_Systems_Impact__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Change Control</value>
        </criteriaItems>
        <description>Change Control - If Status is Submitted to Backend and there&apos;s a FOPP Impact, sends email to FOPP if 1) there&apos;s a Systems Impact and Systems has confirmed the Systems Implementation Date OR 2) there&apos;s no Systems Impact and therefore, routes to FOPP.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Change Control - Backend Processing - KM Email</fullName>
        <actions>
            <name>Change_Control_Backend_Processing_KM</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 8 AND (3 OR (4 AND 5 AND 6) OR (6 AND 7))</booleanFilter>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Submitted to Backend</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.KM_Impact__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.KM_FOPP_Publication_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Case.KM_Systems_Impact__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.KM_Backend_Processing_Status__c</field>
            <operation>equals</operation>
            <value>Systems Implementation Date Confirmed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.KM_FOPP_Impact__c</field>
            <operation>notEqual</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.KM_Systems_Impact__c</field>
            <operation>notEqual</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Change Control</value>
        </criteriaItems>
        <description>Change Control - If Status is Submitted to Backend and there&apos;s KM Impact, sends email to KM if 1) FOPP Publication Date has been or 2) No FOPP Impact, but there&apos;s Systems Impact &amp; Confirmed Date or 3) No FOPP or Systems Impact.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Change Control - Backend Processing - Systems Email</fullName>
        <actions>
            <name>Change_Control_Backend_Processing_Systems</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Change Control</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Submitted to Backend</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.KM_Systems_Impact__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Change Control - If Status is Submitted to Backend, sends email to Systems if there&apos;s a Systems Impact.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Change Control - Backend Processing - Training Email</fullName>
        <actions>
            <name>Change_Control_Backend_Processing_Training</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 8 AND (3 OR (4 AND 5 AND 6) OR (6 AND 7))</booleanFilter>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Submitted to Backend</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.KM_Training_Impact__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.KM_FOPP_Publication_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Case.KM_Systems_Impact__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.KM_Backend_Processing_Status__c</field>
            <operation>equals</operation>
            <value>Systems Implementation Date Confirmed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.KM_FOPP_Impact__c</field>
            <operation>notEqual</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.KM_Systems_Impact__c</field>
            <operation>notEqual</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Change Control</value>
        </criteriaItems>
        <description>Change Control - If Status is Submitted to Backend and there&apos;s a Training Impact, sends email to Training if 1) FOPP Publication Date has been  or 2) No FOPP Impact, but there&apos;s Systems Impact &amp; Confirmed Date or 3) No FOPP or Systems Impact.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Change Control - Backend processing - Post FOPP</fullName>
        <actions>
            <name>Change_Control_Backend_Processing</name>
            <type>FlowAction</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Change Control</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.IsClosed</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.KM_Backend_Processing_Status__c</field>
            <operation>equals</operation>
            <value>Submitted to FOPP</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.KM_FOPP_Publication_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Change Control - This workflow is triggered once FOPP Publication date is triggered to take backend processing to KM and/or Training as applicable</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Change Control - Backend processing - Post Systems</fullName>
        <actions>
            <name>Change_Control_Backend_Processing</name>
            <type>FlowAction</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.IsClosed</field>
            <operation>notEqual</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Change Control</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.KM_Backend_Processing_Status__c</field>
            <operation>equals</operation>
            <value>Systems Implementation Date Confirmed</value>
        </criteriaItems>
        <description>Change Control - When Systems team confirms implementation Date, this workflow is called to send the process to FOPP</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Change Control - Capture Submitted for Backend Processing Date%2FTime</fullName>
        <actions>
            <name>Backend_Processing_Start</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Submitted to Backend</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Change Control</value>
        </criteriaItems>
        <description>Change Control - Captures the date/time the case was updated to &apos;Submitted to Backend&apos;</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Change Control - Change request Close Notification to requester</fullName>
        <actions>
            <name>Change_Control_Change_request_Close_Notification_to_requester</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Change Control</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.IsClosed</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Change Control - Whenever a Change Control is closed, an email will be sent to original Web To Case requester.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Change Control - Email Notification when Owner is KM Queue and Priority is Cosmetic</fullName>
        <actions>
            <name>Change_Control_Send_email_to_KM_team_on_Case_Assignment_Cosmetic</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.OwnerId</field>
            <operation>equals</operation>
            <value>KM</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Priority</field>
            <operation>equals</operation>
            <value>Cosmetic</value>
        </criteriaItems>
        <description>Change Control - When Owner is KM Queue and Priority is Cosmetic, send email notification to KM Queue.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Change Control - On Hold from Submitted for Approval</fullName>
        <active>true</active>
        <description>Change Control - On Hold from Submitted for Approval</description>
        <formula>AND( RecordType.Name = &quot;Change Control&quot;, ISPICKVAL(Status, &quot;On Hold&quot;), PRIORVALUE(Status) = &quot;Submitted for Approval&quot; )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Change Control - Parent Case Cancelled Notification - FOPP</fullName>
        <actions>
            <name>Change_Control_Parent_Case_Cancelled_Notification_FOPP</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3 AND (4 OR (5 AND 6))</booleanFilter>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Change Control</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>On Hold,Closed - Cancelled</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.KM_FOPP_Impact__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.KM_Systems_Impact__c</field>
            <operation>notEqual</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.KM_Systems_Impact__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.KM_Implementation_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Change Control - If Status is On Hold/Closed-Cancelled and there&apos;s a FOPP Impact, sends email to FOPP if 1) there&apos;s a Systems Impact and Systems has confirmed the Systems Implementation Date OR 2) there&apos;s no Systems Impact and therefore, routes to FOPP.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Change Control - Parent Case Cancelled Notification - KM</fullName>
        <actions>
            <name>Change_Control_Parent_Case_Cancelled_Notification_KM</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3 AND (4 OR (5 AND 6 AND 7) OR (7 AND 8))</booleanFilter>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Change Control</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>On Hold,Closed - Cancelled</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.KM_Impact__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.KM_FOPP_Publication_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Case.KM_Systems_Impact__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.KM_Implementation_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Case.KM_FOPP_Impact__c</field>
            <operation>notEqual</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.KM_Systems_Impact__c</field>
            <operation>notEqual</operation>
            <value>True</value>
        </criteriaItems>
        <description>Change Control - If Status is On Hold/Closed - Cancelled and there&apos;s KM Impact, sends email to KM if 1) FOPP Publication Date has been or 2) No FOPP Impact, but there&apos;s Systems Impact &amp; Confirmed Date or 3) No FOPP or Systems Impact.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Change Control - Parent Case Cancelled Notification - Systems</fullName>
        <actions>
            <name>Change_Control_Parent_Case_Cancelled_Notification_Systems</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Change Control</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>On Hold,Closed - Cancelled</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.KM_Systems_Impact__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Change Control - If Status is On Hold/Closed - Cancelled, sends email to Systems if there&apos;s a Systems Impact.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Change Control - Parent Case Cancelled Notification - Training</fullName>
        <actions>
            <name>Change_Control_Parent_Case_Cancelled_Notification_Training</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3 AND (4 OR (5 AND 6 AND 7) OR (7 AND 8))</booleanFilter>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Change Control</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>On Hold,Closed - Cancelled</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.KM_Training_Impact__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.KM_FOPP_Publication_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Case.KM_Systems_Impact__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.KM_Implementation_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Case.KM_FOPP_Impact__c</field>
            <operation>notEqual</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.KM_Systems_Impact__c</field>
            <operation>notEqual</operation>
            <value>True</value>
        </criteriaItems>
        <description>Change Control - If Status is On Hold/Closed - Cancelled and there&apos;s a Training Impact, sends email to Training if 1) FOPP Publication Date has been or 2) No FOPP Impact, but there&apos;s Systems Impact &amp; Confirmed Date or 3) No FOPP or Systems Impact.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Change Control - Parent Case Resume Notification - FOPP</fullName>
        <actions>
            <name>Change_Control_Parent_Case_Resumed_Notification_FOPP</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Change Control - If Case is Resumed and there&apos;s a FOPP Impact, sends email to FOPP if 1) there&apos;s a Systems Impact and Systems has confirmed the Systems Implementation Date OR 2) there&apos;s no Systems Impact and therefore, routes to FOPP.</description>
        <formula>AND( RecordType.Name = &quot;Change Control&quot;, ISPICKVAL(Status, &quot;Submitted to Backend&quot;), ISPICKVAL(PRIORVALUE(Status), &quot;On Hold&quot;), KM_FOPP_Impact__c = True, OR( KM_Systems_Impact__c = False, AND( KM_Systems_Impact__c = True, NOT(ISNULL(KM_Implementation_Date__c)) )))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Change Control - Parent Case Resume Notification - KM</fullName>
        <actions>
            <name>Change_Control_Parent_Case_Resume_Notification_KM</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Change Control - If Case is Resumed and there&apos;s KM Impact, sends email to KM if 1) FOPP Publication Date has been or 2) No FOPP Impact, but there&apos;s Systems Impact &amp; Confirmed Date or 3) No FOPP or Systems Impact.</description>
        <formula>AND( RecordType.Name = &quot;Change Control&quot;, ISPICKVAL(Status, &quot;Submitted to Backend&quot;), ISPICKVAL(PRIORVALUE(Status), &quot;On Hold&quot;), KM_Impact__c  = True, OR( NOT(ISNULL(KM_FOPP_Publication_Date__c)), AND( KM_Systems_Impact__c = True, NOT(ISNULL(KM_Implementation_Date__c)), KM_FOPP_Impact__c = False ), AND( KM_FOPP_Impact__c = False, KM_Systems_Impact__c = False) ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Change Control - Parent Case Resume Notification - Systems</fullName>
        <actions>
            <name>Change_Control_Parent_Case_Resume_Notification_Systems</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Change Control - If  Case is Resumed, sends email to Systems if there&apos;s a Systems Impact.</description>
        <formula>AND( RecordType.Name = &quot;Change Control&quot;, ISPICKVAL(Status, &quot;Submitted to Backend&quot;), ISPICKVAL(PRIORVALUE(Status), &quot;On Hold&quot;), KM_Systems_Impact__c = True )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Change Control - Parent Case Resume Notification - Training</fullName>
        <actions>
            <name>Change_Control_Parent_Case_Resume_Notification_Training</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Change Control - If Case is Resumed and there&apos;s a Training Impact, sends email to Training if 1) FOPP Publication Date has been or 2) No FOPP Impact, but there&apos;s Systems Impact &amp; Confirmed Date or 3) No FOPP or Systems Impact.</description>
        <formula>AND(
RecordType.Name = &quot;Change Control&quot;,
ISPICKVAL(Status, &quot;Submitted to Backend&quot;),
ISPICKVAL(PRIORVALUE(Status), &quot;On Hold&quot;),
KM_Training_Impact__c = True,
OR(
NOT(ISNULL(KM_FOPP_Publication_Date__c)),
AND(
KM_Systems_Impact__c = True,
ISPICKVAL(KM_Backend_Processing_Status__c, &quot;Systems Implementation Date Confirmed&quot;),
KM_FOPP_Impact__c = False
),
AND(
KM_FOPP_Impact__c = False,
KM_Systems_Impact__c = False)
)
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Change Control - Send Email to Approver Queue</fullName>
        <actions>
            <name>Send_email_to_Change_Control_Approval_case_owner</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Change Control Approval</value>
        </criteriaItems>
        <description>Change Control - When a Change Control Approval case (child case) is Created, send email notification to the Owner (Queue Members).</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Change Control - Send Emails to Queue %26 Submitter</fullName>
        <actions>
            <name>Change_Control_Response_to_Submitter_when_a_new_Change_Control_Case</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Change_Control_Send_email_to_KM_team_on_Case_Assignment_Cosmetic</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Upd_Owner_to_SOP_Queue</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Change Control - When KM flips the Record Type from Article Feedback to Change Control, send an email notification to the SOP Queue and to the Submitter (similar to how it occurs when the Case is submitted via W2C).</description>
        <formula>AND( RecordType.DeveloperName = &quot;Change_Control&quot;, ISPICKVAL(Origin, &quot;Article Feedback&quot;) )</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Change Control Approval Reminder</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Change Control Approval</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>notEqual</operation>
            <value>Closed - Declined,Closed - Approved,Closed - Cancelled</value>
        </criteriaItems>
        <description>Change Control - Send email to Case approver 1 day before the Target approval date.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Change_Control_Send_reminder_email_to_Change_Control_Approval_case_owner</name>
                <type>Alert</type>
            </actions>
            <offsetFromField>Case.KM_Approval_Target_Date__c</offsetFromField>
            <timeLength>-1</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Change Control Approval case is declined</fullName>
        <actions>
            <name>Change_Control_Case_is_Declined</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Closed - Declined</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Change Control Approval</value>
        </criteriaItems>
        <description>Change Control - If any of the change control approval case is declined then send email to parent case owner</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Change Control Approval not approved by Target Date</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Change Control Approval</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.IsClosed</field>
            <operation>notEqual</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.KM_Approval_Target_Date__c</field>
            <operation>lessOrEqual</operation>
            <value>TODAY</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.KM_Approval_Target_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Change Control - This Workflow is triggered when an approver has neither Approved nor declined a change request past Approval Target Date. This will send email to SOPP team.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Send_Email_to_SOPP_Change_Control_Case_not_approved</name>
                <type>Alert</type>
            </actions>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Complaint Process - Escalated to Resolution Team</fullName>
        <actions>
            <name>Update_Complaint_Process_Case_Owner</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 AND 2) AND (3 OR 4 OR 5)</booleanFilter>
        <criteriaItems>
            <field>Case.Action__c</field>
            <operation>equals</operation>
            <value>Log Complaint</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Escalated</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.OwnerId</field>
            <operation>notEqual</operation>
            <value>Resolution Team Queue</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.OwnerId</field>
            <operation>notEqual</operation>
            <value>Corporate Customer Service Team</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.OwnerId</field>
            <operation>notEqual</operation>
            <value>Manager/Team Leader</value>
        </criteriaItems>
        <description>Complaint Process - Escalated to Resolution Team</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Credit Dispute Review - Set Owner</fullName>
        <actions>
            <name>Update_Owner_to_Credit_Dispute_Team</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Status_to_In_Process</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Category__c</field>
            <operation>equals</operation>
            <value>Credit</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Service_Request_Type__c</field>
            <operation>equals</operation>
            <value>Credit Bureau Disputes</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Requires_Approval__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Dispute_Reason__c</field>
            <operation>notEqual</operation>
            <value>Address Provided</value>
        </criteriaItems>
        <description>If Requires approval is not checked set owner to Credit Dispute Team Queue</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Doc Not in DMS - Copy of Title</fullName>
        <actions>
            <name>Update_Owner_To_Admin_Discrepant_F_U</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Status_To_New</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Doc_Not_in_DMS__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Service_Request_Type__c</field>
            <operation>equals</operation>
            <value>Copy of Title</value>
        </criteriaItems>
        <description>Case Status as New and assign to the Admin - Discrepant &amp; F/Up</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Due Date Change - Account Past Due</fullName>
        <actions>
            <name>Sub_Status_to_Waiting_on_Customer</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Service_Request_Type__c</field>
            <operation>equals</operation>
            <value>Due Date Change</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Denial_Reason__c</field>
            <operation>equals</operation>
            <value>Account Past Due</value>
        </criteriaItems>
        <description>When a Denial Reason is Account Past Due set Sub Status to &apos;Waiting on Customer&apos;</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Due Date Change - Signature Form Sent</fullName>
        <actions>
            <name>Update_Status_To_Hold</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Service_Request_Type__c</field>
            <operation>equals</operation>
            <value>Due Date Change</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Sub_Status__c</field>
            <operation>equals</operation>
            <value>Signature Form Sent</value>
        </criteriaItems>
        <description>When a User sends a form they will update Sub Status to Hold, which updates the case status to Hold</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Edit Profile Authorized Party Update Comm Comments</fullName>
        <actions>
            <name>Update_Comm_Comments_Authorized_Party</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Action__c</field>
            <operation>equals</operation>
            <value>Edit Profile</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Category__c</field>
            <operation>equals</operation>
            <value>Account Profile Update</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Service_Request_Type__c</field>
            <operation>equals</operation>
            <value>Authorized Party</value>
        </criteriaItems>
        <description>Edit Profile Authorized Party Update Comm Comments</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Ext %26 Def - Admin Working - Lease</fullName>
        <actions>
            <name>Update_Owner_to_Lease_Deferral_Queue</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>IF Substatus = &apos;Admin Working&apos;, set Case Owner = Lease Deferral Queue</description>
        <formula>AND(TEXT(Service_Request_Type__c) = &quot;Extension or Deferral&quot;, Financial_Account__r.RecordType.DeveloperName = &quot;Lease&quot;, TEXT(Sub_Status__c) = &quot;Admin Working&quot;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Ext %26 Def - Admin Working - Retail</fullName>
        <actions>
            <name>Update_Owner_To_Retail_Extension_Queue</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>IF Substatus = &apos;Admin Working&apos;, set Case Owner = Retail Extension Queue</description>
        <formula>AND(TEXT(Service_Request_Type__c) = &quot;Extension or Deferral&quot;, Financial_Account__r.RecordType.DeveloperName = &quot;Retail&quot;, TEXT(Sub_Status__c) = &quot;Admin Working&quot;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Ext %26 Def - DENY</fullName>
        <actions>
            <name>Update_Owner_to_Manager_Queue</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Status_to_Escalated</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>IF Extension &amp; Deferrals = DENY score but no Denial Reason, and user does NOT use Escalate To on publisher, set case status = Escalated</description>
        <formula>AND(TEXT(Service_Request_Type__c) = &quot;Extension or Deferral&quot;,LEFT(Financial_Account__r.Extensions_Deferrals__c , 4) = &quot;DENY&quot; , ISBLANK(text(Denial_Reason__c)),NOT( Ops_Letter_Eligible__c ))</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Ext %26 Def - TED Notes</fullName>
        <actions>
            <name>Ext_Def_TED_Notes</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Service_Request_Type__c</field>
            <operation>equals</operation>
            <value>Extension or Deferral</value>
        </criteriaItems>
        <description>Concatenate TED Notes with Description</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Ext or Def - Lease Case Owner</fullName>
        <actions>
            <name>Update_Owner_to_Lease_Deferral_Queue</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Status_to_In_Process</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>If FA is lease account, case owner is set to Lease Deferral Queue</description>
        <formula>AND(TEXT(Service_Request_Type__c) = &quot;Extension or Deferral&quot;,  OR(LEFT(Financial_Account__r.Extensions_Deferrals__c, 4) &lt;&gt; &quot;DENY&quot;,AND( Ops_Letter_Eligible__c ,LEFT(Financial_Account__r.Extensions_Deferrals__c , 4) = &quot;DENY&quot;,ISBLANK(TEXT(Escalated_To__c)))), Financial_Account__r.RecordType.DeveloperName = &quot;Lease&quot;, ISBLANK(TEXT(Denial_Reason__c)))</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Ext or Def - Retail Case Owner</fullName>
        <actions>
            <name>Update_Owner_To_Retail_Extension_Queue</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Status_to_In_Process</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>If FA is retail account, case owner is set to Retail Extension Queue</description>
        <formula>AND(TEXT(Service_Request_Type__c) = &quot;Extension or Deferral&quot;, OR(LEFT(Financial_Account__r.Extensions_Deferrals__c, 4) &lt;&gt; &quot;DENY&quot;,AND( Ops_Letter_Eligible__c ,LEFT(Financial_Account__r.Extensions_Deferrals__c , 4) = &quot;DENY&quot;,ISBLANK(TEXT(Escalated_To__c)))), Financial_Account__r.RecordType.DeveloperName = &quot;Retail&quot;,  ISBLANK(TEXT(Denial_Reason__c)) )</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Ext or Def - Set Service Result</fullName>
        <actions>
            <name>Update_Service_Result_to_Denied_Ext</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Category__c</field>
            <operation>equals</operation>
            <value>Contract Modifications</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Service_Request_Type__c</field>
            <operation>equals</operation>
            <value>Extension or Deferral</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Denial_Reason__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>If there is a Denied Reason for Extension or Deferral set Service Result to Denied Extension/Deferral Req</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>InitiateCasePublish</fullName>
        <actions>
            <name>Publish_Case_To_TFS</name>
            <type>OutboundMessage</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Source_System_Created_By__c</field>
            <operation>equals</operation>
            <value>SFDC</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Service_Request_Type__c</field>
            <operation>notEqual</operation>
            <value>Refinancing</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Service_Request_Type__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Initiate Case Publishing to TFS</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>InitiateCasePublish - Complaint</fullName>
        <actions>
            <name>Publish_Case_To_TFS</name>
            <type>OutboundMessage</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Complaint</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Service_Request_Category__c</field>
            <operation>equals</operation>
            <value>Complaints</value>
        </criteriaItems>
        <description>Sends case data to TIBCO/STARS via outbound message for customer complaint cases</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>InitiateCasePublish - EMS</fullName>
        <actions>
            <name>Publish_Case_To_TFS</name>
            <type>OutboundMessage</type>
        </actions>
        <active>true</active>
        <description>EMS project specific case publish criteria to send Support Request and Due Date Change Request case data to TIBCO/STARS via outbound message</description>
        <formula>AND(   Source_System_Created_By__c = &apos;SFDC&apos;,   OR(    RecordType.Name = &apos;Support Request&apos;,    RecordType.Name = &apos;Due Date Change Request&apos;  ),   OR(    ISNEW(),    PRIORVALUE(Last_Comment__c) != Last_Comment__c   )  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>InitiateCasePublish- UC</fullName>
        <actions>
            <name>Publish_Case_To_TFS</name>
            <type>OutboundMessage</type>
        </actions>
        <active>true</active>
        <description>Initiate Case Publishing to TFS</description>
        <formula>AND(Source_System_Created_By__c = &apos;SFDC&apos;,BEGINS(RecordType.Name,&apos;UC -&apos;),Not(ISNEW()),OR(ISCHANGED(Status),ISCHANGED(Description),ISCHANGED(Sub_Status__c),ISCHANGED(Subject),ISCHANGED(Service_Request_Type__c),ISCHANGED(Service_Result__c)))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Insurance Cancellation Other - Assignment</fullName>
        <actions>
            <name>Case_Status_to_External_Transfer</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Transfer_To_Provider_Dealer</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3</booleanFilter>
        <criteriaItems>
            <field>Case.Category__c</field>
            <operation>equals</operation>
            <value>Insurance</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Service_Request_Type__c</field>
            <operation>equals</operation>
            <value>Cancellation</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Insurance_Provider__c</field>
            <operation>equals</operation>
            <value>Other</value>
        </criteriaItems>
        <description>If provider is Other, set Status to &apos;External Transfer&apos; and Transfer/Refer to &apos;Provider/Dealer&apos;</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Insurance Cancellation TMIS - Assignment</fullName>
        <actions>
            <name>Case_Status_to_Internal_Transfer</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Transfer_To_TMIS</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3</booleanFilter>
        <criteriaItems>
            <field>Case.Category__c</field>
            <operation>equals</operation>
            <value>Insurance</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Service_Request_Type__c</field>
            <operation>equals</operation>
            <value>Cancellation</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Insurance_Provider__c</field>
            <operation>equals</operation>
            <value>TMIS</value>
        </criteriaItems>
        <description>If provider is TMIS, set Status to &apos;Internal Transfer (Closed)&apos; and Transfer/Refer to &apos;TMIS&apos;</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>KM Child Case Approved</fullName>
        <actions>
            <name>Update_Parent_Case_Approval_Count</name>
            <type>FlowAction</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Closed - Approved</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Change Control Approval</value>
        </criteriaItems>
        <description>Change Control - When a change control child case is approved, KM Approval Count needs to be subtracted by 1. When it becomes zero, parent case status will be changed to &quot;Front end approved&quot;.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>LFS Email Notification Internally Created Cases</fullName>
        <actions>
            <name>LFS_Initiated_Support_Request_Notification_to_Customer</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Case_Origin_LFS</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Support Request,Due Date Change Request</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.eCSR_Initiated__c</field>
            <operation>equals</operation>
            <value>Yes - Lexus</value>
        </criteriaItems>
        <description>Used to send case creation notification for LFS customer if &quot;Email Notification&quot; field is set to &quot;Yes - Lexus&quot; by internal user for new Support Request and DDC cases created on the customer&apos;s behalf. Also, updates Case Origin field appropriately.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>LFS Email Notification Internally Created Cases - NO</fullName>
        <actions>
            <name>Case_Origin_LFS</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Support Request,Due Date Change Request</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.eCSR_Initiated__c</field>
            <operation>equals</operation>
            <value>No - Lexus</value>
        </criteriaItems>
        <description>Used to NOT send case creation notification for LFS customer if &quot;Email Notification&quot; field is set to &quot;No - Lexus&quot; by internal user for new Support Request or DDC cases created on the customer&apos;s behalf.  Also, updates Case Origin field appropriately.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>LME Number %3D 1 or 2</fullName>
        <actions>
            <name>Update_Status_To_Resolved</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Action__c</field>
            <operation>equals</operation>
            <value>Start Process</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Category__c</field>
            <operation>equals</operation>
            <value>Lease End</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Service_Request_Type__c</field>
            <operation>equals</operation>
            <value>Lease Maturity Extension</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Number_of_LME_s__c</field>
            <operation>equals</operation>
            <value>1,2</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Denial_Reason__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>LME Number = 1 or 2</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>LME Number %3D 3</fullName>
        <actions>
            <name>Signature_Required_True</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Owner_To_Team_Lead_Queue</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Sub_Status_Waiting_For_Approval</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Service_Request_Type__c</field>
            <operation>equals</operation>
            <value>Lease Maturity Extension</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Number_of_LME_s__c</field>
            <operation>equals</operation>
            <value>3</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Denial_Reason__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Assign Case to Team Lead Queue
Sub Status to Waiting For Approval
Signature Required to True</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>LME Number %3D 4</fullName>
        <actions>
            <name>Signature_Required_True</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Owner_to_Manager_Queue</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Sub_Status_Waiting_For_Approval</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Service_Request_Type__c</field>
            <operation>equals</operation>
            <value>Lease Maturity Extension</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Number_of_LME_s__c</field>
            <operation>equals</operation>
            <value>4</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Denial_Reason__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Assign Case to Manager Queue
Sub Status to Waiting For Approval
Signature Required to True</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Last Modified Lan Id</fullName>
        <actions>
            <name>Last_Modified_Lan_Id_update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.CaseNumber</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Used to indicate the Lan Id of the user who last modified a case.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Late Charge Waiver %3C100 Exchange Queue</fullName>
        <actions>
            <name>Update_Owner_to_Exchange_Team_Queue</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Status_to_In_Process</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>If Late Charge Waive Amount is under $100 has been paid and Date that late charge was paid is within next 2 business days - place in Admin Exchange Team Queue</description>
        <formula>AND(Late_Charge_Waive_Amount__c &lt;= 100,Has_Late_Charge_Been_Paid__c = True,Late_Charge_Paid_Date__c &lt;= Today() + 2)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Late Charge Waiver %3C100 Late Charge Queue</fullName>
        <actions>
            <name>Update_Owner_to_Late_Charge_Waiver_Queue</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Status_to_In_Process</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>If Late Charge is under $100 has NOT been paid and Date that late charge was paid is NOT within next 2 business days - place in Late Charge Waiver Queue</description>
        <formula>AND(Late_Charge_Waive_Amount__c &lt;= 100,  OR(ISBLANK(Late_Charge_Paid_Date__c), Late_Charge_Paid_Date__c &gt; Today() + 2))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Late Charge Waiver %3E 500</fullName>
        <actions>
            <name>Late_Charge_Waiver_Greater_than_500</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Sub_Status_to_Waiting_For_Approval</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Owner_to_Accounts_Manager_Queue</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Status_to_In_Process</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>If Late Charge is greater than $500
Case Status = In Process, Owner = Customer Accounts Manager Queue</description>
        <formula>Late_Charge_Waive_Amount__c &gt; 500</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Late Charge Waiver - Approved - Admin Exchange Queue</fullName>
        <actions>
            <name>Update_Owner_to_Exchange_Team_Queue</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Date that late charge was paid is within next 2 business days - place in Admin Exchange Team Queue</description>
        <formula>AND(TEXT(Service_Request_Type__c) = &quot;Late Charge Waiver&quot;, TEXT(Sub_Status__c) = &quot;Request Approved&quot;, Has_Late_Charge_Been_Paid__c = True, Late_Charge_Paid_Date__c &lt;= Today() + 2)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Late Charge Waiver - Approved - Late Charge Waiver Queue</fullName>
        <actions>
            <name>Update_Owner_to_Late_Charge_Waiver_Queue</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Late Charge has not been paid place in Late Charge Waiver Queue</description>
        <formula>AND(TEXT(Service_Request_Type__c) = &quot;Late Charge Waiver&quot;, TEXT(Sub_Status__c) = &quot;Request Approved&quot;, OR(ISBLANK(Late_Charge_Paid_Date__c), Late_Charge_Paid_Date__c &gt; Today() + 2))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Late Charge Waiver 100-250</fullName>
        <actions>
            <name>Sub_Status_to_Waiting_For_Approval</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Owner_to_Resolution_Team_Queue</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Status_to_In_Process</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>If Late Charge Waive Amount is between $100 and $250
Case Status = In Process, Owner = Resolution Team Queue, Sub Status = Waiting For Approval</description>
        <formula>AND(Late_Charge_Waive_Amount__c &gt; 100, Late_Charge_Waive_Amount__c &lt;= 250)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Late Charge Waiver 250-500</fullName>
        <actions>
            <name>Sub_Status_to_Waiting_For_Approval</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Owner_to_Manager_Queue</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Status_to_In_Process</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>If Late Charge is $250 to $500
Case Status = In Process, Owner = Manager Queue, Sub status  = Waiting For Approval</description>
        <formula>AND(Late_Charge_Waive_Amount__c &gt; 250, Late_Charge_Waive_Amount__c &lt;= 500)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Lease Pre-Inspection - Transfer To</fullName>
        <actions>
            <name>Transfer_To_AutoVin</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Category__c</field>
            <operation>equals</operation>
            <value>Excess Wear &amp; Use</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Service_Request_Type__c</field>
            <operation>equals</operation>
            <value>Lease Pre-Inspection</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Denial_Reason__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Set the transfer to field to AutoVin</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Payoff Quote copy Contact Name to Quoted To</fullName>
        <actions>
            <name>Contact_Name_to_Quoted_To</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Service_Request_Type__c</field>
            <operation>equals</operation>
            <value>Payoff Quote</value>
        </criteriaItems>
        <description>Copy Contact Name to Quoted To</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>RL Close Parent Case</fullName>
        <actions>
            <name>RL_Close_Parent_Case</name>
            <type>FlowAction</type>
        </actions>
        <active>true</active>
        <description>Closes the parent rights letter case when the status on a quality review child case is set to closed</description>
        <formula>RecordType.Name = &quot;RL Quality Review&quot; &amp;&amp; ISCHANGED(Status) &amp;&amp; ISPICKVAL(Status, &quot;Closed&quot;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>RL Create Child Quality Review Case</fullName>
        <actions>
            <name>RL_Create_Child_Quality_Review_Case</name>
            <type>FlowAction</type>
        </actions>
        <active>true</active>
        <description>When a rights letter or notice of sale case status changes to Quality Review, create a new quality review child case</description>
        <formula>(RecordType.Name = &quot;Rights Letter&quot; || RecordType.Name = &quot;RL Notice of Sale&quot; || RecordType.Name = &quot;RL Notice of Sale-Salvage&quot;) &amp;&amp; ISCHANGED(Status) &amp;&amp; ISPICKVAL(Status, &quot;Quality Review&quot;)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>RL Initial Assignment</fullName>
        <actions>
            <name>RL_Capture_Initial_Assignee</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>RL_Capture_Initial_Assignment_Time</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Capture the initial assignment owner and time</description>
        <formula>!$Setup.General_Settings__c.Data_Admin_Exemption__c &amp;&amp; ISBLANK(RL_Initial_Assignee__c) &amp;&amp; ISBLANK(Owner:Queue.QueueName)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>RL Initial Pass Completion Time</fullName>
        <actions>
            <name>RL_Initial_Pass_Completion_Time</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Capture the time at which the initial assignee changes the status from In Progress</description>
        <formula>(!$Setup.General_Settings__c.Data_Admin_Exemption__c &amp;&amp;  ISBLANK(RL_Initial_Pass_Completion_Time__c) &amp;&amp;  !ISBLANK(RL_Initial_Assignee__c)) &amp;&amp;   (!ISPICKVAL(Status, &quot;In Progress&quot;) &amp;&amp;  ISCHANGED(Status)  ||   ISCHANGED(OwnerId))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>RL Secondary Assignment</fullName>
        <actions>
            <name>RL_Capture_Secondary_Assignment_Time</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Capture the secondary assignment time</description>
        <formula>!$Setup.General_Settings__c.Data_Admin_Exemption__c &amp;&amp;  ISBLANK(RL_Secondary_Assignment_Time__c) &amp;&amp;  !ISBLANK(RL_Initial_Assignee__c) &amp;&amp;  ISBLANK(Owner:Queue.QueueName) &amp;&amp;  ISCHANGED(OwnerId)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>RL Secondary Pass Completion Time</fullName>
        <actions>
            <name>RL_Secondary_Pass_Completion_Time</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Capture the time at which the secondary assignee changes the status from In Progress</description>
        <formula>(!$Setup.General_Settings__c.Data_Admin_Exemption__c &amp;&amp;  ISBLANK(RL_Secondary_Pass_Completion_Time__c) &amp;&amp;  !ISBLANK(RL_Secondary_Assignment_Time__c)) &amp;&amp;   (!ISPICKVAL(Status, &quot;In Progress&quot;) &amp;&amp;  ISCHANGED(Status)  ||   ISCHANGED(OwnerId))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>RL Set Hold Status after Auto IMS</fullName>
        <actions>
            <name>RL_Set_Hold_Status</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RL_Auto_IMS_Hold_Placed__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Update the case status to Hold after Auto IMS Hold Placed checkbox is filled</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>RL Update Subject</fullName>
        <actions>
            <name>RL_Update_Subject</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Updates the subject for a rights letters case</description>
        <formula>RecordType.Name = &quot;Rights Letter&quot; &amp;&amp;   (ISNEW() || ISCHANGED(Financial_Account__c) || ISCHANGED(Form_Rule__c) || ISCHANGED(RL_State_of_Jurisdiction__c))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Read-only Service Requests</fullName>
        <actions>
            <name>Change_Ownership_to_Admin</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND (Not 2)</booleanFilter>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>notEqual</operation>
            <value>Collection,Rights Letter,RL Quality Review,RL Notice of Sale,RL Notice of Sale-Salvage,Due Date Change Request,Support Request,Web-To-Case,Change Control,Change Control Approval,Article Feedback</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>startsWith</operation>
            <value>UC -</value>
        </criteriaItems>
        <description>Change ownership on service request cases to prevent edits after submission.
Modified in R7 to apply rule to all Cases Record Types beginning with &quot;UC -&quot;</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Reassign Web-to-Case</fullName>
        <actions>
            <name>Resolved_Web_To_Case</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Web-To-Case</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Resolved</value>
        </criteriaItems>
        <description>When a Web-To-Case (Contact Us) case is edited to change the Status field to “Resolved”, the case is automatically assigned to the Contact Us Resolved Queue as the owner.  This removes ownership of resolved Contact Us cases from eCSRs.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Request Denied</fullName>
        <actions>
            <name>Update_Denial_Reason_to_MSTL_Denied</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Status_To_Resolved</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Service_Request_Type__c</field>
            <operation>equals</operation>
            <value>Autocheque Enrollment,Due Date Change,Lease Maturity Extension,Late Charge Waiver,Remove Vehicle From US (Temporary),Substitution of Collateral</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Sub_Status__c</field>
            <operation>equals</operation>
            <value>Request Denied</value>
        </criteriaItems>
        <description>If substatus &apos;Request Denied&apos; is selected set status to resolved and denial reason to MSTL Denied</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Service Recipient Borrower</fullName>
        <actions>
            <name>Update_Service_Recipient_Borrower</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Due Date Change Request,Support Request</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Customer_Role_Type__c</field>
            <operation>equals</operation>
            <value>0-Primary Borrower</value>
        </criteriaItems>
        <description>Determines if the Service Recipient filed should be set as &apos;Borrower/Customer&apos;</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Service Recipient Co-Borrower</fullName>
        <actions>
            <name>Update_Service_Recipient_Co_borrower</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Due Date Change Request,Support Request</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Customer_Role_Type__c</field>
            <operation>notEqual</operation>
            <value>0-Primary Borrower</value>
        </criteriaItems>
        <description>Determines if the Service Recipient filed should be set as &apos;Co-Borrower/Customer&apos;</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Set Initial RL score</fullName>
        <actions>
            <name>Set_Initial_RL_score_value</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>This rule sets the Value from RL_Score__c to Initial_RL_Score__c at the the time of &apos;Rights Letter&apos; case creation</description>
        <formula>RecordType.Name = &apos;Rights Letter&apos; &amp;&amp;  NOT(ISBLANK(RL_System_Required_Notice_Date_Time__c)) &amp;&amp;  NOT(ISBLANK(Form_Rule__c)) &amp;&amp;  ISBLANK(Initial_RL_Score__c)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Start Process - Dealer Portal In Process</fullName>
        <actions>
            <name>Update_Status_to_In_Process</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3 and 4</booleanFilter>
        <criteriaItems>
            <field>Case.Account_Closed_in_ITS__c</field>
            <operation>equals</operation>
            <value>False</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Service_Request_Type__c</field>
            <operation>equals</operation>
            <value>Dealer Portal Lease Payoff</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.LeasePortalCheck__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>notEqual</operation>
            <value>Rejected - Closed</value>
        </criteriaItems>
        <description>Updates Dealer Portal case&apos;s status to In Process to ensure visibility on list.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Start Process - Dealer Portal Obtained ODO</fullName>
        <actions>
            <name>Sub_Status_to_Blank</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Status_To_Resolved</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3 AND 4 and 5</booleanFilter>
        <criteriaItems>
            <field>Case.Account_Closed_in_ITS__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Service_Request_Type__c</field>
            <operation>equals</operation>
            <value>Dealer Portal Lease Payoff</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Lease_End_Mileage__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Case.ODO_Statement_Status__c</field>
            <operation>equals</operation>
            <value>Valid</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>notEqual</operation>
            <value>Rejected - Closed</value>
        </criteriaItems>
        <description>Closes Dealer Portal case if Account has been closed in ITS and Mileage information is obtained.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Start Process - Dealer Portal Waiting for ODO</fullName>
        <actions>
            <name>Sub_Status_to_Waiting_on_Customer</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Status_To_Hold</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND (3 OR 4) AND 5</booleanFilter>
        <criteriaItems>
            <field>Case.Account_Closed_in_ITS__c</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Service_Request_Type__c</field>
            <operation>equals</operation>
            <value>Dealer Portal Lease Payoff</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Lease_End_Mileage__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Case.ODO_Statement_Status__c</field>
            <operation>notEqual</operation>
            <value>Valid</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>notEqual</operation>
            <value>Rejected - Closed</value>
        </criteriaItems>
        <description>Puts the case on Hold and Waiting for customer if ODO information is not obtained but Account has been closed in ITS.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Start Process Contract Modifications Name Update</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Case.Category__c</field>
            <operation>equals</operation>
            <value>Contract Modifications</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Service_Request_Type__c</field>
            <operation>equals</operation>
            <value>Name/SSN/Vehicle Update</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>notEqual</operation>
            <value>Resolved</value>
        </criteriaItems>
        <description>Start Process Contract Modifications Name Update to Close Case after 21 days if Case is not Resolved and customer does not respond back with needed information.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Close_Case_if_no_action_taken</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Case.CreatedDate</offsetFromField>
            <timeLength>21</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Start a Process Credit Dispute Review Date</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Case.Category__c</field>
            <operation>equals</operation>
            <value>Credit</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Service_Request_Type__c</field>
            <operation>equals</operation>
            <value>Credit Bureau Disputes</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>In Process</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.OwnerId</field>
            <operation>notEqual</operation>
            <value>Credit Dispute Team Queue</value>
        </criteriaItems>
        <description>Start a Process Credit Dispute Review Date is greater than current day and owner is not Credit Dispute Queue Owner</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Start_a_Process_Credit_Dispute_Update</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Case.Review_Date__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Hours</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Start a Process Lien Release - Admin</fullName>
        <actions>
            <name>Lien_Case_Status_Hold</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>UC_UpdateRunRules</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Lien_Release_Case_Owner</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3</booleanFilter>
        <criteriaItems>
            <field>Case.Service_Request_Type__c</field>
            <operation>equals</operation>
            <value>Lien Release</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Authorization_Received__c</field>
            <operation>notEqual</operation>
            <value>YES - VERBAL,YES - WRITTEN,N/A</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Send_To__c</field>
            <operation>equals</operation>
            <value>Originating Dealer,3rd Party</value>
        </criteriaItems>
        <description>This workflow is designed to take cases for &quot;Start a Process - Lien Release &quot; and move them to the Lien Release Queue for Admin&apos;s to process.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Follow_up_with_Customer_regarding_outstanding_information</name>
                <type>Alert</type>
            </actions>
            <actions>
                <name>Close_Case_if_no_action_taken</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Case.CreatedDate</offsetFromField>
            <timeLength>3</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>Start a Process Lien Release - In Process</fullName>
        <actions>
            <name>Lien_Case_Status_In_Process</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>UC_UpdateRunRules</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Lien_Release_Case_Owner</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 AND (3 OR 4) AND 2 AND 5)</booleanFilter>
        <criteriaItems>
            <field>Case.Service_Request_Type__c</field>
            <operation>equals</operation>
            <value>Lien Release</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>notEqual</operation>
            <value>Escalated,Resolved,Rejected - Closed,Requires Agent Review</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Send_To__c</field>
            <operation>equals</operation>
            <value>Customer,Co-borrower</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Authorization_Received__c</field>
            <operation>equals</operation>
            <value>YES - VERBAL,YES - WRITTEN</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.OwnerId</field>
            <operation>notEqual</operation>
            <value>Admin - Escalations</value>
        </criteriaItems>
        <description>Start a Process Lien Release - In Process</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Start a Process Lien Release - Requires Agent Review</fullName>
        <actions>
            <name>Agent_Review_Lien_Release_Request</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Requires Agent Review</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Service_Request_Type__c</field>
            <operation>equals</operation>
            <value>Lien Release</value>
        </criteriaItems>
        <description>Start a Process Lien Release - Requires Agent Review</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Start a Process Misapplied Payment</fullName>
        <actions>
            <name>Email_Resolution_Team</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Start_a_Process_Misapplied_Pay_Status</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Start_a_Process_Misapplied_Payment_Owner</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3 AND (4 OR 5 OR 6 OR 7 OR 8 OR 9)</booleanFilter>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>UC - Payment Process</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Service_Request_Type__c</field>
            <operation>equals</operation>
            <value>Misapplied Payment</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>notEqual</operation>
            <value>Escalated,Resolved,Rejected - Closed,Requires Agent Review</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Effective_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Effective_Date1__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Effective_Date2__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Payment_Amount__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Payment_Amount1__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Payment_Amount2__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Start a Process Misapplied Payment</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Start a Process Misapplied Payment Requires Agent Review</fullName>
        <actions>
            <name>Start_a_Process_Misapplied_Pay_Agent_Rev</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>UC - Payment Process</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Service_Request_Type__c</field>
            <operation>equals</operation>
            <value>Misapplied Payment</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Requires Agent Review</value>
        </criteriaItems>
        <description>Start a Process Misapplied Payment Requires Agent Review</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Start a Process Refund - Escalation</fullName>
        <actions>
            <name>Start_a_Process_Refund_Escalated</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Start_a_Process_Refund_Resolution_Team</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 AND 2 AND 3 AND 4 AND 5</booleanFilter>
        <criteriaItems>
            <field>Case.Category__c</field>
            <operation>equals</operation>
            <value>Payments</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Service_Request_Type__c</field>
            <operation>equals</operation>
            <value>Refund</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Escalation_Reason__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>notEqual</operation>
            <value>,Resolved,Hold,Rejected - Closed,Requires Agent Review</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Action__c</field>
            <operation>equals</operation>
            <value>Start Process</value>
        </criteriaItems>
        <description>If a Escalation Reason is selected the Case is escalated</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Start a Process Refund From Account Update</fullName>
        <actions>
            <name>Start_a_Process_Refund_Update_From_Acct</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Service_Request_Type__c</field>
            <operation>equals</operation>
            <value>Refund</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Action__c</field>
            <operation>equals</operation>
            <value>Start Process</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.From_Account__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Start a Process Refund Updates the From Account Update to match the FA</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Start a Process Refund a Payment</fullName>
        <actions>
            <name>Start_a_Process_Refund_Admin</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Start_a_Process_Refund_In_Process</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 AND 2 AND 7 AND 8 AND 9) AND (3 OR 4 OR 5 OR 6)</booleanFilter>
        <criteriaItems>
            <field>Case.Category__c</field>
            <operation>equals</operation>
            <value>Payments</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Service_Request_Type__c</field>
            <operation>equals</operation>
            <value>Refund</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.From_Account__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Effective_Date__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Payment_Amount__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Refund_Amount__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Escalation_Reason__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>notEqual</operation>
            <value>Resolved</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Payment_Channel__c</field>
            <operation>notEqual</operation>
            <value>WUSP</value>
        </criteriaItems>
        <description>Start a Process Refund a Payment - Updates the status to &quot;In Process&quot; once the CS Agent saves the case with the needed information.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Start a Process UC - Title Process Record Type Update</fullName>
        <actions>
            <name>Start_a_Process_Title_Record_Type_Update</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Case.Action__c</field>
            <operation>equals</operation>
            <value>Start Process</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Service_Type__c</field>
            <operation>equals</operation>
            <value>Title</value>
        </criteriaItems>
        <description>Start a Process UC - Title Process Record Type Update</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Sub Status to Blank</fullName>
        <actions>
            <name>Update_Sub_Status_to_Blank</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 AND 2) OR (4 AND 5 AND ((3 AND 7) OR 8)) OR (6 AND 5) OR (9 AND 8 AND 5)</booleanFilter>
        <criteriaItems>
            <field>Case.Service_Request_Type__c</field>
            <operation>equals</operation>
            <value>Due Date Change,Lease Maturity Extension,Late Charge Waiver,Credit Bureau Disputes,Remove Vehicle From US,Extension or Deferral,Remove Vehicle From US (Temporary)</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Rejected - Closed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Confirmation_Required__c</field>
            <operation>notEqual</operation>
            <value>No</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Service_Request_Type__c</field>
            <operation>equals</operation>
            <value>Credit Bureau Disputes</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Status</field>
            <operation>equals</operation>
            <value>Resolved</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Service_Request_Type__c</field>
            <operation>equals</operation>
            <value>Remove Vehicle From US,Extension or Deferral</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Sub_Status__c</field>
            <operation>equals</operation>
            <value>Request Denied</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Sub_Status__c</field>
            <operation>notEqual</operation>
            <value>Request Denied</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Service_Request_Type__c</field>
            <operation>equals</operation>
            <value>Lease Maturity Extension,Late Charge Waiver</value>
        </criteriaItems>
        <description>For approval process set substatus to Blank when case is resolved</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>TFS Email Notification Internally Created Cases</fullName>
        <actions>
            <name>Notify_TFS_Customer_of_Case_Created_on_their_Behalf</name>
            <type>Alert</type>
        </actions>
        <actions>
            <name>Case_Origin_TFS</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Support Request,Due Date Change Request</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.eCSR_Initiated__c</field>
            <operation>equals</operation>
            <value>Yes - Toyota</value>
        </criteriaItems>
        <description>Used to send case creation notification for TFS customer if &quot;Email Notification&quot; field is set to &quot;Yes - Toyota&quot; by internal user for new Support Request and DDC cases created on the customer&apos;s behalf. Also, updates Case Origin field appropriately.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>TFS Email Notification Internally Created Cases - NO</fullName>
        <actions>
            <name>Case_Origin_TFS</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Support Request,Due Date Change Request</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.eCSR_Initiated__c</field>
            <operation>equals</operation>
            <value>No - Toyota</value>
        </criteriaItems>
        <description>Used to NOT send case creation notification for TFS customer if &quot;Email Notification&quot; field is set to &quot;No - Toyota&quot; by internal user for new Support Request or DDC cases created on the customer&apos;s behalf.  Also, updates Case Origin field appropriately.</description>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Temp Removal from US Request Approved</fullName>
        <actions>
            <name>Update_Status_To_Resolved</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.Service_Request_Type__c</field>
            <operation>equals</operation>
            <value>Remove Vehicle From US (Temporary)</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Sub_Status__c</field>
            <operation>equals</operation>
            <value>Request Approved</value>
        </criteriaItems>
        <description>If substatus &apos;Request Approved&apos; is selected set status to resolved for Case Topic = Remove Vehicle From US (Temporary)</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>UC_Title_Assignment1</fullName>
        <actions>
            <name>UC_Title_Owner_CriticalEscalations</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>UC_UpdateRunRules</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Assigns Cases for TSG - Critical Escalations</description>
        <formula>AND(      RunRules__c,      OR(           ISNEW(),           ISCHANGED(RunRules__c)      ),      CaseAssignmentRule__c = &quot;Admin - Critical Escalations&quot;,      IF(      ISCHANGED(RunRules__c),      NOT( LastModifiedById =  $Label.ETL_User_ID ),      TRUE      ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>UC_Title_Assignment10</fullName>
        <actions>
            <name>UC_Title_Owner_PIFELTHSBC</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>UC_UpdateRunRules</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Assigns Cases for TSG - PIF ELT HSBC</description>
        <formula>AND(  RunRules__c,  OR(  ISNEW(),  ISCHANGED(RunRules__c)  ),  CaseAssignmentRule__c = &quot;PIF - ELT HSBC&quot;,  IF(  ISCHANGED(RunRules__c),  NOT( LastModifiedById = $Label.ETL_User_ID ),  TRUE  )  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>UC_Title_Assignment11</fullName>
        <actions>
            <name>UC_Title_Owner_PIFELTReg</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>UC_UpdateRunRules</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Assigns Cases for TSG - PIF ELT Regular</description>
        <formula>AND(  RunRules__c,  OR(  ISNEW(),  ISCHANGED(RunRules__c)  ),  CaseAssignmentRule__c = &quot;PIF - ELT Regular&quot;,  IF(  ISCHANGED(RunRules__c),  NOT( LastModifiedById = $Label.ETL_User_ID ),  TRUE  )  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>UC_Title_Assignment12</fullName>
        <actions>
            <name>UC_Title_Owner_PIFELTPortal</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>UC_UpdateRunRules</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Assigns Cases for TSG - PIF ELT Portal</description>
        <formula>AND(RunRules__c,  OR( ISNEW(), ISCHANGED(RunRules__c) ), CaseAssignmentRule__c = &quot;PIF - ELT Portal&quot;, IF( ISCHANGED(RunRules__c), OR(NOT(LastModifiedById = $Label.ETL_User_ID ), Text(Origin) = &apos;DDPIFP&apos;), TRUE ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>UC_Title_Assignment13</fullName>
        <actions>
            <name>UC_UpdateRunRules</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>uc_title_owner_heldPIF</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Assigns Cases for TSG - PIF Held PIF</description>
        <formula>AND(  RunRules__c,  OR(  ISNEW(),  ISCHANGED(RunRules__c)  ),  CaseAssignmentRule__c = &quot;PIF - Held PIF&quot;,  IF(  ISCHANGED(RunRules__c),  NOT( LastModifiedById = $Label.ETL_User_ID ),  TRUE  )  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>UC_Title_Assignment14</fullName>
        <actions>
            <name>UC_Title_Owner_PIFLeaseReg</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>UC_UpdateRunRules</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Assigns Cases for TSG - PIF Lease Regular</description>
        <formula>AND(  RunRules__c,  OR(  ISNEW(),  ISCHANGED(RunRules__c)  ),  CaseAssignmentRule__c = &quot;PIF - Lease Regular&quot;,  IF(  ISCHANGED(RunRules__c),  NOT( LastModifiedById = $Label.ETL_User_ID ),  TRUE  )  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>UC_Title_Assignment15</fullName>
        <actions>
            <name>UC_UpdateRunRules</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>uc_title_owner_PIFLeasePortal</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Assigns Cases for TSG - PIF Lease Portal</description>
        <formula>AND(RunRules__c,   OR(  ISNEW(),  ISCHANGED(RunRules__c)  ),  CaseAssignmentRule__c = &quot;PIF - Lease Portal&quot;,  IF(  ISCHANGED(RunRules__c),  OR(NOT(LastModifiedById = $Label.ETL_User_ID ), Text(Origin) = &apos;DDPIFP&apos;),  TRUE  )  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>UC_Title_Assignment16</fullName>
        <actions>
            <name>UC_Title_Owner_PIFRetReg</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>UC_UpdateRunRules</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Assigns Cases for TSG - PIF Retail Regular</description>
        <formula>AND(  RunRules__c,  OR(  ISNEW(),  ISCHANGED(RunRules__c)  ),  CaseAssignmentRule__c = &quot;PIF - Retail Regular&quot;,  IF(  ISCHANGED(RunRules__c),  NOT( LastModifiedById = $Label.ETL_User_ID ),  TRUE  )  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>UC_Title_Assignment17</fullName>
        <actions>
            <name>UC_Title_Owner_PIFRetPortal</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>UC_UpdateRunRules</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Assigns Cases for TSG - PIF Retail Portal</description>
        <formula>AND(  RunRules__c,  OR(  ISNEW(),  ISCHANGED(RunRules__c)  ),  CaseAssignmentRule__c = &quot;PIF - Retail Portal&quot;,  IF(  ISCHANGED(RunRules__c),  NOT( LastModifiedById = $Label.ETL_User_ID ),  TRUE  )  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>UC_Title_Assignment18</fullName>
        <actions>
            <name>UC_UpdateRunRules</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>uc_title_owner_PIFRetHSBC</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Assigns Cases for TSG - PIF Retail HSBC</description>
        <formula>AND(  RunRules__c,  OR(  ISNEW(),  ISCHANGED(RunRules__c)  ),  CaseAssignmentRule__c = &quot;PIF - Retail HSBC&quot;,  IF(  ISCHANGED(RunRules__c),  NOT( LastModifiedById = $Label.ETL_User_ID ),  TRUE  )  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>UC_Title_Assignment2</fullName>
        <actions>
            <name>UC_Title_Owner_Escalations</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>UC_UpdateRunRules</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Assigns Cases for TSG - Escalations</description>
        <formula>AND(  RunRules__c,  OR(  ISNEW(),  ISCHANGED(RunRules__c)  ),  CaseAssignmentRule__c = &quot;Admin - Escalations&quot;,  IF(  ISCHANGED(RunRules__c),  NOT( LastModifiedById = $Label.ETL_User_ID ),  TRUE  )  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>UC_Title_Assignment3</fullName>
        <actions>
            <name>UC_Title_Owner_CustCore</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>UC_UpdateRunRules</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Assigns Cases for TSG - Customer Correspondence</description>
        <formula>AND(  RunRules__c,  OR(  ISNEW(),  ISCHANGED(RunRules__c)  ),  CaseAssignmentRule__c = &quot;Admin - Customer Correspondence&quot;,  IF(  ISCHANGED(RunRules__c),  NOT( LastModifiedById = $Label.ETL_User_ID ),  TRUE  )  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>UC_Title_Assignment4</fullName>
        <actions>
            <name>UC_Title_Owner_DiscFUp</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>UC_UpdateRunRules</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Assigns Cases for TSG - Discrepant &amp; F/Up</description>
        <formula>AND(  RunRules__c,  OR(  ISNEW(),  ISCHANGED(RunRules__c)  ),  CaseAssignmentRule__c = &quot;Admin - Discrepant &amp; F/Up&quot;,  IF(  ISCHANGED(RunRules__c),  NOT( LastModifiedById = $Label.ETL_User_ID ),  TRUE  )  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>UC_Title_Assignment5</fullName>
        <actions>
            <name>UC_Title_Owner_LeaseTerm</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>UC_UpdateRunRules</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Assigns Cases for TSG - Lease Term</description>
        <formula>AND(  RunRules__c,  OR(  ISNEW(),  ISCHANGED(RunRules__c)  ),  CaseAssignmentRule__c = &quot;Admin - Lease Term&quot;,  IF(  ISCHANGED(RunRules__c),  NOT( LastModifiedById = $Label.ETL_User_ID ),  TRUE  )  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>UC_Title_Assignment6</fullName>
        <actions>
            <name>UC_Title_Owner_PIFSpec</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>UC_UpdateRunRules</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Assigns Cases for TSG - PIF Specialists</description>
        <formula>AND(  RunRules__c,  OR(  ISNEW(),  ISCHANGED(RunRules__c)  ),  CaseAssignmentRule__c = &quot;Admin - PIF Specialists&quot;,  IF(  ISCHANGED(RunRules__c),  NOT( LastModifiedById = $Label.ETL_User_ID ),  TRUE  )  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>UC_Title_Assignment7</fullName>
        <actions>
            <name>UC_Title_Owner_RepoRR</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>UC_UpdateRunRules</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Assigns Cases for TSG - Repo/R&amp;R</description>
        <formula>AND(  RunRules__c,  OR(  ISNEW(),  ISCHANGED(RunRules__c)  ),  CaseAssignmentRule__c = &quot;Admin - Repo/R&amp;R&quot;,  IF(  ISCHANGED(RunRules__c),  NOT( LastModifiedById = $Label.ETL_User_ID ),  TRUE  )  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>UC_Title_Assignment8</fullName>
        <actions>
            <name>UC_Title_Owner_STS</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>UC_UpdateRunRules</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Assigns Cases for TSG - State to State</description>
        <formula>AND(  RunRules__c,  OR(  ISNEW(),  ISCHANGED(RunRules__c)  ),  CaseAssignmentRule__c = &quot;Admin - State to State&quot;,  IF(  ISCHANGED(RunRules__c),  NOT( LastModifiedById = $Label.ETL_User_ID ),  TRUE  )  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>UC_Title_Assignment9</fullName>
        <actions>
            <name>UC_Title_Owner_TOETOL</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>UC_UpdateRunRules</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Assigns Cases for TSG - TOE/TOL</description>
        <formula>AND(  RunRules__c,  OR(  ISNEW(),  ISCHANGED(RunRules__c)  ),  CaseAssignmentRule__c = &quot;Admin - TOE/TOL&quot;,  IF(  ISCHANGED(RunRules__c),  NOT( LastModifiedById = $Label.ETL_User_ID ),  TRUE  )  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>UC_Title_Holding</fullName>
        <actions>
            <name>UC_UpdateRunRules</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Update_Owner_to_Admin_Holding_Queue</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Assigns Cases for Admin - Holding Queue</description>
        <formula>AND(RunRules__c,      OR(           ISNEW(),           ISCHANGED(RunRules__c)      ),      CaseAssignmentRule__c = &quot;Admin - Holding Queue&quot;,      IF(      ISCHANGED(RunRules__c),      NOT( LastModifiedById =  $Label.ETL_User_ID ),      TRUE      ) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Upate RunRules to FALSE</fullName>
        <actions>
            <name>UC_UpdateRunRules</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Update RunRules to False for Updates made by ETL.</description>
        <formula>AND(NOT(ISNEW()),LastModifiedById =  $Label.ETL_User_ID, ISPICKVAL(Service_Request_Type__c,&quot;PIF Release&quot;))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Case Status - FrontEndApproved</fullName>
        <actions>
            <name>Update_Case_Status_FrontEndApproved</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.KM_approval_Count__c</field>
            <operation>equals</operation>
            <value>0</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Change Control</value>
        </criteriaItems>
        <description>Change Control - Updates case status to &quot;Front End Approved&quot; when the Approval Count becomes 0.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Child Cases if Parent Case Owner changes</fullName>
        <actions>
            <name>Update_Children_Cases</name>
            <type>FlowAction</type>
        </actions>
        <active>true</active>
        <description>Change Control - Whenever Parent Case owner is updated, call a flow that updates all children &quot;KM Parent Case Owner&quot; field to Parent case&apos;s owner</description>
        <formula>ISCHANGED( OwnerId ) &amp;&amp;  RecordType.Name = &quot;Change Control&quot;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Child Cases if Parent Case status - Cancelled or On Hold%2C Submitted for Approval</fullName>
        <actions>
            <name>Update_children_Cases_Change_Status_Submitted_for_Approval</name>
            <type>FlowAction</type>
        </actions>
        <active>true</active>
        <description>Change Control - This rule updates all children cases status to Closed Cancelled if parent case status is changed to Closed - Cancelled and prior case status was Submitted for Approval</description>
        <formula>AND(RecordType.Name = &quot;Change Control&quot;,  ISPICKVAL(Status, &quot;Closed - Cancelled&quot;), OR(ISPICKVAL(PRIORVALUE(Status), &quot;Submitted for Approval&quot;), ISPICKVAL(PRIORVALUE(Status), &quot;On Hold&quot;)))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Child Cases if Parent Case status - Cancelled or On Hold%2C Submitted to Backend</fullName>
        <actions>
            <name>Update_children_Cases_Change_Status_Submitted_to_Backend</name>
            <type>FlowAction</type>
        </actions>
        <active>true</active>
        <description>Change Control - This rule Sends email to all impacted backed processing teams if parent case status is changed to Closed - Cancelled and prior case status was Submitted to Backend</description>
        <formula>AND(RecordType.Name = &quot;Change Control&quot;,  ISPICKVAL(Status, &quot;Closed - Cancelled&quot;), OR(ISPICKVAL(PRIORVALUE(Status), &quot;Submitted to Backend&quot;),ISPICKVAL(PRIORVALUE(Status), &quot;KM Changes Approved&quot;), ISPICKVAL(PRIORVALUE(Status), &quot;On Hold&quot;)))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Closed Collection Case Integration ID</fullName>
        <actions>
            <name>Append_mmddyyhhmmss_to_Integration_ID</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Collection</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.IsClosed</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <description>Updates Collection case Integration ID by appending &apos;~mmddyyhhmmss&apos; to the end when the case is first closed</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update DDC Description</fullName>
        <actions>
            <name>Update_Description_for_DDC</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Due Date Change Request</value>
        </criteriaItems>
        <description>Due Date Change Requests are sent to STARS which has a 2000 chr limit.  Custom fld Support Request Description (2000) will be used for data entry on theses case record types and the standard description field will be updated for STARS</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update PIFCase Integration ID</fullName>
        <actions>
            <name>Append_mmddyyhhmmss_to_Integration_ID</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>UC - Title Process,UC - Title Release</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.IsClosed</field>
            <operation>equals</operation>
            <value>True</value>
        </criteriaItems>
        <criteriaItems>
            <field>Case.Integration_ID__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Updates PIF case Integration ID by appending &apos;~mmddyyhhmmss&apos; to the end when the case is first closed</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Update Subject</fullName>
        <actions>
            <name>Update_Subject</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Due Date Change Request,Web-To-Case,Support Request</value>
        </criteriaItems>
        <description>Updates the standard Subject field with the custom Subject picklist value for Support Request, Due Date Change Request, and Web-to-Case record types.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update Support Request Description</fullName>
        <actions>
            <name>Update_Description_for_Support_Request</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Case.RecordTypeId</field>
            <operation>equals</operation>
            <value>Support Request</value>
        </criteriaItems>
        <description>Support Requests are sent to STARS which has a 2000 chr limit.  Custom fld Support Request Description (2000) will be used for data entry on theses case record types and the standard description field will be updated for STARS</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
