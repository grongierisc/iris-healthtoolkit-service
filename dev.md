# useful commands
## clean up docker 
```
docker system prune -f
```

## build container with no cache
```
docker-compose build --no-cache --progress=plain
```

## start container
```
docker-compose up -d
```

## open terminal to docker
```
docker-compose exec iris iris session iris -U FHIRServer
```

## FHIR Namespace setup

do ##class(HS.HC.Util.Installer).InstallFoundation("FHIRServer")

## fhir server configuration setup
```
do ##class(HS.FHIRServer.ConsoleSetup).Setup()
```

## load fhir resources
```
zw ##class(HS.FHIRServer.Tools.DataLoader).SubmitResourceFiles("/opt/irisapp/fhir/", "FHIRServer", "/fhir/r4")

kill ^%ISCLOG

kill ^ISCLOG

set ^%ISCLOG=3
```

## example zpm method invoke


<Invoke Class="%EnsembleMgr" Method="EnableNamespace" Phase="Compile" When="Before" CheckStatus="true">
         <Arg>${namespace}</Arg>
         <Arg>${verbose}</Arg>
      </Invoke>


