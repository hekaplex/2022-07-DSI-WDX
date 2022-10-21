Select Readmitted as ra
FROM dbo.ReadmissionData
WHERE Readmitted != 'null'
ORDER BY ra

SELECT COUNT (Readmitted)
FROM dbo.ReadmissionData
WHERE Readmitted ='yes'

SELECT COUNT (Readmitted)
FROM dbo.ReadmissionData
WHERE Readmitted ='no'

SELECT Readmitted ra
FROM dbo.ReadmissionData
WHERE Readmitted ='no'
DELETE 




