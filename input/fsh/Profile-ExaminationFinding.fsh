Profile: ExaminationFinding
Parent: Finding
Id: ExaminationFinding
Title: "Examination Finding"
Description: "An observation made by a clinician or patient that can be normal or abnormal."
* bodySite MS
* bodySite from BodySites (required)
* component ^slicing.discriminator.type = #pattern
* component ^slicing.discriminator.path = "code"
* component ^slicing.rules = #open
* component ^slicing.description = "Slice based on the component.code pattern"
* component contains laterality 0..1 MS
* component[laterality].code = SCT#272741003 // Laterality
* component[laterality].value[x] only CodeableConcept
* component[laterality].valueCodeableConcept from Lateralities (required)
* component[laterality].dataAbsentReason 0..0
* component[laterality].interpretation 0..0
* component[laterality].referenceRange 0..0
* component contains severity 0..1 MS
* component[severity].code = SCT#246112005 // Severity
* component[severity].value[x] only CodeableConcept
* component[severity].valueCodeableConcept from Severities (required)
* component[severity].dataAbsentReason 0..0
* component[severity].interpretation 0..0
* component[severity].referenceRange 0..0