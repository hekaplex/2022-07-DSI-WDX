SELECT 
	 VendorName
	,VendorID
	,VendorAddress1
	,VendorCity
	,VendorState
FROM
Vendors
WHERE
VendorID Between '17' AND '25' 
ORDER BY VendorState;


SELECT VendorName, InvoiceNumber, InvoiceDate, InvoiceTotal
FROM Invoices JOIN Vendors
	ON Invoices.VendorID = Vendors.VendorID
WHERE InvoiceTotal - CreditTotal - PaymentTotal >2
ORDER BY VendorName; 