Class HealthToolKit.REST.Custom Extends %CSP.REST
{

Parameter CHARSET = "UTF-8";

Parameter CONVERTINPUTSTREAM = 1;

Parameter HandleCorsRequest = 1;

XData UrlMap [ XMLNamespace = "http://www.fhirhl7v2demo.com/urlmap" ]
{
<Routes>
  <Route Url="/" Method="POST" Call="custom" Cors="true"/>
</Routes>
}

ClassMethod custom() As %Status
{
    #dim %request as %CSP.Request

    Set tBsName = "HL7_REST_"_$P(%request.URL,"/",*-1)

    Set content = $zcvt(%request.Content.Read(),"I","UTF8")

    set status = $$$OK

    set tMsg = ##class(EnsLib.HL7.Message).ImportFromString(content)
    
    try {

        $$$ThrowOnError(##class(Ens.Director).CreateBusinessService(tBsName,.tService))
        
        $$$ThrowOnError(tService.ProcessInput(tMsg,.output))
    
    } catch ex {

        set status = ex.AsStatus()

    }
    
    return status
}

}
