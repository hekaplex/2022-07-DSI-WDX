-- What Vendors have a VendorID between 17 and 25? --

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
ORDER BY VendorState
