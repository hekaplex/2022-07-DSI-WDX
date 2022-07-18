/*
Show me invoices with outstanding balances
*/
Select
	invoiceid
	,vendorid
	,invoicetotal
	,invoiceduedate
from
	invoices
where
	PaymentTotal
	= 0
