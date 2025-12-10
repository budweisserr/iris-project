Class MedicalCenter.Address Extends (%SerialObject, %Populate)
{

Property Street As %String(POPSPEC = "##class(MedicalCenter.PopUtils).Street()");

Property City As %String(POPSPEC = "##class(MedicalCenter.PopUtils).City()");

Property State As %String(POPSPEC = "##class(MedicalCenter.PopUtils).State()");

Property ZipCode As %String(MAXLEN = 10, MINLEN = 5, POPSPEC = "##class(MedicalCenter.PopUtils).Zip()");

Storage Default
{
<Data name="AddressState">
<Value name="1">
<Value>Street</Value>
</Value>
<Value name="2">
<Value>City</Value>
</Value>
<Value name="3">
<Value>State</Value>
</Value>
<Value name="4">
<Value>ZipCode</Value>
</Value>
</Data>
<State>AddressState</State>
<StreamLocation>^MedicalCenter.AddressS</StreamLocation>
<Type>%Storage.Serial</Type>
}

}
