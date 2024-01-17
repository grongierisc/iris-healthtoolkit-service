# Iris Healthtoolkit Service

[![Video](https://raw.githubusercontent.com/grongierisc/iris-healthtoolkit-service/main/misc/images/Cover.png)](https://youtu.be/lr2B7zSFkds "Video")

Easy to use HL7v2 to FHIR,  CDA to FHIR, FHIR to HL7v2 as a Service.

The aim of this project is to provide an REST API that can convert easily various health formats.
Post the desire format in the REST body, get the answer in the new format.

* :fire: Official Version : https://www.intersystems.com/IC-FTS/ :fire:

* :tv: Video : https://youtu.be/lr2B7zSFkds :tv:

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

### HL7 to FHIR
```
POST http://localhost:32783/api/hl7/fhir
```

#### Example

<details>
  <summary>Input</summary>
  
  ```text
MSH|^~\&||^^NPI|||20211105165829+0000||ADT^A01|66053,61109.396628|P|2.5.1|||AL|AL|||||PH_SS-Ack^SS Sender^2.16.840.1.114222.4.10.3^ISO
EVN||202111051658|||||^^NPI
PID|1||060a6bd5-5146-4b08-a916-009858997bd3^^^https://github.com/synthetichealth/synthea^~060a6bd5-5146-4b08-a916-009858997bd3^^^http://hospital.smarthealthit.org^MR~999-97-4582^^^&^SS~S99986284^^^&^DL~X84330364X^^^&^PPN||Masson^Livia^^^Mrs.^^||19920820|F|Simon^Livia^^||615 Avenue Lemaire^^Lyon^Auvergne-Rhone-Alpes^63000||^PRN^PH^^^555^286|||||||||||||||||||||
PV1|1|O||424441002|||||||||||||||1^^^&&^VN|||||||||||||||||||||||||200812312325|20090101044004
PV2|||72892002^Grossesse normale^SCT
OBX|1||8302-2^Taille du corps^LN||20101014002504^^|cm^^UCUM|||||F|||20101014
OBX|2||72514-3^Gravite de la douleur - 0-10 evaluation numerique verbale [Score] - Signaleee^LN||20101014002504^^|{score}^^UCUM|||||F|||20101014
OBX|3||29463-7^Poids corporel^LN||20101014002504^^|kg^^UCUM|||||F|||20101014
OBX|4||39156-5^Indice de masse corporelle^LN||20101014002504^^|kg/m2^^UCUM|||||F|||20101014
OBX|5||72166-2^Statut du tabagisme^LN||20171026002504^Ancien fumeur^SCT^^^^^^Ancien fumeur||||||F|||20171026
  ```
  
</details>

<details>
  <summary>Output</summary>
  
  ```json
{
  "resourceType": "Bundle",
  "type": "transaction",
  "entry": [
    {
      "request": {
        "method": "POST",
        "url": "Organization"
      },
      "fullUrl": "urn:uuid:347a0c88-e7fa-11ec-9601-0242ac1a0002",
      "resource": {
        "resourceType": "Organization",
        "identifier": [
          {
            "value": "https://github.com/synthetichealth/synthea"
          }
        ]
      }
    },
    {
      "request": {
        "method": "POST",
        "url": "Organization"
      },
      "fullUrl": "urn:uuid:34d03d1a-e7fa-11ec-9601-0242ac1a0002",
      "resource": {
        "resourceType": "Organization",
        "identifier": [
          {
            "value": "http://hospital.smarthealthit.org"
          }
        ]
      }
    },
    {
      "request": {
        "method": "POST",
        "url": "Patient"
      },
      "fullUrl": "urn:uuid:36dd6e2a-e7fa-11ec-9601-0242ac1a0002",
      "resource": {
        "resourceType": "Patient",
        "address": [
          {
            "city": "Lyon",
            "line": [
              "615 Avenue Lemaire"
            ],
            "postalCode": "63000",
            "state": "Auvergne-Rhone-Alpes"
          }
        ],
        "birthDate": "1992-08-20",
        "gender": "female",
        "identifier": [
          {
            "assigner": {
              "reference": "urn:uuid:347a0c88-e7fa-11ec-9601-0242ac1a0002"
            },
            "system": "https://github.com/synthetichealth/synthea",
            "value": "060a6bd5-5146-4b08-a916-009858997bd3"
          },
          {
            "assigner": {
              "reference": "urn:uuid:34d03d1a-e7fa-11ec-9601-0242ac1a0002"
            },
            "system": "http://hospital.smarthealthit.org",
            "type": {
              "coding": [
                {
                  "code": "MR",
                  "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
                }
              ],
              "text": "MRN"
            },
            "value": "060a6bd5-5146-4b08-a916-009858997bd3"
          },
          {
            "extension": [
              {
                "url": "http://intersystems.com/fhir/extn/sda3/lib/patient-number-i-s-o-assigning-authority",
                "valueString": "&"
              }
            ],
            "type": {
              "coding": [
                {
                  "code": "SS"
                }
              ],
              "text": "SS"
            },
            "value": "999-97-4582"
          },
          {
            "extension": [
              {
                "url": "http://intersystems.com/fhir/extn/sda3/lib/patient-number-i-s-o-assigning-authority",
                "valueString": "&"
              }
            ],
            "type": {
              "coding": [
                {
                  "code": "DL",
                  "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
                }
              ],
              "text": "DL"
            },
            "value": "S99986284"
          },
          {
            "extension": [
              {
                "url": "http://intersystems.com/fhir/extn/sda3/lib/patient-number-i-s-o-assigning-authority",
                "valueString": "&"
              }
            ],
            "type": {
              "coding": [
                {
                  "code": "PPN",
                  "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
                }
              ],
              "text": "PPN"
            },
            "value": "X84330364X"
          }
        ],
        "name": [
          {
            "family": "Simon",
            "given": [
              "Livia"
            ],
            "text": "Livia Simon"
          },
          {
            "family": "Masson",
            "given": [
              "Livia"
            ],
            "prefix": [
              "Mrs."
            ],
            "text": "Mrs. Livia Masson",
            "use": "official"
          }
        ],
        "telecom": [
          {
            "system": "phone",
            "use": "home",
            "value": "(555) 286"
          }
        ]
      }
    },
    {
      "request": {
        "method": "POST",
        "url": "Encounter"
      },
      "fullUrl": "urn:uuid:38cf2d40-e7fa-11ec-9601-0242ac1a0002",
      "resource": {
        "resourceType": "Encounter",
        "class": {
          "code": "AMB",
          "system": "http://terminology.hl7.org/CodeSystem/v3-ActCode"
        },
        "extension": [
          {
            "url": "http://intersystems.com/fhir/extn/sda3/lib/encounter-encounter-type",
            "valueString": "O"
          },
          {
            "url": "http://intersystems.com/fhir/extn/sda3/lib/encounter-entered-on",
            "valueDateTime": "2008-12-31T23:25:00+00:00"
          },
          {
            "url": "http://intersystems.com/fhir/extn/sda3/lib/encounter-to-time",
            "valueDateTime": "2009-01-01T04:40:04+00:00"
          }
        ],
        "identifier": [
          {
            "type": {
              "text": "EncounterNumber"
            },
            "use": "official",
            "value": "1"
          }
        ],
        "period": {
          "start": "2008-12-31T23:25:00+00:00"
        },
        "reasonCode": [
          {
            "coding": [
              {
                "code": "72892002",
                "display": "Grossesse normale",
                "system": "http://snomed.info/sct"
              }
            ]
          }
        ],
        "status": "unknown",
        "subject": {
          "reference": "urn:uuid:36dd6e2a-e7fa-11ec-9601-0242ac1a0002"
        },
        "type": [
          {
            "coding": [
              {
                "code": "424441002"
              }
            ]
          }
        ]
      }
    },
    {
      "request": {
        "method": "POST",
        "url": "Observation"
      },
      "fullUrl": "urn:uuid:3a13745e-e7fa-11ec-9601-0242ac1a0002",
      "resource": {
        "resourceType": "Observation",
        "code": {
          "coding": [
            {
              "code": "72166-2",
              "display": "Statut du tabagisme",
              "system": "http://loinc.org"
            }
          ]
        },
        "effectiveDateTime": "2017-10-26T00:00:00+00:00",
        "encounter": {
          "reference": "urn:uuid:38cf2d40-e7fa-11ec-9601-0242ac1a0002"
        },
        "extension": [
          {
            "url": "http://intersystems.com/fhir/extn/sda3/lib/observation-encounter-number",
            "valueString": "1"
          },
          {
            "url": "http://intersystems.com/fhir/extn/sda3/lib/observation-observation-coded-value",
            "valueCodeableConcept": {
              "coding": [
                {
                  "code": "20171026002504",
                  "display": "Ancien fumeur",
                  "system": "http://snomed.info/sct"
                }
              ],
              "text": "Ancien fumeur"
            }
          }
        ],
        "status": "final",
        "subject": {
          "reference": "urn:uuid:36dd6e2a-e7fa-11ec-9601-0242ac1a0002"
        },
        "valueString": "Ancien fumeur"
      }
    },
    {
      "request": {
        "method": "POST",
        "url": "Observation"
      },
      "fullUrl": "urn:uuid:3b6212fc-e7fa-11ec-9601-0242ac1a0002",
      "resource": {
        "resourceType": "Observation",
        "category": [
          {
            "coding": [
              {
                "code": "vital-signs",
                "display": "Vital Signs",
                "system": "http://terminology.hl7.org/CodeSystem/observation-category"
              }
            ],
            "text": "Vital Signs"
          }
        ],
        "code": {
          "coding": [
            {
              "code": "8302-2",
              "display": "Taille du corps",
              "system": "http://loinc.org"
            }
          ],
          "extension": [
            {
              "url": "http://intersystems.com/fhir/extn/sda3/lib/code-table-detail-observation-observation-value-units",
              "valueCodeableConcept": {
                "coding": [
                  {
                    "code": "cm",
                    "system": "http://unitsofmeasure.org"
                  }
                ]
              }
            }
          ]
        },
        "effectiveDateTime": "2010-10-14T00:00:00+00:00",
        "encounter": {
          "reference": "urn:uuid:38cf2d40-e7fa-11ec-9601-0242ac1a0002"
        },
        "extension": [
          {
            "url": "http://intersystems.com/fhir/extn/sda3/lib/observation-encounter-number",
            "valueString": "1"
          }
        ],
        "status": "final",
        "subject": {
          "reference": "urn:uuid:36dd6e2a-e7fa-11ec-9601-0242ac1a0002"
        },
        "valueCodeableConcept": {
          "coding": [
            {
              "code": "20101014002504"
            }
          ]
        }
      }
    },
    {
      "request": {
        "method": "POST",
        "url": "Observation"
      },
      "fullUrl": "urn:uuid:3c8aba30-e7fa-11ec-9601-0242ac1a0002",
      "resource": {
        "resourceType": "Observation",
        "code": {
          "coding": [
            {
              "code": "72514-3",
              "display": "Gravite de la douleur - 0-10 evaluation numerique verbale [Score] - Signaleee",
              "system": "http://loinc.org"
            }
          ],
          "extension": [
            {
              "url": "http://intersystems.com/fhir/extn/sda3/lib/code-table-detail-observation-observation-value-units",
              "valueCodeableConcept": {
                "coding": [
                  {
                    "code": "{score}",
                    "system": "http://unitsofmeasure.org"
                  }
                ]
              }
            }
          ]
        },
        "effectiveDateTime": "2010-10-14T00:00:00+00:00",
        "encounter": {
          "reference": "urn:uuid:38cf2d40-e7fa-11ec-9601-0242ac1a0002"
        },
        "extension": [
          {
            "url": "http://intersystems.com/fhir/extn/sda3/lib/observation-encounter-number",
            "valueString": "1"
          }
        ],
        "status": "final",
        "subject": {
          "reference": "urn:uuid:36dd6e2a-e7fa-11ec-9601-0242ac1a0002"
        },
        "valueCodeableConcept": {
          "coding": [
            {
              "code": "20101014002504"
            }
          ]
        }
      }
    },
    {
      "request": {
        "method": "POST",
        "url": "Observation"
      },
      "fullUrl": "urn:uuid:3de455d0-e7fa-11ec-9601-0242ac1a0002",
      "resource": {
        "resourceType": "Observation",
        "category": [
          {
            "coding": [
              {
                "code": "vital-signs",
                "display": "Vital Signs",
                "system": "http://terminology.hl7.org/CodeSystem/observation-category"
              }
            ],
            "text": "Vital Signs"
          }
        ],
        "code": {
          "coding": [
            {
              "code": "29463-7",
              "display": "Poids corporel",
              "system": "http://loinc.org"
            }
          ],
          "extension": [
            {
              "url": "http://intersystems.com/fhir/extn/sda3/lib/code-table-detail-observation-observation-value-units",
              "valueCodeableConcept": {
                "coding": [
                  {
                    "code": "kg",
                    "system": "http://unitsofmeasure.org"
                  }
                ]
              }
            }
          ]
        },
        "effectiveDateTime": "2010-10-14T00:00:00+00:00",
        "encounter": {
          "reference": "urn:uuid:38cf2d40-e7fa-11ec-9601-0242ac1a0002"
        },
        "extension": [
          {
            "url": "http://intersystems.com/fhir/extn/sda3/lib/observation-encounter-number",
            "valueString": "1"
          }
        ],
        "status": "final",
        "subject": {
          "reference": "urn:uuid:36dd6e2a-e7fa-11ec-9601-0242ac1a0002"
        },
        "valueCodeableConcept": {
          "coding": [
            {
              "code": "20101014002504"
            }
          ]
        }
      }
    },
    {
      "request": {
        "method": "POST",
        "url": "Observation"
      },
      "fullUrl": "urn:uuid:3f501418-e7fa-11ec-9601-0242ac1a0002",
      "resource": {
        "resourceType": "Observation",
        "code": {
          "coding": [
            {
              "code": "39156-5",
              "display": "Indice de masse corporelle",
              "system": "http://loinc.org"
            }
          ],
          "extension": [
            {
              "url": "http://intersystems.com/fhir/extn/sda3/lib/code-table-detail-observation-observation-value-units",
              "valueCodeableConcept": {
                "coding": [
                  {
                    "code": "kg/m2",
                    "system": "http://unitsofmeasure.org"
                  }
                ]
              }
            }
          ]
        },
        "effectiveDateTime": "2010-10-14T00:00:00+00:00",
        "encounter": {
          "reference": "urn:uuid:38cf2d40-e7fa-11ec-9601-0242ac1a0002"
        },
        "extension": [
          {
            "url": "http://intersystems.com/fhir/extn/sda3/lib/observation-encounter-number",
            "valueString": "1"
          }
        ],
        "status": "final",
        "subject": {
          "reference": "urn:uuid:36dd6e2a-e7fa-11ec-9601-0242ac1a0002"
        },
        "valueCodeableConcept": {
          "coding": [
            {
              "code": "20101014002504"
            }
          ]
        }
      }
    }
  ]
}
  ```
  
</details>


### FHIR to HL7 ADT
```
POST http://localhost:32783/api/fhir/hl7/adt
```

#### Example

<details>
  <summary>Input</summary>
  
  ```json
{
  "resourceType": "Bundle",
  "type": "transaction",
  "entry": [
    {
      "request": {
        "method": "POST",
        "url": "Organization"
      },
      "fullUrl": "urn:uuid:347a0c88-e7fa-11ec-9601-0242ac1a0002",
      "resource": {
        "resourceType": "Organization",
        "identifier": [
          {
            "value": "https://github.com/synthetichealth/synthea"
          }
        ]
      }
    },
    {
      "request": {
        "method": "POST",
        "url": "Organization"
      },
      "fullUrl": "urn:uuid:34d03d1a-e7fa-11ec-9601-0242ac1a0002",
      "resource": {
        "resourceType": "Organization",
        "identifier": [
          {
            "value": "http://hospital.smarthealthit.org"
          }
        ]
      }
    },
    {
      "request": {
        "method": "POST",
        "url": "Patient"
      },
      "fullUrl": "urn:uuid:36dd6e2a-e7fa-11ec-9601-0242ac1a0002",
      "resource": {
        "resourceType": "Patient",
        "address": [
          {
            "city": "Lyon",
            "line": [
              "615 Avenue Lemaire"
            ],
            "postalCode": "63000",
            "state": "Auvergne-Rhone-Alpes"
          }
        ],
        "birthDate": "1992-08-20",
        "gender": "female",
        "identifier": [
          {
            "assigner": {
              "reference": "urn:uuid:347a0c88-e7fa-11ec-9601-0242ac1a0002"
            },
            "system": "https://github.com/synthetichealth/synthea",
            "value": "060a6bd5-5146-4b08-a916-009858997bd3"
          },
          {
            "assigner": {
              "reference": "urn:uuid:34d03d1a-e7fa-11ec-9601-0242ac1a0002"
            },
            "system": "http://hospital.smarthealthit.org",
            "type": {
              "coding": [
                {
                  "code": "MR",
                  "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
                }
              ],
              "text": "MRN"
            },
            "value": "060a6bd5-5146-4b08-a916-009858997bd3"
          },
          {
            "extension": [
              {
                "url": "http://intersystems.com/fhir/extn/sda3/lib/patient-number-i-s-o-assigning-authority",
                "valueString": "&"
              }
            ],
            "type": {
              "coding": [
                {
                  "code": "SS"
                }
              ],
              "text": "SS"
            },
            "value": "999-97-4582"
          },
          {
            "extension": [
              {
                "url": "http://intersystems.com/fhir/extn/sda3/lib/patient-number-i-s-o-assigning-authority",
                "valueString": "&"
              }
            ],
            "type": {
              "coding": [
                {
                  "code": "DL",
                  "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
                }
              ],
              "text": "DL"
            },
            "value": "S99986284"
          },
          {
            "extension": [
              {
                "url": "http://intersystems.com/fhir/extn/sda3/lib/patient-number-i-s-o-assigning-authority",
                "valueString": "&"
              }
            ],
            "type": {
              "coding": [
                {
                  "code": "PPN",
                  "system": "http://terminology.hl7.org/CodeSystem/v2-0203"
                }
              ],
              "text": "PPN"
            },
            "value": "X84330364X"
          }
        ],
        "name": [
          {
            "family": "Simon",
            "given": [
              "Livia"
            ],
            "text": "Livia Simon"
          },
          {
            "family": "Masson",
            "given": [
              "Livia"
            ],
            "prefix": [
              "Mrs."
            ],
            "text": "Mrs. Livia Masson",
            "use": "official"
          }
        ],
        "telecom": [
          {
            "system": "phone",
            "use": "home",
            "value": "(555) 286"
          }
        ]
      }
    },
    {
      "request": {
        "method": "POST",
        "url": "Encounter"
      },
      "fullUrl": "urn:uuid:38cf2d40-e7fa-11ec-9601-0242ac1a0002",
      "resource": {
        "resourceType": "Encounter",
        "class": {
          "code": "AMB",
          "system": "http://terminology.hl7.org/CodeSystem/v3-ActCode"
        },
        "extension": [
          {
            "url": "http://intersystems.com/fhir/extn/sda3/lib/encounter-encounter-type",
            "valueString": "O"
          },
          {
            "url": "http://intersystems.com/fhir/extn/sda3/lib/encounter-entered-on",
            "valueDateTime": "2008-12-31T23:25:00+00:00"
          },
          {
            "url": "http://intersystems.com/fhir/extn/sda3/lib/encounter-to-time",
            "valueDateTime": "2009-01-01T04:40:04+00:00"
          }
        ],
        "identifier": [
          {
            "type": {
              "text": "EncounterNumber"
            },
            "use": "official",
            "value": "1"
          }
        ],
        "period": {
          "start": "2008-12-31T23:25:00+00:00"
        },
        "reasonCode": [
          {
            "coding": [
              {
                "code": "72892002",
                "display": "Grossesse normale",
                "system": "http://snomed.info/sct"
              }
            ]
          }
        ],
        "status": "unknown",
        "subject": {
          "reference": "urn:uuid:36dd6e2a-e7fa-11ec-9601-0242ac1a0002"
        },
        "type": [
          {
            "coding": [
              {
                "code": "424441002"
              }
            ]
          }
        ]
      }
    },
    {
      "request": {
        "method": "POST",
        "url": "Observation"
      },
      "fullUrl": "urn:uuid:3a13745e-e7fa-11ec-9601-0242ac1a0002",
      "resource": {
        "resourceType": "Observation",
        "code": {
          "coding": [
            {
              "code": "72166-2",
              "display": "Statut du tabagisme",
              "system": "http://loinc.org"
            }
          ]
        },
        "effectiveDateTime": "2017-10-26T00:00:00+00:00",
        "encounter": {
          "reference": "urn:uuid:38cf2d40-e7fa-11ec-9601-0242ac1a0002"
        },
        "extension": [
          {
            "url": "http://intersystems.com/fhir/extn/sda3/lib/observation-encounter-number",
            "valueString": "1"
          },
          {
            "url": "http://intersystems.com/fhir/extn/sda3/lib/observation-observation-coded-value",
            "valueCodeableConcept": {
              "coding": [
                {
                  "code": "20171026002504",
                  "display": "Ancien fumeur",
                  "system": "http://snomed.info/sct"
                }
              ],
              "text": "Ancien fumeur"
            }
          }
        ],
        "status": "final",
        "subject": {
          "reference": "urn:uuid:36dd6e2a-e7fa-11ec-9601-0242ac1a0002"
        },
        "valueString": "Ancien fumeur"
      }
    },
    {
      "request": {
        "method": "POST",
        "url": "Observation"
      },
      "fullUrl": "urn:uuid:3b6212fc-e7fa-11ec-9601-0242ac1a0002",
      "resource": {
        "resourceType": "Observation",
        "category": [
          {
            "coding": [
              {
                "code": "vital-signs",
                "display": "Vital Signs",
                "system": "http://terminology.hl7.org/CodeSystem/observation-category"
              }
            ],
            "text": "Vital Signs"
          }
        ],
        "code": {
          "coding": [
            {
              "code": "8302-2",
              "display": "Taille du corps",
              "system": "http://loinc.org"
            }
          ],
          "extension": [
            {
              "url": "http://intersystems.com/fhir/extn/sda3/lib/code-table-detail-observation-observation-value-units",
              "valueCodeableConcept": {
                "coding": [
                  {
                    "code": "cm",
                    "system": "http://unitsofmeasure.org"
                  }
                ]
              }
            }
          ]
        },
        "effectiveDateTime": "2010-10-14T00:00:00+00:00",
        "encounter": {
          "reference": "urn:uuid:38cf2d40-e7fa-11ec-9601-0242ac1a0002"
        },
        "extension": [
          {
            "url": "http://intersystems.com/fhir/extn/sda3/lib/observation-encounter-number",
            "valueString": "1"
          }
        ],
        "status": "final",
        "subject": {
          "reference": "urn:uuid:36dd6e2a-e7fa-11ec-9601-0242ac1a0002"
        },
        "valueCodeableConcept": {
          "coding": [
            {
              "code": "20101014002504"
            }
          ]
        }
      }
    },
    {
      "request": {
        "method": "POST",
        "url": "Observation"
      },
      "fullUrl": "urn:uuid:3c8aba30-e7fa-11ec-9601-0242ac1a0002",
      "resource": {
        "resourceType": "Observation",
        "code": {
          "coding": [
            {
              "code": "72514-3",
              "display": "Gravite de la douleur - 0-10 evaluation numerique verbale [Score] - Signaleee",
              "system": "http://loinc.org"
            }
          ],
          "extension": [
            {
              "url": "http://intersystems.com/fhir/extn/sda3/lib/code-table-detail-observation-observation-value-units",
              "valueCodeableConcept": {
                "coding": [
                  {
                    "code": "{score}",
                    "system": "http://unitsofmeasure.org"
                  }
                ]
              }
            }
          ]
        },
        "effectiveDateTime": "2010-10-14T00:00:00+00:00",
        "encounter": {
          "reference": "urn:uuid:38cf2d40-e7fa-11ec-9601-0242ac1a0002"
        },
        "extension": [
          {
            "url": "http://intersystems.com/fhir/extn/sda3/lib/observation-encounter-number",
            "valueString": "1"
          }
        ],
        "status": "final",
        "subject": {
          "reference": "urn:uuid:36dd6e2a-e7fa-11ec-9601-0242ac1a0002"
        },
        "valueCodeableConcept": {
          "coding": [
            {
              "code": "20101014002504"
            }
          ]
        }
      }
    },
    {
      "request": {
        "method": "POST",
        "url": "Observation"
      },
      "fullUrl": "urn:uuid:3de455d0-e7fa-11ec-9601-0242ac1a0002",
      "resource": {
        "resourceType": "Observation",
        "category": [
          {
            "coding": [
              {
                "code": "vital-signs",
                "display": "Vital Signs",
                "system": "http://terminology.hl7.org/CodeSystem/observation-category"
              }
            ],
            "text": "Vital Signs"
          }
        ],
        "code": {
          "coding": [
            {
              "code": "29463-7",
              "display": "Poids corporel",
              "system": "http://loinc.org"
            }
          ],
          "extension": [
            {
              "url": "http://intersystems.com/fhir/extn/sda3/lib/code-table-detail-observation-observation-value-units",
              "valueCodeableConcept": {
                "coding": [
                  {
                    "code": "kg",
                    "system": "http://unitsofmeasure.org"
                  }
                ]
              }
            }
          ]
        },
        "effectiveDateTime": "2010-10-14T00:00:00+00:00",
        "encounter": {
          "reference": "urn:uuid:38cf2d40-e7fa-11ec-9601-0242ac1a0002"
        },
        "extension": [
          {
            "url": "http://intersystems.com/fhir/extn/sda3/lib/observation-encounter-number",
            "valueString": "1"
          }
        ],
        "status": "final",
        "subject": {
          "reference": "urn:uuid:36dd6e2a-e7fa-11ec-9601-0242ac1a0002"
        },
        "valueCodeableConcept": {
          "coding": [
            {
              "code": "20101014002504"
            }
          ]
        }
      }
    },
    {
      "request": {
        "method": "POST",
        "url": "Observation"
      },
      "fullUrl": "urn:uuid:3f501418-e7fa-11ec-9601-0242ac1a0002",
      "resource": {
        "resourceType": "Observation",
        "code": {
          "coding": [
            {
              "code": "39156-5",
              "display": "Indice de masse corporelle",
              "system": "http://loinc.org"
            }
          ],
          "extension": [
            {
              "url": "http://intersystems.com/fhir/extn/sda3/lib/code-table-detail-observation-observation-value-units",
              "valueCodeableConcept": {
                "coding": [
                  {
                    "code": "kg/m2",
                    "system": "http://unitsofmeasure.org"
                  }
                ]
              }
            }
          ]
        },
        "effectiveDateTime": "2010-10-14T00:00:00+00:00",
        "encounter": {
          "reference": "urn:uuid:38cf2d40-e7fa-11ec-9601-0242ac1a0002"
        },
        "extension": [
          {
            "url": "http://intersystems.com/fhir/extn/sda3/lib/observation-encounter-number",
            "valueString": "1"
          }
        ],
        "status": "final",
        "subject": {
          "reference": "urn:uuid:36dd6e2a-e7fa-11ec-9601-0242ac1a0002"
        },
        "valueCodeableConcept": {
          "coding": [
            {
              "code": "20101014002504"
            }
          ]
        }
      }
    }
  ]
}
  ```
  
</details>

<details>
  <summary>Output</summary>
  
  ```text
MSH|^~\&||^^NPI|||20220609134903+0000||^|66269,49743.388133779|P|2.5.1|||AL|AL|||||PH_SS-Ack^SS Sender^2.16.840.1.114222.4.10.3^ISO
EVN||202206091349|||||^^NPI
PID|1||060a6bd5-5146-4b08-a916-009858997bd3^^^https://github.com/s&&ISO^~060a6bd5-5146-4b08-a916-009858997bd3^^^http://hospital.smar&&ISO^MR~999-97-4582^^^&^SS~S99986284^^^&^DL~X84330364X^^^&^PPN||Masson^Livia^^^Mrs.^^||19920820|F|Simon^Livia^^||615 Avenue Lemaire^^^^||^PRN^PH^^^555^286|||||||||||||||||||||
PV1|1|O||424441002|||||||||||||||1^^^&&^VN|||||||||||||||||||||||||200812312325|
PV2|||72892002^Grossesse normale^SCT
OBX|1||72166-2^Statut du tabagisme^LN||^^||||||F|||20171026
OBX|2||8302-2^Taille du corps^LN||^^||||||F|||20101014
OBX|3||72514-3^Gravite de la douleur - 0-10 evaluation numerique verbale [Score] - Signaleee^LN||^^||||||F|||20101014
OBX|4||29463-7^Poids corporel^LN||^^||||||F|||20101014
OBX|5||39156-5^Indice de masse corporelle^LN||^^||||||F|||20101014

  ```
  
</details>


### FHIR to HL7 ORU
```
POST http://localhost:32783/api/fhir/hl7/oru
```

### FHIR to HL7 vxu
```
POST http://localhost:32783/api/fhir/hl7/vxu
```

### CDA to FHIR
```
POST http://localhost:32783/api/cda/fhir
```

#### Example

<details>
  <summary>Input</summary>
  
  ```xml

  ```
  
</details>

<details>
  <summary>Output</summary>
  
  ```text

  ```
  
</details>


### FHIR repo
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

## How it's working

This project works with the pivot diagram: SDA.

The SDA (Summary Document Architecture) is the InterSystems Clinical Data Format. 

The SDA <-> FHIR correspondences can be consulted [here](https://docs.intersystems.com/irisforhealthlatest/csp/docbook/Doc.View.cls?KEY=HXFHIR_transforms), and those of the CDA -> SDA [here](https://docs.intersystems.com/irisforhealthlatest/csp/docbook/DocBook.UI.Page.cls?KEY=HXCDA).

![gif sda pivot](https://raw.githubusercontent.com/grongierisc/iris-healthtoolkit-service/main/misc/images/Gif_SDA_Pivot.gif)


