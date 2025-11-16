USE lab3;

-- ️Patient
INSERT INTO Patient VALUES
(1, 'CIN1001', 'Sara El Amrani', '1995-06-21', 'F', 'A+', '0612345678'),
(2, 'CIN1002', 'Omar Bennani', '1988-09-15', 'M', 'O-', '0623456789'),
(3, 'CIN1003', 'Youssef Khadir', '2000-01-10', 'M', 'B+', '0634567890'),
(4, 'CIN1004', 'Lina Berrada', '1993-11-05', 'F', 'AB-', '0645678901'),
(5, 'CIN1005', 'Amine Fassi', '1998-04-20', 'M', 'A-', '0656789012');

-- Hospital
INSERT INTO Hospital VALUES
(1, 'CHU Rabat', 'Rabat', 'Rabat-Salé'),
(2, 'CHU Casablanca', 'Casablanca', 'Casablanca-Settat'),
(3, 'CHU Marrakech', 'Marrakech', 'Marrakech-Safi'),
(4, 'CHU Fès', 'Fès', 'Fès-Meknès'),
(5, 'CHU Agadir', 'Agadir', 'Souss-Massa');

-- Department
INSERT INTO Department VALUES
(1, 1, 'Cardiology', 'Heart Diseases'),
(2, 1, 'Neurology', 'Brain and Nerves'),
(3, 2, 'Pediatrics', 'Child Health'),
(4, 3, 'Surgery', 'General Surgery'),
(5, 4, 'Radiology', 'Imaging');

-- Staff
INSERT INTO Staff VALUES
(1, 'Dr. Hicham El Idrissi', 'Active'),
(2, 'Dr. Salma Tazi', 'Active'),
(3, 'Nurse Rania Lahlou', 'Active'),
(4, 'Technician Yassine Kabbaj', 'Retired'),
(5, 'Dr. Mehdi Rahali', 'Active');

-- Work_in
INSERT INTO Work_in VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(4, 5),
(5, 5);

-- ClinicalActivity
INSERT INTO ClinicalActivity VALUES
(1, 1, 1, 1, '2025-10-10', '10:00:00'),
(2, 2, 2, 2, '2025-10-30', '11:45:00'),
(3, 3, 3, 3, '2025-09-05', '15:00:00'),
(4, 4, 4, 4, '2025-09-22', '12:15:00'),
(5, 5, 4, 5, '2026-01-30', '11:45:00'),
(6, 1, 1, 1,'2025-11-11', '11:45:00'),
(7, 2, 2, 2, '2025-01-11', '09:30:00'),
(8, 5, 5, 5, '2025-11-20', '09:30:00');

-- Appointment
INSERT INTO Appointment VALUES
(1, 'Routine Checkup', 'Completed'),
(2, 'Neurology Consultation', 'Completed'),
(3, 'Pediatric Visit', 'Cancelled'),
(4, 'Surgery Follow-up', 'Completed'),
(5, 'X-ray Review', 'Scheduled'),
(6, 'Routine Checkup', 'Completed'),
(7, 'Neurology Consultation', 'Completed'),
(8, 'Monitoring treatment progress', 'Scheduled');

-- Emergency
INSERT INTO Emergency VALUES
(1, 3, 'Discharged'),
(2, 4, 'Admitted'),
(3, 2, 'Transferred'),
(4, 5, 'Deceased'),
(5, 1, 'Admitted');

-- Insurance
INSERT INTO Insurance VALUES
(1, 'CNOPS'),
(2, 'CNSS'),
(3, 'RAMED'),
(4, 'Private'),
(5, 'None');

-- Expense
INSERT INTO Expense VALUES
(1, 1, 1, 500.00),
(2, 2, 2, 800.00),
(3, 3, 3, 200.00),
(4, 4, 4, 1200.00),
(5, 5, 5, 50.00);

-- Medication
INSERT INTO Medication VALUES
(1, 'Paracetamol', 'Tablet', '500mg', 'Paracetamol', 'Analgesic', 'Sanofi'),
(2, 'Amoxicillin', 'Capsule', '250mg', 'Amoxicillin', 'Antibiotic', 'Pfizer'),
(3, 'Aspirin', 'Tablet', '100mg', 'Acetylsalicylic Acid', 'Analgesic', 'Bayer'),
(4, 'Cough Syrup', 'Liquid', '5mg/10ml', 'Dextromethorphan', 'Antitussive', 'GSK'),
(5, 'Insulin', 'Injection', '10IU/ml', 'Insulin', 'Antidiabetic', 'Novo Nordisk');

-- Stock
INSERT INTO Stock VALUES
(1, 1, NOW(), 10.00, 100, 10),
(2, 2, NOW(), 25.00, 50, 5),
(2, 3, NOW(), 7.00, 200, 20),
(3, 4, NOW(), 10.00, 200, 20),
(3, 3, NOW(), 5.00, 200, 20),
(4, 4, NOW(), 15.00, 30, 10),
(5, 5, NOW(), 50.00, 10, 5);

-- Prescription
INSERT INTO Prescription VALUES
(1, 1, '2025-10-10'),
(2, 2, '2026-01-11'),
(3, 3, '2025-09-05'),
(4, 4, '2025-09-22'),
(5, 5, '2026-01-30');

-- Includes
INSERT INTO Includes VALUES
(1, 1, '1 tablet every 8h', '5 days'),
(2, 2, '1 capsule every 12h', '7 days'),
(3, 3, '1 tablet daily', '10 days'),
(4, 4, '10ml twice daily', '5 days'),
(5, 5, 'Inject before meals', '30 days');

-- ContactLocation
INSERT INTO ContactLocation VALUES
(1, 'Rabat', 'Rabat-Salé', 'Avenue Hassan II', '12', '10000', '0537001122'),
(2, 'Casablanca', 'Casablanca-Settat', 'Bd Zerktouni', '22', '20000', '0522003344'),
(3, 'Marrakech', 'Marrakech-Safi', 'Rue Mohammed V', '5', '40000', '0524005566'),
(4, 'Fès', 'Fès-Meknès', 'Rue Hassan', '8', '30000', '0535007788'),
(5, 'Agadir', 'Souss-Massa', 'Bd 20 Août', '3', '80000', '0528009900');

-- have
INSERT INTO have VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);


ALTER TABLE Patient ADD Email VARCHAR(100);
UPDATE Patient SET Phone = '0611223344' WHERE IID = 3;
UPDATE Hospital SET Region = 'Casablanca-Settat' WHERE HID = 2;

DELETE FROM Appointment WHERE Status = 'Cancelled';
