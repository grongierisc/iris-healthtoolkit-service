Include HS.FHIRServer

/// This business process takes a FHIR resource or Bundle as input. The FHIR input can
/// only be of the configured FHIR version. This business process transforms the FHIR
/// data into SDA3, forwards the SDA3 stream to a specified business host, receives
/// the response from the business host, and returns a FHIR response.
Class HealthToolKit.FHIR.DTL.Util.HC.FHIR.SDA3.Process Extends (Ens.BusinessProcess, HS.HC.Util.Trace.Helper) [ ClassType = persistent, Inheritance = right ]
{

Parameter HSDEPLOY = 1;

Parameter SETTINGS = "TargetConfigName:Basic:selector?context={Ens.ContextSearch/ProductionItems?targets=1&productionName=@productionId},CallbackClass,OutputToQuickStream,TransformClass::selector?context={HS.HC.Util.ContextSearch/SubclassOf?class=HS.FHIR.DTL.Util.API.Transform.FHIRToSDA3},FHIRMetadataSet::selector?context={HS.FHIRServer.Util.ContextSearch/FHIRMetadataSets}";

/// Business host to which to forward the XMLMessage message (which includes the
/// SDA3 stream) after it is built by the FHIR to SDA3 transformation.
Property TargetConfigName As Ens.DataType.ConfigName;

/// THIS SETTING IS UNUSED AS OF 2020.2 - It is retained to provide user visibility for reference during conversion of existing code customizations.<br>
/// <br>
/// (LEGACY COMMENT) Class to use for the callback object that is invoked during the DTL transformation
/// process. If this setting is left blank, at run-time it is defaulted to
/// "HS.FHIR.DTL.Util.API.HC.Callback.Default."+FHIRVersion+"ToSDA3". FHIRVersion is
/// to be derived from the incoming FHIR request message FHIRVersion property.
Property CallbackClass As %String(MAXLEN = 256) [ Deprecated ];

/// The output of this business process is an HS.Message.XMLMessage message.<br>
/// <br>
/// If OutputToQuickStream is not checked, the SDA3 output of the transformation
/// will be placed in the HS.Message.XMLMessage ContentStream property.<br>
/// <br>
/// If this setting is checked, the SDA3 output will be placed in an
/// HS.SDA3.QuickStream, and the QuickStreamId property of the HS.Message.XMLMessage
/// will be set to the id of that QuickStream.
Property OutputToQuickStream As %Boolean [ InitialExpression = 0 ];

/// FHIR to SDA3 transformation API class. Must be or extend HS.FHIR.DTL.Util.API.Transform.FHIRToSDA3.
Property TransformClass As %Dictionary.Classname [ InitialExpression = "HS.FHIR.DTL.Util.API.Transform.FHIRToSDA3" ];

/// FHIR Metadata Set. These are defined in HS_FHIRServer.FHIRMetadataSet.
Property FHIRMetadataSet As %String(MAXLEN = 256);

Method OnRequest(
	pRequest As %Library.Persistent,
	Output pResponse As %Library.Persistent) As %Status
{
	Set tSC = $$$OK
	
	Try {
		If pRequest.%IsA("HS.FHIRServer.Interop.Request") {
			Do ..ProcessFHIRInteropRequest(pRequest, .pResponse)
			
		} ElseIf pRequest.%IsA("HS.Message.FHIR.Request") {
			Set tSC = ..ProcessFHIRRequest(pRequest, .pResponse)
			
		} Else {
			Set tSC = $$$ERROR($$$GeneralError, "Request type not handled:  " _ pRequest.%ClassName(1)) Quit
		}
		
	} Catch eException {
		Set tSC = eException.AsStatus()
	}
	
	Quit tSC
}

Method OnInit() As %Status
{
	If ..TargetConfigName="" {
		Return $$$ERROR($$$GeneralError, "TargetConfigName not configured")
	}
	
	Set tRequiredBase = "HS.FHIR.DTL.Util.API.Transform.FHIRToSDA3"
	
	If '$ClassMethod(..TransformClass, "%IsA", tRequiredBase) {
		Return $$$ERROR($$$GeneralError, "TransformClass must extend "_tRequiredBase)
	}
	
	If ..FHIRMetadataSet="" {
		Return $$$ERROR($$$GeneralError, "FHIRMetadataSet not configured")
	}
	
	Return $$$OK
}

/// ProcessFHIRInteropRequest uses HS.FHIRServer.Interop.Request as its vehicle for
/// input, and returns HS.FHIRServer.Interop.Response to return the status.<br>
/// Input:<br>
/// - Either pRequest.QuickStreamId OR pRequest.Request.Json is required. If both are
///   populated, then QuickStreamId is used. No other request property is required.
/// - pRequest.Request.RequestFormatCode is optional, however, providing it as input
///   provides a minor performance gain.<br>
/// Output:<br>
/// - pResponse.Response.Status is populated with 200 upon successful completion.
///   Otherwise, this method will Throw an error which will be caught by OnRequest()
///   and returned as a %Status.
Method ProcessFHIRInteropRequest(
	pRequest As HS.FHIRServer.Interop.Request,
	ByRef pResponse As HS.FHIRServer.Interop.Response) As %Status
{
	Set tFHIRMetadataSetKey = $ZStrip($Piece(..FHIRMetadataSet, "/", 1), "<>W")
	
	#dim tTransformer As HS.FHIR.DTL.Util.API.Transform.FHIRToSDA3
	
	If pRequest.QuickStreamId'="" {
		Set tQuickStream = ##class(HS.SDA3.QuickStream).%OpenId(pRequest.QuickStreamId)
		If pRequest.Request.RequestFormatCode'="" {
			Set tFHIRFormat = pRequest.Request.RequestFormatCode
		} Else {
			$$$ThrowOnError(##class(HS.HC.Util).GetFormatFromData(tQuickStream, .tFHIRFormat))
			Do tQuickStream.Rewind()
			If tFHIRFormat="json" {
				Set tFHIRFormat = $$$FHIRContentCodeJSON
			} ElseIf tFHIRFormat="xml" {
				Set tFHIRFormat = $$$FHIRContentCodeXML
			}
		}
		Set tTransformer = $ClassMethod(..TransformClass, "TransformStream", tQuickStream, tFHIRMetadataSetKey, tFHIRFormat)
		
	} ElseIf (($IsObject(pRequest.Request.Json))&&(pRequest.Request.Json.%GetIterator().%GetNext())) {
		// Could have Json %DynamicObject if this host is called InProc.
		Set tTransformer = $ClassMethod(..TransformClass, "TransformObject", pRequest.Request.Json, tFHIRMetadataSetKey)
		
	} Else {
		$$$ThrowStatus($$$ERROR($$$GeneralError, "FHIR interop request message missing FHIR content"))
	}
	
	// If FHIR input was a single resource, then .object will be
	// a single SDA3 object (e.g., instance of HS.SDA3.Patient).
	// Otherwise if a Bundle of resources was input, then .object
	// will be an HS.SDA3.Container.
	Set tSDA3Object = tTransformer.object
	
	Set tSDA3XMLMessage = ##class(HS.Message.XMLMessage).%New()
	If ..OutputToQuickStream {
		Set tQuickStream = ##class(HS.SDA3.QuickStream).%New()
		Set tQuickStreamId = tQuickStream.%Id()
		Do tSDA3XMLMessage.AdditionalInfo.SetAt(tQuickStreamId, "QuickStreamId")
		Set tSDA3Stream = tQuickStream
	} Else {
		Set tQuickStreamId = ""
		Set tSDA3Stream = tSDA3XMLMessage.ContentStream
	}
	
	$$$ThrowOnError(tSDA3Object.XMLExportToStream(tSDA3Stream))
	
	Do tSDA3Stream.Rewind()
	
	$$$HSTRACE("SDA3 Stream", "tSDA3Stream", tSDA3Stream)
	
	$$$ThrowOnError(pRequest.NewResponse(.pResponse))
	//Set pResponse.Response = ##class(HS.FHIRServer.API.Data.Response).%New()
	Set pResponse.Response.ResponseFormatCode = pRequest.Request.ResponseFormatCode
	
	// tSDA3XMLResponse is unused placeholder. Upon error tSC will be Thrown and
	// FHIRService will catch it and formulate an OperationOutcome from it.
	Set tSC = ..SendRequestSync(..TargetConfigName, tSDA3XMLMessage, .tSDA3XMLResponse)
	$$$ThrowOnError(tSC)
	
	set pResponse.QuickStreamId = tSDA3XMLResponse.QuickStreamId
	set pResponse.Response.Status = 200
	set pResponse.ContentType = "text/plain"
	
	If ($Get(tQuickStreamId)'="")&&($IsObject($Get(tQuickStream))) Do tQuickStream.Clear()
	
	Quit
}

/// ProcessFHIRRequest is retained to provide compatibility with the
/// HS.Message.FHIR.Request message input. This method does NOT
/// provide compatibility with the pre-2020.2 transformation API or
/// customization mechanisms.
Method ProcessFHIRRequest(
	pFHIRRequest As HS.Message.FHIR.Request,
	Output pFHIRResponse As HS.Message.FHIR.Response) As %Status
{
	Set tSC = $$$OK
	
	Try {
		// Create a FHIRServer Interop request from the FHIR request message.
		Set tRequest = ##class(HS.FHIRServer.Interop.Request).%New()
		If pFHIRRequest.ContentType["json" {
			Set tRequest.Request.RequestFormatCode = $$$FHIRContentCodeJSON
		} Else {
			Set tRequest.Request.RequestFormatCode = $$$FHIRContentCodeXML
		}
		If pFHIRRequest.QuickStreamId'="" {
			Set tRequest.QuickStreamId = pFHIRRequest.QuickStreamId
		} Else {
			Set tQuickStream = ##class(HS.SDA3.QuickStream).%New()
			Do tQuickStream.CopyFrom(pFHIRRequest.Payload)
			Set tQuickStreamId = tQuickStream.%Id()
			Set tRequest.QuickStreamId = tQuickStreamId
		}
		
		#dim tResponse As HS.FHIRServer.Interop.Response
		
		Try {
			Set tSC2 = $$$OK
			Do ..ProcessFHIRInteropRequest(tRequest, .tResponse)
		} Catch e2Exception {
			Set tSC2 = e2Exception.AsStatus()
		}
		
		Do pFHIRRequest.NewResponse(.pFHIRResponse)
		
		If $$$ISOK(tSC2) {
			Set pFHIRResponse.Status = tResponse.Response.Status
		} Else {
			Set pFHIRResponse.Status = 500
			Set tFHIRStream = ##class(%Stream.TmpCharacter).%New()
			Set tText = $system.Status.GetErrorText(tSC2)
			Set tSC = ##class(HS.FHIR.Utils).CreateOutcomeSingleIssueStream(pFHIRRequest.ContentType, .tFHIRStream, "error", "exception", tText, , , tText, , , pFHIRRequest.FormatFHIROutput)
			If $$$ISERR(tSC) Quit
			Do tFHIRStream.Rewind()
			Do pFHIRResponse.Payload.CopyFrom(tFHIRStream)
		}
		
	} Catch eException {
		Set tSC = eException.AsStatus()
	}
	
	If ($Get(tQuickStreamId)'="")&&($IsObject($Get(tQuickStream))) Do tQuickStream.Clear()
	
	Quit tSC
}

Storage Default
{
<Data name="ProcessDefaultData">
<Subscript>"Process"</Subscript>
<Value name="1">
<Value>TraceOperations</Value>
</Value>
<Value name="2">
<Value>TargetConfigName</Value>
</Value>
<Value name="3">
<Value>CallbackClass</Value>
</Value>
<Value name="4">
<Value>OutputToQuickStream</Value>
</Value>
<Value name="5">
<Value>TransformClass</Value>
</Value>
<Value name="6">
<Value>FHIRMetadataSet</Value>
</Value>
</Data>
<DefaultData>ProcessDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
