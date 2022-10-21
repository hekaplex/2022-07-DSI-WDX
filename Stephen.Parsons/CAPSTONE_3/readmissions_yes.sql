DELETE FROM dbo.ReadmissionData
WHERE Readmitted = 'no'

SELECT*
FROM dbo.ReadmissionData
WHERE Readmitted !='null'
      