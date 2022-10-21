/*How many of our updated contacts have been with us since 2015 and spent >= $2500 this year? */
SELECT I.VendorID
    , I.InvoiceDate 
    , I.PaymentTotal
FROM Invoices I
INNER JOIN InvoiceArchive A
ON I.VendorID = A.VendorID
 

SELECT I.VendorID
    , I.InvoiceDate 
    , I.PaymentTotal
    , A.VendorID
    , A.InvoiceDate 
    , A.PaymentTotal
FROM Invoices I
    , InvoiceArchive A


