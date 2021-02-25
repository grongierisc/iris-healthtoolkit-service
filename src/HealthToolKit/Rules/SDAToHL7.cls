/// 
Class HealthToolKit.Rules.SDAToHL7 Extends Ens.Rule.Definition
{

Parameter RuleAssistClass = "EnsLib.HL7.MsgRouter.RuleAssist";

XData RuleDefinition [ XMLNamespace = "http://www.intersystems.com/rule" ]
{
<ruleDefinition alias="" context="EnsLib.HL7.MsgRouter.RoutingEngine" production="HealthToolKit.Production">
<ruleSet name="" effectiveBegin="" effectiveEnd="">
<rule name="">
<constraint name="source" value="FHIR_SDA"></constraint>
<when condition="1">
<send transform="HS.Gateway.SDA3.SDA3ToHL7.ADTA0N" target="HL7_File_Operation"></send>
<send transform="HS.Gateway.SDA3.SDA3ToHL7.ORUR01" target="HL7_File_Operation"></send>
<send transform="HS.Gateway.SDA3.SDA3ToHL7.VXUV04" target="HL7_File_Operation"></send>
<send transform="" target="HL7_File_Operation"></send>
</when>
</rule>
</ruleSet>
</ruleDefinition>
}

}
