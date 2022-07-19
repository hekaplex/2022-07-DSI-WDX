/****** Script for SelectTopNRows command from SSMS  ******/
SELECT
--column list
V.VendorName
,V.VendorCity
,I.InvoiceDate
,I.InvoiceTotal
FROM 
--Table Alias - shortcut long form
Invoices AS I
JOIN 
--Table Alias - shortcut short form
Vendors V
ON I.VendorID = V.VendorID

--shows version of SQL Server
SELECT @@version

--Query Designer 
SELECT        Vendors.VendorName, SUM(Invoices.InvoiceTotal) AS Expr1
FROM            Invoices INNER JOIN
                         Vendors ON Invoices.VendorID = Vendors.VendorID
GROUP BY Vendors.VendorName