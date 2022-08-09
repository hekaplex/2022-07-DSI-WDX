SELECT DISTINCT
-- Using this as a view for what citys have the least paid invoices
-- Not sure why the "Distinct" isnt filtering out the non-unique VendorIDs
	V.VendorID
	,V.vendorCity
	AS City
	,I.PaymentTotal
	AS Paid
FROM Vendors V
JOIN Invoices I
	ON V.VendorID = I.VendorID
	WHERE I.Paymenttotal <100
	ORDER BY City ASC


