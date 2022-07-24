--what states are in our KS invoices
SELECT 
	DISTINCT
	V.VendorState
	,KS.[VendorID]
	,KS.[InvoiceNumber]
	--base table with a table alias
  FROM 
  -- box for query called [AP].[dbo].[KS_InvoiceArchive] 
  (
  --correlated table subquery
  --inline nested query in the middle
	  SELECT 
	[InvoiceID], [VendorID], [InvoiceNumber]
	FROM [dbo].[InvoiceArchive]
	WHERE InvoiceID BETWEEN 3 AND 8
  )
  AS KS
LEFT OUTER JOIN
	[dbo].[Vendors] AS V
	--join criteria
	ON KS.VendorID = V. VendorID
--cartesian product, all pairs query, dot product , cross join
--SELECT 732/6 --122
--122 rows in Vendors
--6 rows in KSinvoices, 2 distinct VendorID values

--Common Table Expression (CTE)
--front load the table alias/subquery
;

WITH
	KS
		AS
		(
			  SELECT 
				[InvoiceID], [VendorID], [InvoiceNumber]
				FROM [dbo].[InvoiceArchive]
				WHERE InvoiceID BETWEEN 3 AND 8
		)
SELECT 
	DISTINCT
	V.VendorState
	,KS.[VendorID]
	,KS.[InvoiceNumber]
	--base table with a table alias from CTE
  FROM  KS
LEFT OUTER JOIN
	[dbo].[Vendors] AS V
	--join criteria
	ON KS.VendorID = V. VendorID

--subquery in a filter

SELECT 
* from Invoices
WHERE
InvoiceTotal
> 
--scalar subquery
(
SELECT 
AVG(InvoiceTotal)
 from Invoices
)