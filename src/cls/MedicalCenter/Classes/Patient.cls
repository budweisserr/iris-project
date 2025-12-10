Class MedicalCenter.Patient Extends (MedicalCenter.Person, %Populate)
{

Property MedicalRecordNo As %String(MAXLEN = 50, POPSPEC = "String(10)") [ Required ];

Property BloodType As %String(MAXLEN = 5, POPSPEC = "ValueList("",A,B,AB,O"")");

Property Allergies As list Of %String(POPSPEC = "##class(MedicalCenter.PopUtils).Allergy()");

Property Medications As array Of %String(POPSPEC = "##class(MedicalCenter.PopUtils).Medication():##class(MedicalCenter.PopUtils).Dosage()");

Relationship PrimaryDoctor As MedicalCenter.Doctor [ Cardinality = one, Inverse = Patients ];

Relationship MedicalRecords As MedicalCenter.MedicalRecord [ Cardinality = children, Inverse = Patient ];

Index MedicalRecordNoIdx On MedicalRecordNo [ Unique ];

/// TRIGGER: Logs updates to ^PatientLog
Trigger LogPatientUpdate [ Event = UPDATE, Foreach = row/object, Language = objectscript, Time = AFTER ]
{
    // Ensure we use the IDKEY (PersonId)
    New id, info
    Set id = {PersonId}
    Set info = "Updated info for " _ {LastName}
    
    // Write to global
    Set ^PatientLog(id, $Horolog) = info
}

/// COS-based Query: Returns all patients
Query AllPatients() As %Query(ROWSPEC = "ID:%String,FullName:%String,Age:%Integer") [ SqlProc ]
{
}

ClassMethod AllPatientsExecute(ByRef qHandle As %Binary) As %Status
{
    Set qHandle = "" 
    Quit $$$OK
}

ClassMethod AllPatientsFetch(ByRef qHandle As %Binary, ByRef Row As %List, ByRef AtEnd As %Integer = 0) As %Status
{
    Set id = $Order(^MedicalCenter.PersonD(qHandle))
    If id = "" {
        Set AtEnd = 1
        Set Row = ""
        Quit $$$OK
    }
    
    Set qHandle = id

    Set obj = ##class(MedicalCenter.Patient).%OpenId(id)
    If '$IsObject(obj) {
        // Skip if not patient (recursive call to fetch next)
        Quit ..AllPatientsFetch(.qHandle, .Row, .AtEnd)
    }
    
    Set Row = $ListBuild(id, obj.FirstName_" "_obj.LastName, obj.Age)
    Quit $$$OK
}

ClassMethod AllPatientsClose(ByRef qHandle As %Binary) As %Status
{
    Kill qHandle
    Quit $$$OK
}

Storage Default
{
<Data name="Medications">
<Attribute>Medications</Attribute>
<Structure>subnode</Structure>
<Subscript>"MedicalCenter.Patient.Medications"</Subscript>
</Data>
<Data name="PatientDefaultData">
<Subscript>"Patient"</Subscript>
<Value name="1">
<Value>MedicalRecordNo</Value>
</Value>
<Value name="2">
<Value>BloodType</Value>
</Value>
<Value name="3">
<Value>Allergies</Value>
</Value>
<Value name="4">
<Value>PrimaryDoctor</Value>
</Value>
</Data>
<DefaultData>PatientDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
