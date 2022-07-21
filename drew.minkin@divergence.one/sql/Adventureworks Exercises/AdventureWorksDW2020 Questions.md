## AdventureworksDW SQL Exercises
_[Adapted from SQLZoo](https://sqlzoo.net/wiki)_

### _Note: Be sure to include both Internet AND Reseller Sales_ 

 
### Easy SQL Questions

1. How many items with ListPrice more than $1000 have been sold?
    > 1.  Union Internet & reseller sales
    > 1.  Filter  > 1000 on OrderlineNumber
    > 1.  Count total ordernumber+orderlinenumber


1. Give the Sales Territory Region Name with Total orders for the region over $100000. Include the subtotal plus tax plus freight.

   > 1. Union Internet & reseller sales
   > 1. Add tax + freight to Order Amount per order
   > 1. Join with Sales Territory 
   > 1. Aggregate by terrotory region
   > 1. Filter for orders > $10000

1. A "Single Item Order" is a customer order where only one item is ordered. Show the SalesOrderNumber and the UnitPrice for every Single Item Order.
    > 1. Union Internet & reseller sales
    > 1. Aggregate SalesOrderNumber for SUM of salesAmount and use HAVING filter for Count(*) = 1 and SUm(OrderQuantity) of 1

1. Show the French product description for product with Product alternate key 'FR-M94S-42'.
    > 1. Filter Product table

### Medium SQL Questions

1. Where did the racing socks go? List the product name and the State for all Customers, total orders and total amount of product  'Racing Socks' sold who ordered ProductModel 'Racing Socks' for Internet sales.

    > 1. Join Geography, Customers, Internet Sales and Product
    > 1. Filter for models with 'Racing Socks' using LIKE
    > 1. Aggregate by State 


1. Use the SubTotal value in Internet Sales to list orders from the largest to fv the smallest. For each order show the State/Province Name and the SubTotal and the total weight of the order.

    > 1. Join with Customer and Geography to get to State and product weight
    > 1. Aggregate to sum by 
    > 1. Order the SalesAmount descending

1. How many products via Internet in ProductCategory 'Components' have been sold to an address in 'London' in UK?

    > 1. Join Sales to Customer, Geography, produc and Category
    > 1. Filter by Category, Country  and City
    > 1. Aggregate to count 

### Hard SQL Questions
1. For every Internet customer in the city of Chula Vista, CA show AddressLine1 - if there is no shipping address leave it blank. Use one row per customer.
    > 1. Join internet, Customer and Geography
    > 1. filter by Geogrpy city and state
    > 1. Use an ISNULL on shpping address columns to get a blank instead of NULL


1. For each order show the SalesOrderNumber and SubTotal calculated three ways:
    > All three require a union of internet and resller sales and an aggregate
    1. From the SalesOrderNumber
    > This is a straight grouping by this columne
    2. Sum of OrderQty*UnitPrice
    > This is a aggregate of the sum of these products of each line number
    3. Sum of OrderQty*ListPrice
    > This requires a join with Product
    Extra Credit - Join all three calculations into one table

1. Show the best selling ProductSubCategory by reason for sale.
    > 1. Join the two fact tables, Salesreason, Product, and Product SubCategory tables
    > 1. Aggregate at the count of sales reason type and subcategory the sum of all sales
    > 1. Create a ROW_NUMBER() column called SubcategoryRank paritioned by Reason ordered by total quantty sold
    > 1. Filter where SubcategoryRank = 1  

1. Show how many orders are in the following ranges (in $):

    | RANGE | Num Orders |
    | ----------- | ----------- |  
    | 0 - 99 | |
    | 100- 999 | |
    | 1000-9999 | |
    | 10000+ | |
    > 1. Aggreate SalesAmount by SalesOrderNumber
    > 1. Create a RANGE column
    > 1. Aggregate to count and sort by RANGE

1. For reeller sales, list the name and addresses of resellers containing the word 'Bike' (upper or lower case) and companies containing 'cycle' (upper or lower case). Ensure that the 'bike's are listed before the 'cycles's .
    > 1. Join Reseller and Reseller Sales and Product
    > 1. Filter using LIKE and OR

1. Show the total order value for each Sales Territory Region. List by value with the highest first for both Internet and Reseller, showing which sale type (Internet or Reseller).
    > 1. UNION  Internet and Reseller Sales, adding a column of SalesSource that shows 'Internet' or 'Reseller'
    > 1. Join combines table with Sales territory table
    > 1. Aggregate by region and SalesSource

1. Find the best customer in each Sales Territory Region in Internet Sales.  
    > 1. Join Customer and Sales Territory with Sales
    > 1. Aggregate at the grain of company and territory the sum of all sales
    > 1. Create a ROW_NUMBER() column called TerritoryRank paritioned by Terrotory ordered by total sales
    > 1. Filter where TerritoryRank = 1   
