-- 1
SELECT P.IID,P.FullName
FROM Patient P
ORDER BY FullName;

-- 2
SELECT DISTINCT Ins.Type
FROM Insurance Ins;

-- 3
SELECT DISTINCT S.STAFF_ID , S.FullName
FROM Staff S
JOIN Work_in W ON S.STAFF_ID = W.STAFF_ID
JOIN Department D ON W.DEP_ID = D.DEP_ID
JOIN Hospital H ON D.HID = H.HID
WHERE H.City='Rabat';

-- 4
SELECT *
    FROM Appointment A
    JOIN ClinicalActivity CA ON CA.CAID = A.CAID
WHERE CURDATE() <= CA.Date AND DATEDIFF(CA.Date, CURDATE()) <= 7 AND A.Status = 'Scheduled';

-- 5
SELECT CA.Dep_ID, COUNT(*) AS cnt
    FROM Appointment A
    JOIN ClinicalActivity CA on A.CAID=CA.CAID
   GROUP BY CA.Dep_ID

-- 6
SELECT S.HID,AVG(UnitPrice) as average_unit_price
FROM Stock S
GROUP BY S.HID;

-- 7
SELECT HID
FROM Hospital H
JOIN Department D ON H.HID = D.HID
JOIN ClinicalActivity CA ON D.DEP_ID = CA.DEP_ID
JOIN Emergency E ON CA.CAID = E.CAID
WHERE E.Outcome = 'Admitted'
GROUP BY H.HID
HAVING COUNT(E.CAID) > 20;

-- 8
SELECT M.MID, M.Name FROM Medication M
    JOIN Stock S ON M.MID = S.MID
WHERE M.TherapeuticClass = 'Antibiotic' AND S.UnitPrice < 200;

-- 9
SELECT S1.HID,S1.Mid
FROM Stock S1
    WHERE (SELECT count(*)
    FROM Stock S2
    WHERE S1.HID = S2.HID
    AND S2.UnitPrice>S1.UnitPrice)<3
ORDER BY S1.HID ,S1.UnitPrice DESC;

-- 10
SELECT D.DEP_ID,
       D.Name AS DepartmentName,
       (SELECT COUNT(*)
        FROM ClinicalActivity CA1
        JOIN Appointment A1 ON CA1.CAID = A1.CAID
        WHERE CA1.DEP_ID = D.DEP_ID
          AND A1.Status = 'Scheduled') AS ScheduledCount,
       (SELECT COUNT(*)
        FROM ClinicalActivity CA2
        JOIN Appointment A2 ON CA2.CAID = A2.CAID
        WHERE CA2.DEP_ID = D.DEP_ID
          AND A2.Status = 'Completed') AS CompletedCount,
       (SELECT COUNT(*)
        FROM ClinicalActivity CA3
        JOIN Appointment A3 ON CA3.CAID = A3.CAID
        WHERE CA3.DEP_ID = D.DEP_ID
          AND A3.Status = 'Cancelled') AS CancelledCount
FROM Department D;

-- 11
SELECT P.IID, P.FullName
    FROM Patient P
    WHERE P.IID NOT IN (
    	SELECT CA.IID
    	FROM Appointment A
    	JOIN ClinicalActivity CA ON A.CAID = CA.CAID
    	WHERE A.Status = 'Scheduled'
        AND CA.Date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 30 DAY)
    );

-- 12
SELECT S.STAFF_ID,
       S.FullName,
       COUNT(A.CAID) AS TotalAppointments,
       COUNT(A.CAID) * 100.0 /
           (SELECT COUNT(A2.CAID)
            FROM ClinicalActivity CA2
            JOIN Appointment A2 ON CA2.CAID = A2.CAID
            JOIN Department D2 ON CA2.DEP_ID = D2.DEP_ID
            WHERE D2.HID = D.HID) AS PercentageShare
FROM Staff S
JOIN ClinicalActivity CA ON S.STAFF_ID = CA.STAFF_ID
JOIN Appointment A ON CA.CAID = A.CAID
JOIN Department D ON D.DEP_ID = CA.DEP_ID
GROUP BY S.STAFF_ID,S.FullName;

-- 13
SELECT MID, HID
    FROM Stock S
    WHERE S.ReorderLevel > S.Qty
    ORDER BY MID;

-- 14
SELECT H.Name
FROM Hospital H
JOIN Stock S ON S.HID = H.HID
JOIN Medication M ON S.MID = M.MID
WHERE NOT EXISTS ((SELECT MID
                  FROM Medication
                  WHERE TherapeuticClass = 'Antibiotic')
                EXCEPT
                    (SELECT S2.MID
                     FROM Stock S2
                     JOIN Medication M2 ON M2.MID = S2.MID
                     WHERE S2.HID = H.HID AND M2.TherapeuticClass = 'Antibiotic'));

-- 15
SELECT H.HID,H.Name AS HospitalName , H.City , M.TherapeuticClass , AVG(S.UnitPrice) AS HospitalAvgPrice , 'Above Average' AS PriceStatus
FROM Hospital H, Stock S, Medication M
WHERE H.HID = S.HID
AND S.MID = M.MID
GROUP BY H.HID, M.TherapeuticClass
HAVING AVG(S.UnitPrice) > (
    SELECT AVG(S2.UnitPrice)
    FROM Stock S2, Hospital H2, Medication M2
    WHERE S2.HID = H2.HID
    AND S2.MID = M2.MID
    AND H2.City = H.City
    AND M2.TherapeuticClass = M.TherapeuticClass
)

UNION

SELECT H.HID,H.Name AS HospitalName , H.City , M.TherapeuticClass , AVG(S.UnitPrice) AS HospitalAvgPrice , 'Below or Equal to Average' AS PriceStatus
FROM Hospital H, Stock S, Medication M
WHERE H.HID = S.HID
AND S.MID = M.MID
GROUP BY H.HID, M.TherapeuticClass
HAVING AVG(S.UnitPrice) <= (
    SELECT AVG(S2.UnitPrice)
    FROM Stock S2, Hospital H2, Medication M2
    WHERE S2.HID = H2.HID
    AND S2.MID = M2.MID
    AND H2.City = H.City
    AND M2.TherapeuticClass = M.TherapeuticClass
);

-- 16
SELECT P.IID, P.FullName, MIN(CA.Date) AS NextAppointmentDate
FROM Patient P
JOIN ClinicalActivity CA ON P.IID = CA.IID
JOIN Appointment A ON CA.CAID = A.CAID
WHERE CA.Date >= CURDATE()
AND A.Status = 'Scheduled'
GROUP BY P.IID
HAVING MIN(CA.Date) IS NOT NULL;

-- 17
SELECT P.IID,P.FullName,MAX(C.Date)as latest_emergency_date,COUNT(*) as total_emergency_visit
FROM Patient P
JOIN ClinicalActivity C on P.IID=C.IID
JOIN Emergency E on C.CAID=E.CAID
GROUP BY P.IID
Having count(*)>=2 AND DATEDIFF(CURDATE(), MAX(C.Date)) <= 14;

-- 18
SELECT H.City, H.Name, COUNT(DISTINCT A.CAID) as app_count
FROM Hospital H
JOIN Department D ON H.HID = D.HID
JOIN ClinicalActivity CA ON CA.DEP_ID = D.DEP_ID
JOIN Appointment A ON A.CAID = CA.CAID
WHERE CA.Date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 90 DAY)
AND A.Status = 'Completed'
GROUP BY H.HID
ORDER BY H.City, app_count;

-- 19
SELECT
    H.City,
    M.MID,
    M.Name AS MedicationName,
    MIN(ST.UnitPrice) AS MinPrice,
    MAX(ST.UnitPrice) AS MaxPrice,
    ROUND((MAX(ST.UnitPrice) - MIN(ST.UnitPrice)) * 100.0 / MIN(ST.UnitPrice), 2) AS PriceSpreadPercent
FROM Hospital H
JOIN Stock ST ON H.HID = ST.HID
JOIN Medication M ON ST.MID = M.MID
GROUP BY H.City, M.MID, M.Name
HAVING (MAX(ST.UnitPrice) - MIN(ST.UnitPrice)) * 100.0 / MIN(ST.UnitPrice)>30;

-- 20
SELECT *
    FROM Stock
    WHERE Qty < 0 OR UnitPrice <= 0;