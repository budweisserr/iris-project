Class MedicalCenter.PopUtils
{

/* --- Person Data --- */
ClassMethod FirstName() As %String
{
    Set data = $ListBuild("James", "Mary", "John", "Patricia", "Robert", "Jennifer", "Michael", "Linda", "William", "Elizabeth")
    Quit $List(data, $Random($ListLength(data)) + 1)
}

ClassMethod LastName() As %String
{
    Set data = $ListBuild("Smith", "Johnson", "Williams", "Brown", "Jones", "Garcia", "Miller", "Davis", "Rodriguez", "Martinez")
    Quit $List(data, $Random($ListLength(data)) + 1)
}

/* --- Address Data --- */
ClassMethod Street() As %String
{
    Set data = $ListBuild("Main St", "High St", "Park Ave", "Maple Dr", "Oak Ln", "Cedar Rd", "Pine St", "Washington Blvd")
    // Generate a random number 1-999 to add to the street
    Quit ($Random(999)+1) _ " " _ $List(data, $Random($ListLength(data)) + 1)
}

ClassMethod City() As %String
{
    Set data = $ListBuild("New York", "Los Angeles", "Chicago", "Houston", "Phoenix", "Philadelphia", "San Antonio", "San Diego")
    Quit $List(data, $Random($ListLength(data)) + 1)
}

ClassMethod State() As %String
{
    Set data = $ListBuild("NY", "CA", "IL", "TX", "AZ", "PA", "TX", "CA")
    Quit $List(data, $Random($ListLength(data)) + 1)
}

ClassMethod Zip() As %String
{
    // Simple random 5-digit zip
    Quit 10000 + $Random(89999)
}

/* --- Patient Data --- */
ClassMethod Allergy() As %String
{
    Set data = $ListBuild("Peanuts", "Pollen", "Penicillin", "Dust Mites", "Latex", "Shellfish", "Milk", "Soy")
    Quit $List(data, $Random($ListLength(data)) + 1)
}

ClassMethod Medication() As %String
{
    Set data = $ListBuild("Aspirin", "Ibuprofen", "Paracetamol", "Amoxicillin", "Lisinopril", "Metformin")
    Quit $List(data, $Random($ListLength(data)) + 1)
}

ClassMethod Dosage() As %String
{
    Set data = $ListBuild("10mg", "20mg", "50mg", "100mg", "500mg", "5ml")
    Quit $List(data, $Random($ListLength(data)) + 1)
}

/* --- Doctor Data --- */
ClassMethod Specialization() As %String
{
    Set data = $ListBuild("Cardiology", "Neurology", "Pediatrics", "Oncology", "Dermatology", "Surgery", "General Practice")
    Quit $List(data, $Random($ListLength(data)) + 1)
}

ClassMethod Certification() As %String
{
    Set data = $ListBuild("Board Certified", "ACL Support", "PALS", "BLS", "Trauma Care", "Internal Medicine")
    Quit $List(data, $Random($ListLength(data)) + 1)
}

/* --- Department Data --- */
ClassMethod DeptName() As %String
{
    Set data = $ListBuild("Emergency", "ICU", "Radiology", "Pathology", "Outpatient", "Surgery Center", "Maternity")
    Quit $List(data, $Random($ListLength(data)) + 1)
}

/* --- Medical Record Data --- */
ClassMethod Diagnosis() As %String
{
    Set data = $ListBuild("Hypertension", "Diabetes Type 2", "Acute Bronchitis", "Migraine", "Influenza", "Fracture")
    Quit $List(data, $Random($ListLength(data)) + 1)
}

ClassMethod Treatment() As %String
{
    Set data = $ListBuild("Rest and fluids", "Physical Therapy", "Antibiotics", "Dietary changes", "Surgery", "Observation")
    Quit $List(data, $Random($ListLength(data)) + 1)
}

/* --- Appointment Data --- */
ClassMethod ApptStatus() As %String
{
    Set data = $ListBuild("Scheduled", "Confirmed", "Completed", "Cancelled", "No Show")
    Quit $List(data, $Random($ListLength(data)) + 1)
}

}
