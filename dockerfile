ARG IMAGE=intersystemsdc/irishealth-community:2020.4.0.524.0-zpm
FROM $IMAGE

USER root

WORKDIR /opt/irisapp
RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt/irisapp
USER ${ISC_PACKAGE_MGRUSER}

COPY . .
COPY iris.script /tmp/iris.script


# run iris and initial 
RUN iris start IRIS \
	&& iris session IRIS < /tmp/iris.script \
	&& iris stop IRIS quietly

RUN cp misc/swagger.yml /usr/irissys/csp/swagger-ui/swagger.yml 
RUN old=http://localhost:52773/crud/_spec && \
	new=./swagger.yml && \
	sed -i "s|$old|$new|g" /usr/irissys/csp/swagger-ui/index.html
