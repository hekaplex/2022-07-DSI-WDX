SELECT 
--SS.Name StoreName, SUM(SubTotal) SubTotal, SUM(weight*orderqty) as total_weight
COUNT(*)
FROM Sales.SalesOrderHeader SOH
JOIN Sales.SalesOrderDetail SOD
ON SOD.SalesOrderID = SOH.SalesOrderID
JOIN Production.Product PD
ON SOD.productID = PD.ProductID
JOIN Sales.Customer SC
ON SOH.CustomerID = SC.CustomerID
JOIN Person.Person PP
ON PP.BusinessEntityID = SC.PersonID
JOIN [Person].BusinessEntity PB
ON PB.BusinessEntityID=PP.BusinessEntityID 
JOIN Sales.Store SS
ON PB.[BusinessEntityID] = SS.[BusinessEntityID]
--GROUP BY SS.Name
--ORDER BY Subtotal DESC
GO

--Sales-> P.BE -> Person _> Customer -< SOH


select count(*)
FROM  
-- Sales.Customer SC
--JOIN 
Person.Person PP
--ON PP.BusinessEntityID = SC.PersonID
JOIN 
[Person].BusinessEntity PB
ON PB.BusinessEntityID=PP.BusinessEntityID 
JOIN Sales.Store SS
ON PB.[BusinessEntityID] = SS.[BusinessEntityID]

