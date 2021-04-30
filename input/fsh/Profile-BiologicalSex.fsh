Profile: BiologicalSex
Parent: Observation
Id: BiologicalSex
Title: "Biological Sex"
Description: "An observation that represents the biological sex of a patient."
* code = SCT#429019009 // Finding related to biological sex
* value[x] only CodeableConcept 
* valueCodeableConcept from BiologicalSexes (required)
* subject 1..1
* subject only Reference(DeidentifiedPatient)
* component 0..0