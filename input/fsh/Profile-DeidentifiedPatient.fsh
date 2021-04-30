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