Class MedicalCenter.Department Extends (%Persistent, %Populate)
{

Property DeptId As %String(MAXLEN = 50, POPSPEC = "String(5)") [ Required ];

Property Name As %String(MAXLEN = 100, MINLEN = 3, POPSPEC = "##class(MedicalCenter.PopUtils).DeptName()");

Property Capacity As %Integer(MAXVAL = 500, MINVAL = 1, POPSPEC = "Integer(10,500)");

Property HeadDoctor As MedicalCenter.Doctor;

Relationship Doctors As MedicalCenter.Doctor [ Cardinality = many, Inverse = Department ];

Index DeptIdIdx On DeptId [ Unique ];

Storage Default
{
<Data name="DepartmentDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>DeptId</Value>
</Value>
<Value name="3">
<Value>Name</Value>
</Value>
<Value name="4">
<Value>Capacity</Value>
</Value>
<Value name="5">
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
