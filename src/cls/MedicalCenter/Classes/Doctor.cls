Class MedicalCenter.Doctor Extends (MedicalCenter.Person, %Populate)
{

Property LicenseNo As %String(MAXLEN = 50, POPSPEC = "String(8)") [ Required ];

Property Specialization As %String(MAXLEN = 100, POPSPEC = "##class(MedicalCenter.PopUtils).Specialization()");

Property Experience As %Integer(MAXVAL = 60, MINVAL = 0, POPSPEC = "Integer(1,40)");

Property Certifications As list Of %String(POPSPEC = "##class(MedicalCenter.PopUtils).Certification():2");

Property License As %Stream.FileBinary;

Relationship Department As MedicalCenter.Department [ Cardinality = one, Inverse = Doctors ];

Relationship Patients As MedicalCenter.Patient [ Cardinality = many, Inverse = PrimaryDoctor ];

Index LicenseNoIdx On LicenseNo [ Unique ];

Query BySpecialization(spec As %String) As %SQLQuery
{
    SELECT LastName, FirstName, Department->Name As DeptName
    FROM MedicalCenter.Doctor
    WHERE Specialization = :spec
}

Storage Default
{
<Data name="DoctorDefaultData">
<Subscript>"Doctor"</Subscript>
<Value name="1">
<Value>LicenseNo</Value>
</Value>
<Value name="2">
<Value>Specialization</Value>
</Value>
<Value name="3">
<Value>Experience</Value>
</Value>
<Value name="4">
<Value>Certifications</Value>
</Value>
<Value name="5">
<Value>License</Value>
</Value>
<Value name="6">
<Value>Department</Value>
</Value>
</Data>
<DefaultData>DoctorDefaultData</DefaultData>
<Type>%Storage.Persistent</Type>
}

}
