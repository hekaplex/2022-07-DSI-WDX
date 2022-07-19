SELECT InvoiceNumber, InvoiceDate, InvoiceTotal
FROM Invoices
-- include values in BETWEEN clause 
WHERE InvoiceDate BETWEEN '2015-12-08' AND '2015-12-30'
ORDER BY InvoiceDate

SELECT GETDATE() as [now]

SELECT 
	[Invoice Number] = InvoiceNumber,
	Date = InvoiceDate,
Total = InvoiceTotal
FROM Invoices;

--polymorphism
SELECT
--money + money = money (sum)
I.InvoiceTotal + I.PaymentTotal as BigNumber
--varchar + varchar = varchar (concatenate)
,
V.VendorName
--single quote 
+Char(39) 
--Carriage Return + Line Feed
+Char(10) + Char(13)
+'s '
+ I.InvoiceNumber 
--Table Alias - shortcut short form
FROM Invoices I
JOIN Vendors V
ON I.VendorID = V.VendorID

--SELECT ASCII('L')
--SELECT CHAR(76)

SELECT InvoiceID,
InvoiceID / 10 AS Quotient,
InvoiceID / 10.0 AS QuotientDecimal,
InvoiceID % 10 AS Remainder
FROM Invoices
ORDER BY InvoiceID

SELECT VendorContactFName, VendorContactLName,
LEN(VendorContactFName), 
LEN(VendorContactLName),
LEFT(VendorContactFName, 1) +
LEFT(VendorContactLName, 1) AS Initials
FROM Vendors;

SELECT 'Invoice: #' + InvoiceNumber
+ ', dated ' + CONVERT(char(10), PaymentDate, 1)
+ ' for $' + CONVERT(varchar(8), PaymentTotal, 2)
FROM Invoices;

SELECT InvoiceDate,
GETDATE() AS 'Today''sDate',
DATEDIFF(year, InvoiceDate, GETDATE()) AS Age
FROM Invoices;


SELECT 
--DISTINCT 
VendorCity, VendorState
FROM Vendors;

--No ORDER BY, no guarantee of physical order being static
SELECT 
TOP 5
VendorCity, VendorState
FROM Vendors;


SELECT 
	TOP 5 PERCENT  WITH TIES
VendorID, InvoiceTotal
FROM Invoices
ORDER BY InvoiceTotal DESC;


SELECT 
	TOP 5
	WITH TIES
VendorID, InvoiceDate
FROM Invoices
where CreditTotal = 0
ORDER BY InvoiceDate ASC;

SELECT 
VendorID, InvoiceDate
FROM Invoices
where CreditTotal < 0
ORDER BY InvoiceDate ASC;

SELECT 
VendorID, InvoiceDate
FROM Invoices
where CreditTotal > 0
ORDER BY InvoiceDate ASC;

SELECT 
VendorID, InvoiceDate
FROM Invoices
-- SAME AS CreditTotal != 0
where CreditTotal <> 0
ORDER BY InvoiceDate ASC;

--9 rows with parenthesis
SELECT 
VendorID, InvoiceDate
FROM Invoices
WHERE (InvoiceDate> '01/01/2020'
OR InvoiceTotal> 500)
AND InvoiceTotal-PaymentTotal-CreditTotal> 0

--6 rows with different parenthesis & operator order
SELECT 
VendorID, InvoiceDate
FROM Invoices
WHERE InvoiceDate> '01/01/2020'
AND (InvoiceTotal> 500
OR InvoiceTotal-PaymentTotal-CreditTotal> 0)

SELECT 
VendorID, InvoiceDate
FROM Invoices
WHERE
InvoiceTotal> 500
AND VendorID IN
(SELECT VendorID
FROM Invoices
WHERE InvoiceDate > '2020-01-01')

SELECT 
VendorID, InvoiceDate
FROM Invoices
WHERE
InvoiceTotal> 500
AND VendorID IN
--join materializes through an IN clause
(SELECT VendorID
FROM Vendors
WHERE VendorState = 'CA')

				SELECT 
					I.VendorID
					, I.InvoiceDate
FROM Invoices I
	JOIN Vendors V
		ON I.VendorID = V.VendorID
			WHERE
				I.InvoiceTotal> 500
AND V.VendorState = 'CA'