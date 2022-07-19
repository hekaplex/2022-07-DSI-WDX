SELECT 
-- Looking for the highest income state paid to date
    V.VendorState 
	,SUM(I.Paymenttotal) [Paid]
From Vendors V
JOIN Invoices I
	ON V.VendorID = I.VendorID
	Group By V.Vendorstate
	Order By Paid Desc

