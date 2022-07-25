Select  
-- Looking at the highest paying customers and getting their address
	v.VendorName
	,SUM(I.PaymentTotal) as 'Total Payments'
	,VendorAddress1 +', '+ VendorCity+', '+ VendorState  AS Address
From vendors V
JOIN Invoices I
	ON V.VendorID = I.VendorID
	Group By v.VendorName, VendorAddress1 +', '+ VendorCity+', '+ VendorState 
	order by [Total Payments] Desc


Select DIstinct
	G.AccountDescription
	,G.AccountNo
	,v.VendorState
From vendors V
Left JOIN GLAccounts G
	ON V.DefaultAccountNo = G.AccountNo
	ORDER BY G.AccountDescription, V.VendorState

--classwork below.  looking at it for inspiration
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
UNION
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
UNION ALL
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


--end classwork