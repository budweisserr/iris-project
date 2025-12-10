Class MedicalCenter.Tests.PatientTest Extends %UnitTest.TestCase
{

Method TestPatientPopulation()
{
    Set count = ##class(MedicalCenter.Patient).Populate(1)
    Do $$$AssertEquals(count, 1, "Should successfully generate 1 patient")
    
    Set id = $Order(^MedicalCenter.PersonD(""), -1)
    Do $$$AssertNotEquals(id, "", "Patient ID should not be empty")

    Set obj = ##class(MedicalCenter.Patient).%OpenId(id)
    Do $$$AssertTrue($IsObject(obj), "Patient object should open successfully")
    
    Set listCount = obj.Allergies.Count()
    Do $$$AssertTrue(listCount > 0, "Allergies list should not be empty")
    
    Set allergy1 = obj.Allergies.GetAt(1)
    Do $$$AssertNotEquals(allergy1, "", "First allergy should not be empty")
    Do $$$LogMessage("Verified Allergy: " _ allergy1)

    Set arrayCount = obj.Medications.Count()
    Do $$$AssertTrue(arrayCount > 0, "Medications array should contain data")
    
    Set key = ""
    Set val = obj.Medications.GetNext(.key)
    Do $$$AssertNotEquals(val, "", "Medication value should be present")
    Do $$$AssertNotEquals(key, "", "Medication key (Dosage) should be present")
    Do $$$LogMessage("Verified Medication: " _ val _ " (Dosage: " _ key _ ")")

    Do $$$AssertNotEquals(obj.FirstName, "", "FirstName should be populated")
    Do $$$AssertNotEquals(obj.LastName, "", "LastName should be populated")
    Do $$$LogMessage("Verified Name: " _ obj.FirstName _ " " _ obj.LastName)

    Do $$$AssertTrue($IsObject(obj.Address), "Address object should be present")
    Do $$$AssertNotEquals(obj.Address.Street, "", "Street should be populated")
    Do $$$AssertNotEquals(obj.Address.City, "", "City should be populated")
    Do $$$AssertNotEquals(obj.Address.ZipCode, "", "ZipCode should be populated")
    Do $$$LogMessage("Verified Address: " _ obj.Address.Street _ ", " _ obj.Address.City)

    Do ##class(MedicalCenter.Patient).%KillExtent()
}

}
