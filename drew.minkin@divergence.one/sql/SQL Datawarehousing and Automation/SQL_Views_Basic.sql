USE AP;

--manage by exception
GO
CREATE VIEW TopVendors
AS
	SELECT 
		TOP 5 percent
		VendorID
		,InvoiceTotal
	FROM
		Invoices
	ORDER BY InvoiceTotal DESC
GO	
SELECT * FROM TopVendors
GO
ALTER VIEW TopVendors
AS
	SELECT 
		TOP 5 percent
		VendorID
		,InvoiceTotal
		,InvoiceDueDate
	FROM
		Invoices
	ORDER BY InvoiceTotal DESC
GO
DROP VIEW TopVendors;
GO
CREATE VIEW
	OutstandingInvoices
	--EXPLICIT COLUMN LIST/order
	(VendorID
		,InvoiceTotal
		,InvoiceDueDate
		,BalanceDue)
AS
	SELECT 
	TOP 100 PERCENT
		VendorID
		,InvoiceTotal
		,InvoiceDueDate
		,InvoiceTotal - PaymentTotal - CreditTotal 
	FROM
		Invoices
	WHERE InvoiceTotal - PaymentTotal - CreditTotal > 0
	ORDER BY InvoiceTotal DESC
GO
	SELECT * FROM OutstandingInvoices
USE [AP]
GO
SELECT * FROM SYS.views
/****** Object:  View [dbo].[OutstandingInvoiceSummary]    Script Date: 9/6/2022 12:20:39 PM ******/
IF
EXISTS(SELECT * FROM SYS.views where name = 'OutstandingInvoiceSummary')
DROP VIEW [dbo].[OutstandingInvoiceSummary]
GO


GO
CREATE VIEW OutstandingInvoiceSummary
	AS
	WITH
	base
	AS
		(SELECT
		TOP 100 PERCENT
			V.VendorName
			,COUNT(*) as InvoiceQty
			,SUM(I.InvoiceTotal) InvoiceSum
			,SUM(I.BalanceDue) BalanceDue
			FROM	
			Vendors V
			JOIN
				(
				SELECT
					TOP 100 PERCENT
						VendorID
						,InvoiceTotal
						,InvoiceDueDate
						,InvoiceTotal - PaymentTotal - CreditTotal BalanceDue
					FROM
						Invoices
					WHERE InvoiceTotal - PaymentTotal - CreditTotal > 0
				) I
				ON I.VendorID = V.VendorID
		GROUP BY
					V.VendorName
		ORDER BY 3 DESC
		)
		select top 100 percent * from base order by 3 desc
GO
SELECT * FROM OutstandingInvoiceSummary order by 4 desc

GO
CREATE VIEW VendorPayment
--WITH SCHEMABINDING
	AS
		SELECT
			V.VendorName
			,I.InvoiceNumber
			,I.InvoiceTotal
			,I.InvoiceDate
			,I.PaymentDate
			,I.CreditTotal
			,I.PaymentTotal
			FROM	
			Vendors V
			JOIN
				Invoices I
				ON I.VendorID = V.VendorID
			WHERE InvoiceTotal - PaymentTotal - CreditTotal > 0

--preflight check
SELECT * FROM 
VendorPayment
	WHERE
		VendorName LIKE 'Malloy%'
		AND InvoiceNumber = 'P-0608'
--Malloy Lithographing Inc	P-0608	20551.18	2016-03-23 00:00:00	NULL	3255.118	0.00
UPDATE
	VendorPayment
	SET 
		PaymentTotal = 5000
		,CreditTotal = 5000 + CreditTotal
		,PaymentDate = GETDATE()
	WHERE
		VendorName LIKE 'Malloy%'
		AND InvoiceNumber = 'P-0608'

SELECT * FROM 
VendorPayment
	WHERE
		VendorName LIKE 'Malloy%'
		AND InvoiceNumber = 'P-0608'

SELECT
	sys.tables.name as TableName
	,sys.schemas.name as SchemaName
FROM
	sys.tables 
	JOIN
		sys.schemas
			ON
	sys.tables.schema_id =sys.schemas.schema_id

SELECT
	sys.views.name as ViewName
	,sys.schemas.name as SchemaName
FROM
	sys.views
	JOIN
		sys.schemas
			ON
	sys.views.schema_id =sys.schemas.schema_id

