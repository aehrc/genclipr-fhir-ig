// ALIASES
Alias: SCT = http://snomed.info/sct
Alias: HPO = http://purl.obolibrary.org/obo/hp.owl
Alias: OBSCAT = http://terminology.hl7.org/CodeSystem/observation-category
Alias: V2IDT = http://terminology.hl7.org/CodeSystem/v2-0203
Alias: V3ACT = http://terminology.hl7.org/ValueSet/v3-ActEncounterCode
Alias: ENCTYPE = http://hl7.org/fhir/ValueSet/encounter-type
Alias: UCUM = http://unitsofmeasure.org

// CODE SYSTEMS
CodeSystem: FindingType
Title: "Finding Type"
Description: "Extends the Observation Category codes to include additional categories."
* #patient-reported "Patient Reported" "An observation done by the patient, for example a symptom."
* #laboratory-finding "Laboratory Finding" "Higher-level observations derived from laboratory observations. For example, a positive laboratory test for the presence of nitrite in urine can be represented as an observation of Nitrituria."

CodeSystem: IdentifierType
Title: "Identifier Type"
Description: "Types of identifiers used in a genomics clinical picture FHIR repository."
* #RSI "Research study identifier" "An identifier given to a research study."

CodeSystem: EncounterClass
Title: "Encounter Class"
Description: "Class of encounters captured in a genomics clinical picture FHIR repository."
* #RS "research study" "An encounter that is part of a research study."

CodeSystem: EncounterType
Title: "Encounter Type"
Description: "Type of encounters captured in a genomics clinical picture FHIR repository."
* #REF "referral" "An initial encounter done by a specialist after referral."
* #PRI "pre-investigation" "An encounter done before genomic testing results are available."
* #PTI "post-investigation" "An encounter done after genomic testing results are available."

// VALUE SETS 
ValueSet: BiologicalSexCodes
Title: "Biological Sex Value Set"
Description: "SNOMED CT concepts for biological sex."
* SCT#248152002 "Female"
* SCT#248153007 "Male"
* SCT#32570681000036106 "Indeterminate sex"
* SCT#32570691000036108 "Intersex"
* SCT#407374003 "Transsexual"

ValueSet: ClinicalFindingTypeCodes
Title: "Finding Type Value Set"
Description: "Finding types."
* codes from system http://terminology.hl7.org/CodeSystem/observation-category
* codes from system FindingType

ValueSet: ClinicalFindingCodes
Title: "Clinical Findings Value Set"
Description: "Clinical findings from SNOMED CT."
* codes from system SCT where concept descendent-of #404684003
// TODO: might need to refine this more

ValueSet: AbnormalClinicalFindingCodes
Title: "Abnormal Clinical Findings Value Set"
Description: "Abnormal clinical findings from SNOMED CT and HPO."
* codes from system HPO where concept descendent-of #HP:0000118
* codes from system SCT where concept descendent-of #64572001
// TODO: need to come up with a better value set that takes into consideration the HPO to SCT map

// Follows recommendations in pattern 3 (see http://hl7.org/fhir/R4/observation.html#code-interop)
// but narrows options to just present and absent
ValueSet: PresenceCodes
Title: "Presence Value Set"
Description: "Presence / absence values from SNOMED CT."
* SCT#52101004 "Present"
* SCT#2667000 "Absent"
* SCT#385660001 "Not done"
* SCT#373068000 "Undetermined"

ValueSet: BodySiteCodes
Title: "Body Sites Value Set"
Description: "Body sites from SNOMED CT."
* codes from system SCT where concept descendent-of #442083009

ValueSet: IdentifierTypeCodes
Title: "Identifier Types Value Set"
Description: "Identifier types used in this IG."
* codes from system IdentifierType
* V2IDT#PI

ValueSet: EncounterClassCodes
Title: "Encounter Class Value Set"
Description: "Classes of encounters captured in a genomics clinical picture FHIR repository."
* codes from system EncounterClass
* include codes from valueset V3ACT

ValueSet: EncounterTypeCodes
Title: "Encounter Type Value Set"
Description: "Types of encounters captured in a genomics clinical picture FHIR repository."
* codes from system EncounterType
* include codes from valueset ENCTYPE

ValueSet: LateralityCodes
Title: "Laterality Value Set"
Description: "Codes used to describe the laterality of a body structure."
* SCT#24028007 "Right"
* SCT#7771000 "Left"
* SCT#66459002 "Unilateral"
* SCT#51440002 "Right and left"

ValueSet: SeverityCodes
Title: "Severity Value Set"
Description: "Codes used to describe the severity of a finding."
* codes from system SCT where concept descendent-of #272141005

// EXTENSIONS
Extension: ResearchStudyReference
Id: ResearchStudyReference
Title: "Research Study"
Description: "A research study associated with an encounter."
* ^context.type = #element
* ^context.expression =  "Encounter"
* value[x] only Reference(GencliprResearchStudy)

// PROFILES
Profile: GencliprResearchStudy
Parent: ResearchStudy
Id: GencliprResearchStudy
Title: "Genomics Clinical Picture Repository Research Study"
Description: "Captures information about a research study and groups encounters that where generated as part of the study."
* identifier 1..* MS
* identifier.type = IdentifierType#RSI

Profile: GencliprResearchSubject
Parent: ResearchSubject
Id: GencliprResearchSubject
Title: "Genomics Clinical Picture Repository Research Subject"
Description: "This resource represents a patient that is the subject of a research study."
* identifier 1..* MS
* identifier.type = V2IDT#PI
* study MS
* study only Reference(GencliprResearchStudy)
* individual MS
* individual only Reference(DeidentifiedPatient)

Profile: DeidentifiedPatient
Parent: Patient
Id: DeidentifiedPatient
Title: "Deidentified Patient"
Description: "A deidentified patient whose clinical picture is being stored in the repository."
* identifier 1..* MS
* identifier.type = V2IDT#PI
* birthDate 1..1 MS
* gender 0..1 MS
* name 0..0
* telecom 0..0
* address 0..0
* maritalStatus 0..0
* photo 0..0
* contact 0..0
* generalPractitioner 0..0

Profile: GencliprEncounter
Parent: Encounter
Id: GencliprEncounter
Title: "Genomics Clinical Picture Repository Encounter"
Description: "An encounter stored in the repository."
* extension contains ResearchStudyReference named researchStudy 0..1 MS
* subject 1..1
* subject only Reference(DeidentifiedPatient)
* class from EncounterClassCodes (required)
* type MS
* type from EncounterTypeCodes (required)
// might need to say something about diagnosis
* participant 0..0
* appointment 0..0
* account 0..0
* hospitalization 0..0
* location 0..0

Profile: BiologicalSex
Parent: Observation
Id: BiologicalSex
Title: "Biological Sex"
Description: "An observation that represents the biological sex of a patient."
* code = SCT#429019009 // Finding related to biological sex
* value[x] only CodeableConcept 
* valueCodeableConcept from BiologicalSexCodes (required)
* subject 1..1
* subject only Reference(DeidentifiedPatient)
* component 0..0

// See https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3041577/ for a discussion on these definitions
Profile: Finding
Parent: Observation
Id: Finding
Title: "Finding"
Description: "An observation about a patient that can be normal or abnormal and is expressed in a way that its action is reduced to a single concept (see pattern 3 in http://hl7.org/fhir/R4/observation.html#code-interop)."
* category MS
* category 1..*
* bodySite MS
* bodySite from BodySiteCodes (required)
* subject 1..1
* subject only Reference(DeidentifiedPatient)
* effective[x] only dateTime or Period
* effective[x] MS
* encounter 1..1
* encounter only Reference(GencliprEncounter)
* component ^slicing.discriminator.type = #pattern
* component ^slicing.discriminator.path = "code"
* component ^slicing.rules = #open
* component ^slicing.description = "Slice based on the component.code pattern"
* component contains laterality 0..1 MS
* component[laterality].code = SCT#272741003 // Laterality
* component[laterality].value[x] only CodeableConcept
* component[laterality].valueCodeableConcept from LateralityCodes (required)
* component[laterality].dataAbsentReason 0..0
* component[laterality].interpretation 0..0
* component[laterality].referenceRange 0..0
* component contains severity 0..1 MS
* component[severity].code = SCT#246112005 // Severity
* component[severity].value[x] only CodeableConcept
* component[severity].valueCodeableConcept from SeverityCodes (required)
* component[severity].dataAbsentReason 0..0
* component[severity].interpretation 0..0
* component[severity].referenceRange 0..0
* value[x] from PresenceCodes (required)
* focus 0..0
* interpretation 0..0
* referenceRange 0..0
* hasMember 0..0

Profile: PatientReportedFinding
Parent: Finding
Id: PatientReportedFinding
Title: "Patient Reported Finding"
Description: "An observation made by the patient that can be normal or abnormal."
* category = FindingType#patient-reported

Profile: ExaminationFinding
Parent: Finding
Id: ExaminationFinding
Title: "Examination Finding"
Description: "An observation made by a clinician that can be normal or abnormal."
* category = OBSCAT#exam

Profile: Symptom
Parent: PatientReportedFinding
Id: Symptom
Title: "Symptom"
Description: "A symptom is an observation made by the patient and is hypothesized to be a realization of a disease."
* code from AbnormalClinicalFindingCodes (required)

Profile: Sign
Parent: ExaminationFinding
Id: Sign
Title: "Sign"
Description: "A sign is a bodily feature of a patient observed by a clinician which is deemed to be of clinical relevance. It records a phenotype that is clinically abnormal."
* code from AbnormalClinicalFindingCodes (required)