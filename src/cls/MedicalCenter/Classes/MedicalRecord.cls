Class MedicalCenter.MedicalRecord Extends (%Persistent, %Populate)
{

Property RecordId As %String(MAXLEN = 50, POPSPEC = "String(10)") [ Required ];

Property VisitDate As %DateTime(POPSPEC = "TimeStamp()");

Property Diagnosis As %String(MAXLEN = 500, MINLEN = 5, POPSPEC = "##class(MedicalCenter.PopUtils).Diagnosis()");

Property Treatment As %String(MAXLEN = 1000, POPSPEC = "##class(MedicalCenter.PopUtils).Treatment()");

Property TestResults As list Of %String;

Property DetailedNotes As %Stream.GlobalCharacter;

Relationship Patient As MedicalCenter.Patient [ Cardinality = parent, Inverse = MedicalRecords ];

Property AttendingDoctor As MedicalCenter.Doctor;

Index RecordIdIdx On RecordId [ Unique ];

Storage Default
{
<Data name="MedicalRecordDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>RecordId</Value>
</Value>
<Value name="3">
<Value>VisitDate</Value>
</Value>
<Value name="4">
<Value>Diagnosis</Value>
</Value>
<Value name="5">
<Value>Treatment</Value>
</Value>
<Value name="6">
<Value>TestResults</Value>
</Value>
<Value name="7">
<Value>DetailedNotes</Value>
</Value>
<Value name="8">
<Value>AttendingDoctor</Value>
</Value>
</Data>
<DataLocation>{%%PARENT}("MedicalCenter.Patient.MedicalRecords")</DataLocation>
<DefaultData>MedicalRecordDefaultData</DefaultData>
<IdLocation>^MedicalCenter.PatientC("MedicalRecords")</IdLocation>
<IndexLocation>^MedicalCenter.MedicalRecordI</IndexLocation>
<StreamLocation>^MedicalCenter.MedicalRecordS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
