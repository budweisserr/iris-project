Class MedicalCenter.Appointment Extends (%Persistent, %Populate)
{

Property ApptId As %String(MAXLEN = 50, POPSPEC = "String(10)") [ Required ];

Property DateTime As %DateTime(POPSPEC = "TimeStamp()");

Property Duration As %Integer(MAXVAL = 480, MINVAL = 15, POPSPEC = "Integer(15,60)");

Property Status As %String(MAXLEN = 20, POPSPEC = "##class(MedicalCenter.PopUtils).ApptStatus()");

Property Notes As %Stream.GlobalCharacter;

Property Patient As MedicalCenter.Patient;

Property Doctor As MedicalCenter.Doctor;

Index ApptIdKey On ApptId [ IdKey ];

Query Upcoming() As %SQLQuery
{
    SELECT ApptId, DateTime, Patient->LastName, Doctor->LastName
    FROM MedicalCenter.Appointment
    WHERE DateTime > CURRENT_TIMESTAMP
    ORDER BY DateTime
}

Storage Default
{
<Data name="AppointmentDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>DateTime</Value>
</Value>
<Value name="3">
<Value>Duration</Value>
</Value>
<Value name="4">
<Value>Status</Value>
</Value>
<Value name="5">
<Value>Notes</Value>
</Value>
<Value name="6">
<Value>Patient</Value>
</Value>
<Value name="7">
<Value>Doctor</Value>
</Value>
</Data>
<DataLocation>^MedicalCenter.AppointmentD</DataLocation>
<DefaultData>AppointmentDefaultData</DefaultData>
<IdLocation>^MedicalCenter.AppointmentD</IdLocation>
<IndexLocation>^MedicalCenter.AppointmentI</IndexLocation>
<StreamLocation>^MedicalCenter.AppointmentS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
