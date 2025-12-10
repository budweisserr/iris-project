Class MedicalCenter.Person Extends (%Persistent, %Populate) [ Abstract ]
{

Property PersonId As %String(MAXLEN = 50, POPSPEC = "String(10)") [ Required ];

Property FirstName As %String(MAXLEN = 50, MINLEN = 2, POPSPEC = "##class(MedicalCenter.PopUtils).FirstName()");

Property LastName As %String(MAXLEN = 50, MINLEN = 2, POPSPEC = "##class(MedicalCenter.PopUtils).LastName()");

Property DateOfBirth As %Date(POPSPEC = "Date(1950,2023)");

Property Address As MedicalCenter.Address;

Property Age As %Integer [ Transient ];

Method AgeGet() As %Integer
{
    If (..DateOfBirth = "") Quit ""
    Quit ($Horolog - ..DateOfBirth) \ 365.25
}

Index PersonIdKey On PersonId [ IdKey ];

Query ByName(name As %String) As %SQLQuery(CONTAINID = 1)
{
    SELECT %ID, FirstName, LastName, DateOfBirth 
    FROM MedicalCenter.Person 
    WHERE LastName %STARTSWITH :name
    ORDER BY LastName
}

Storage Default
{
<Data name="PersonDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>FirstName</Value>
</Value>
<Value name="3">
<Value>LastName</Value>
</Value>
<Value name="4">
<Value>DateOfBirth</Value>
</Value>
<Value name="5">
<Value>Address</Value>
</Value>
</Data>
<DataLocation>^MedicalCenter.PersonD</DataLocation>
<DefaultData>PersonDefaultData</DefaultData>
<IdLocation>^MedicalCenter.PersonD</IdLocation>
<IndexLocation>^MedicalCenter.PersonI</IndexLocation>
<StreamLocation>^MedicalCenter.PersonS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
