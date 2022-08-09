INSERT INTO InvoicesCopy_Drew
select
[InvoiceID], [InvoiceNumber], [InvoiceTotal]
FROM PaidInvoices
where ISNUMERIC([InvoiceNumber]) = 1

UPDATE
	InvoicesCopy_Drew
	SET INVOICEDATE = GETDATE()

SELECT * 
FROm

UPDATE
	InvoicesCopy_Drew
	SET INVOICEDATE = DATEADD(DAY,-1,GETDATE())
	WHERE InvoiceTotal > 100

SELECT * 
FROm
InvoicesCopy_Drew


DELETE
	FROM InvoicesCopy_Drew
	WHERE InvoiceTotal <= 100	


INSERT INTO
InvoicesCopy_Drew
--([InvoiceID], [InvoiceNumber], [InvoiceTotal], [INVOICEDATE])
values
(2	,263253241	,40.20	,'2022-07-23 11:02:13.807'),
(3	,963253234	,138.75	,'2022-07-23 11:02:13.807')


INSERT INTO
InvoicesCopy_Drew
SELECT
[InvoiceID], [InvoiceNumber],[InvoiceTotal], GETDATE()
FROM [AP].[dbo].[InvoiceArchive]
WHERE ISNUMERIC([InvoiceNumber] ) = 1
AND InvoiceID not in (2,3)

--QUERY BASED UPDATE
/*pre-flight-check
SELECT ICD.*
from*/

update
ICD
set INVOICEDATE = '7-22-22'
FROM
InvoicesCopy_Drew ICD
JOIN 
(SELECT * FROM [AP].[dbo].[InvoiceArchive]
WHERE ISNUMERIC([InvoiceNumber] ) = 1) IAN
ON ICD.[InvoiceNumber] = IAN.[InvoiceNumber]

delete
ICD
FROM
InvoicesCopy_Drew ICD
JOIN 
(SELECT * FROM [AP].[dbo].[InvoiceArchive]
WHERE ISNUMERIC([InvoiceNumber] ) = 1) IAN
ON ICD.[InvoiceNumber] = IAN.[InvoiceNumber]

SELECT @@ROWCOUNT

UPDATE InvoiceArchive  set InvoiceDate = '7-24-22'

MERGE 
INTO 
--a lot like ...FROM   InvoiceCopy LEFT OUTER JOIN InvoiceArchive
--Master Copy for Analysis
InvoiceArchive ia
--Latest version from Production/Staging
USING InvoiceCopy ic
--exactly like ...FROM InvoiceCopy LEFT OUTER JOIN InvoiceArchive
ON ia.InvoiceNumber = ic.InvoiceNumber
--INNER JOIN = UPDATE
WHEN MATCHED 
--WHERE ON ia.InvoiceID IS NOT NULL AND  ic.InvoiceID IS NOT NULL 
	AND ic.PaymentDate IS NOT NULL
	AND ic.PaymentTotal > ia.PaymentTotal
	THEN 
		UPDATE SET
		ia.PaymentTotal = ic.PaymentTotal
		,ia.PaymentDate = GETDATE()
		,ia.CreditTotal = ic.CreditTotal
--LEFT OUTER JOIN WITH NULL FROM SOURCE = INSERT
WHEN NOT MATCHED 
--WHERE ON ia.InvoiceID IS NULL AND  ic.InvoiceID IS NOT NULL 
	THEN
		INSERT ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate])
		VALUES(ic.[InvoiceID], ic.[VendorID], ic.[InvoiceNumber], '7-22-22', ic.[InvoiceTotal], ic.[PaymentTotal], ic.[CreditTotal], ic.[TermsID], ic.[InvoiceDueDate])
--RIGHT OUTER JOIN = DELETE
;
SELECT [InvoiceDate], COUNT(*)
FROM InvoiceArchive
GROUP BY [InvoiceDate]
