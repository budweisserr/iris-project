Class MedicalCenter.Tests.RelationshipTest Extends %UnitTest.TestCase
{

Method TestParentChildConnection()
{

    Set pat = ##class(MedicalCenter.Patient).%New()
    Set pat.PersonId = "REL_TEST_P1"
    Set pat.MedicalRecordNo = "MRN_REL_P1"
    Set pat.FirstName = "Parent"
    Set pat.LastName = "Tester"
    
    Set pat.DateOfBirth = +$Horolog
    
    Set rec = ##class(MedicalCenter.MedicalRecord).%New()
    Set rec.RecordId = "REC_REL_C1"
   
    Set rec.VisitDate = $ZDateTime($Horolog, 3)
    
    Set rec.Diagnosis = "Test Diagnosis"
    
    Do pat.MedicalRecords.Insert(rec)
    
    Set sc = pat.%Save()
    Do $$$AssertStatusOK(sc, "Parent (and Child) saved successfully")
    
    If $$$ISERR(sc) Quit
    
    Set patId = pat.%Id()
    Set recId = rec.%Id() 
    
    Set loadedRec = ##class(MedicalCenter.MedicalRecord).%OpenId(recId)
    
    If $$$AssertTrue($IsObject(loadedRec), "Child record retrieved") {
        Do $$$AssertEquals(loadedRec.Patient.%Id(), patId, "Child should point back to Parent correctly")
    }
    
    Set loadedPat = ##class(MedicalCenter.Patient).%OpenId(patId)
    If $$$AssertTrue($IsObject(loadedPat), "Parent record retrieved") {
        Do $$$AssertEquals(loadedPat.MedicalRecords.Count(), 1, "Parent should have exactly 1 child record")
        Do $$$AssertEquals(loadedPat.MedicalRecords.GetAt(1).RecordId, "REC_REL_C1", "Parent's child record should match")
    }
    
    Do ##class(MedicalCenter.Patient).%KillExtent()
}

Method TestCascadeDelete()
{
    Set pat = ##class(MedicalCenter.Patient).%New()
    Set pat.PersonId = "REL_DEL_P1"
    Set pat.MedicalRecordNo = "MRN_DEL_P1"
    Set pat.FirstName = "Delete"
    Set pat.LastName = "Target"
    Set pat.DateOfBirth = +$Horolog
    
    Set rec1 = ##class(MedicalCenter.MedicalRecord).%New()
    Set rec1.RecordId = "REC_DEL_C1"

    Set rec1.VisitDate = $ZDateTime($Horolog, 3) 
    Do pat.MedicalRecords.Insert(rec1)
    
    Set rec2 = ##class(MedicalCenter.MedicalRecord).%New()
    Set rec2.RecordId = "REC_DEL_C2"
   
    Set rec2.VisitDate = $ZDateTime($Horolog, 3)
    Do pat.MedicalRecords.Insert(rec2)
    
    Set sc = pat.%Save()
    Do $$$AssertStatusOK(sc, "Parent with 2 children saved")
    
    If $$$ISERR(sc) Quit
    
    Set patId = pat.%Id()
    Set rec1Id = rec1.%Id()
    Set rec2Id = rec2.%Id()
    
    Set sc = ##class(MedicalCenter.Patient).%DeleteId(patId)
    Do $$$AssertStatusOK(sc, "Parent deletion executed")
    
    Do $$$AssertNotTrue(##class(MedicalCenter.Patient).%ExistsId(patId), "Parent should no longer exist")
    
    Do $$$AssertNotTrue(##class(MedicalCenter.MedicalRecord).%ExistsId(rec1Id), "Child 1 should be deleted")
    Do $$$AssertNotTrue(##class(MedicalCenter.MedicalRecord).%ExistsId(rec2Id), "Child 2 should be deleted")
}

}
