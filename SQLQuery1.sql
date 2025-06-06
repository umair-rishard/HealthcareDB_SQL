-- 1. Create the Database
-- ============================================
CREATE DATABASE HealthcareDB;
GO

-- ============================================
-- 2. Use the Database
-- ============================================
USE HealthcareDB;
GO

-- ============================================
-- 3. Admin Table
-- ============================================
CREATE TABLE Admin (
    AdminID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Mail NVARCHAR(100) NOT NULL UNIQUE,
    Password NVARCHAR(100) NOT NULL
);
GO

INSERT INTO Admin (Name, Mail, Password) VALUES
('Dr. Shalini Rajapaksha', 'admin1@hospital.com', 'Admin@123'),
('Dr. Asela Perera', 'admin2@hospital.com', 'Admin@234'),
('Dr. Dilani Fernando', 'admin3@hospital.com', 'Admin@345'),
('Dr. Ravin Weerasinghe', 'admin4@hospital.com', 'Admin@456'),
('Dr. Kusal Jayasuriya', 'admin5@hospital.com', 'Admin@567'),
('Dr. Nirmala De Silva', 'admin6@hospital.com', 'Admin@678'),
('Dr. Harsha Gunasekara', 'admin7@hospital.com', 'Admin@789'),
('Dr. Ishara Ranasinghe', 'admin8@hospital.com', 'Admin@890'),
('Dr. Tharindu Jayawardena', 'admin9@hospital.com', 'Admin@901'),
('Dr. Menaka Alwis', 'admin10@hospital.com', 'Admin@012');
GO

-- ============================================
-- 4. Doctor Table
-- ============================================
CREATE TABLE Doctor (
    DoctorID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Specialization NVARCHAR(100),
    Contact NVARCHAR(20),
    AdminID INT,
    FOREIGN KEY (AdminID) REFERENCES Admin(AdminID)
);
GO

INSERT INTO Doctor (Name, Specialization, Contact, AdminID) VALUES
('Dr. Nadeesha Perera', 'Cardiology', '0771122334', 1),
('Dr. Amal Fernando', 'Neurology', '0772233445', 2),
('Dr. Suren Jayasena', 'Orthopedics', '0773344556', 3),
('Dr. Anjali Madushani', 'Pediatrics', '0774455667', 4),
('Dr. Vimukthi Ranasinghe', 'General Medicine', '0775566778', 5),
('Dr. Menaka Thilakarathna', 'Dermatology', '0776677889', 6),
('Dr. Ruwan Gamage', 'Psychiatry', '0777788990', 7),
('Dr. Chandima Alwis', 'Radiology', '0778899001', 8),
('Dr. Sanduni Silva', 'ENT', '0779900112', 9),
('Dr. Harsha Dissanayake', 'Ophthalmology', '0770011223', 10);
GO

-- ============================================
-- 5. Patient Table
-- ============================================
CREATE TABLE Patient (
    PatientID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    DOB DATE,
    Gender NVARCHAR(10),
    Contact NVARCHAR(20)
);
GO

INSERT INTO Patient (Name, DOB, Gender, Contact) VALUES
('Kavinda Perera', '2000-03-01', 'Male', '0711111111'),
('Shanika Fernando', '1999-06-15', 'Female', '0722222222'),
('Dilanka De Silva', '2001-01-20', 'Male', '0733333333'),
('Pasan Samarasinghe', '2000-12-05', 'Male', '0744444444'),
('Thilini Wijesinghe', '1998-11-23', 'Female', '0755555555'),
('Nuwan Herath', '1997-09-10', 'Male', '0766666666'),
('Sithara Jayasinghe', '2002-07-30', 'Female', '0777777777'),
('Nadeesh Rathnayake', '2003-04-18', 'Male', '0788888888'),
('Udara Gunawardena', '1996-05-09', 'Male', '0799999999'),
('Tharindu Abeysekara', '1995-02-14', 'Male', '0700000000');
GO

-- ============================================
-- 6. Create Appointment Table
-- ============================================
CREATE TABLE Appointment (
    AppointmentID INT PRIMARY KEY IDENTITY(1,1),
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    Date DATE NOT NULL,
    Time TIME NOT NULL,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID)
);
GO

-- Insert 10 Appointment Records
INSERT INTO Appointment (PatientID, DoctorID, Date, Time) VALUES
(1, 1, '2025-06-10', '09:00'),
(2, 2, '2025-06-11', '10:30'),
(3, 3, '2025-06-12', '11:15'),
(4, 4, '2025-06-13', '13:00'),
(5, 5, '2025-06-14', '14:30'),
(6, 6, '2025-06-15', '15:45'),
(7, 7, '2025-06-16', '09:30'),
(8, 8, '2025-06-17', '10:00'),
(9, 9, '2025-06-18', '11:00'),
(10, 10, '2025-06-19', '12:15');
GO

-- ============================================
-- 7. Create Prescription Table
-- ============================================
CREATE TABLE Prescription (
    PrescriptionID INT PRIMARY KEY IDENTITY(1,1),
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    AppointmentID INT NOT NULL,
    Date DATE NOT NULL,
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID),
    FOREIGN KEY (AppointmentID) REFERENCES Appointment(AppointmentID)
);
GO

-- Insert 10 Prescription Records
INSERT INTO Prescription (PatientID, DoctorID, AppointmentID, Date) VALUES
(1, 1, 1, '2025-06-10'),
(2, 2, 2, '2025-06-11'),
(3, 3, 3, '2025-06-12'),
(4, 4, 4, '2025-06-13'),
(5, 5, 5, '2025-06-14'),
(6, 6, 6, '2025-06-15'),
(7, 7, 7, '2025-06-16'),
(8, 8, 8, '2025-06-17'),
(9, 9, 9, '2025-06-18'),
(10, 10, 10, '2025-06-19');
GO

-- ============================================
-- 8. Create Medication Table
-- ============================================
CREATE TABLE Medication (
    MedicationID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Price DECIMAL(10,2) NOT NULL
);
GO

-- Insert 10 Medication Records
INSERT INTO Medication (Name, Price) VALUES
('Paracetamol', 25.00),
('Amoxicillin', 40.50),
('Metformin', 30.00),
('Lisinopril', 35.75),
('Atorvastatin', 45.00),
('Ibuprofen', 22.50),
('Omeprazole', 28.25),
('Amlodipine', 33.80),
('Losartan', 39.90),
('Cetrizine', 20.00);
GO

-- ============================================
-- 9. PrescriptionDetails Table
-- ============================================
CREATE TABLE PrescriptionDetails (
    PrescriptionID INT NOT NULL,
    MedicationID INT NOT NULL,
    Duration NVARCHAR(50),
    PRIMARY KEY (PrescriptionID, MedicationID),
    FOREIGN KEY (PrescriptionID) REFERENCES Prescription(PrescriptionID),
    FOREIGN KEY (MedicationID) REFERENCES Medication(MedicationID)
);
GO

-- Insert 10 PrescriptionDetails Records
INSERT INTO PrescriptionDetails (PrescriptionID, MedicationID, Duration) VALUES
(1, 1, '5 days'),
(2, 2, '7 days'),
(3, 3, '10 days'),
(4, 4, '3 days'),
(5, 5, '14 days'),
(6, 6, '5 days'),
(7, 7, '7 days'),
(8, 8, '10 days'),
(9, 9, '3 days'),
(10, 10, '14 days');
GO
