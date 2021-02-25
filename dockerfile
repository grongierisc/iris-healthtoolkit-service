ARG IMAGE=intersystemsdc/irishealth-community:2020.4.0.524.0-zpm
FROM $IMAGE

USER root

RUN apt-get update && apt-get install -y openjdk-8-jdk 

WORKDIR /opt/irisapp
RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt/irisapp
USER ${ISC_PACKAGE_MGRUSER}

COPY . .
COPY iris.script /tmp/iris.script


# run iris and initial 
RUN iris start IRIS \
	&& iris session IRIS < /tmp/iris.script \
	&& iris stop IRIS quietly  
