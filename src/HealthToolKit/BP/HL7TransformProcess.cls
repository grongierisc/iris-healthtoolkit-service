/// This is a custom business process that transforms an HL7 message to SDA format (an internal healthcare data format for InterSystems IRIS for Health).
/// To use this class, add a business process with this class to the production and configure the target. The default target will send the SDA to a component
/// that converts the data to FHIR.
/// 
Class HealthToolKit.HL7TransformProcess Extends Ens.BusinessProcess [ ClassType = persistent ]
{

Parameter SETTINGS = "TargetConfigName:Basic:selector?context={Ens.ContextSearch/ProductionItems?targets=1&productionName=@productionId},TransformFile:Basic";

Property TargetConfigName As Ens.DataType.ConfigName [ InitialExpression = "HS.FHIR.DTL.Util.HC.SDA3.FHIR.Process" ];

/// Transforms an HL7 message to SDA, an internal healthcare format for InterSystems IRIS for Health.
Method OnRequest(
	pRequest As EnsLib.HL7.Message,
	Output pResponse As Ens.Response) As %Status
{
	set tSC = $$$OK
	try {
         set tSC = ##class(HS.Gateway.HL7.HL7ToSDA3).GetSDA(pRequest,.tSDA)
         set tSC = ..SendRequestSync(..TargetConfigName,##class(Ens.StreamContainer).%New(tSDA),.pResponse)
	} catch ex {
		set tSC = ex.AsStatus()
	}
	quit tSC
}

Storage Default
{
<Data name="HL7TransformProcessDefaultData">
<Subscript>"HL7TransformProcess"</Subscript>
<Value name="1">
<Value>TargetConfigName</Value>
</Value>
</Data>
<DefaultData>HL7TransformProcessDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
