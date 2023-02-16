/// 
Class HealthToolKit.BP.FHIRRouter Extends Ens.BusinessProcessBPL
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Ens.Request' response='Ens.Response' height='2000' width='2000' >
<sequence xend='200' yend='950' >
<if name='Transform ?' condition='request.Request.RequestPath [ "hl7"' xpos='200' ypos='250' xend='200' yend='850' >
<true>
<switch name='Witch HL7' xpos='470' ypos='400' xend='470' yend='650' >
<case condition='request.Request.RequestPath [ "adt"' >
<assign name="Default" property="^HL7Transforme" value="&quot;HS.Gateway.SDA3.SDA3ToHL7.ADTA0N&quot;" action="set" xpos='875' ypos='550' />
</case>
<case condition='request.Request.RequestPath [ "oru"' >
<assign name="oru" property="^HL7Transforme" value="&quot;HS.Gateway.SDA3.SDA3ToHL7.ORUR01&quot;" action="set" xpos='1145' ypos='550' />
</case>
<case condition='request.Request.RequestPath [ "vxu"' >
<assign name="vxu" property="^HL7Transforme" value="&quot;HS.Gateway.SDA3.SDA3ToHL7.VXUV04&quot;" action="set" xpos='471' ypos='553' />
</case>
<default>
<assign name="adt" property="^HL7Transforme" value="&quot;HS.Gateway.SDA3.SDA3ToHL7.ADTA0N&quot;" action="set" xpos='605' ypos='550' />
</default>
</switch>
<call name='To Transform' target='FHIR_SDA' async='0' xpos='470' ypos='750' >
<request type='Ens.Request' >
<assign property="callrequest" value="request" action="set" />
</request>
<response type='Ens.Response' >
<assign property="response" value="callresponse" action="set" />
</response>
</call>
</true>
<false>
<call name='To Repo' target='FHIR_Local_Operation' async='0' xpos='200' ypos='400' >
<request type='Ens.Request' >
<assign property="callrequest" value="request" action="set" />
</request>
<response type='Ens.Response' >
<assign property="response" value="callresponse" action="set" />
</response>
</call>
</false>
</if>
</sequence>
</process>
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
