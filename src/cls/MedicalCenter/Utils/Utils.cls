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

}
