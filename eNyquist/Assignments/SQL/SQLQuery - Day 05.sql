/*
Vendor Invoice data.
*/

SELECT
    *
FROM
    INVOICES
/*
Show vendors with a balance due. *Please note: This borrows heavily from "Murach's SQL Server 2019..." "Section 1"
*/
SELECT
    InvoiceNumber, InvoiceDate, InvoiceTotal, PaymentTotal, CreditTotal, InvoiceDueDate,
    InvoiceTotal-PaymentTotal-CreditTotal
AS
    BalanceDue
FROM
    Invoices
WHERE
    InvoiceTotal-PaymentTotal-CreditTotal>0
ORDER BY
    InvoiceDueDate;
/*
Vendor Name dataset inputted.
*/
SELECT
    VendorName, InvoiceNumber, InvoiceDate, InvoiceTotal
FROM
    Vendors
INNER JOIN
    Invoices
ON
    Vendors.VendoriD = Invoices.VendoriD
WHERE
    InvoiceTotal >= 0
ORDER BY
    VendorName, InvoiceTotal DESC;
/*
Vendors with outstanding balance due (more than 3 years)
*/
SELECT
    VendorName, InvoiceNumber, InvoiceDate, InvoiceTotal
AS
    OutstandingBalanceDue
FROM
    Vendors
JOIN
    Invoices
ON
    Vendors.VendorID=Invoices.VendorID
WHERE
    invoices.invoiceDate BETWEEN '2016-01-01' and '2021-12-31'
ORDER BY
    InvoiceDate
/*
Vendors with an outstanding balance of more than $500.
*/
SELECT
    VendorName, InvoiceNumber, InvoiceDate, InvoiceTotal
AS
    OutstandingBalanceDue
FROM
    Vendors
JOIN
    Invoices
ON
    Vendors.VendorID=Invoices.VendorID
WHERE
    invoices.invoiceDate 
    

BETWEEN '2016-01-01' and '2021-12-31' 
    AND
    InvoiceTotal>=500
ORDER BY
    OutstandingBalanceDue