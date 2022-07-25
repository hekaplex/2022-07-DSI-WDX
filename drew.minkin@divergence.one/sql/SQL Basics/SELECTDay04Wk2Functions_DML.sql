USe Examples;
--string examples
SELECT 
      [VendorPhone]
	, SUBSTRING([VendorPhone],2,3) as AreaCode
	, SUBSTRING([VendorPhone],7,3) as Prefix
	, SUBSTRING([VendorPhone],11,4) as Extension
	, VendorContactLName
	+ ', '
	+LEFT(VendorContactFName,1)
	+ '.' As ContactAbbreviation
  FROM [Examples].[dbo].[Vendors]
--(209) 555-1551

SELECT 
	[Name]
	,SUBSTRING([Name],1,CHARINDEX(' ',[Name])-1) FName
	,SUBSTRING([Name],CHARINDEX(' ',[Name])+1,LEN(Name) -CHARINDEX(' ',[Name])) LName
	,RIGHT([Name],LEN(Name) -CHARINDEX(' ',[Name])) LName2
  FROM [Examples].[dbo].[StringSample]
--real number examples
SELECT 
	[R]
	,([R] - ROUND([R],2) ) * 10000000000 As Invisible_precision
	,ROUND([R],2) Rounded_2digits
	,ROUND([R],2,1) Rounded_2digits_floor
FROM 
	[Examples].[dbo].[RealSample]
WHERE 
	ROUND([R],2) = 1

--date examples
SELECT 
	[StartDate]
	,CAST([StartDate] AS time)
	,DATEPART(DAY,[StartDate])		AS DAYPart
	,DATEPART(MONTH,[StartDate])	AS MONPart
	,DATEPART(YEAR,[StartDate])		AS YEAPart
	,DATEPART(HOUR,[StartDate])		AS HOUPart
	,DATEPART(MINUTE,[StartDate])	AS MINPart
	,DATEPART(SECOND,[StartDate]) AS SecPart
  FROM [Examples].[dbo].[DateSample]

 --self-join + DATEDIFF
 SELECT 
	A.[StartDate] 
	,B.[StartDate] 
	,DATEDIFF(DAY,A.[StartDate],B.[StartDate])
  FROM [DateSample] A
  JOIN [DateSample]  B
  ON B.ID = A.ID+1

Use AP;

SELECT 
InvoiceNumber
,TermsID
,CASE TermsID
	WHEN 1 THEN 'Net due 10 days	10'
	WHEN 2 THEN 'Net due 20 days	20'
	WHEN 3 THEN 'Net due 30 days	30'
	WHEN 4 THEN 'Net due 60 days	60'
	ELSE 'Net due 90 days	90'
	END 
		AS terms
FROM 
Invoices
;
SELECT 
InvoiceNumber
,TermsID
,CHOOSE( TermsID
	,'Net due 10 days'
	,'Net due 20 days'
	,'Net due 30 days'
	,'Net due 60 days'
	,'Net due 90 days'
	)
		AS terms
FROM 
Invoices
;

SELECT 
VendorID
,SUM(InvoiceTotal) As SumInvoices
,IIF(SUM(InvoiceTotal) > 1000,'Low','High')
FROM 
Invoices
GROUP BY VendorID
;

SELECT
	VendorName
	,VendorState
	,ROW_NUMBER() OVER (ORDER BY VendorName) As RowNum_Name
	,ROW_NUMBER() OVER (ORDER BY VendorState) As RowNum_State
	,ROW_NUMBER() OVER (PARTITION BY VendorState ORDER BY VendorState) As RowNum_StatePartition
	,ROW_NUMBER() OVER (PARTITION BY VendorState ORDER BY VendorName) As RowNum_StatePartition
FROM
	Vendors;

With
	InvoiceNTile
AS
	(
	SELECT
		InvoiceNumber
		,InvoiceTotal
		,NTILE(3) OVER (ORDER BY InvoiceTotal) as RankinThirds
	FROM
		Invoices
	)
SELECT
	RankinThirds
	,MIN(InvoiceTotal)		MIN_InvoiceTotal
	,MAX(InvoiceTotal)		MAX_InvoiceTotal
	,AVG(InvoiceTotal)		AVG_InvoiceTotal
	,STDEV(InvoiceTotal)	STDEV_InvoiceTotal
	,COUNT(InvoiceTotal)	COUNT_InvoiceTotal
FROM
InvoiceNTile
GROUP BY RankinThirds

SELECT @@ROWCOUNT

SELECT OBJECT_ID('FakeTableName') IS NOT NULL
	DROP TABLE FakeTableName

USE Examples;

SELECT *
INTO InvoicesCopy_Drew
FROM Invoices

INSERT INTO InvoicesCopy_Drew
([InvoiceID], [InvoiceNumber], [InvoiceTotal])
VALUES
	(101, 12345, 470.47)

SELECT *
FROM InvoicesCopy_Drew


INSERT INTO InvoicesCopy_Drew
([InvoiceID], [InvoiceNumber], [InvoiceTotal])
VALUES
	(102, 12345, 470.47)
	,	(103, 12346, 480.47)
	,	(104, 12347, 490.47)

INSERT INTO InvoicesCopy_Drew
select
[InvoiceID], [InvoiceNumber], [InvoiceTotal]
FROM PaidInvoices
where ISNUMERIC([InvoiceNumber]) = 1

SELECT *
FROM InvoicesCopy_Drew

alter table InvoicesCopy_Drew add INVOICEDATE DATE
--TRANSACTIONS AND CONCURRENCY
begin TRAN

update 
	InvoicesCopy_Drew
set INVOICEDATE = getdate()

--ROLLBACK TRAN
commit tran

--do A select with wher BEFORRE COMMITING AN update OR delete
update 
	InvoicesCopy_Drew
set INVOICEDATE = dateadd(day,-7,getdate())
where InvoiceTotal = 0


--update invoices from paidinvoices

select count(*)
FROM
InvoicesCopy_Drew icd
	JOIN
	PaidInvoices p
	on 
		p.InvoiceNumber
		=
		icd.InvoiceNumber
where ISNUMERIC(p.[InvoiceNumber]) = 1

update 
	icd
SET
	INVOICEDATE = dateadd(day,-14,getdate())
FROM
	InvoicesCopy_Drew icd
	JOIN
	PaidInvoices p
	on 
		p.InvoiceNumber
		=
		icd.InvoiceNumber
where ISNUMERIC(p.[InvoiceNumber]) = 1

DELETE
--SELECT * 
	FROM 
		InvoicesCopy_Drew
	WHERE InvoiceNumber IS NULL

--delete our manual inserts into table
-- did not come from paidinvoices
;
with p as
	(
	SELECT InvoiceNumber PInvoiceNumber FROM
	PaidInvoices
	--where ISNUMERIC([InvoiceNumber]) = 1
	)
,
icd
as (
SELECT cast(invoicenumber as varchar(25)) ICDinvoicenumber from InvoicesCopy_Drew 
)
delete
	icd
FROM
	icd
LEFT OUTER JOIN
	 p
	on 
		p.PInvoiceNumber
		=
		icd.ICDInvoiceNumber
Where p.PInvoiceNumber IS NULL

MERGE 
INTO 
--a lot like ...FROM   InvoiceCopy LEFT OUTER JOIN InvoiceArchive
InvoiceArchive ia
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
		,ia.PaymentDate = ic.PaymentDate
		,ia.CreditTotal = ic.CreditTotal
--LEFT OUTER JOIN WITH NULL FROM SOURCE = INSERT
WHEN NOT MATCHED 
--WHERE ON ia.InvoiceID IS NULL AND  ic.InvoiceID IS NOT NULL 
	THEN
		INSERT ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate])
		VALUES(ic.[InvoiceID], ic.[VendorID], ic.[InvoiceNumber], ic.[InvoiceDate], ic.[InvoiceTotal], ic.[PaymentTotal], ic.[CreditTotal], ic.[TermsID], ic.[InvoiceDueDate])
--RIGHT OUTER JOIN = DELETE
WHEN NOT MATCHED BY SOURCE
--WHERE ON ia.InvoiceID IS NOT NULL AND  ic.InvoiceID IS NULL 
	THEN DELETE;

SELECT * FROM InvoiceCopy INTERSECT SELECT * FROM InvoiceArchive
--101 rows
SELECT * FROM InvoiceArchive ExCEPT SELECT * FROM InvoiceCopy
--101 rows 

UPDATE InvoiceCopy SET 

SELECT COUNT(*)
FROM InvoiceArchive 
WHERE CreditTotal = 777.77
--117/0