/// 
Class HealthToolKit.Rules.RoutingRule Extends Ens.Rule.Definition
{

Parameter RuleAssistClass = "EnsLib.HL7.MsgRouter.RuleAssist";

XData RuleDefinition [ XMLNamespace = "http://www.intersystems.com/rule" ]
{
<ruleDefinition alias="" context="EnsLib.HL7.MsgRouter.RoutingEngine" production="HealthToolKit.Production">
<ruleSet name="" effectiveBegin="" effectiveEnd="">
<rule name="">
<constraint name="source" value="HL7FileService"></constraint>
<when condition="1">
<send transform="HealthToolKit.DT.HL7PIDToJSON" target="Custom_Local_Operation"></send>
<send transform="HealthToolKit.DT.HL7PIDToJSON" target="Custom_JDBC_Operation"></send>
<send transform="HealthToolKit.DT.HL7PIDToJSON" target="Custom_Http_Operation"></send>
<send transform="" target="HL7_File_Operation"></send>
</when>
</rule>
</ruleSet>
</ruleDefinition>
}

}
