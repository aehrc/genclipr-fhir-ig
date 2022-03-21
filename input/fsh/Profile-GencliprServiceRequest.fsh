Profile: GencliprServiceRequest
Parent: ServiceRequest
Id: GencliprServiceRequest
Title: "Genomics Clinical Picture Repository Service Request"
Description: "Captues information about the genomic testing requested for a patient."
* code from GenomicTestTypes (required)
* subject 1..1
* subject only Reference(DeidentifiedPatient)
* encounter 1..1
* encounter only Reference(GencliprEncounter)