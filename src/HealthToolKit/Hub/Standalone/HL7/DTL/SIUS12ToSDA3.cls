Class HealthToolKit.Hub.Standalone.HL7.DTL.SIUS12ToSDA3 Extends Ens.DataTransformDTL [ DependsOn = (EnsLib.HL7.Message, HS.SDA3.Container) ]
{

Parameter IGNOREMISSINGSOURCE = 1;

Parameter REPORTERRORS = 1;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='EnsLib.HL7.Message' targetClass='HS.SDA3.Container' sourceDocType='2.5:SIU_S12' create='new' language='objectscript' >
<foreach property='source.{PIDgrp()}' key='k1' >
<subtransform class='HS.Hub.Standalone.HL7.DTL.SubTransform.PIDToSDA3' targetObj='target' sourceObj='source.{PIDgrp(k1).PID}' aux='source.{MSH:SendingFacility.NamespaceID}' />
<subtransform class='HS.Hub.Standalone.HL7.DTL.SubTransform.PD1ToSDA3' targetObj='target' sourceObj='source.{PIDgrp(k1).PD1}' />
</foreach>
</transform>
}

}
