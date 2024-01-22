ARG IMAGE=intersystemsdc/irishealth-community:preview
FROM $IMAGE as builder

ARG IRIS_PASSWORD

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

RUN old=http://localhost:52773/crud/_spec && \
	new=./swagger.yml && \
	sed -i "s|$old|$new|g" /usr/irissys/csp/swagger-ui/index.html

FROM $IMAGE as final

ADD --chown=${ISC_PACKAGE_MGRUSER}:${ISC_PACKAGE_IRISGROUP} https://github.com/grongierisc/iris-docker-multi-stage-script/releases/latest/download/copy-data.py /irisdev/app/copy-data.py

RUN --mount=type=bind,source=/,target=/builder/root,from=builder \
	cp -f /builder/root/usr/irissys/iris.cpf /usr/irissys/iris.cpf && \
	python3 /irisdev/app/copy-data.py -c /usr/irissys/iris.cpf -d /builder/root/ 