Class HealthToolKit.BO.Local Extends Ens.BusinessOperation
{

Parameter INVOCATION = "Queue";

Method Save(pInput As HealthToolKit.Msg.PatientRequest, pOutput As Ens.Request)
{

    Set tPatient = ##class(HealthToolKit.Table.Patient).%New(pInput)
    $$$ThrowOnError(tPatient.%Save())

    Quit $$$OK
}

XData MessageMap
{
<MapItems>
  <MapItem MessageType="HealthToolKit.Msg.PatientRequest">
    <Method>Save</Method>
  </MapItem>
</MapItems>
}

}
