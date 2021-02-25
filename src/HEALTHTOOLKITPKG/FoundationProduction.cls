Class HEALTHTOOLKITPKG.FoundationProduction Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="HEALTHTOOLKITPKG.FoundationProduction" TestingEnabled="true" LogGeneralTraceEvents="false">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="Router" Category="" ClassName="EnsLib.HL7.MsgRouter.RoutingEngine" PoolSize="1" Enabled="true" Foreground="false" Comment="Cela permet de gérer la logique de routage." LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="Validation"></Setting>
    <Setting Target="Host" Name="BusinessRuleName">HealthToolKit.Rules.RoutingRule</Setting>
    <Setting Target="Host" Name="BadMessageHandler">BadMessageHandler</Setting>
  </Item>
  <Item Name="Bad_Message_Handler" Category="" ClassName="EnsLib.HL7.Operation.FileOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="Bad messages are sent to this operation." LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="HL7_File_Service" Category="" ClassName="EnsLib.HL7.Service.FileService" PoolSize="1" Enabled="true" Foreground="false" Comment="This is a default HL7 File Service." LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="TargetConfigNames">Router,HL7_SDA</Setting>
  </Item>
  <Item Name="HL7_File_Operation" Category="" ClassName="EnsLib.HL7.Operation.FileOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="This is a default HL7 File Operation." LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="FilePath">/irisdev/app/</Setting>
  </Item>
  <Item Name="Custom_JDBC_Operation" Category="" ClassName="HealthToolKit.BO.JDBC" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="DSN">jdbc:postgresql://db/iam</Setting>
    <Setting Target="Adapter" Name="JDBCClasspath">/tmp/db/postgresql-42.2.11.jar</Setting>
    <Setting Target="Adapter" Name="JDBCDriver">org.postgresql.Driver</Setting>
    <Setting Target="Adapter" Name="Credentials">iam</Setting>
    <Setting Target="Adapter" Name="JGService">JG</Setting>
  </Item>
  <Item Name="Custom_Local_Operation" Category="" ClassName="HealthToolKit.BO.Local" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="Custom_Http_Operation" Category="" ClassName="HealthToolKit.BO.REST" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="HTTPServer">localhost</Setting>
    <Setting Target="Adapter" Name="URL">/api/patient</Setting>
  </Item>
  <Item Name="HL7_Http_Service" Category="" ClassName="EnsLib.HL7.Service.HTTPService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="MessageSchemaCategory">2.3.1</Setting>
    <Setting Target="Host" Name="TargetConfigNames">Router,HL7_SDA</Setting>
    <Setting Target="Adapter" Name="Port">9980</Setting>
  </Item>
  <Item Name="CDA_Http_Service" Category="" ClassName="HealthToolKit.CDARest" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="TargetConfigNames">CDA_SDA</Setting>
  </Item>
  <Item Name="FHIR_Http_Service" Category="" ClassName="HS.FHIRServer.Interop.Service" PoolSize="0" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="TargetConfigName">FHIR_Local_Operation</Setting>
    <Setting Target="Host" Name="TraceOperations">*FULL*</Setting>
  </Item>
  <Item Name="CDA_SDA" Category="" ClassName="HealthToolKit.CCDATransformProcess" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="TargetConfigName">SDA_FHIR</Setting>
  </Item>
  <Item Name="HL7_SDA" Category="" ClassName="HealthToolKit.HL7TransformProcess" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="TargetConfigName">SDA_FHIR</Setting>
  </Item>
  <Item Name="SDA_FHIR" Category="" ClassName="HS.FHIR.DTL.Util.HC.SDA3.FHIR.Process" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="TargetConfigName">FHIR_Local_Operation</Setting>
    <Setting Target="Host" Name="FHIREndpoint">/api/fhir</Setting>
    <Setting Target="Host" Name="FHIRMetadataSet">HL7v40 / Base HL7 Metadata for FHIR R4 (4.0.1)</Setting>
    <Setting Target="Host" Name="TransmissionMode">transaction</Setting>
  </Item>
  <Item Name="FHIR_Local_Operation" Category="" ClassName="HS.FHIRServer.Interop.Operation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="FHIR_SDA" Category="" ClassName="HS.FHIR.DTL.Util.HC.FHIR.SDA3.Process" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="TargetConfigName">SDA_HL7</Setting>
    <Setting Target="Host" Name="FHIRMetadataSet">HL7v40 / Base HL7 Metadata for FHIR R4 (4.0.1)</Setting>
  </Item>
  <Item Name="JG" Category="" ClassName="EnsLib.JavaGateway.Service" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="HS.Util.Trace.Operations" Category="" ClassName="HS.Util.Trace.Operations" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="SDA_HL7" Category="" ClassName="HealthToolKit.BP.SDAtoHL7TransformProcess" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="TargetConfigName">HL7_File_Operation</Setting>
  </Item>
</Production>
}

}
