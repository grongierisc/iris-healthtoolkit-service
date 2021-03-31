Include (HS.Gateway.HL7.HL7ToSDA3, HS.HC)

/// Convert an HL7 message into SDA3 XML
Class HealthToolKit.Hub.Standalone.HL7.HL7ToSDA3 Extends %RegisteredObject [ ProcedureBlock ]
{

Parameter HSDEPLOY = 1;

/// Input: One HL7 message in EnsLib.HL7.Message
/// Output: SDA3 Container object
ClassMethod GetSDAContainer(pRequest As EnsLib.HL7.Message, Output pSDA As HS.SDA3.Container, pLogAlerts As %Boolean = 1) As %Status
{
 set msgType = pRequest.Name,msgType = $P(msgType,"_",1)_"_"_$P(msgType,"_",2)

 set tSC=$$$OK

 // force schema to resolve even if EVN missing error occurs
 do:$$$OK'=pRequest.BuildMapStatus pRequest.BuildMap() 
 
 // Get HL7 To SDA Transform Class
 set tSC = ..GetTransformClass(msgType, .tTransformClass) 
 if $$$ISERR(tSC) quit tSC
 
 // Perform HL7 To SDA Transform
 set tSC=$ClassMethod(tTransformClass,"Transform",pRequest,.pSDA)
 if $$$ISERR(tSC) quit tSC
 
 set tSC=$$$OK,tAction=""

 set tSendingFacilityNamespaceID = pRequest.GetValueAt("MSH:SendingFacility.NamespaceID",,.tSC)
 if $$$ISERR(tSC) quit tSC

 set tSC=..DetermineAction(msgType, .tAction)
 if $$$ISERR(tSC) quit tSC

 set pSDA.UpdateECRDemographics = 0
 set pSDA.EventDescription = pRequest.Name
 set pSDA.SendingFacility = tSendingFacilityNamespaceID
 set pSDA.Action = tAction

 quit tSC
}

ClassMethod GetTransformClass(msgType As %String, ByRef pTransformClass As %String) As %Status
{
	set tSC=$$$OK
	
	set pTransformClass=..OnGetTransformClass() 
	quit:pTransformClass'=""	
	
	set pTransformClass = $CASE(msgType,
              "ADT_A01":"ADTA01ToSDA3", "ADT_A02":"ADTA02ToSDA3", "ADT_A03":"ADTA03ToSDA3",
              "ADT_A04":"ADTA01ToSDA3", "ADT_A05":"ADTA05ToSDA3", "ADT_A06":"ADTA01ToSDA3",
              "ADT_A07":"ADTA01ToSDA3", "ADT_A08":"ADTA01ToSDA3", "ADT_A09":"ADTA01ToSDA3",
              "ADT_A10":"ADTA01ToSDA3", "ADT_A11":"ADTA09ToSDA3", "ADT_A12":"ADTA01ToSDA3",
              "ADT_A13":"ADTA01ToSDA3", "ADT_A16":"ADTA01ToSDA3", "ADT_A17":"ADTA01ToSDA3",
              "ADT_A18":"ADTA18ToSDA3", "ADT_A23":"ADTA21ToSDA3", "ADT_A25":"ADTA01ToSDA3",
              "ADT_A27":"ADTA01ToSDA3", "ADT_A28":"ADTA05ToSDA3", "ADT_A29":"ADTA21ToSDA3",
              "ADT_A30":"ADTA30ToSDA3", "ADT_A31":"ADTA05ToSDA3", "ADT_A34":"ADTA30ToSDA3",
              "ADT_A36":"ADTA30ToSDA3", "ADT_A39":"ADTA40ToSDA3", "ADT_A40":"ADTA40ToSDA3",
              "ADT_A45":"ADTA45ToSDA3", "ADT_A47":"ADTA30ToSDA3", "ADT_A50":"ADTA50ToSDA3",
              "ADT_A60":"ADTA60ToSDA3", "BAR_P12":"BARP12ToSDA3", "MDM_T02":"MDMT02ToSDA3",
              "MDM_T04":"MDMT02ToSDA3", "MDM_T08":"MDMT02ToSDA3", "MDM_T11":"MDMT01ToSDA3",
              "OMP_O09":"OMPO09ToSDA3", "ORM_O01":"ORMO01ToSDA3", "ORU_R01":"ORUR01ToSDA3",
              "PPR_PC1":"PPRPC1ToSDA3", "PPR_PC2":"PPRPC1ToSDA3", "PPR_PC3":"PPRPC1ToSDA3",
              "RDE_O11":"RDEO11ToSDA3", "SIU_S12":"SIUS12ToSDA3", "SIU_S13":"SIUS12ToSDA3",
              "SIU_S14":"SIUS12ToSDA3", "SIU_S15":"SIUS12ToSDA3", "SIU_S16":"SIUS12ToSDA3",
              "SIU_S17":"SIUS12ToSDA3", "SIU_S26":"SIUS12ToSDA3", "VXU_V04":"VXUV04ToSDA3",
              :"Unsupported HL7 Message Type")

	set:pTransformClass="Unsupported HL7 Message Type" tSC = $$$HSError($$$HSErrUnsupportedHL7MessageType,msgType)
 	if $$$ISERR(tSC) quit tSC
 	
	set tTransformPackage = "HealthToolKit.Hub.Standalone.HL7.DTL"
	set tTransformClass = tTransformPackage_"."_pTransformClass

	if '$$$comClassDefined(tTransformClass)
	{
		set tTransformPackage = "HS.Hub.Standalone.HL7.DTL"
 		set tTransformClass = tTransformPackage_"."_pTransformClass
	}

	set pTransformClass = tTransformClass

	quit tSC
}

ClassMethod DetermineAction(msgType, ByRef pAction As %String) As %Status
{
 set tSC=$$$OK
 
 #; Supported message types and message structures	
 set pAction = $CASE(msgType, 
 				"ADT_A23":"DeletePatient", 
 				"ADT_A29":"DeletePatient", 
 				"ADT_A18":"Merge", 
 				"ADT_A30":"Merge", 
 				"ADT_A34":"Merge", 
 				"ADT_A36":"Merge", 
 				"ADT_A39":"Merge", 
 				"ADT_A40":"Merge", 
 				"ADT_A47":"Merge", 
               :"AddOrUpdate")
               
 quit tSC
}

/// Utility Method for formatting a Phone Number from the 4 fields supplied
/// Can be called from within transforms for processing incoming HL7 messages
ClassMethod FormatPhone(country As %String, area As %String, number As %String, extension As %String) As %String
{
 set tPhone=""
 if country'="" set tPhone=tPhone_"+"_country
 if area'="" set:tPhone'="" tPhone=tPhone_" " set tPhone=tPhone_"("_area_")"
 set:tPhone'="" tPhone=tPhone_" " set tPhone=tPhone_number
 if extension'="" set:tPhone'="" tPhone=tPhone_" " set tPhone=tPhone_"x"_extension
 quit tPhone
}

/// Utility Method for converting HL7 date to timestamp for assigning to an SDA object.
/// Can be called from within transforms for processing incoming HL7 messages
ClassMethod timestamp(dt As %String) As %String
{
 quit:dt="""""" dt
 #; Convert an HL7 date of the form yyyymmddhhnnss into a
 #; standard SDA date format yyyy-mm-ddThh:nn:ss
 #; If invalid, return ""
 set tz="+"_$zstrip($p(dt,"+",2),"<>W")
 set:tz="+" tz="-"_$zstrip($p(dt,"-",2),"<>W")
 If tz="-" {
	 Set tz="Z"
 }Else{
	 set tz = $E(tz,1,3)_":"_$E(tz,4,*)
 }
 set:dt["+" dt=$zstrip($p(dt,"+"),"<>W") quit:$c(0)[dt ""
 set:dt["-" dt=$zstrip($p(dt,"-"),"<>W") quit:$c(0)[dt ""
 #; extract yyyy,mm,dd,hh,nn,ss
 set yyyy=$e(dt,1,4),mm=$e(dt,5,6),dd=$e(dt,7,8),hh=$e(dt,9,10),nn=$e(dt,11,12),ss=$e(dt,13,14)
 #; default mm and dd to 01
 set:mm="" mm=1 set:dd="" dd=1
 #; convert to yyyy-mm-dd hh:nn:ss
 set dt=yyyy_"-"_$e(100+mm,2,3)_"-"_$e(100+dd,2,3)_" "_$e(100+hh,2,3)_":"_$e(100+nn,2,3)_":"_$e(100+ss,2,3)
 #; validate
 set valid=$zdth(dt,8,1,,,,,,,0) if valid=0 quit ""
 #; convert to yyyy-mm-ddThh:nn:ss
 quit ..XMLToLogical($tr(dt," ","T")_tz)
}

ClassMethod XMLToLogical(pXmlTime As %String) As %String
{
	If $length(pXmlTime,"T")'=2 Quit ""
	Set dt=$translate(pXmlTime,"T"," ")
	Set len=$length(pXmlTime)
	If $extract(pXmlTime,len)="Z" {
		Set dt=$extract(dt,1,len-1)
	} ElseIf $case($extract(pXmlTime,len-5),"+":1,"-":1,:0) {
		If $extract(pXmlTime,len-2)'=":" Quit ""
		Set dt=$extract(dt,1,len-6)
		Set f=$piece(dt,".",2) If f'="" Set f="."_f,dt=$piece(dt,".")
		Set t=$zdatetimeh(dt,3,1,,,,,,,"") If t="" Quit ""
		Set d=$piece(t,",")
		Set s=$piece(t,",",2)
		Set z=($extract(pXmlTime,len-4,len-3)*60+$extract(pXmlTime,len-1,len))*60
		If $extract(pXmlTime,len-5)="-" {
			Set s=s+z
			If s>=(24*60*60) Set d=d+1,s=s-(24*60*60)
		} Else {
			Set s=s-z
			If s<0 Set d=d-1,s=s+(24*60*60)
		}
		Set dt=$zdatetime(d_","_s,3,1,0,,,,,,,"")
		Quit $select(dt="":"",1:dt_f)
	}
	If $zdatetimeh(dt,3,1,,,,,,,"")="" Quit ""
	Quit dt
}

/// Convert an HL7 timestamp to horolog ($H) format
/// Can be called from within transforms for processing incoming HL7 messages
ClassMethod HL7ToHorolog(dt As %String) As %String
{
	// First transform YYYYMMDDhhmm to YYYYMMDDThh:mm
	set dt = $E(dt,1,8)_"T"_$E(dt,9,10)_":"_$E(dt,11,12)
	quit $ZDTH(dt,8,2)
}

/// Patient Number Identifier Codes
/// Can be called from within transforms for processing incoming HL7 messages
ClassMethod idtype(value As %String) As %String
{
 if (value="MR")||(value="MRN")||(value="PI") quit "MRN"
 If ##class(HS.Registry.Config).GetKeyValue("\General\LegacyPatientIdentifierTypeRestriction",0) {
	 if (value="SSN")||(value="DL")||(value="XX")||(value="PPN")||(value="SNC")||(value="NI") quit value
	 if (value="") quit ""
	 quit "OTH"
 }
 Quit value
}

/// If both last and first are given, returns the name as last_", "_first<br>
/// Else if last is given, returns last<br>
/// Else if first is given, returns first<br>
/// Else returns ""
/// Can be called from within transforms for processing incoming HL7 messages
ClassMethod formatname(last As %String, first As %String, middle As %String, prefix As %String) As %String
{
 set name=""
 if $l(last) {
	set name=last
	if $l(first) {
		set name=name_", "_first}	
 } elseif $l(first) {
	set name=first}
 quit name
}

/// Callback method to provide transform class name
ClassMethod OnGetTransformClass() As %String
{
 quit ""
}

}
