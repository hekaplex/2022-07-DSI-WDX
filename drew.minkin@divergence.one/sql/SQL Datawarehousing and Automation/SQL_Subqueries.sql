--Subqueries
Use AP
--GOAL: above average invoices
SELECT 
	InvoiceNumber
	,InvoiceDate
	,InvoiceTotal
FROM Invoices
WHERE InvoiceTotal > 
--scalar subquery
	(
		SELECT 
			AVG(InvoiceTotal)
		FROM 
			Invoices
	) --1879.7413
ORDER BY
	InvoiceTotal DESC;

--"old school" w join
--GOAL: Invoices w Vendors in CA
--table based subquery
SELECT
	I.InvoiceNumber
	,I.InvoiceDate
	,I.InvoiceTotal
	,V.VendorName
FROM 
	Invoices I
	JOIN
		Vendors V
		ON
			I.VendorID = V.VendorID
WHERE VendorState = 'CA'
--subquery
ALTER PROCEDURE sample_report 
--default parameter 
@state varchar(2) = 'CA'
AS
SELECT
	 I.InvoiceNumber [Invoice Number]
	,I.InvoiceDate  [Invoice Date]
	,I.InvoiceTotal [Invoice Total] 
	,I.VendorID 	[Vendor ID]
FROM 
	Invoices AS I
WHERE 
		VendorID
		IN
		(
			SELECT
				VendorID
			FROM
				Vendors
			WHERE
				VendorState = @state
		)

EXEC sample_report @state = 'MA'
--relational algebra
--GOAL Big Spenders based on one vendor
--ANY and ALL clauses
SELECT
	 I.InvoiceNumber [Invoice Number]
	,I.InvoiceTotal [Invoice Total] 
	,I.InvoiceDate  [Invoice Date]
	,V.VendorName 	[Vendor Name]
FROM 
	Invoices AS I
	JOIN
		Vendors V
		ON
			I.VendorID = V.VendorID
WHERE 
		InvoiceTotal > ALL
		(
			SELECT
				I.InvoiceTotal [Invoice Total] 
			FROM 
				Invoices AS I
			WHERE
				I.VendorID = 34
				/*
				116.54
				1083.58
				*/
		)
ORDER BY [Invoice Total] ASC

SELECT
	 I.InvoiceNumber [Invoice Number]
	,I.InvoiceTotal [Invoice Total] 
	,I.InvoiceDate  [Invoice Date]
	,V.VendorName 	[Vendor Name]
FROM 
	Invoices AS I
	JOIN
		Vendors V
		ON
			I.VendorID = V.VendorID
WHERE 
		InvoiceTotal > ANY
		(
			SELECT
				I.InvoiceTotal [Invoice Total] 
			FROM 
				Invoices AS I
			WHERE
				I.VendorID = 115
				/*
				6.00
				6.00
				25.67
				6.00
				*/
		)
ORDER BY [Invoice Total] ASC

--EXISTS CLAUSE
--Vendors with no Invoices
SELECT
	V.VendorCity
	,V.VendorState
	,V.VendorName
FROM 
	Vendors V
	--similar to except
WHERE NOT EXISTS
	(
		SELECT
			*
		FROM 
			Invoices AS I --, vendors as V
		WHERE
			I.VendorID = V.VendorID
	)
--Common Table Expression (CTE)
WITH
	Summary
	--All vendors per state
		AS
		(
		SELECT
			V.VendorState
			,V.VendorName
			,SUM(I.InvoiceTotal) AS SumofInvoices
		FROM 
			Vendors V
		JOIN			
			Invoices AS I
			ON
			I.VendorID = V.VendorID
		GROUP BY
			V.VendorState
			,V.VendorName
		)
	,
	--Top vendors per state
	TopInState
	AS
		(
		SELECT
			VendorState
			,MAX(SumofInvoices) MaxSumofInvoices
		FROM 
			Summary
		GROUP BY
			VendorState
		)
	SELECT 
		S.VendorState
		,S.VendorName
		,T.MaxSumofInvoices
		FROM Summary S
		join
			TopInState T
			on
			S.VendorState = T.VendorState

--recursive CTE
WITH
	EmployeesCTE
		AS
			(
				--root of hierarchy
				SELECT 
					EmployeeID
					,FirstName + ' '+LastName As [Employee Name]
					, 1 AS [Rank]
					,ManagerID 
					from Employees
					WHERE ManagerID IS NULL
				UNION ALL
				--recursive branch/leaf members
				SELECT 
					Employees.EmployeeID
					,FirstName + ' '+LastName As [Employee Name]
					, 1 + [Rank]
					,Employees.ManagerID 
					from Employees
						JOIN EmployeesCTE
						ON  Employees.ManagerID = EmployeesCTE.EmployeeID
			)
		SELECT
			*
		FROM
			EmployeesCTE
		ORDER BY
			[Rank], EmployeeID;
