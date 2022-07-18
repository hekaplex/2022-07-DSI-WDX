SELECT
-- Showing the vendors that have paid their bills late
    V.VendorID
	,I.PaymentDate
	,I.InvoiceDueDate
From Vendors V
JOIN Invoices I
	ON I.VendorID = V.VendorID
	Where I.PaymentDate > I.InvoiceDueDate
	Order BY V.VendorID