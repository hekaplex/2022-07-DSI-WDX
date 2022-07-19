/* 
Vendors with out standing balances
*/

select 
	VendorID, SUM([Invoicetotal]-[PaymentTotal]) as [outstanding]
from Invoices
Group by VendorID
having SUM([invoiceTotal]-[PaymentTotal]) > 0






