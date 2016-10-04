<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Contact_FirstName_Format_Change</fullName>
        <field>FirstName</field>
        <formula>UPPER(LEFT( FirstName, 1))&amp; Lower(MID(FirstName,2,Len(FirstName)-1))</formula>
        <name>Contact FirstName Format Change</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Contact_LastName_Format_Change</fullName>
        <field>LastName</field>
        <formula>UPPER(LEFT(LastName, 1))&amp; Lower(MID(LastName,2,Len(LastName)-1))</formula>
        <name>Contact LastName Format Change</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
</Workflow>
