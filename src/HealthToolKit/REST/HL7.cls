Class HealthToolKit.REST.HL7 Extends %CSP.REST
{

Parameter CHARSET = "UTF-8";

Parameter CONVERTINPUTSTREAM = 1;

Parameter HandleCorsRequest = 1;

XData UrlMap [ XMLNamespace = "http://www.fhirhl7v2demo.com/urlmap" ]
{
<Routes>
  <Route Url="/fhir" Method="POST" Call="hl7" Cors="true"/>
</Routes>
}

ClassMethod hl7() As %Status
{
    #dim %request as %CSP.Request

    Set tBsName = "HL7_Http_Service"

    Set content = $zcvt(%request.Content.Read(),"I","UTF8")

    set status = $$$OK

    set tMsg = ##class(EnsLib.HL7.Message).ImportFromString(content)
    
    try {

        $$$ThrowOnError(##class(Ens.Director).CreateBusinessService(tBsName,.tService))
        
        $$$ThrowOnError(tService.ProcessInput(tMsg,.output))
        #dim output as HS.FHIRServer.Interop.Response
		// If there is any content, pass it back directly
        set ensResponse = output
		if ( ensResponse.QuickStreamId '= "" ) {
			Set %response.ContentType = ensResponse.ContentType
			Set %response.CharSet = ensResponse.CharSet
			Set outputQuickStream = ##class(HS.SDA3.QuickStream).%OpenId(ensResponse.QuickStreamId)
			d outputQuickStream.OutputToDevice()
		
		}
    
    } catch ex {

        set status = ex.AsStatus()

    }
    
    return status
}

}
