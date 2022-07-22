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