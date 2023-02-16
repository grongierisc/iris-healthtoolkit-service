Class HEALTHTOOLKITPKG.FoundationProduction Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="HEALTHTOOLKITPKG.FoundationProduction" TestingEnabled="true" LogGeneralTraceEvents="false">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="HL7_Http_Service" Category="" ClassName="HealthToolKit.HL7Rest" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="TargetConfigNames">HL7_SDA</Setting>
  </Item>
  <Item Name="CDA_Http_Service" Category="" ClassName="HealthToolKit.CDARest" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="TargetConfigNames">CDA_SDA</Setting>
  </Item>
  <Item Name="FHIR_Http_Service" Category="" ClassName="HS.FHIRServer.Interop.Service" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="TargetConfigName">FHIR_Router</Setting>
    <Setting Target="Host" Name="TraceOperations">*FULL*</Setting>
  </Item>
  <Item Name="CDA_SDA" Category="" ClassName="HealthToolKit.CCDATransformProcess" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="TargetConfigName">SDA_FHIR</Setting>
  </Item>
  <Item Name="HL7_SDA" Category="" ClassName="HealthToolKit.HL7TransformProcess" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="TargetConfigName">SDA_FHIR</Setting>
  </Item>
  <Item Name="SDA_FHIR" Category="" ClassName="HealthToolKit.FHIR.DTL.Util.HC.SDA3.FHIR.Process" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="TargetConfigName">FHIR_Local_Operation</Setting>
    <Setting Target="Host" Name="FHIREndpoint">/api/fhir</Setting>
    <Setting Target="Host" Name="FHIRMetadataSet">HL7v40 / Base HL7 Metadata for FHIR R4 (4.0.1)</Setting>
    <Setting Target="Host" Name="TransmissionMode">transaction</Setting>
    <Setting Target="Host" Name="TraceOperations">*FULL*</Setting>
    <Setting Target="Host" Name="TransformClass">HealthToolKit.FHIR.DTL.Util.API.Transform.SDA3ToFHIR</Setting>
  </Item>
  <Item Name="FHIR_Local_Operation" Category="" ClassName="HS.FHIRServer.Interop.Operation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="FHIR_SDA" Category="" ClassName="HealthToolKit.FHIR.DTL.Util.HC.FHIR.SDA3.Process" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="TargetConfigName">SDA_HL7</Setting>
    <Setting Target="Host" Name="FHIRMetadataSet">HL7v40 / Base HL7 Metadata for FHIR R4 (4.0.1)</Setting>
  </Item>
  <Item Name="HS.Util.Trace.Operations" Category="" ClassName="HS.Util.Trace.Operations" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="SDA_HL7" Category="" ClassName="HealthToolKit.BP.SDAtoHL7TransformProcess" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="TargetConfigName"></Setting>
    <Setting Target="Host" Name="TraceOperations">*FULL*</Setting>
  </Item>
  <Item Name="FHIR_Router" Category="" ClassName="HealthToolKit.BP.FHIRRouter" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
</Production>
}

}
