Profile: GencliprEncounter
Parent: Encounter
Id: GencliprEncounter
Title: "Genomics Clinical Picture Repository Encounter"
Description: "An encounter stored in the repository."
* extension contains RESEARCHSTUDY named researchStudy 0..1 MS
* extension contains ASSOCENCOUNTER named associatedEncounter 0..1 MS
* subject 1..1
* subject only Reference(DeidentifiedPatient)
* class from EncounterClasses (required)
* type MS
* type from EncounterTypes (example)
// might need to say something about diagnosis
* participant 0..0
* appointment 0..0
* account 0..0
* hospitalization 0..0
* location 0..0