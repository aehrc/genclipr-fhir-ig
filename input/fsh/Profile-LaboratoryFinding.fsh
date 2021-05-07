Profile: LaboratoryFinding
Parent: Finding
Id: LaboratoryFinding
Title: "Laboratory Finding"
Description: "An observation based on the result of a laboratory test."
* category = FindingType#laboratory-finding
* interpretation MS
* interpretation from TestInterpretationValues (required)
* component ^slicing.discriminator.type = #pattern
* component ^slicing.discriminator.path = "code"
* component ^slicing.rules = #open
* component ^slicing.description = "Slice based on the component.code pattern"
* component contains percentage 0..1 MS
* component[percentage].code = SCT#258755000
* component[percentage].value[x] only Quantity
* component[percentage].valueQuantity.unit = "percentage"
* component[percentage].valueQuantity.system = UCUM
* component[percentage].valueQuantity.code = UCUM#%