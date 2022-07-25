SELECT
	ProductKey
	,SalesOrderNumber
	,OrderDate
	,UnitPrice
	,SalesOrderLineNumber
	
FROM FactInternetSales
WHERE UnitPrice > 1000

SELECT
	ProductKey
	,SalesOrderNumber
	,OrderDate
	,UnitPrice
	,SalesOrderLineNumber
	
FROM FactResellerSales
WHERE UnitPrice > 1000
ORDER BY SalesOrderLineNumber
SELECT *
FROM DimProduct
	WHERE ListPrice > 1000
/* Show items with list price more than 1000 dollars */


SELECT
	SalesAmount
,	Freight
	,TaxAmt
FROM FactInternetSales
WHERE
	SalesAmount + TaxAmt + Freight > 10000
SELECT 
	SalesTerritoryRegion




	



	







	



 