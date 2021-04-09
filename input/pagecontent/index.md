# Genomics Clinical Picture Repository FHIR Implementation Guide

## Scope

This implementation guide describes a collection of FHIR resources that can be used to implement a repository that stores patient clinical pictures, including clinically relevant genomic data. Patient information can come from multiple sources, including electronic health record systems (EHRs), electronic data capture systems such as REDCap, and laboratory information management systems (LIMs). It is meant to be used in a research setting and therefore requires patient information to be de-identified. The FHIR profiles contain strict terminology bindings that ensure queries can be run consistently across multiple repositories. This implies, however, that data might require mapping and transformation, even when being imported from FHIR-enabled sources.

## Understanding FHIR

This implementation guide uses terminology, notations and design principles that are specific to FHIR. Before reading this implementation guide, its important to be familiar with some of the basic principles of FHIR as well as general guidance on how to read FHIR specifications. Readers who are unfamiliar with FHIR are encouraged to read (or at least skim) the following prior to reading the rest of this implementation guide.

   - [FHIR overview](http://hl7.org/fhir/overview.html)
   - [Developer's Introduction](http://hl7.org/fhir/overview-dev.html) 
   - [Clinical Introduction](http://hl7.org/fhir/overview-clinical.html)
   - [FHIR data types](http://hl7.org/fhir/datatypes.html)
   - [Using codes](http://hl7.org/fhir/terminologies.html)
   - [References between resources](http://hl7.org/fhir/references.html)
   - [How to read resource and profile definitions](http://hl7.org/fhir/formats.html)
   - [Base resource](http://hl7.org/fhir/resource.html)
   
This implementation guide builds on FHIR v4.0.1: R4.

## Design

The design decisions in this implementation guide are based on the guidance given in the base FHIR specification and the paper [Toward an Ontological Treatment of Disease and Diagnosis](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3041577/). 

A summary of the model is shown in the following diagram:

<img src="model.png" alt="FHIR model" style="float:none"/>

The following sections describe the different resources that were used.

### Research study

When data is being imported from a research study, the [GencliprResearchStudy](StructureDefinition-GencliprResearchStudy.html) profile should be used to indicate that these resources where produced as part of the study. The [researchStudy](http://hl7.org/fhir/StructureDefinition/workflow-researchStudy) extension can be used to indicate that an event is relevant to a research study. In this IG it is used to link [GencliprEncounter](StructureDefinition-GencliprEncounter.html)s to a [GencliprResearchStudy](StructureDefinition-GencliprResearchStudy.html).

### Encounter

All resources are required to be associated with a [GencliprEncounter](StructureDefinition-GencliprEncounter.html). If the data comes from a research study then the encounter should be linked to the corresponding research study resource. No direct links from the resources in the encounter to the research study are required.

### Patient

The main challenge when dealing with de-identified data is matching data about the same patient from multiple sources. A typical approach is to use _pseudonimisation_, but this is out of scope of this implementation guide. A [DeidentifiedPatient](StructureDefinition-DeidentifiedPatient.html) only requires an identifier. Every resource should be associated to a [DeidentifiedPatient](StructureDefinition-DeidentifiedPatient.html) regardless of the data's origin. When data originates in a research study, a [GencliprResearchSubject](StructureDefinition-GencliprResearchSubject.html) is also required to establish the link to the corresponding [GencliprResearchStudy](StructureDefinition-GencliprResearchStudy.html). Both the patient and the research subject should have the same identifier.

#### Date of birth

The `dateOfBirth` attribute is mandatory. In certain scenarios, for example when dealing with rare diseases, a full date of birth might be identifying. The FHIR `date` data type also accepts years or years and months only. In cases where providing the full date of birth is problematic, the source systems should submit only a partial date of birth. This, however, is not validated by the IG.

#### Gender and sex

The `gender` attribute in the `Patient` resource represents the patient's administrative gender. The clinical picture repository requires the biological sex, and this should be represented as an Observation, according to the [FHIR documentation](https://www.hl7.org/fhir/patient.html#gender). The implementation guide defines the [BiologicalSex](StructureDefinition-BiologicalSex.html) profile to represent this observation and this is the preferred mechanism to record the patient's biological sex. If only the administrative gender is available, then the `gender` attribute can be used.

### Findings

[Finding](StructureDefinition-Finding.html) is the parent class of all the observations whose value can be represented as a code from the [presence value set](ValueSet-PresenceCodes.html). It extends the [Observation](https://www.hl7.org/fhir/observation.html) resource and follows the third pattern discussed in the [interoperability section](http://hl7.org/fhir/R4/observation.html#code-interop). In this case, the code is reduced to a single term and the value indicates its presence or absence. The choice was made to support a coded value instead of a boolean value, so values such as _not done_ could be supported. This is important because when running complex queries, for example, the calculation of scores that use multiple data points, it is important to distinguish if these data points are absent or were never collected.

Observations that do not follow this pattern have their own profile, such as [biological sex](StructureDefinition-BiologicalSex.html).

#### Signs and Symptoms

A sign is defined as "a bodily feature of a patient that is observed in a physical examination and is deemed by the clinician to be of clinical significance". Note that in this IG we distinguish a `sign` from a `phenotype` or `phenotypic feature`. A sign is an _observation_ of a phenotype and therefore the repository is a collection of signs (and symptoms) rather than phenotypes (or phenotypic features). The [Sign](StructureDefinition-Sign.html) profile extends the [ExaminationFinding](StructureDefinition-ExaminationFinding.html) profile and the [Symptom](StructureDefinition-Symptom.html) profile extends the [PatientReportedFinding](StructureDefinition-PatientReportedFinding.html) profile. Both of these constrain the codes to be abnormal conditions, i.e., the code is bound to a value set that includes SNOMED CT disorders and HPO phenotypic abnormalities.

#### Laboratory Findings
A laboratory finding is defined as "a representation of a quality of a specimen that is the output of a laboratory test and that can support an inference to an assertion about some quality of the patient". In this IG, laboratory findings are observations that interpret raw test results and follow the same basic pattern as signs and symptoms but contain different modifiers that are relevant in this context. They can be referenced by a [DiagnosticReport](https://www.hl7.org/fhir/diagnosticreport.html), but this is not required.

## Authors

- Alejandro Metke [GitHub](https://github.com/ametke)

![alt text](csiro_logo.jpg "CSIRO logo")
![alt text](aehrc_logo.jpg "AEHRC logo")
