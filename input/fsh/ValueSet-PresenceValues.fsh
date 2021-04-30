// Follows recommendations in pattern 3 (see http://hl7.org/fhir/R4/observation.html#code-interop)
// but narrows options to just present and absent
ValueSet: PresenceValues
Title: "Presence Value Set"
Description: "Presence / absence values from SNOMED CT."
* SCT#52101004 "Present"
* SCT#2667000 "Absent"
* SCT#385660001 "Not done"
* SCT#373068000 "Undetermined"