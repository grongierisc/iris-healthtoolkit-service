# iris-healthtoolkit-service
Convert HL7 to FHIR,  CDA to FHIR, FHIR to HL7 as a Service

HL7 to FHIR
POST http://localhost:32783/api/hl7/

FHIR to HL7
POST http://localhost:32783/api/fhir/hl7

CDA to FHIR
POST http://localhost:32783/api/cda/

FHIR repo
http://localhost:32783/api/fhir

TODO :
- [ ] FHIR to HL7
    - [ ] ORU
    - [ ] VXN
- [ ] README
- [ ] VIDEO
- [ ] CLEANUP Dirty work
- [ ] Explain SDA pivot

Video :

FHIR et IRIS le voyageur dans le temps.

Bonjour, C'est Guillaume d'InterSystems.
Aujourd'hui j'ai 88 secondes pour vous parler du FHIR et du voyage dans le temps.
Le FHIR pour Fast Healthcare Interoperability Resources.
Inventé en 2011 par l'organiseme HL7 et sortie en version finale en 2019.
A ne pas confondre avec HL7v2 inventé en 1989.
Si on fesait une analogie de ces protocoles de santé avec les réseaux sociaux
Cela donnerait :
Le FHIR est à TikTok
Ce que l'HL7v2 est au minitel

Le moins que l'on puisse dire, c'est qu'il y a un écart générationelle entre les deux.
Comme toute communauté, 
faire du FHIR avec du FHIR 
c'est aussi simple que faire de 
HL7v2 avec de HL7v2.

Et que se passe t il si on fait communiquer les deux ?
Pour commencer les formats sont pas les memes.
L'HL7v2 est sous forme de fichier plat.
Le FHIR est généralement proposé sous forme de JSON.
Maintenant, il nous reste à mapper les champs d'un format à l'autre.
C'est long, compliqué et source d'erreur.

Et si on avait une machine à voyager dans le temps ?
Une machine qui fesait la passerelle entre 1989 et 2019 ?

C'est ce que je vous propose avec IRIS For Health.
Vous ne me coyer pas ?

Rendez-vous sur GitHub :
https://github.com/grongierisc/iris-healthtoolkit-service

Ici vous y trouverez une demo clé en main.

Envoyer sur cette api (/api/fhir/hl7/adt) du bundle FHIR et en sortie vous aurez de l'HL7v2 ADT
Envoyer ici (/api/hl7/fhir) une ADT HL7v2 vous aurez en sortie du bundle FHIR

N'hesitez pas à venir nous voir sur intersystems.com ou sur le salon pour en apprendre plus sur IRIS for Health et d'autres sujets comme le NLP, l'AutoML, notre DPI, le serveur FHIR, l'analystics, les bases de données, l'intéropérabilité, le devops, ...




C'est là qu'arrive notre notion de voyage dans le temps.
Comment faire communiquer ces deux mondes ?



