/// Transforms SDA3 HS.SDA3.RadOrder to vR4 DiagnosticReport
Class HS.FHIR.DTL.SDA3.vR4.RadOrder.DiagnosticReport Extends Ens.DataTransformDTL [ DependsOn = (HS.SDA3.RadOrder, HS.FHIR.DTL.vR4.Model.Resource.DiagnosticReport), ProcedureBlock ]
{

/// This DTL XData block was generated. Do not modify it.
XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='HS.SDA3.RadOrder' targetClass='HS.FHIR.DTL.vR4.Model.Resource.DiagnosticReport' create='existing' language='objectscript' >
  <annotation>
    <![CDATA[ Transforms HS.SDA3.RadOrder (SDA3) to DiagnosticReport (vR4) ]]>
  </annotation>
<assign value='"Radiology"' property='target.category.(1).text' action='set' >
<annotation>
<![CDATA[ Plain text representation of the concept
 --- This target is one field within a CodeableConcept object assigned to the target DiagnosticReport:category.    ]]>
</annotation>
</assign>
<assign value='"RAD"' property='target.category.(1).coding.(1).code' action='set' >
<annotation>
<![CDATA[ Service category
 --- This target is one field within a CodeableConcept object assigned to the target DiagnosticReport:category.    ]]>
</annotation>
</assign>
<assign value='"Radiology"' property='target.category.(1).coding.(1).display' action='set' >
<annotation>
<![CDATA[ Representation defined by the system
 --- This target is one field within a CodeableConcept object assigned to the target DiagnosticReport:category.    ]]>
</annotation>
</assign>
<assign value='"http://terminology.hl7.org/CodeSystem/v2-0074"' property='target.category.(1).coding.(1).system' action='set' >
<annotation>
<![CDATA[ Identity of the terminology system
 --- This target is one field within a CodeableConcept object assigned to the target DiagnosticReport:category.    ]]>
</annotation>
</assign>
<assign value='aux("transformer").GetPatientReference()' property='value' action='set' />
<if condition='value&apos;=""'> 
<true>
<assign value='value' property='target.subject' action='set' >
<annotation>
<![CDATA[ The subject of the report - usually, but not always, the patient ]]>
</annotation>
</assign></true> 
</if> 
<assign value='target.basedOn.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Resource.ServiceRequest).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source, "HS.FHIR.DTL.SDA3.vR4.RadOrder.ServiceRequest")' property='DTL' action='set' />
<if condition='DTL&apos;=""'> 
<true>
<assign value='$classmethod(DTL, "Transform", source, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""'> 
<true>
<assign value='aux("transformer").AddResource(source, tmp)' property='reference' action='set' />
<if condition='reference&apos;=""'> 
<true>
<assign value='reference' property='target.basedOn' action='set' key='index'  >
<annotation>
<![CDATA[ What was requested
Note: If results exist, this is where the ServiceRequest resource is created. This way, the ServiceRequest and DiagnosticReport resources are linked by a reference ]]>
</annotation>
</assign></true> 
</if>
</true>
</if>
</true>
</if>

<if condition='source.Comments&apos;=""'> 
<true> 
<assign value='source.Comments' property='target.conclusion' action='set' >
<annotation>
<![CDATA[ Clinical conclusion (interpretation) of test results ]]>
</annotation>
</assign></true> 
</if> 

<assign value='##class(HS.FHIR.DTL.Util.Lookup).SaveValueToAux("EncounterNumber", source.EncounterNumber, .aux)' property='value' action='set' />
<if condition='value&apos;=""'> 
<true>
<assign value='value' property='target' action='set' >
<annotation>
<![CDATA[ A Diagnostic report - a combination of request information, atomic results, images, interpretation, as well as formatted reports ]]>
</annotation>
</assign></true> 
</if> 
<assign value='aux("transformer").GetReference("Encounter",source.EncounterNumber)' property='value' action='set' />
<if condition='value&apos;=""'> 
<true>
<assign value='value' property='target.encounter' action='set' >
<annotation>
<![CDATA[ Health care event when test ordered ]]>
</annotation>
</assign></true> 
</if> 
<assign value='##class(HS.FHIR.DTL.Util.SDA3.Handler.ExternalId).Identifier(source.ExternalId)' property='value' action='set' />
<assign value='target.identifier.Count()+1' property='index' action='set' />
<if condition='value&apos;=""'> 
<true>
<assign value='value' property='target.identifier' action='set' key='index'  >
<annotation>
<![CDATA[ Business identifier for report ]]>
</annotation>
</assign></true> 
</if> 
<assign value='##class(HS.FHIR.DTL.Util.SDA3.Handler.Order).FillerId(source.FillerId, .aux)' property='value' action='set' />
<assign value='target.identifier.Count()+1' property='index' action='set' />
<if condition='value&apos;=""'> 
<true>
<assign value='value' property='target.identifier' action='set' key='index'  >
<annotation>
<![CDATA[ Business identifier for report ]]>
</annotation>
</assign></true> 
</if> 
<if condition='source.FromTime&apos;=""'> 
<true>
<assign value='##class(HS.FHIR.DTL.Util.Element.TypeCast).DateToFHIR(source.FromTime, "dateTime")' property='value' action='set' />
<if condition='value&apos;=""'> 
<true>
<assign value='value' property='target.effectivePeriod.start' action='set' >
<annotation>
<![CDATA[ Starting time with inclusive boundary ]]>
</annotation>
</assign></true> 
</if> 
</true>
</if>
<if condition='source.Result.ResultTime = ""'> 
<true>
<assign value='##class(HS.FHIR.DTL.Util.Element.TypeCast).DateToFHIR(source.FromTime, "instant")' property='value' action='set' />
<if condition='value&apos;=""'> 
<true>
<assign value='value' property='target.issued' action='set' >
<annotation>
<![CDATA[ DateTime this version was made ]]>
</annotation>
</assign></true> 
</if> 
</true>
</if>
<if condition='##class(HS.FHIR.DTL.Util.Element.Object).Defined(source, "OrderCategory")'> 
<true>
<assign value='target.category.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Datatype.CodeableConcept).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.OrderCategory, "HS.FHIR.DTL.SDA3.vR4.CodeTableTranslated.CodeableConcept")' property='DTL' action='set' />
<if condition='DTL&apos;=""'> 
<true>
<assign value='$classmethod(DTL, "Transform", source.OrderCategory, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""'> 
<true>
<assign value='tmp' property='target.category' action='set' key='index'  >
<annotation>
<![CDATA[ Service category
 --- In this case, any FHIR4 code may be used; diagnostic-service-sections shows Example codes, but you may use codes from any ValueSet. 
 --- SDA does not restrict code values to a particular set.    ]]>
</annotation>
</assign></true> 
</if>
</true>
</if>
</true> 
</if>
<if condition='##class(HS.FHIR.DTL.Util.Element.Object).Defined(source, "OrderedBy")'> 
<true>
<assign value='target.performer.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Resource.Practitioner).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.OrderedBy, "HS.FHIR.DTL.SDA3.vR4.CodeTableDetail.CareProvider.Practitioner")' property='DTL' action='set' />
<if condition='DTL&apos;=""'> 
<true>
<assign value='$classmethod(DTL, "Transform", source.OrderedBy, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""'> 
<true>
<assign value='aux("transformer").AddResource(source.OrderedBy, tmp)' property='reference' action='set' />
<if condition='reference&apos;=""'> 
<true>
<assign value='reference' property='target.performer' action='set' key='index'  >
<annotation>
<![CDATA[ Responsible Diagnostic Service ]]>
</annotation>
</assign></true> 
</if>
</true>
</if>
</true>
</if>
</true> 
</if>
<if condition='##class(HS.FHIR.DTL.Util.Element.Object).Defined(source, "OrderItem")'> 
<true>
<assign value='##class(HS.FHIR.DTL.vR4.Model.Datatype.CodeableConcept).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.OrderItem, "HS.FHIR.DTL.SDA3.vR4.CodeTableTranslated.CodeableConcept")' property='DTL' action='set' />
<if condition='DTL&apos;=""'> 
<true>
<assign value='$classmethod(DTL, "Transform", source.OrderItem, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""'> 
<true>
<assign value='tmp' property='target.code' action='set'  >
<annotation>
<![CDATA[ Name/Code for this diagnostic report
 --- Although not required according to the HS.SDA3.RadOrder class definition, in practice, the OrderItem property always contains a value.
 --- In this case, report-codes is the Preferred FHIR4 ValueSet for codes, but if you need to express meanings not found in report-codes, you may use codes from any ValueSet. 
 --- SDA does not restrict code values to a particular set.    ]]>
</annotation>
</assign></true> 
</if>
</true>
</if>
</true> 
<false>
<assign value='##class(HS.FHIR.DTL.vR4.Model.Datatype.CodeableConcept).%New()' property='tmp' action='set' />
<assign value='"Default"' property='tmp.text' action='set' />
<assign value='tmp' property='target.code' action='set' />
</false>
</if>
<if condition='##class(HS.FHIR.DTL.Util.Element.Object).Defined(source, "ParentResultObservation")'> 
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.ParentResultObservation, "HS.FHIR.DTL.SDA3.vR4.CodeTableDetail.LabTestItem.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""'> 
<true>
<assign value='$classmethod(DTL, "Transform", source.ParentResultObservation, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""'> 
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/rad-order-parent-result-observation"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index'  >
<annotation>
<![CDATA[ Additional content defined by implementations ]]>
</annotation>
</assign></true> 
</if>
</true>
</if>
</true> 
</if>
<if condition='source.ParentResultObservationSubId&apos;=""'> 
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.ParentResultObservationSubId, "HS.FHIR.DTL.SubXFrm.SDA3.vR4.String.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""'> 
<true>
<assign value='$classmethod(DTL, "Transform", source.ParentResultObservationSubId, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""'> 
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/rad-order-parent-result-observation-sub-id"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index'  >
<annotation>
<![CDATA[ Additional content defined by implementations ]]>
</annotation>
</assign></true> 
</if>
</true>
</if>

</true>
</if>
<if condition='source.ParentResultObservationText&apos;=""'> 
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.ParentResultObservationText, "HS.FHIR.DTL.SubXFrm.SDA3.vR4.String.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""'> 
<true>
<assign value='$classmethod(DTL, "Transform", source.ParentResultObservationText, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""'> 
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/rad-order-parent-result-observation-text"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index'  >
<annotation>
<![CDATA[ Additional content defined by implementations ]]>
</annotation>
</assign></true> 
</if>
</true>
</if>

</true>
</if>
<assign value='##class(HS.FHIR.DTL.Util.SDA3.Handler.Order).PlacerId(source.PlacerId, .aux)' property='value' action='set' />
<assign value='target.identifier.Count()+1' property='index' action='set' />
<if condition='value&apos;=""'> 
<true>
<assign value='value' property='target.identifier' action='set' key='index'  >
<annotation>
<![CDATA[ Business identifier for report ]]>
</annotation>
</assign></true> 
</if> 
<if condition='source.Result.ResultItems.Count() = 0'> 
<true>
<if condition='##class(HS.FHIR.DTL.Util.Element.Object).Defined(source, "Result")'> 
<true>
<assign value='target.presentedForm.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Datatype.Attachment).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.Result, "HS.FHIR.DTL.SDA3.vR4.Result.Attachment")' property='DTL' action='set' />
<if condition='DTL&apos;=""'> 
<true>
<assign value='$classmethod(DTL, "Transform", source.Result, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""'> 
<true>
<assign value='tmp' property='target.presentedForm' action='set' key='index'  >
<annotation>
<![CDATA[ Entire report as issued ]]>
</annotation>
</assign></true> 
</if>
</true>
</if>
</true> 
</if>
</true>
</if>
<foreach property='source.Result.ResultItems()' key='st' >
<assign value='target.result.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Resource.Observation).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.Result.ResultItems.(st), "HS.FHIR.DTL.SDA3.vR4.LabResultItem.Observation")' property='DTL' action='set' />
<if condition='DTL&apos;=""'> 
<true>
<assign value='$classmethod(DTL, "Transform", source.Result.ResultItems.(st), .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""'> 
<true>
<assign value='aux("transformer").AddResource(source.Result.ResultItems.(st), tmp)' property='reference' action='set' />
<if condition='reference&apos;=""'> 
<true>
<assign value='reference' property='target.result' action='set' key='index'  >
<annotation>
<![CDATA[ Observations ]]>
</annotation>
</assign></true> 
</if>
</true>
</if>
</true>
</if>
</foreach>
<if condition='source.Result.ResultTime&apos;=""'> 
<true>
<assign value='##class(HS.FHIR.DTL.Util.Element.TypeCast).DateToFHIR(source.Result.ResultTime, "instant")' property='value' action='set' />
<if condition='value&apos;=""'> 
<true>
<assign value='value' property='target.issued' action='set' >
<annotation>
<![CDATA[ DateTime this version was made ]]>
</annotation>
</assign></true> 
</if> 
</true>
</if>
<if condition='##class(HS.FHIR.DTL.Util.Element.Object).Defined(source.Result, "VerifiedBy")'> 
<true>
<assign value='target.performer.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Resource.Practitioner).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.Result.VerifiedBy, "HS.FHIR.DTL.SDA3.vR4.CodeTableDetail.CareProvider.Practitioner")' property='DTL' action='set' />
<if condition='DTL&apos;=""'> 
<true>
<assign value='$classmethod(DTL, "Transform", source.Result.VerifiedBy, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""'> 
<true>
<assign value='aux("transformer").AddResource(source.Result.VerifiedBy, tmp)' property='reference' action='set' />
<if condition='reference&apos;=""'> 
<true>
<assign value='reference' property='target.performer' action='set' key='index'  >
<annotation>
<![CDATA[ Responsible Diagnostic Service ]]>
</annotation>
</assign></true> 
</if>
</true>
</if>
</true>
</if>
</true> 
</if>
<foreach property='source.Specimens()' key='st' >
<assign value='target.specimen.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Resource.Specimen).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.Specimens.(st), "HS.FHIR.DTL.SDA3.vR4.Specimen.Specimen")' property='DTL' action='set' />
<if condition='DTL&apos;=""'> 
<true>
<assign value='$classmethod(DTL, "Transform", source.Specimens.(st), .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""'> 
<true>
<assign value='aux("transformer").AddResource(source.Specimens.(st), tmp)' property='reference' action='set' />
<if condition='reference&apos;=""'> 
<true>
<assign value='reference' property='target.specimen' action='set' key='index'  >
<annotation>
<![CDATA[ Specimens this report is based on ]]>
</annotation>
</assign></true> 
</if>
</true>
</if>
</true>
</if>
</foreach>
<assign value='##class(HS.FHIR.DTL.Util.Lookup).Code("SDA3","vR4","HS.SDA3.RadOrder:Status","diagnostic-report-status|4.0.1",source.Status)' property='value' action='set' />
<if condition='value&apos;=""'> 
<true>
<assign value='value' property='target.status' action='set' >
<annotation>
<![CDATA[ registered | partial | preliminary | final +
 --- This mapping entry seeks a lookup table entry that can match a source value with a target value for this field. If the mapping cannot find the lookup table, or cannot find a matching entry in the lookup table, and it has a non-empty Default Value defined, it places its Default Value into the target field. Otherwise, the target receive no value from this mapping. 
 --- If the mapping is SDA to FHIR, and the source field contains a non-empty value, then by convention there are two mapping entries for this source field. Both entries execute under the same Condition to Set this Field. One entry does the lookup to retrieve the value to assign to the target field. The other stores the original source field value in a FHIR extension.    ]]>
</annotation>
</assign></true> 
<false> 
<assign value='"unknown"' property='target.status' action='set' />
</false> 
</if> 
<if condition='source.Status&apos;=""'> 
<true>
<if condition='(##class(HS.FHIR.DTL.Util.Lookup).Code("SDA3","vR4","HS.SDA3.RadOrder:Status","diagnostic-report-status|4.0.1",source.Status) = "")'> 
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.Status, "HS.FHIR.DTL.SubXFrm.SDA3.vR4.String.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""'> 
<true>
<assign value='$classmethod(DTL, "Transform", source.Status, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""'> 
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/rad-order-status"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index'  >
<annotation>
<![CDATA[ Additional content defined by implementations
 --- This mapping supports a related mapping that does a table lookup to match the incoming source value with a value to place in the target field. This mapping has the same Condition to Set this Field as the table lookup. If the lookup successfully finds a value for target field, this mapping stores the original source field value in a FHIR extension.    ]]>
</annotation>
</assign></true> 
</if>
</true>
</if>

</true>
</if>
</true>
</if>
<if condition='source.ToTime&apos;=""'> 
<true>
<assign value='##class(HS.FHIR.DTL.Util.Element.TypeCast).DateToFHIR(source.ToTime, "dateTime")' property='value' action='set' />
<if condition='value&apos;=""'> 
<true>
<assign value='value' property='target.effectivePeriod.end' action='set' >
<annotation>
<![CDATA[ End time with inclusive boundary, if not ongoing ]]>
</annotation>
</assign></true> 
</if> 
</true>
</if>
<if condition='##class(HS.FHIR.DTL.Util.Element.Object).Defined(source, "VerifiedBy")'> 
<true>
<assign value='target.performer.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Resource.Practitioner).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.VerifiedBy, "HS.FHIR.DTL.SDA3.vR4.CodeTableDetail.CareProvider.Practitioner")' property='DTL' action='set' />
<if condition='DTL&apos;=""'> 
<true>
<assign value='$classmethod(DTL, "Transform", source.VerifiedBy, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""'> 
<true>
<assign value='aux("transformer").AddResource(source.VerifiedBy, tmp)' property='reference' action='set' />
<if condition='reference&apos;=""'> 
<true>
<assign value='reference' property='target.performer' action='set' key='index'  >
<annotation>
<![CDATA[ Responsible Diagnostic Service ]]>
</annotation>
</assign></true> 
</if>
</true>
</if>
</true>
</if>
</true> 
</if>
<if condition='##class(%Dictionary.ClassDefinition).%ExistsId("HS.FHIR.DTL.Mapping.Extension.SDA3.vR4.RadOrder.DiagnosticReport")'> 
<true>
<code><![CDATA[  lock +^HS.FHIR.DTL("lock", "HS.FHIR.DTL.Mapping.Extension.SDA3.vR4.RadOrder.DiagnosticReport") ]]></code>
<assign value='##class(HS.FHIR.DTL.Mapping.Extension.SDA3.vR4.RadOrder.DiagnosticReport).Transform(source.Extension, .target, .aux)' property='target' action='set' />
<code><![CDATA[  lock -^HS.FHIR.DTL("lock", "HS.FHIR.DTL.Mapping.Extension.SDA3.vR4.RadOrder.DiagnosticReport") ]]></code>
</true>
</if>
</transform>
}

}
