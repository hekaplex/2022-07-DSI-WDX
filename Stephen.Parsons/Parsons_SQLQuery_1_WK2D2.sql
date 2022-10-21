/* Who are our biggest single-invoice customers? */
SELECT I.VendorID
    , I.InvoiceDate 
    , I.PaymentTotal
FROM Invoices I
INNER JOIN InvoiceArchive A
ON I.VendorID = A.VendorID 
 
UNION
SELECT I.VendorID
    , I.InvoiceDate 
    , I.PaymentTotal
FROM Invoices I
WHERE I.InvoiceDate LIKE '2022-%' 
ORDER BY PaymentTotal DESC  
