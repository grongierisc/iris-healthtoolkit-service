# Iris Healthtoolkit Service

[![Video](https://raw.githubusercontent.com/grongierisc/iris-healthtoolkit-service/main/misc/images/Cover.png)](https://youtu.be/lr2B7zSFkds "Video")

Easy to use HL7v2 to FHIR,  CDA to FHIR, FHIR to HL7v2 as a Service.

The aim of this project is to provide an REST API that can convert easily various health formats.
Post the desire format in the REST body, get the answer in the new format.

* Live demo : 

* Video : https://youtu.be/lr2B7zSFkds

## Install

Clone this repository

```
git clone https://github.com/grongierisc/iris-healthtoolkit-service.git
```

Docker

```
docker-compose up --build -d
```

## Usage

* Go to : http://localhost:32783/swagger-ui/index.html

## Api details

* HL7 to FHIR
```
POST http://localhost:32783/api/hl7/fhir
```

* FHIR to HL7 ADT
```
POST http://localhost:32783/api/fhir/hl7/adt
```

* FHIR to HL7 ORU
```
POST http://localhost:32783/api/fhir/hl7/oru
```

* FHIR to HL7 vxu
```
POST http://localhost:32783/api/fhir/hl7/vxu
```

* CDA to FHIR
```
POST http://localhost:32783/api/cda/fhir
```

* FHIR repo
```
GET http://localhost:32783/api/fhir/metadata
```

## Supported HL7 inbound format :

* ADT_A01, ADT_A02, ADT_A03, ADT_A04, ADT_A05, ADT_A06, ADT_A07, ADT_A08, ADT_A09, ADT_A10, ADT_A11, ADT_A12, ADT_A13, ADT_A17, ADT_A18, ADT_A23, ADT_A25, ADT_A27, ADT_A28, ADT_A29, ADT_A30, ADT_A31, ADT_A34, ADT_A36, ADT_A39, ADT_A40, ADT_A41, ADT_A45, ADT_A47, ADT_A49, ADT_A50, ADT_A51, ADT_A60


* BAR_P12


* MDM_T02, MDM_T04, MDM_T08, MDM_T11


* OMP_O09


* ORM_O01


* ORU_R01


* PPR_PC1, PPR_PC2, PPR_PC3


* RDE_O11


* SIU_S12, SIU_S13, SIU_S14, SIU_S15, SIU_S16, SIU_S17, SIU_S26


* VXU_V04
## TODO :

 - [ ] describe how it's working
