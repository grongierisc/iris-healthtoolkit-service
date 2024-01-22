/// This is a custom business process that transforms an HL7 message to SDA format (an internal healthcare data format for InterSystems IRIS for Health).
/// To use this class, add a business process with this class to the production and configure the target. The default target will send the SDA to a component
/// that converts the data to FHIR.
/// 
Class HealthToolKit.BP.SDAtoHL7TransformProcess Extends (Ens.BusinessProcess, HS.HC.Util.Trace.Helper) [ ClassType = persistent ]
{

Parameter SETTINGS = "TargetConfigName:Basic:selector?context={Ens.ContextSearch/ProductionItems?targets=1&productionName=@productionId},TransformFile:Basic";

Property TargetConfigName As Ens.DataType.ConfigName [ InitialExpression = "HS.FHIR.DTL.Util.HC.SDA3.FHIR.Process" ];

/// Description
Property TransformFile As %String(VALUELIST = ",HS.Gateway.SDA3.SDA3ToHL7.ADTA0N,HS.Gateway.SDA3.SDA3ToHL7.ORUR01,HS.Gateway.SDA3.SDA3ToHL7.VXUV04") [ InitialExpression = "HS.Gateway.SDA3.SDA3ToHL7.ADTA0N" ];

/// Transforms an HL7 message to SDA, an internal healthcare format for InterSystems IRIS for Health.
Method OnRequest(
	pRequest As HS.Message.XMLMessage,
	Output pResponse As Ens.Response) As %Status
{
	set tSC = $$$OK


		set tVDoc= ##class(EnsLib.EDI.XML.Document).ImportFromString(pRequest.ContentStream, .Status)

		set tTransform = $s($g(^HL7Transforme)'="":$g(^HL7Transforme),1:..TransformFile)
		Try {
			do $classmethod(tTransform,"Transform",tVDoc,.tHL7) //##class(HS.Gateway.SDA3.SDA3ToHL7.ADTA0N).Transform(tVDoc,.tHL7)
		}
		Catch ex {

		}

		#dim tHL7 as EnsLib.HL7.Message
		Set tQuickStream = ##class(HS.SDA3.QuickStream).%New()
		set tStream = ##Class(%IO.StringStream).%New()
		do tHL7.OutputToLibraryStream(tStream)
		do tQuickStream.CopyFrom(tStream)
		
		Set pResponse = ##class(HS.FHIRServer.Interop.Response).%New()
		set pResponse.QuickStreamId = tQuickStream.%Id()

		$$$HSTRACE("HL7 Payload", "HL7", tQuickStream.Read())
	

	quit tSC
}

Storage Default
{
<Data name="HL7TransformProcessDefaultData">
<Subscript>"HL7TransformProcess"</Subscript>
<Value name="1">
<Value>TargetConfigName</Value>
</Value>
<Value name="2">
<Value>TransformFile</Value>
</Value>
<Value name="3">
<Value>TraceOperations</Value>
</Value>
</Data>
<DefaultData>HL7TransformProcessDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
