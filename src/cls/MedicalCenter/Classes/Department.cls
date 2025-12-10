Class MedicalCenter.Department Extends (%Persistent, %Populate)
{

Property DeptId As %String(MAXLEN = 50, POPSPEC = "String(5)") [ Required ];

Property Name As %String(MAXLEN = 100, MINLEN = 3, POPSPEC = "##class(MedicalCenter.PopUtils).DeptName()");

Property Capacity As %Integer(MAXVAL = 500, MINVAL = 1, POPSPEC = "Integer(10,500)");

Property HeadDoctor As MedicalCenter.Doctor;

Relationship Doctors As MedicalCenter.Doctor [ Cardinality = many, Inverse = Department ];

Index DeptIdKey On DeptId [ IdKey ];

Query FindByCapacity(minCap As %Integer = 10) As %SQLQuery
{
    SELECT Name, Capacity, HeadDoctor->LastName As HeadDoctorName
    FROM MedicalCenter.Department
    WHERE Capacity >= :minCap
}

Storage Default
{
<Data name="DepartmentDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
<Value name="3">
<Value>Capacity</Value>
</Value>
<Value name="4">
<Value>HeadDoctor</Value>
</Value>
</Data>
<DataLocation>^MedicalCenter.DepartmentD</DataLocation>
<DefaultData>DepartmentDefaultData</DefaultData>
<IdLocation>^MedicalCenter.DepartmentD</IdLocation>
<IndexLocation>^MedicalCenter.DepartmentI</IndexLocation>
<StreamLocation>^MedicalCenter.DepartmentS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
