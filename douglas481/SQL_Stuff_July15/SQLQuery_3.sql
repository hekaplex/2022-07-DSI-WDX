--Vendor IDs of companies who owe more than $5000
Select [VendorID], SUM([InvoiceTotal]-[PaymentTotal]) as [BalanceOwed]
From [dbo].[Invoices]
Group by [VendorID]
Having SUM([InvoiceTotal]-[PaymentTotal])>5000
Order by [VendorID];