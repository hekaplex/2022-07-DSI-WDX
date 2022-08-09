SELECT * FROM
Vendors
--In clause being passed an array/list of values
WHERE VendorState in ('CA','NY')

SELECT * FROM
Vendors
WHERE 
	VendorZipCode
	--excludes values in range
	NOT BETWEEN 93662 AND 93792
ORDER BY 
	VendorZipCode
-- YYYY-MM-DD default format
SELECT CONVERT(date,getdate())
-- date and time
select getdate()
-- convert date to datetime give midnight time
SELECT CONVERT(datetime,CONVERT(date,getdate()))

--wildcard beginning of string
SELECT * FROM
Vendors
WHERE 
	VendorName like 'A%'

--wildcard end of string
SELECT * FROM
Vendors
WHERE 
	VendorName like '%l'

--SQL by default is case-insensitive
SELECT * FROM
Vendors
WHERE 
	VendorName like '%L'

--SQL fill in the blanks
SELECT * FROM
Vendors
WHERE 
	VendorName like '%b__l%'

--SQL fill in the blanks
SELECT * FROM
Vendors
WHERE 
	VendorName like '%b[ui][iel]l%'
--exclude some values
SELECT * FROM
Vendors
WHERE 
	VendorName like '%b[^u][iel]l%'

--NULL vs empty string
SELECT * FROM
Vendors

--LEN of NULL is NULL
SELECT DISTINCT (LEN(VendorAddress2))
FROM Vendors

--CASTING null
SELECT DISTINCT (COALESCE(LEN(VendorAddress2),0))
FROM Vendors

SELECT DISTINCT (isnull(LEN(VendorAddress2),0))
FROM Vendors

SELECT 
*
FROM Vendors
WHERE VendorAddress2 IS NULL


SELECT 
*
FROM Vendors
WHERE VendorAddress2 IS NOT NULL

--order by 
SELECT VendorState, VendorCity, VendorName,
VendorCity+ ', ' + VendorState+ ' ' + VendorZipCode
AS Address
FROM Vendors
--default ORDER BY is ASC
ORDER BY VendorState, VendorCity, VendorName;

SELECT VendorState, VendorCity, VendorName,
VendorCity+ ', ' + VendorState+ ' ' + VendorZipCode
AS Address
FROM Vendors
--default ORDER BY is ASC
ORDER BY VendorState DESC, VendorCity ASC, VendorName DESC;

SELECT VendorState, VendorCity, VendorName,
VendorCity+ ', ' + VendorState+ ' ' + VendorZipCode
AS Address
FROM Vendors
ORDER BY LEN(VendorCity) DESC

--SQL is 1 index based
SELECT VendorState, VendorCity, VendorName,
VendorCity+ ', ' + VendorState+ ' ' + VendorZipCode
AS Address
FROM Vendors
--default ORDER BY is ASC
ORDER BY 1 DESC, 2 ASC, 3 DESC;

SELECT VendorState, VendorCity, VendorName,
VendorCity+ ', ' + VendorState+ ' ' + VendorZipCode
AS Address
FROM Vendors
--default ORDER BY is ASC
ORDER BY 4 DESC;