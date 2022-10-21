CREATE VIEW TodaysSalesList
AS
SELECT VendorName, VendorContactLName, VendorPhone, VendorAddress1, VendorAddress2
FROM
Vendors
WHERE VendorID IN (Select VendorID FROM Invoices);

