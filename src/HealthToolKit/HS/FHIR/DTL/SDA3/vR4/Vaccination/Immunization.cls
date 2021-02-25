/// Transforms SDA3 HS.SDA3.Vaccination to vR4 Immunization
Class HS.FHIR.DTL.SDA3.vR4.Vaccination.Immunization Extends Ens.DataTransformDTL [ DependsOn = (HS.SDA3.Vaccination, HS.FHIR.DTL.vR4.Model.Resource.Immunization), ProcedureBlock ]
{

Parameter IGNOREMISSINGSOURCE = 0;

Parameter REPORTERRORS = 0;

Parameter TREATEMPTYREPEATINGFIELDASNULL = 0;

XData DTL [ XMLNamespace = "http://www.intersystems.com/dtl" ]
{
<transform sourceClass='HS.SDA3.Vaccination' targetClass='HS.FHIR.DTL.vR4.Model.Resource.Immunization' create='existing' language='objectscript' >
<annotation> Transforms HS.SDA3.Vaccination (SDA3) to Immunization (vR4) </annotation>
<assign value='"0"' property='target.primarySource' action='set' >
<annotation> Indicates context the data was recorded in </annotation>
</assign>
<assign value='##class(HS.FHIR.DTL.Util.SDA3.Handler.CustomPairs).Extension(source.CustomPairs, .target, .aux)' property='value' action='set' />
<assign value='target.extension.Count()+1' property='index' action='set' />
<if condition='value&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-custom-pairs"' property='value.url' action='set' />
<assign value='value' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations
 --- When the SDA3 source data contains a CustomPairs collection, and the target is FHIR, the collection is mapped to a FHIR extension that contains a Parameters resource. This Parameters resource is a collection of paired fields: name and valueString.   </annotation>
</assign>
</true>
</if>
<assign value='aux("transformer").GetPatientReference()' property='value' action='set' />
<if condition='value&apos;=""' >
<true>
<assign value='value' property='target.patient' action='set' >
<annotation> Who was immunized </annotation>
</assign>
</true>
</if>
<if condition='source.Administrations.Count()&gt;0' >
<true>
<assign value='target' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.Administrations.(1), "HS.FHIR.DTL.SDA3.vR4.Administration.Immunization")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.Administrations.(1), .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='tmp' property='target' action='set' >
<annotation> Immunization event information
 --- SDA3 HS.SDA3.Vaccination:Administrations is a *List*, and FHIR4 Immunization is *Single*. 
 --- For a list object mapped to a single FHIR object, the mapping table must contain 2 mapping entries for the source list: One maps only the first item from the list to the target object; the other maps the list to a FHIR extension that contains the full list.   </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='source.AuthorizationTime&apos;=""' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.AuthorizationTime, "HS.FHIR.DTL.SubXFrm.SDA3.vR4.TimeStamp.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.AuthorizationTime, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-authorization-time"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='source.CallbackNumber&apos;=""' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.CallbackNumber, "HS.FHIR.DTL.SubXFrm.SDA3.vR4.String.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.CallbackNumber, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-callback-number"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='source.Comments&apos;=""' >
<true>
<assign value='target.note.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Datatype.Annotation).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.Comments, "HS.FHIR.DTL.SubXFrm.SDA3.vR4.String.Annotation")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.Comments, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='tmp' property='target.note' action='set' key='index' >
<annotation> Additional immunization notes </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<foreach property='source.ComponentMeds()' key='st' >
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.ComponentMeds.(st), "HS.FHIR.DTL.SDA3.vR4.CodeTableDetail.DrugProduct.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.ComponentMeds.(st), .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-component-meds"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</foreach>
<if condition='source.Condition&apos;=""' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.Condition, "HS.FHIR.DTL.SubXFrm.SDA3.vR4.String.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.Condition, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-condition"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='##class(HS.FHIR.DTL.Util.Element.Object).Defined(source, "ConfidentialityCode")' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.ConfidentialityCode, "HS.FHIR.DTL.SDA3.vR4.CodeTableTranslated.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.ConfidentialityCode, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-confidentiality-code"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='##class(HS.FHIR.DTL.Util.Element.Object).Defined(source, "ConsultationDepartment")' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.ConsultationDepartment, "HS.FHIR.DTL.SDA3.vR4.CodeTableDetail.HealthCareFacility.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.ConsultationDepartment, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-consultation-department"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='##class(HS.FHIR.DTL.Util.Element.Object).Defined(source, "DosageForm")' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.DosageForm, "HS.FHIR.DTL.SDA3.vR4.CodeTableTranslated.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.DosageForm, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-dosage-form"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='source.DosageSteps&apos;=""' >
<true>
<assign value='1' property='j1' action='set' />
<foreach property='source.DosageSteps()' key='k1' >
<if condition='source.DosageSteps.(k1).DoseQuantity&apos;=""' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.DosageSteps.(k1).DoseQuantity, "HS.FHIR.DTL.SubXFrm.SDA3.vR4.Numeric.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.DosageSteps.(k1).DoseQuantity, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-dosage-steps-dose-quantity"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='##class(HS.FHIR.DTL.Util.Element.Object).Defined(source.DosageSteps.(k1), "DoseUoM")' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.DosageSteps.(k1).DoseUoM, "HS.FHIR.DTL.SDA3.vR4.CodeTableTranslated.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.DosageSteps.(k1).DoseUoM, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-dosage-steps-dose-uo-m"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='##class(HS.FHIR.DTL.Util.Element.Object).Defined(source.DosageSteps.(k1), "Duration")' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.DosageSteps.(k1).Duration, "HS.FHIR.DTL.SDA3.vR4.CodeTableDetail.Duration.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.DosageSteps.(k1).Duration, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-dosage-steps-duration"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='source.DosageSteps.(k1).EncounterNumber&apos;=""' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.DosageSteps.(k1).EncounterNumber, "HS.FHIR.DTL.SubXFrm.SDA3.vR4.String.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.DosageSteps.(k1).EncounterNumber, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-dosage-steps-encounter-number"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='##class(HS.FHIR.DTL.Util.Element.Object).Defined(source.DosageSteps.(k1), "EnteredAt")' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.DosageSteps.(k1).EnteredAt, "HS.FHIR.DTL.SDA3.vR4.CodeTableDetail.Organization.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.DosageSteps.(k1).EnteredAt, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-dosage-steps-entered-at"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='##class(HS.FHIR.DTL.Util.Element.Object).Defined(source.DosageSteps.(k1), "EnteredBy")' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.DosageSteps.(k1).EnteredBy, "HS.FHIR.DTL.SDA3.vR4.CodeTableDetail.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.DosageSteps.(k1).EnteredBy, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-dosage-steps-entered-by"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='source.DosageSteps.(k1).EnteredOn&apos;=""' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.DosageSteps.(k1).EnteredOn, "HS.FHIR.DTL.SubXFrm.SDA3.vR4.TimeStamp.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.DosageSteps.(k1).EnteredOn, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-dosage-steps-entered-on"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='source.DosageSteps.(k1).ExternalId&apos;=""' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.DosageSteps.(k1).ExternalId, "HS.FHIR.DTL.SubXFrm.SDA3.vR4.String.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.DosageSteps.(k1).ExternalId, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-dosage-steps-external-id"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='##class(HS.FHIR.DTL.Util.Element.Object).Defined(source.DosageSteps.(k1), "Frequency")' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.DosageSteps.(k1).Frequency, "HS.FHIR.DTL.SDA3.vR4.CodeTableDetail.Frequency.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.DosageSteps.(k1).Frequency, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-dosage-steps-frequency"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='source.DosageSteps.(k1).FromTime&apos;=""' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.DosageSteps.(k1).FromTime, "HS.FHIR.DTL.SubXFrm.SDA3.vR4.TimeStamp.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.DosageSteps.(k1).FromTime, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-dosage-steps-from-time"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='source.DosageSteps.(k1).TextInstruction&apos;=""' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.DosageSteps.(k1).TextInstruction, "HS.FHIR.DTL.SubXFrm.SDA3.vR4.String.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.DosageSteps.(k1).TextInstruction, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-dosage-steps-text-instruction"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='source.DosageSteps.(k1).ToTime&apos;=""' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.DosageSteps.(k1).ToTime, "HS.FHIR.DTL.SubXFrm.SDA3.vR4.TimeStamp.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.DosageSteps.(k1).ToTime, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-dosage-steps-to-time"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
</foreach>
</true>
</if>
<if condition='source.DoseQuantity&apos;=""' >
<true>
<if condition='source.DoseQuantity&apos;=""' >
<true>
<assign value='source.DoseQuantity' property='target.doseQuantity.value' action='set' >
<annotation> Numerical value (with implicit precision) </annotation>
</assign>
</true>
</if>
</true>
</if>
<if condition='##class(HS.FHIR.DTL.Util.Element.Object).Defined(source, "DoseUoM")' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.DoseUoM, "HS.FHIR.DTL.SDA3.vR4.CodeTableTranslated.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.DoseUoM, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-dose-uo-m"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='source.DoseUoM.Code&apos;=""' >
<true>
<if condition='source.DoseUoM.Code&apos;=""' >
<true>
<assign value='source.DoseUoM.Code' property='target.doseQuantity.code' action='set' >
<annotation> Coded form of the unit </annotation>
</assign>
</true>
</if>
</true>
</if>
<if condition='##class(HS.FHIR.DTL.Util.Lookup).GetURIForCode(source.DoseUoM.SDACodingStandard) = ""' >
<true>
<assign value='##class(HS.FHIR.DTL.Util.Lookup).GetURIForValueSet("vR4", "http://unitsofmeasure.org", source.DoseUoM.Code)' property='value' action='set' />
<if condition='value&apos;=""' >
<true>
<assign value='value' property='target.doseQuantity.system' action='set' >
<annotation> System that defines coded unit form </annotation>
</assign>
</true>
<false>
<assign value='"http://www.intersystems.com/fhir/system"' property='target.doseQuantity.system' action='set' />
</false>
</if>
</true>
</if>
<if condition='source.DoseUoM.Description&apos;=""' >
<true>
<if condition='source.DoseUoM.Description&apos;=""' >
<true>
<assign value='source.DoseUoM.Description' property='target.doseQuantity.unit' action='set' >
<annotation> Unit representation </annotation>
</assign>
</true>
</if>
</true>
</if>
<if condition='source.DoseUoM.SDACodingStandard&apos;=""' >
<true>
<assign value='##class(HS.FHIR.DTL.Util.Lookup).GetURIForCode(source.DoseUoM.SDACodingStandard)' property='value' action='set' />
<if condition='value&apos;=""' >
<true>
<assign value='value' property='target.doseQuantity.system' action='set' >
<annotation> System that defines coded unit form </annotation>
</assign>
</true>
</if>
</true>
</if>
<if condition='source.DoseUoM.SDACodingStandard&apos;=""' >
<true>
<if condition='##class(HS.FHIR.DTL.Util.Lookup).GetURIForCode(source.DoseUoM.SDACodingStandard) = ""' >
<true>
<assign value='1' property='index' action='set' />
<if condition='target.doseQuantity&apos;=""' >
<true>
<assign value='target.doseQuantity.extension.Count()+1' property='index' action='set' />
</true>
</if>
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.DoseUoM.SDACodingStandard, "HS.FHIR.DTL.SubXFrm.SDA3.vR4.StrippedString.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.DoseUoM.SDACodingStandard, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-dose-uo-m-s-d-a-coding-standard"' property='tmp.url' action='set' />
<assign value='tmp' property='target.doseQuantity.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='##class(HS.FHIR.DTL.Util.Element.Object).Defined(source, "DrugProduct")' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.DrugProduct, "HS.FHIR.DTL.SDA3.vR4.CodeTableDetail.DrugProduct.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.DrugProduct, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-drug-product"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='##class(HS.FHIR.DTL.Util.Element.Object).Defined(source, "Duration")' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.Duration, "HS.FHIR.DTL.SDA3.vR4.CodeTableDetail.Duration.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.Duration, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-duration"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='source.EncounterNumber&apos;=""' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.EncounterNumber, "HS.FHIR.DTL.SubXFrm.SDA3.vR4.String.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.EncounterNumber, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-encounter-number"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<assign value='aux("transformer").GetReference("Encounter",source.EncounterNumber)' property='value' action='set' />
<if condition='value&apos;=""' >
<true>
<assign value='value' property='target.encounter' action='set' >
<annotation> Encounter immunization was part of </annotation>
</assign>
</true>
</if>
<if condition='##class(HS.FHIR.DTL.Util.Element.Object).Defined(source, "EnteredAt")' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.EnteredAt, "HS.FHIR.DTL.SDA3.vR4.CodeTableDetail.Organization.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.EnteredAt, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-entered-at"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='##class(HS.FHIR.DTL.Util.Element.Object).Defined(source, "EnteredBy")' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.EnteredBy, "HS.FHIR.DTL.SDA3.vR4.CodeTableDetail.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.EnteredBy, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-entered-by"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<assign value='##class(HS.FHIR.DTL.Util.Element.TypeCast).DateToFHIR(source.EnteredOn, "dateTime")' property='value' action='set' />
<if condition='value&apos;=""' >
<true>
<assign value='value' property='target.occurrenceDateTime' action='set' >
<annotation> Vaccine administration date
 --- The source is optional, but the target is *Required*. When there is no source data to assign to this field, there is no default value, so the FHIR resource fails validation and is not saved. For this field, this is the desired behavior.   </annotation>
</assign>
</true>
</if>
<if condition='##class(HS.FHIR.DTL.Util.Element.Object).Defined(source, "EnteringOrganization")' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.EnteringOrganization, "HS.FHIR.DTL.SDA3.vR4.CodeTableDetail.HealthCareFacility.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.EnteringOrganization, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-entering-organization"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<assign value='##class(HS.FHIR.DTL.Util.SDA3.Handler.ExternalId).Identifier(source.ExternalId)' property='value' action='set' />
<assign value='target.identifier.Count()+1' property='index' action='set' />
<if condition='value&apos;=""' >
<true>
<assign value='value' property='target.identifier' action='set' key='index' >
<annotation> Business identifier </annotation>
</assign>
</true>
</if>
<if condition='source.FillerAssigningAuthority&apos;=""' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.FillerAssigningAuthority, "HS.FHIR.DTL.SubXFrm.SDA3.vR4.String.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.FillerAssigningAuthority, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-filler-assigning-authority"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<assign value='##class(HS.FHIR.DTL.Util.SDA3.Handler.Order).FillerId(source.FillerId, .aux)' property='value' action='set' />
<assign value='target.identifier.Count()+1' property='index' action='set' />
<if condition='value&apos;=""' >
<true>
<assign value='value' property='target.identifier' action='set' key='index' >
<annotation> Business identifier </annotation>
</assign>
</true>
</if>
<if condition='##class(HS.FHIR.DTL.Util.Element.Object).Defined(source, "Frequency")' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.Frequency, "HS.FHIR.DTL.SDA3.vR4.CodeTableDetail.Frequency.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.Frequency, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-frequency"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='source.FromTime&apos;=""' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.FromTime, "HS.FHIR.DTL.SubXFrm.SDA3.vR4.TimeStamp.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.FromTime, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-from-time"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='source.GroupAssigningAuthority&apos;=""' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.GroupAssigningAuthority, "HS.FHIR.DTL.SubXFrm.SDA3.vR4.String.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.GroupAssigningAuthority, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-group-assigning-authority"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='source.GroupId&apos;=""' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.GroupId, "HS.FHIR.DTL.SubXFrm.SDA3.vR4.String.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.GroupId, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-group-id"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='source.Indication&apos;=""' >
<true>
<if condition='(source.Administrations.Count() &gt; 0) &amp;&amp; (&apos;##class(HS.FHIR.DTL.Util.SDA3.Handler.Vaccination).RefusalReasonExists(source.Administrations))' >
<true>
<if condition='source.Indication&apos;=""' >
<true>
<assign value='source.Indication' property='target.reasonCode.(1).text' action='set' >
<annotation> Plain text representation of the concept </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='source.Indication&apos;=""' >
<true>
<if condition='(source.Administrations.Count() = 0) || (##class(HS.FHIR.DTL.Util.SDA3.Handler.Vaccination).RefusalReasonExists(source.Administrations))' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.Indication, "HS.FHIR.DTL.SubXFrm.SDA3.vR4.String.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.Indication, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-indication"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='source.MaxDoseQuantity&apos;=""' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.MaxDoseQuantity, "HS.FHIR.DTL.SubXFrm.SDA3.vR4.Numeric.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.MaxDoseQuantity, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-max-dose-quantity"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='source.NumberOfRefills&apos;=""' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.NumberOfRefills, "HS.FHIR.DTL.SubXFrm.SDA3.vR4.String.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.NumberOfRefills, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-number-of-refills"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='##class(HS.FHIR.DTL.Util.Element.Object).Defined(source, "OrderCategory")' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.OrderCategory, "HS.FHIR.DTL.SDA3.vR4.CodeTableTranslated.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.OrderCategory, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-order-category"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='##class(HS.FHIR.DTL.Util.Element.Object).Defined(source, "OrderedBy")' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.OrderedBy, "HS.FHIR.DTL.SDA3.vR4.CodeTableDetail.CareProvider.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.OrderedBy, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-ordered-by"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='source.OrderGroup&apos;=""' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.OrderGroup, "HS.FHIR.DTL.SubXFrm.SDA3.vR4.String.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.OrderGroup, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-order-group"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='##class(HS.FHIR.DTL.Util.Element.Object).Defined(source, "OrderItem")' >
<true>
<assign value='##class(HS.FHIR.DTL.vR4.Model.Datatype.CodeableConcept).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.OrderItem, "HS.FHIR.DTL.SDA3.vR4.CodeTableTranslated.CodeableConcept")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.OrderItem, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='tmp' property='target.vaccineCode' action='set' >
<annotation> Vaccine product administered
 --- Although not required according to the HS.SDA3.Vaccination class definition, in practice, the OrderItem property always contains a value.
 --- In this case, any FHIR4 code may be used; vaccine-code shows Example codes, but you may use codes from any ValueSet. 
 --- SDA does not restrict code values to a particular set.    </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='source.OrderQuantity&apos;=""' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.OrderQuantity, "HS.FHIR.DTL.SubXFrm.SDA3.vR4.String.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.OrderQuantity, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-order-quantity"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='source.PharmacyStatus&apos;=""' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.PharmacyStatus, "HS.FHIR.DTL.SubXFrm.SDA3.vR4.String.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.PharmacyStatus, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-pharmacy-status"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='source.PlacerAssigningAuthority&apos;=""' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.PlacerAssigningAuthority, "HS.FHIR.DTL.SubXFrm.SDA3.vR4.String.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.PlacerAssigningAuthority, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-placer-assigning-authority"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<assign value='##class(HS.FHIR.DTL.Util.SDA3.Handler.Order).PlacerId(source.PlacerId, .aux)' property='value' action='set' />
<assign value='target.identifier.Count()+1' property='index' action='set' />
<if condition='value&apos;=""' >
<true>
<assign value='value' property='target.identifier' action='set' key='index' >
<annotation> Business identifier </annotation>
</assign>
</true>
</if>
<if condition='source.PrescriptionNumber&apos;=""' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.PrescriptionNumber, "HS.FHIR.DTL.SubXFrm.SDA3.vR4.String.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.PrescriptionNumber, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-prescription-number"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='##class(HS.FHIR.DTL.Util.Element.Object).Defined(source, "Priority")' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.Priority, "HS.FHIR.DTL.SDA3.vR4.CodeTableTranslated.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.Priority, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-priority"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='source.RateAmount&apos;=""' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.RateAmount, "HS.FHIR.DTL.SubXFrm.SDA3.vR4.Numeric.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.RateAmount, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-rate-amount"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='source.RateTimeUnit&apos;=""' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.RateTimeUnit, "HS.FHIR.DTL.SubXFrm.SDA3.vR4.String.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.RateTimeUnit, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-rate-time-unit"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='##class(HS.FHIR.DTL.Util.Element.Object).Defined(source, "RateUnits")' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.RateUnits, "HS.FHIR.DTL.SDA3.vR4.CodeTableTranslated.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.RateUnits, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-rate-units"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='source.ReassessmentTime&apos;=""' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.ReassessmentTime, "HS.FHIR.DTL.SubXFrm.SDA3.vR4.TimeStamp.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.ReassessmentTime, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-reassessment-time"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='##class(HS.FHIR.DTL.Util.Element.Object).Defined(source, "ReceivingLocation")' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.ReceivingLocation, "HS.FHIR.DTL.SDA3.vR4.CodeTableDetail.HealthCareFacility.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.ReceivingLocation, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-receiving-location"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='source.RefillNumber&apos;=""' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.RefillNumber, "HS.FHIR.DTL.SubXFrm.SDA3.vR4.Numeric.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.RefillNumber, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-refill-number"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='##class(HS.FHIR.DTL.Util.Element.Object).Defined(source, "Route")' >
<true>
<assign value='##class(HS.FHIR.DTL.vR4.Model.Datatype.CodeableConcept).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.Route, "HS.FHIR.DTL.SDA3.vR4.CodeTableTranslated.CodeableConcept")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.Route, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='tmp' property='target.route' action='set' >
<annotation> How vaccine entered body
 --- In this case, any FHIR4 code may be used; immunization-route shows Example codes, but you may use codes from any ValueSet. 
 --- SDA does not restrict code values to a particular set.    </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<assign value='##class(HS.FHIR.DTL.Util.Lookup).Code("SDA3","vR4","HS.SDA3.Vaccination:Status","immunization-status|4.0.1",source.Status)' property='value' action='set' />
<if condition='value&apos;=""' >
<true>
<assign value='value' property='target.status' action='set' >
<annotation> completed | entered-in-error | not-done
 --- This mapping entry seeks a lookup table entry that can match a source value with a target value for this field. If the mapping cannot find the lookup table, or cannot find a matching entry in the lookup table, and it has a non-empty Default Value defined, it places its Default Value into the target field. Otherwise, the target receive no value from this mapping. 
 --- If the mapping is SDA to FHIR, and the source field contains a non-empty value, then by convention there are two mapping entries for this source field. Both entries execute under the same Condition to Set this Field. One entry does the lookup to retrieve the value to assign to the target field. The other stores the original source field value in a FHIR extension. 
 --- SDA3 HS.SDA3.Vaccination:Status is optional, and FHIR4 Immunization:status is required. No source value is mapped unconditionally to the target and *No Default Value* is supplied in case of no data received. This can be a serious gap. 
 --- This case might be fine, if there exists another mapping to the same target with a non-empty Condition to Set This Field. For example, two mappings could be defined to the same target, each with a Condition to Set This Field, in order to specify mutually exclusive cases.    </annotation>
</assign>
</true>
</if>
<if condition='source.Status&apos;=""' >
<true>
<if condition='(##class(HS.FHIR.DTL.Util.Lookup).Code("SDA3","vR4","HS.SDA3.Vaccination:Status","immunization-status|4.0.1",source.Status) = "")' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.Status, "HS.FHIR.DTL.SubXFrm.SDA3.vR4.String.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.Status, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-status"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations
 --- This mapping supports a related mapping that does a table lookup to match the incoming source value with a value to place in the target field. This mapping has the same Condition to Set this Field as the table lookup. If the lookup successfully finds a value for target field, this mapping stores the original source field value in a FHIR extension.    </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='source.StrengthVolume&apos;=""' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.StrengthVolume, "HS.FHIR.DTL.SubXFrm.SDA3.vR4.Numeric.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.StrengthVolume, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-strength-volume"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='source.StrengthVolumeUnits&apos;=""' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.StrengthVolumeUnits, "HS.FHIR.DTL.SubXFrm.SDA3.vR4.String.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.StrengthVolumeUnits, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-strength-volume-units"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='source.TextInstruction&apos;=""' >
<true>
<assign value='target.note.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Datatype.Annotation).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.TextInstruction, "HS.FHIR.DTL.SubXFrm.SDA3.vR4.String.Annotation")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.TextInstruction, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='tmp' property='target.note' action='set' key='index' >
<annotation> Additional immunization notes </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='source.ToTime&apos;=""' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.ToTime, "HS.FHIR.DTL.SubXFrm.SDA3.vR4.TimeStamp.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.ToTime, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-to-time"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='##class(HS.FHIR.DTL.Util.Element.Object).Defined(source, "VerifiedBy")' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.VerifiedBy, "HS.FHIR.DTL.SDA3.vR4.CodeTableDetail.CareProvider.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.VerifiedBy, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-verified-by"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='source.VerifiedComments&apos;=""' >
<true>
<assign value='target.extension.Count()+1' property='index' action='set' />
<assign value='##class(HS.FHIR.DTL.vR4.Model.Base.Extension).%New()' property='tmp' action='set' />
<assign value='aux("transformer").GetDTL(source.VerifiedComments, "HS.FHIR.DTL.SubXFrm.SDA3.vR4.String.Extension")' property='DTL' action='set' />
<if condition='DTL&apos;=""' >
<true>
<assign value='$classmethod(DTL, "Transform", source.VerifiedComments, .tmp, .aux)' property='status' action='set' />
<if condition='tmp&apos;=""' >
<true>
<assign value='"http://intersystems.com/fhir/extn/sda3/lib/vaccination-verified-comments"' property='tmp.url' action='set' />
<assign value='tmp' property='target.extension' action='set' key='index' >
<annotation> Additional content defined by implementations </annotation>
</assign>
</true>
</if>
</true>
</if>
</true>
</if>
<if condition='##class(%Dictionary.ClassDefinition).%ExistsId("HS.FHIR.DTL.Mapping.Extension.SDA3.vR4.Vaccination.Immunization")' >
<true>
<code>
<![CDATA[  lock +^HS.FHIR.DTL("lock", "HS.FHIR.DTL.Mapping.Extension.SDA3.vR4.Vaccination.Immunization") ]]></code>
<assign value='##class(HS.FHIR.DTL.Mapping.Extension.SDA3.vR4.Vaccination.Immunization).Transform(source.Extension, .target, .aux)' property='target' action='set' />
<code>
<![CDATA[  lock -^HS.FHIR.DTL("lock", "HS.FHIR.DTL.Mapping.Extension.SDA3.vR4.Vaccination.Immunization") ]]></code>
</true>
</if>
<assign value='"Default"' property='target.occurrenceString' action='set' />
</transform>
}

}
