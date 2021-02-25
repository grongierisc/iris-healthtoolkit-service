Class HealthToolKit.Object.Patient Extends %SerialObject
{

Property PatientID As %String;

Property FirstName As %String;

Property LastName As %String;

Storage Default
{
<Data name="PatientState">
<Value name="1">
<Value>FirstName</Value>
</Value>
<Value name="2">
<Value>LastName</Value>
</Value>
<Value name="3">
<Value>IDPatient</Value>
</Value>
<Value name="4">
<Value>PatientID</Value>
</Value>
</Data>
<State>PatientState</State>
<StreamLocation>^HealthToolKit.Object.PatientS</StreamLocation>
<Type>%Storage.Serial</Type>
}

}
