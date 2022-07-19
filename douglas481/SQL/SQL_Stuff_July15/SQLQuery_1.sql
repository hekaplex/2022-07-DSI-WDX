--Vendors and their states who owe money
Select [VendorName], [VendorState], [InvoiceTotal]-[PaymentTotal] as [BalanceOwed]
From [dbo].[Vendors]
Join [dbo].[Invoices]
On [Vendors].[VendorID]=[Invoices].[VendorID]
Where [InvoiceTotal]-[PaymentTotal]>0
Order by BalanceOwed asc;