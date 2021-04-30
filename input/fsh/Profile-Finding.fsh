// See https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3041577/ for a discussion on these definitions
Profile: Finding
Parent: Observation
Id: Finding
Title: "Finding"
Description: "An observation about a patient that can be normal or abnormal and is expressed in a way that its action is reduced to a single concept (see pattern 3 in http://hl7.org/fhir/R4/observation.html#code-interop)."
* category MS
* category 1..*
* code from AbnormalClinicalFindings (required)
* subject 1..1
* subject only Reference(DeidentifiedPatient)
* effective[x] only dateTime or Period
* effective[x] MS
* encounter 1..1
* encounter only Reference(GencliprEncounter)
* value[x] from PresenceValues (required)
* focus 0..0
* interpretation 0..0
* referenceRange 0..0
* hasMember 0..0