-- Query 1: List all appointments with patient and doctor names (JOIN + SORT)
SELECT 
    A.AppointmentID,
    P.Name AS PatientName,
    D.Name AS DoctorName,
    A.Date,
    A.Time
FROM dbo.Appointment A
JOIN dbo.Patient P ON A.PatientID = P.PatientID
JOIN dbo.Doctor D ON A.DoctorID = D.DoctorID
ORDER BY A.Date, A.Time;


-- Query 2: List of female patients born after 2000 (FILTERING)
SELECT 
    PatientID,
    Name,
    DOB,
    Gender,
    Contact
FROM dbo.Patient
WHERE Gender = 'Female'
  AND DOB > '2000-01-01';


-- Query 3: Total number of appointments per doctor (AGGREGATION)
SELECT 
    D.Name AS DoctorName,
    COUNT(A.AppointmentID) AS TotalAppointments
FROM dbo.Doctor D
LEFT JOIN dbo.Appointment A ON D.DoctorID = A.DoctorID
GROUP BY D.Name
ORDER BY TotalAppointments DESC;


-- Query 4: List of medications sorted by price (SORTING)
SELECT 
    MedicationID,
    Name AS MedicationName,
    Price
FROM dbo.Medication
ORDER BY Price DESC;


-- Query 5: Number of times each medication was prescribed (JOIN + AGGREGATION)
SELECT 
    M.Name AS MedicationName,
    COUNT(PD.PrescriptionID) AS TimesPrescribed
FROM dbo.Medication M
LEFT JOIN dbo.PrescriptionDetails PD ON M.MedicationID = PD.MedicationID
GROUP BY M.Name
ORDER BY TimesPrescribed DESC;



-- Transaction: Insert prescription and related medication safely
BEGIN TRANSACTION;

BEGIN TRY
    -- Insert a new unique prescription (change values)
    INSERT INTO dbo.Prescription (PatientID, DoctorID, AppointmentID, Date)
    VALUES (2, 2, 2, GETDATE());

    -- Get new PrescriptionID
    DECLARE @PrescID INT = SCOPE_IDENTITY();

    -- Add medication log
    INSERT INTO dbo.PrescriptionDetails (PrescriptionID, MedicationID, Duration)
    VALUES (@PrescID, 2, '10 days');

    COMMIT TRANSACTION;
    PRINT 'Transaction successful. Data committed.';
END TRY

BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'Error occurred. Transaction rolled back.';
END CATCH;

