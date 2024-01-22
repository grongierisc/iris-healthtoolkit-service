Include HS.FHIRServer

Class HealthToolKit.FHIR.DTL.Util.API.Transform.SDA3ToFHIR Extends (HS.FHIR.DTL.Util.API.Transform.SDA3ToFHIR, Ens.Host)
{

/// override TransformContainer to by pass error
Method TransformContainer(
	source As HS.SDA3.Container,
	patientId As %String = "") As HS.FHIR.DTL.Util.API.Transform.SDA3ToFHIR
{
	if ..%bundle.entry.%Size() > 0 {
		$$$ThrowStatus($$$ERROR($$$GeneralError, "Multiple Containers cannot be transformed consecutively. This API only supports single patient context."))
	}
	
	if patientId '= "" {
		set ..%patientId = patientId
		set ..%resourceIds("Patient") = patientId
	}
	
	while source.GetNextSDA(.sdaType, .sdaObj, .tSC) {
		
		Try {
			do ..TransformHelper(sdaObj)
		}
		
		Catch ex {
			$$$LOGWARNING("Transforming SDA3 object is on error: "_sdaType)
			$$$LOGWARNING("Error: "_ex.AsStatus())

		}
		
	}
	
	return $this
}

}
