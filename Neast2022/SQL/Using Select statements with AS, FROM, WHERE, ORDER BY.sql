SELECT
VendorID AS ID, VendorName AS 'Name', VendorAddress1 AS 'Address', 
VendorCity AS City, VendorState AS 'State' 
From Vendors
WHERE
VendorID > 12 
ORDER BY VendorName



