SELECT
	 
	SalesOrderNumber
	,OrderDate
	,UnitPrice
	
	
FROM FactInternetSales
WHERE UnitPrice > 1000

SELECT
	SalesOrderNumber
	,OrderDate
	,UnitPrice
	
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
/* Show total sales including frieght and tax. */


SELECT 
	SalesOrderNumber
	,UnitPrice

FROM FactInternetSales
WHERE OrderQuantity = 1;
SELECT
	SalesOrderNumber
	,UnitPrice
FROM FactResellerSales
/* Show Single item orders */

SELECT
	ProductAlternateKey
	,ProductCategoryKey
	,ProductCategoryAlternateKey
	FROM DimProduct
JOIN DimProductCategory 
ON DimProductCategory.ProductCategoryKey = DimProductCategory.ProductCategoryKey 
WHERE 
ProductAlternateKey = 'FR-M94S-42'
/* Find products with product alternate category key FR-M94S-42 */





