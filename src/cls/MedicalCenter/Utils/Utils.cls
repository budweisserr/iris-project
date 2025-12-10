Class MedicalCenter.Utils
{

/// Do ##class(MedicalCenter.Utils).GenerateAll(10)
ClassMethod GenerateAll(pCount As %Integer = 10) As %Status
{
    Set sc = $$$OK
    Try {
        Write "Starting Data Generation...",!

        Write "Populating Departments... "
        Set count = ##class(MedicalCenter.Department).Populate(pCount)
        Write count_" created.",!

        Write "Populating Doctors... "
        Set count = ##class(MedicalCenter.Doctor).Populate(pCount)
        Write count_" created.",!

        Write "Populating Patients... "
        Set count = ##class(MedicalCenter.Patient).Populate(pCount)
        Write count_" created.",!

        Write "Populating Medical Records... "
        Set count = ##class(MedicalCenter.MedicalRecord).Populate(pCount)
        Write count_" created.",!

        Write "Populating Appointments... "
        Set count = ##class(MedicalCenter.Appointment).Populate(pCount)
        Write count_" created.",!

        Write "Data Generation Complete.",!
        
    } Catch ex {
        Set sc = ex.AsStatus()
        Write "Error during generation: ", $System.Status.GetErrorText(sc),!
    }
    Quit sc
}

ClassMethod ClearAll() As %Status
{
    Set sc = $$$OK
    Try {
        Write "Deleting all data...",!
        
        Do ##class(MedicalCenter.Appointment).%KillExtent()
        Do ##class(MedicalCenter.MedicalRecord).%KillExtent()
        Do ##class(MedicalCenter.Patient).%KillExtent()
        Do ##class(MedicalCenter.Doctor).%KillExtent()
        Do ##class(MedicalCenter.Department).%KillExtent()
        Do ##class(MedicalCenter.Person).%KillExtent()
        
        Write "All data deleted.",!
    } Catch ex {
        Set sc = ex.AsStatus()
    }
    Quit sc
}

// lab 7

ClassMethod DemoDynamicSQL(minExp As %Integer)
{
    Write !, "Dynamic SQL: Doctors with Experience > ", minExp, !
    Set sql = "SELECT PersonId, FirstName, LastName, Specialization FROM MedicalCenter.Doctor WHERE Experience > ?"
    
    Set stmt = ##class(%SQL.Statement).%New()
    Set status = stmt.%Prepare(sql)
    
    If $$$ISERR(status) {
        Do $System.Status.DisplayError(status)
        Quit
    }
    
    Set rset = stmt.%Execute(minExp)
    
    While rset.%Next() {
        Write "ID: ", rset.%Get("PersonId"), " | ", rset.%Get("FirstName"), " ", rset.%Get("LastName"), " (", rset.%Get("Specialization"), ")", !
    }
}

ClassMethod DemoEmbeddedSimple(docLicense As %String)
{
    Write !, "Embedded SQL", !
    New SQLCODE, count, docName
    
    &sql(SELECT Count(*), PrimaryDoctor->LastName 
         INTO :count, :docName
         FROM MedicalCenter.Patient
         WHERE PrimaryDoctor->LicenseNo = :docLicense)
         
    If SQLCODE = 0 {
        Write "Doctor ", docName, " has ", count, " assigned patients.", !
    } Else {
        Write "Error or No Data. SQLCODE: ", SQLCODE, !
    }
}

ClassMethod DemoEmbeddedCursor(statusStr As %String)
{
    Write !, "Embedded SQL (Cursor) for status: ", statusStr, !
    New SQLCODE, patName, docName, apptDate
    
    &sql(DECLARE ApptCursor CURSOR FOR 
         SELECT DateTime, Patient->LastName, Doctor->LastName
         INTO :apptDate, :patName, :docName
         FROM MedicalCenter.Appointment
         WHERE Status = :statusStr)
         
    &sql(OPEN ApptCursor)
    
    For {
        &sql(FETCH ApptCursor)
        Quit:(SQLCODE '= 0)
        
        Write "Date: ", apptDate, " | Patient: ", patName, " | Doctor: ", docName, !
    }
    
    &sql(CLOSE ApptCursor)
    Write "End of Cursor data.", !
}

ClassMethod TestTrigger(patientId As %String)
{
    Write !, "Testing Trigger", !
    Set pat = ##class(MedicalCenter.Patient).%OpenId(patientId)
    If '$IsObject(pat) Write "Patient not found.",! Quit
    
    Write "Current BloodType: ", pat.BloodType, !
    
    // Change data to trigger update
    Set pat.BloodType = $Case(pat.BloodType, "A":"B", "B":"O", "O":"AB", :"A")
    Set sc = pat.%Save()
    
    If $$$ISOK(sc) {
        Write "Patient saved. Checking Log...", !
        
        // Initialize val to avoid UNDEFINED error
        Set val = ""
        Set logTime = $Order(^PatientLog(patientId, ""), -1, val)
        
        If (logTime = "") {
             Write "NO LOG FOUND. The trigger did not fire or write data.", !
        } Else {
             Write "Log Entry [", $ZDateTime(logTime), "]: ", val, !
        }
    } Else {
        Do $System.Status.DisplayError(sc)
    }
}

ClassMethod TestCOSQuery()
{
    Write "Testing COS Query",!
    
    Set stmt = ##class(%SQL.Statement).%New()
    
    Set status = stmt.%PrepareClassQuery("MedicalCenter.Patient", "AllPatients")
    If $$$ISERR(status) Do $System.Status.DisplayError(status) Quit
    
    Set rset = stmt.%Execute()
    
    While rset.%Next() {
        Write "ID: ", rset.%Get("ID"), " | Name: ", rset.%Get("FullName"), " | Age: ", rset.%Get("Age"),!
    }
}

ClassMethod TestAgeProperty(patientId As %String)
{
    Set pat = ##class(MedicalCenter.Patient).%OpenId(patientId)
    If '$IsObject(pat) Write "Patient not found",! Quit
    
    Write "Patient: ", pat.LastName, !
    Write "Calculated Age: ", pat.Age, !
}

}
