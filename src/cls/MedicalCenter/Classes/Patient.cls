Class MedicalCenter.Patient Extends (MedicalCenter.Person, %Populate)
{

Property MedicalRecordNo As %String(MAXLEN = 50, POPSPEC = "String(10)") [ Required ];

Property BloodType As %String(MAXLEN = 5, POPSPEC = "ValueList("",A,B,AB,O"")");

Property Allergies As list Of %String(POPSPEC = "##class(MedicalCenter.PopUtils).Allergy()");

Property Medications As array Of %String(POPSPEC = "##class(MedicalCenter.PopUtils).Medication():##class(MedicalCenter.PopUtils).Dosage()");

Relationship PrimaryDoctor As MedicalCenter.Doctor [ Cardinality = one, Inverse = Patients ];

Relationship MedicalRecords As MedicalCenter.MedicalRecord [ Cardinality = children, Inverse = Patient ];

Index MedicalRecordNoIdx On MedicalRecordNo [ Unique ];

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
