Include (HS.Gateway.HL7.HL7ToSDA3, HS.HC, HS.HC.Invoke, Ensemble)

/// Convert an HL7 message into SDA3 XML
Class HealthToolKit.Gateway.HL7.HL7ToSDA3 Extends HS.Gateway.HL7.HL7ToSDA3 [ Not ProcedureBlock ]
{

ClassMethod GetSDA(pRequest As EnsLib.HL7.Message, Output pXML As %Stream.GlobalCharacter, pLogAlerts As %Boolean = 1, pObservationMode As %Boolean = 0, pMultiLineOBXCompatibilityMode As %Boolean = 0, pKeepDuplicateOBXIdentifiers As %Boolean = 0) As %Status
{
    set sc = ##super(pRequest,.pXML,pLogAlerts,pObservationMode,pMultiLineOBXCompatibilityMode,pKeepDuplicateOBXIdentifiers) 
    
    kill ^HS.Data
    merge ^HS.Data=^||HS.Data
    
    quit sc
}

ClassMethod SCH()
{

	$$$Find("SCH")
 	do ..write(cr_"<Appointments>")
 	do ..write(cr_"<Appointment>")
 	Do ..OnAppointment()
 	if ($D(encNum)) { do ..WriteEncounterNumber(encNum) }
 	#; SCH-1 : PlacerAppointmentID
 	#; SCH-2 : FillerAppointmentID
 	#; SCH-3 : OccurrenceNumber
 	set placerApptId = $$$SCHPlacerAppointmentID
 	set fillerApptId = $$$SCHFillerAppointmentID
 	set occNum = $$$SCHOccurrenceNumber
 	if (occNum '= "") {
	 	if (placerApptId '= "") { set placerApptId = placerApptId_":"_occNum }
	 	if (fillerApptId '= "") { set fillerApptId = fillerApptId_":"_occNum }
 	}
 	do ..write(cr_"<PlacerApptId>"_placerApptId_"</PlacerApptId>")
 	do ..write(cr_"<FillerApptId>"_fillerApptId_"</FillerApptId>")
 	// If a delete, just set the ActionCode and quit here.
 	if (msgType = "SIU_S17") {
	 	do ..write(cr_"<ActionCode>D</ActionCode>")
	 	do ..write(cr_"</Appointment>")
	 	do ..write(cr_"</Appointments>")
	 	#; RGS segment is required but not used
		$$$Find("RGS")
	 	quit
 	}
 	// SIU_S15 and 16 set the Status
 	set status = $CASE(msgType, "SIU_S15":"CANCELLED", "SIU_S16":"DC", :"")
 	if (status'="") { do ..write(cr_"<Status>"_status_"</Status>") }
 	// SIU_S26 sets NoShow
 	if (msgType = "SIU_S26") { do ..write(cr_"<NoShow>1</NoShow>") }
 	
 	
 	#; SCH-7 : AppointmentReason
 	if ($$$SCHAppointmentReasonIdentifier'="")||($$$SCHAppointmentReasonText'="") {
	 	do ..write(cr_"<Type>")
	 	do ..write(cr_"<SDACodingStandard>"_$$$SCHAppointmentReasonNameofCodingSystem_"</SDACodingStandard>")
 		do ..write(cr_"<Code>"_$$$SCHAppointmentReasonIdentifier_"</Code>")
 		do ..write(cr_"<Description>"_$$$SCHAppointmentReasonText_"</Description>")
 		do ..write(cr_"</Type>")
 	}
 	
 	#; SCH-9 : AppointmentDuration Or AIS-7
 	#; SCH-10 : AppointmentDurationUnits Or AIS-8
 	#; SCH-11 : AppointmentTimingQuantity
 	#; TQ1-6 : ServiceDuration
 	#; TQ1-7 : StartDateTime
 	#; TQ1-8 : EndDateTime
 	// A TQ1 is supposed to be used for the start and end time, the SCH fields are only supported for backwards compatibility.
 	// Check first for a TQ1 following the SCH, and if none, look at the SCH fields.
 	// In either case, if there is a start time and duration but no end time, end time is calculated, but only if the units
 	// of the duration is one of "M", "MINUTES", "H", or "HOURS", case-insensitive
 	if ($$$IsFollowing("TQ1")) {
	 	$$$GetFollowing("TQ1")
	 	set durationQuantity = $$$TQ1ServiceDurationQuantity
	 	set durationUnits = $system.Util.Collation($$$TQ1ServiceDurationUnitsIdentifier,6)  // ALPHAUP
	 	set fromTime = $$$TQ1StartdatetimeTime
	 	set toTime = $$$TQ1EnddatetimeTime
	 	// Switch context back to SCH segment
	 	set s = s - 1
 	}
 	else {
	 	set durationQuantity = $$$SCHAppointmentDuration
	 	set durationUnits = $system.Util.Collation($$$SCHAppointmentDurationUnitsIdentifier,6)  // ALPHAUP
	 	set (fromTime,toTime)=""
		set %occ="" for {
			set %occ = $$$SCHTimingQuantity(%occ) quit:%occ=""
			set fromTime = $$$SCHTimingQuantityStartDateTime(%occ)
			set toTime = $$$SCHTimingQuantityEndDateTime(%occ)
			quit  // only one
		}
        if durationQuantity="" {
            // Try AIS segment
            set segAIS = $$$Next("AIS")
            #define AISAppointmentDuration				$$$xml($g(^||HS.Data(segAIS,7)))
            #define AISAppointmentDurationUnitsIdentifier				$$$xml($g(^||HS.Data(segAIS,8)))
            
            set durationQuantity = $$$AISAppointmentDuration
	 	    set durationUnits = $system.Util.Collation($$$AISAppointmentDurationUnitsIdentifier,6)  // ALPHAUP

        }
 	}
 	if ((fromTime'="")&&(toTime="")&&($IsValidNum(durationQuantity))&&(",M,MINUTES,H,HOURS,"[(","_durationUnits_","))) {
	 	// Calculate ToTime from FromTime and Duration
	 	// Convert duration to seconds
	 	if ($E(durationUnits) = "M") { set durationQuantity = durationQuantity * 60 }
	 	else { set durationQuantity = durationQuantity * 3600 }
	 	// Convert FromTime to horolog format
	 	set dateTimeH=..HL7ToHorolog(fromTime), dateH=$P(dateTimeH,",",1), timeH=$P(dateTimeH,",",2)
	 	set timeH = timeH + durationQuantity
	 	// Check to see if the duration incremented the date. Not likely, but just in case.
	 	set secondsPerDay = 86400
	 	if (timeH >= secondsPerDay) {
		 	set dateH = dateH + timeH\secondsPerDay // Will also take care of cases where date is incremented by >1
		 	set timeH = timeH # secondsPerDay
	 	}
	 	// and finally convert to xml format
	 	set fromTime = $TR($ZDT(dateTimeH, 3), " ", "T")_"Z"
	 	set toTime = $TR($ZDT(dateH_","_timeH, 3), " ", "T")_"Z"
	 	do ..write(cr_"<FromTime>"_fromTime_"</FromTime>")
	 	do ..write(cr_"<ToTime>"_toTime_"</ToTime>")
 	}
 	else {
		do ..write(cr_"<FromTime>"_..xmltimestamp(fromTime)_"</FromTime>")
	 	do ..write(cr_"<ToTime>"_..xmltimestamp(toTime)_"</ToTime>")
 	}
 	
 	#; SCH-20 : EnteredByPerson
 	set %occ="" for {
		set %occ=$$$SCHEnteredByPerson(%occ) quit:%occ=""
		do ..By("<EnteredBy>",,"User",
			$$$SCHEnteredByPersonAssigningAuthority(%occ),
			$$$SCHEnteredByPersonIDNumber(%occ),
			$$$SCHEnteredByPersonFamilyNameSurname(%occ),
			$$$SCHEnteredByPersonGivenName(%occ))
		quit  // only one
	}
	
	#; SCH-22 : EnteredAtLocation
	if ($$$SCHEnteredAtLocation '= "") { set enteredAt = $$$SCHEnteredAtLocation }
	else { set enteredAt = $$$MSHSendingFacilityNamespaceID }
	do ..write(cr_"<EnteredAt>")
	do ..write(cr_"<Code>"_enteredAt_"</Code>")
	do ..write(cr_"</EnteredAt>")
	
	#; SCH-26 : PlacerOrderNumber
	do ..write("<PlacerOrderId>"_$$$SCHPlacerOrderNumber_"</PlacerOrderId>")
	#; SCH-27 : FillerOrderNumber
	do ..write("<FillerOrderId>"_$$$SCHFillerOrderNumber_"</FillerOrderId>")
	
	#; NTE segment (repeating)
	#; NTEs will follow the TQ1, if present, so first find them, then go back 1 segment because
	#; writecdata will advance the context one segment
	if $$$Next("NTE") {
		set s = $$$Next("NTE")
		// Make sure we are following either the SCH or TQ1
		if ((^||HS.Data(s-1)="SCH")||(^||HS.Data(s-1)="TQ1")) { set s=s-1 do ..writecdata("Notes","NTE",3) }
	}
	
	#; RGS segment is required but not used
	$$$Find("RGS")	
	if $$$Next("AIS") do ..AIS()
	if $$$Next("AIP") do ..AIP()
	if $$$Next("AIL") do ..AIL()
	
	do ..write(cr_"</Appointment>")
	do ..write(cr_"</Appointments>")
}

ClassMethod AIS()
{

    do ##super()
}

}
