// EXTENSIONS
Extension: ResearchStudyReference
Id: ResearchStudyReference
Title: "Research Study"
Description: "A research study associated with an encounter."
* ^context.type = #element
* ^context.expression =  "Encounter"
* value[x] only Reference(GencliprResearchStudy)