<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Last_Modified_by_Lan_Id_Title</fullName>
        <field>Last_Modified_by_Lan_Id__c</field>
        <formula>$User.Lan_Id__c</formula>
        <name>Last Modified by Lan Id Title</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Update_EvaluateFollowUp_to_TRUE</fullName>
        <field>EvaluateFollowUp__c</field>
        <literalValue>1</literalValue>
        <name>Update EvaluateFollowUp to TRUE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <outboundMessages>
        <fullName>Publish_Title_to_Tibco</fullName>
        <apiVersion>36.0</apiVersion>
        <description>This outbound message is used to send title information to stars</description>
        <endpointUrl>https://intsvcs-test1.services.toyotafinancial.com/TFS/Services/Title</endpointUrl>
        <fields>APO_Received__c</fields>
        <fields>Collateral__c</fields>
        <fields>CreatedById</fields>
        <fields>CreatedDate</fields>
        <fields>Customer_Communications__c</fields>
        <fields>Estimated_Mail_Date__c</fields>
        <fields>FA_Number__c</fields>
        <fields>Financial_Account__c</fields>
        <fields>Hold_Reason__c</fields>
        <fields>Id</fields>
        <fields>LastModifiedById</fields>
        <fields>LastModifiedDate</fields>
        <fields>Last_Modified_by_Lan_Id__c</fields>
        <fields>Legacy_ID__c</fields>
        <fields>Mail_Acct_Num__c</fields>
        <fields>Name</fields>
        <fields>Overnight_Mail__c</fields>
        <fields>OwnerId</fields>
        <fields>Payoff_Date__c</fields>
        <fields>Payoff__c</fields>
        <fields>Perfected__c</fields>
        <fields>Send_To__c</fields>
        <fields>Title_Notes__c</fields>
        <fields>Title_Send_To_Address__c</fields>
        <fields>Title_State__c</fields>
        <fields>Title_Status__c</fields>
        <fields>Title_Type__c</fields>
        <fields>Tracking_Number__c</fields>
        <fields>VIN__c</fields>
        <includeSessionId>true</includeSessionId>
        <integrationUser>outbound.integration@toyota.com</integrationUser>
        <name>Publish Title to Tibco</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <rules>
        <fullName>Last Modified by Lan Id Title</fullName>
        <actions>
            <name>Last_Modified_by_Lan_Id_Title</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Title__c.Name</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>This rule will update the Last Modified by Lan Id field</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Publish Title to Tibco</fullName>
        <actions>
            <name>Publish_Title_to_Tibco</name>
            <type>OutboundMessage</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Title__c.LastModifiedById</field>
            <operation>notEqual</operation>
            <value>ETL User</value>
        </criteriaItems>
        <description>This workflow will push the Outbound message to Tibco</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Update EvaluateFollowUp</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Title__c.Title_Status__c</field>
            <operation>equals</operation>
            <value>Pending-Not Yet Received</value>
        </criteriaItems>
        <description>Update EvaluateFollowUp to TRUE 150 Days after a Title has been created.</description>
        <triggerType>onCreateOnly</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Update_EvaluateFollowUp_to_TRUE</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Title__c.CreatedDate</offsetFromField>
            <timeLength>150</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
