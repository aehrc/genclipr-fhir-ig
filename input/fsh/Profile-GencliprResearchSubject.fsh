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