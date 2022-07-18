/*
Show me the states with total invoices above $1,000
*/
SELECT 
    V.VendorState [State]
    --aggregate function SUM,COUNT,MIN,MAX,STDEV
    ,SUM(I.InvoiceTotal)
FROM Vendors V
JOIN Invoices I
    ON V.VendorID = I.VendorID
GROUP BY V.VendorState
--filter of aggregate
HAVING SUM(I.InvoiceTotal) > 1000