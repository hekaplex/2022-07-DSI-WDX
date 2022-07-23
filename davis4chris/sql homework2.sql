--CUSTOMERS IN IL
select
	CustID
	,CustomerFirst
	,CustomerLast
FROM Customers

WHERE CustState IN ('IL')

--- PAID INVOICES FROM 2016 Q1
Select
	invoiceid
	,invoicenumber
from
	dbo.PaidInvoices
Where
	PaymentDate between '2016-01-01' and  '2016-03-31'

--List of all employees, old and new	
select LastName, FirstName, DeptNo
from
	EmployeesOld
union 
Select LastName, FirstName, DeptNo 
from	Employees

--List of vendors, minus vendors from paid accounts
select 
	 VendorID
from
	Vendors
except
select
	 VendorID
from 
	PaidInvoices

--join of all paid and active accounts
select
	*
From
	paidaccounts
	Join
Select
	*
from
	Activeaccounts





