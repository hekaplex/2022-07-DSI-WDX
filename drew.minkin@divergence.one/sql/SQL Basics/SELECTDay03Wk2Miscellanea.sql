--always add decimal when doing math with integers
SELECT 29/6.0

SELECT CONVERT(varchar(20),CONVERT(datetime,'02/28/2022'),112)
--112 = yyyymmdd

SELECT CONVERT(date,'20220230',112)

SELECT CAST('20220228' as date)

SELECT TRY_CONVERT(date,'20220230',112)

SELECT 
	VendorName 
	+ CHAR(10) -- line feed
	+ VendorAddress1 
	+ CHAR(10)
	+ VendorCity 
	+ ', ' 
	+ VendorState 
	+ ', '
	+ VendorZipCode
	+ CHAR(10) 
FROM Vendors

SELECT NCHAR(702)
SELECT UNICODE('ʾ')

Use AP
GO
SELECT 
	InvoiceDate  As BaseDate
,	CAST(InvoiceDate AS varchar) As varcharDate
,	CONVERT(varchar,InvoiceDate) As varcharDate_default
,	CONVERT(varchar,InvoiceDate,1) As varcharDate_1
,	CONVERT(varchar,InvoiceDate,101) As varcharDate_101
,	CONVERT(varchar,InvoiceDate,7)		As varcharDate_7
,	CONVERT(varchar,InvoiceDate,107)	As varcharDate_107
,	CONVERT(varchar,InvoiceDate,12)		As varcharDate_12	
,	CONVERT(varchar,InvoiceDate,112)	As varcharDate_112
,	CONVERT(int,InvoiceDate,112)	As INTDate_112
,	InvoiceTotal  As BaseTotal
,	CAST(InvoiceTotal AS int) As integerTotal
,	CAST(InvoiceTotal AS varchar) As varcharTotal
,	TRY_CONVERT(varchar,InvoiceDate) As varcharDate_default_try
,	TRY_CONVERT(varchar,InvoiceDate, 1) As varcharDate_default_try_1
,	TRY_CONVERT(varchar,InvoiceDate, 107) As varcharDate_default_try_107
,	TRY_CONVERT(varchar,InvoiceTotal) As varcharTotal_try
,	TRY_CONVERT(varchar,InvoiceTotal, 1) As varcharTotal_try_1
,	TRY_CONVERT(date,'Feb 29 2022') As invalid_date
FROM
	Invoices
--20151208	= 42344
SELECT DATEDIFF(Day,'Jan 01, 1900', 'Dec 08, 2015')

--Dynamic SQL
SELECT 'Invoices' as table_name, Count(*) as row_count from Invoices

SELECT Count(*) as row_count from Invoices

SELECT 
	'SELECT '
+	char(39) 
+	TABLE_SCHEMA + '.' +TABLE_NAME
+	''''
+	' as table_name, Count(*) as row_count from '
+	TABLE_SCHEMA + '.' 
+	'['
+	TABLE_NAME
+	']'
+	CHAR(10)
+	'UNION'
FROM INFORMATION_SCHEMA.TABLES

SELECT
a.*
INTO dynamicsql_DrewMinkin_METADATA
FROM
(
	SELECT 'jewelry_kmeans' as table_name, Count(*) as row_count from jewelry_kmeans
	UNION
	SELECT 'jewelry_kmeans_ssis' as table_name, Count(*) as row_count from jewelry_kmeans_ssis
	UNION
	SELECT 'ContactUpdates' as table_name, Count(*) as row_count from ContactUpdates
	UNION
	SELECT 'GLAccounts' as table_name, Count(*) as row_count from GLAccounts
	UNION
	SELECT 'InvoiceArchive' as table_name, Count(*) as row_count from InvoiceArchive
	UNION
	SELECT 'InvoiceLineItems' as table_name, Count(*) as row_count from InvoiceLineItems
	UNION
	SELECT 'Invoices' as table_name, Count(*) as row_count from Invoices
	UNION
	SELECT 'Terms' as table_name, Count(*) as row_count from Terms
	UNION
	SELECT 'Vendors' as table_name, Count(*) as row_count from Vendors
	UNION
	SELECT 'sysdiagrams' as table_name, Count(*) as row_count from sysdiagrams
	UNION
	SELECT 'Invoices2' as table_name, Count(*) as row_count from Invoices2
	UNION
	SELECT 'SequenceTable' as table_name, Count(*) as row_count from SequenceTable
	UNION
	SELECT 'PQ_Sample' as table_name, Count(*) as row_count from PQ_Sample
	UNION
	SELECT 'test' as table_name, Count(*) as row_count from test
	UNION
	SELECT 'test2' as table_name, Count(*) as row_count from test2
	UNION
	SELECT 'XtabVendors' as table_name, Count(*) as row_count from XtabVendors
	UNION
	SELECT 'InvoiceEmpty' as table_name, Count(*) as row_count from InvoiceEmpty
	UNION
	SELECT 'VendorCopy' as table_name, Count(*) as row_count from VendorCopy
	UNION
	SELECT 'InvoiceCopy' as table_name, Count(*) as row_count from InvoiceCopy
	UNION
	SELECT 'OutstandingInvoices' as table_name, Count(*) as row_count from OutstandingInvoices
	UNION
	SELECT 'OustandingInvoiceSummary' as table_name, Count(*) as row_count from OustandingInvoiceSummary
	UNION
	SELECT 'OutsandingInvoiceSummary' as table_name, Count(*) as row_count from OutsandingInvoiceSummary
	UNION
	SELECT 'OutstandingInvoiceSummary' as table_name, Count(*) as row_count from OutstandingInvoiceSummary
	UNION
	SELECT 'VendorPayment' as table_name, Count(*) as row_count from VendorPayment
	UNION
	SELECT 'SumInvoices' as table_name, Count(*) as row_count from SumInvoices
)  a
WHERE 1 = 2


insert
	INTO dynamicsql_DrewMinkin_METADATA
SELECT
a.*
FROM
(
	SELECT 'jewelry_kmeans' as table_name, Count(*) as row_count from jewelry_kmeans
	UNION
	SELECT 'jewelry_kmeans_ssis' as table_name, Count(*) as row_count from jewelry_kmeans_ssis
	UNION
	SELECT 'ContactUpdates' as table_name, Count(*) as row_count from ContactUpdates
	UNION
	SELECT 'GLAccounts' as table_name, Count(*) as row_count from GLAccounts
	UNION
	SELECT 'InvoiceArchive' as table_name, Count(*) as row_count from InvoiceArchive
	UNION
	SELECT 'InvoiceLineItems' as table_name, Count(*) as row_count from InvoiceLineItems
	UNION
	SELECT 'Invoices' as table_name, Count(*) as row_count from Invoices
	UNION
	SELECT 'Terms' as table_name, Count(*) as row_count from Terms
	UNION
	SELECT 'Vendors' as table_name, Count(*) as row_count from Vendors
	UNION
	SELECT 'sysdiagrams' as table_name, Count(*) as row_count from sysdiagrams
	UNION
	SELECT 'Invoices2' as table_name, Count(*) as row_count from Invoices2
	UNION
	SELECT 'SequenceTable' as table_name, Count(*) as row_count from SequenceTable
	UNION
	SELECT 'PQ_Sample' as table_name, Count(*) as row_count from PQ_Sample
	UNION
	SELECT 'test' as table_name, Count(*) as row_count from test
	UNION
	SELECT 'test2' as table_name, Count(*) as row_count from test2
	UNION
	SELECT 'XtabVendors' as table_name, Count(*) as row_count from XtabVendors
	UNION
	SELECT 'InvoiceEmpty' as table_name, Count(*) as row_count from InvoiceEmpty
	UNION
	SELECT 'VendorCopy' as table_name, Count(*) as row_count from VendorCopy
	UNION
	SELECT 'InvoiceCopy' as table_name, Count(*) as row_count from InvoiceCopy
	UNION
	SELECT 'OutstandingInvoices' as table_name, Count(*) as row_count from OutstandingInvoices
	UNION
	SELECT 'OustandingInvoiceSummary' as table_name, Count(*) as row_count from OustandingInvoiceSummary
	UNION
	SELECT 'OutsandingInvoiceSummary' as table_name, Count(*) as row_count from OutsandingInvoiceSummary
	UNION
	SELECT 'OutstandingInvoiceSummary' as table_name, Count(*) as row_count from OutstandingInvoiceSummary
	UNION
	SELECT 'VendorPayment' as table_name, Count(*) as row_count from VendorPayment
	UNION
	SELECT 'SumInvoices' as table_name, Count(*) as row_count from SumInvoices
)  a

--SCALAR SUBQUERY
--what % of invoices are above average size?
SELECT COUNT(*)
	FROM
		Invoices
--120 invoices
WHERE 
	InvoiceTotal 
	>
	(
		SELECT
			AVG(InvoiceTotal)
		FROM
			Invoices
	)
--Old school
SELECT 
	CAST( ROUND(ROUND(numerator/denominator,4)*100,2) as varchar)+'%' 
from	(
	SELECT COUNT(*)*1.0 denominator
		FROM
			Invoices
	)
A
,
	(
		SELECT COUNT(*) numerator
		FROM
			Invoices
	--120 invoices
	WHERE 
		InvoiceTotal 
		>
		(
			SELECT
				AVG(InvoiceTotal)
			FROM
				Invoices
		)
	) B

--CTE Common Table Expression
WITH
	A
		AS
			(
			SELECT COUNT(*)*1.0 denominator
				FROM
					Invoices
			)
,
	B
		AS
			(
				SELECT COUNT(*) numerator
				FROM
					Invoices
			--120 invoices
			WHERE 
				InvoiceTotal 
				>
				(
					SELECT
						AVG(InvoiceTotal)
					FROM
						Invoices
				)
			) 
SELECT 
	CAST( ROUND(ROUND(B.numerator/A.denominator,4)*100,2) as varchar)+'%' 
from A,B	

Use Examples
--recursive CTE
WITH 
	EmployeeCTE
		AS
			(
			--root
			SELECT 
				EmployeeID
				,FirstName + ' '+LastName As [Name]
				,1 As [level]
				from Employees
				Where ManagerID is NULL
			UNION ALL
			SELECT 
				Employees.EmployeeID
				,FirstName + ' '+LastName As [Name]
				,1 + [level] As [level]
				from Employees
				JOIN
					EmployeeCTE
				ON
					Employees.ManagerID = EmployeeCTE.EmployeeID
			)
	SELECT
		*
	FROM
		EmployeeCTE
	ORDER BY
		LEVEL ASC,
		EmployeeID