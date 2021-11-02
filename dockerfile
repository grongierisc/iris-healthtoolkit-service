ARG IMAGE=intersystemsdc/irishealth-community:2021.1.0.215.3-zpm
FROM $IMAGE

ARG IRIS_PASSWORD

USER root

WORKDIR /opt/irisapp
RUN chown ${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} /opt/irisapp
USER ${ISC_PACKAGE_MGRUSER}

RUN echo "${IRIS_PASSWORD}" > /tmp/password.txt && /usr/irissys/dev/Container/changePassword.sh /tmp/password.txt

COPY . .
COPY iris.script /tmp/iris.script


# run iris and initial 
RUN iris start IRIS \
	&& iris session IRIS < /tmp/iris.script \
	&& iris stop IRIS quietly

COPY misc/swagger.yml /usr/irissys/csp/swagger-ui/swagger.yml 
RUN old=http://localhost:52773/crud/_spec && \
	new=./swagger.yml && \
	sed -i "s|$old|$new|g" /usr/irissys/csp/swagger-ui/index.html
