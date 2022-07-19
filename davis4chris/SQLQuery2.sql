SELECT        Vendors.VendorID, Invoices.InvoiceID
FROM            Invoices INNER JOIN
                         Vendors ON Invoices.VendorID = Vendors.VendorID



