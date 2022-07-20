/*Who are the vendors that are local to zip codes starting with a 7 */
SELECT *, 
CASE
WHEN VendorZipCode like '7%' THEN 'Local'
ELSE 'Not Local'
END
AS VendorLocation
FROM Vendors
ORDER BY 
VendorZipCode
