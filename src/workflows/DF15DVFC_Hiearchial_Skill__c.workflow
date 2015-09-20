<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>ID_Chain_FieldStamp</fullName>
        <field>IdChain__c</field>
        <formula>if ( isBlank( Hierarchy_Parent_Branch__c )
, Id
, Hierarchy_Parent_Branch__r.IdChain__c &amp;  $Label.ID_Chain_Delimiter &amp;  Id )</formula>
        <name>ID Chain FieldStamp</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Create%2FEdit Event on Hierarchy Skill</fullName>
        <actions>
            <name>ID_Chain_FieldStamp</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>true</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
