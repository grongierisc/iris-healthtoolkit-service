Class HealthToolKit.REST.CDA Extends %CSP.REST
{

Parameter CHARSET = "UTF-8";

Parameter CONVERTINPUTSTREAM = 1;

Parameter HandleCorsRequest = 1;

XData UrlMap [ XMLNamespace = "http://www.fhirhl7v2demo.com/urlmap" ]
{
<Routes>
  <Route Url="/fhir" Method="POST" Call="cda" Cors="true"/>
</Routes>
}

ClassMethod cda() As %Status
{
    set status = $$$OK

    Set tStream = %request.Content

    set tMsg = ##class(Ens.StreamContainer).%New(tStream)
    
    try {

        Set tBsName = "CDA_Http_Service"

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

    } catch(ex) {
        set status = ex.AsStatus()
    }
    
    return status
}

}
