USE Examples


--unoptimizable join
SELECT 
	VendorName
	, InvoiceNumber
	, InvoiceDate
	, InvoiceLineItemAmount AS LineItemAmount
	, AccountDescription
FROM 
	Vendors
	, Invoices
	, InvoiceLineItems
	, GLAccounts
--JOIN in a WHERE clause
WHERE 
	Vendors.VendorID = Invoices.VendorID
  AND 
	Invoices.InvoiceID = InvoiceLineItems.InvoiceID
  AND 
	InvoiceLineItems.AccountNo = GLAccounts.AccountNo
 AND 
	InvoiceTotal - PaymentTotal - CreditTotal > 0
ORDER BY VendorName, LineItemAmount DESC;

--better syntax
SELECT 
	VendorName
	, InvoiceNumber
	, InvoiceDate
	, InvoiceLineItemAmount AS LineItemAmount
	, AccountDescription
FROM 
	Vendors
	INNER JOIN Invoices
	ON Vendors.VendorID = Invoices.VendorID
	RIGHT JOIN InvoiceLineItems
	ON Invoices.InvoiceID = InvoiceLineItems.InvoiceID
	LEFT JOIN GLAccounts
	ON InvoiceLineItems.AccountNo = GLAccounts.AccountNo
WHERE
	InvoiceTotal - PaymentTotal - CreditTotal > 0
ORDER BY VendorName, LineItemAmount DESC;


SELECT 
	D.DeptNo
	,E.DeptNo
	,E.FirstName + ' '+E.LastName AS Employee
	,P.ProjectNo
FROM 
	Departments D
FULL JOIN
	Employees E
	ON 
		D.DeptNo = E.DeptNo
FULL JOIN
	Projects P
	ON
		E.EmployeeID = P.EmployeeID
	;
SELECT 
	D.*
	,E.*
	,P.*
FROM 
	Departments D
FULL JOIN
	Employees E
	ON 
		D.DeptNo = E.DeptNo
FULL JOIN
	Projects P
	ON
		E.EmployeeID = P.EmployeeID
	;
--UNION
	SELECT
		'Active' AS [Source]
		,InvoiceNumber
		,InvoiceTotal
		,TermsID
	FROM
		ActiveInvoices
-- AND in set theory terms
UNION ALL
	SELECT
		'Paid' AS [Source]
		,InvoiceNumber
		,InvoiceTotal
		,TermsID
	FROM
		PaidInvoices
--UNION ALL
SELECT
	'Active' AS [Source]
	,InvoiceNumber
	,InvoiceTotal
	,TermsID
FROM
	ActiveInvoices
--DISTINCT ... AND  in set theory terms
UNION
SELECT
	'Active' AS [Source]
	,InvoiceNumber
	,InvoiceTotal
	,TermsID
FROM
	ActiveInvoices


--CASE Statement from direct value of column
SELECT
	InvoiceNumber
	,InvoiceTotal
	,CASE TermsID
		WHEN 2 THEN '30 Days'
		ELSE '15 Days'
	END AS Terms
FROM
	ActiveInvoices

Use AP
--CASE from multiple columns or other Sarg (search argument) expression
SELECT 	
	CASE
		WHEN InvoiceTotal - PaymentTotal - CreditTotal > 0
			THEN 'Active'
		ELSE 'Paid'
	END As [Source]
	, InvoiceNumber
	, InvoiceDate
FROM 
	Invoices

Use Examples

--What customers do I have that are not employees
--Option 1 ... FROM C LEFT JOIN E ... WHERE E.* IS NULL
SELECT 
	C.CustomerFirst
	, C.CustomerLast 
FROM 
	Customers C
LEFT OUTER JOIN 
	Employees E
		ON
			C.CustomerFirst = E.FirstName
			AND 
			C.CustomerLast = E.LastName 
WHERE 
	E.FirstName IS NULL
	AND 
	E.LastName IS NULL

--Option 2 EXCEPT clause
SELECT C.CustomerFirst, C.CustomerLast FROM Customers C
EXCEPT
SELECT E.FirstName, E.LastName FROM Employees E

--What Employees are Customers?
SELECT C.CustomerFirst, C.CustomerLast FROM Customers C
INTERSECT
SELECT E.FirstName, E.LastName FROM Employees E

SELECT 
	C.CustomerFirst
	, C.CustomerLast 
FROM 
	Customers C
LEFT OUTER JOIN 
	Employees E
		ON
			C.CustomerFirst = E.FirstName
			AND 
			C.CustomerLast = E.LastName 
WHERE 
	E.FirstName IS NOT NULL
	AND 
	E.LastName IS NOT NULL
