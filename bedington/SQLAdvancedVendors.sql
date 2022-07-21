SELECT * FROM
    Vendors
WHERE VendorState IN ('AR', 'TX', 'NY')
/* Show vendors in the states of Arkansas, Texas, and New York */

SELECT 
    VendorName, VendorZipCode, VendorState
FROM 
    Vendors
WHERE 
    VendorZipCode BETWEEN '70000' AND '95000'
ORDER BY 
    VendorID
/* Show vendors with a zip code between 70000 and 95000 listed by Vendor ID */

SELECT 
	'Active' AS [Source]
	,InvoiceNumber
	,InvoiceTotal
	,TermsID
FROM
    ActiveInvoices
UNION
SELECT
	'Paid' AS [Source]
	,InvoiceNumber
	,InvoiceTotal
	,TermsID
FROM
	PaidInvoices

/* Show paid invoices vs active invoices */

SELECT 
	InvoiceNumber
	,InvoiceTotal
	,CASE TermsID
			WHEN 2 THEN '15 Days'
			ELSE '10 Days'
	END AS Terms
FROM
	ActiveInvoices
	/* Show case statement based on the value of termsID column */