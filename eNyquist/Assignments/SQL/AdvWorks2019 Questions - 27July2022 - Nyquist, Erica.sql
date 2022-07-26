--Erica Nyquist
--27July2022
--Data Science Immersive

--Adventureworks2019 SQL Exercises

--Easy SQL Questions
--I)	How many items with ListPrice more than $1000 have been sold?

SELECT
	COUNT(*) 
		AS Total
FROM 
	Production.ProductListPriceHistory
WHERE 
	ListPrice > $1000;

--II)	Give the Store Name of those customers with Total orders over $100,000. 
--Include the (subtotal) plus (tax) plus (freight).

SELECT
	Customer.StoreID
FROM
	Sales.SalesOrderHeader
JOIN
	Sales.Customer
	ON 
	SalesOrderHeader.CustomerID = Customer.CustomerID
WHERE
	SalesOrderHeader.SubTotal + SalesOrderHeader.TaxAmt + SalesOrderHeader.Freight > 100000;
		
--Medium SQL Questions
--I)	A "Single Item Order" is a customer order where only one item is ordered. 
--Show the SalesOrderID and the UnitPrice for every Single Item Order.

SELECT
	SalesOrderID, UnitPrice
FROM
	Sales.SalesOrderDetail
WHERE
	OrderQty = 1
ORDER BY
	SalesOrderID;


--II)	Where did the racing socks go? List the product name and the 
--Store Name for all Customers who ordered ProductModel 'Racing Socks'.


--III)	Show the product description for culture 'fr' for product with ProductID 736.


--IV)	Use the SubTotal value in SaleOrderHeader to list orders from the largest to the smallest.
--For each order show the Store Name and the SubTotal and the total weight of the order.


--V)	How many products in ProductCategory 'Components' have been sold to an address in 'London'?
