USE AdventureWorks2019
/*
	feature engineering
*/
--binning - equal size
GO  
WITH Raw_quartile
AS
(
SELECT p.FirstName, p.LastName  
    ,NTILE(4) OVER(ORDER BY SalesYTD DESC) AS Quartile  
	,PERCENTILE_DISC(.50) WITHIN GROUP (ORDER BY SalesYTD DESC) OVER () As [Median]
    ,CONVERT(NVARCHAR(20),s.SalesYTD,1) AS SalesYTD  
    , a.PostalCode  
FROM Sales.SalesPerson AS s   
INNER JOIN Person.Person AS p   
    ON s.BusinessEntityID = p.BusinessEntityID  
INNER JOIN Person.Address AS a   
    ON a.AddressID = p.BusinessEntityID  
WHERE TerritoryID IS NOT NULL   
    AND SalesYTD <> 0
)
SELECT 
	Quartile
	,Min(SalesYTD) Min_SalesYTD
	,Max(SalesYTD) Max_SalesYTD
	from Raw_Quartile
GROUP BY
	Quartile
ORDER BY
	Quartile

	;
	--median 2,458,535.62
--non-join shaping
--APPLY

SELECT DeptID, DeptName, DeptMgrID, EmpID, EmpLastName, EmpSalary  
FROM Departments d    
CROSS APPLY dbo.GetReports(d.DeptMgrID) ;  

SELECT DeptID, DeptName, DeptMgrID, EmpID, EmpLastName, EmpSalary  
FROM Departments d   
OUTER APPLY dbo.GetReports(d.DeptMgrID) ; 

/*
USE master;  
GO  
SELECT bucketid,plan_handle
,dbid, query_plan   
FROM sys.dm_exec_cached_plans AS cp   
OUTER APPLY sys.dm_exec_query_plan(cp.plan_handle); 
*/

--pivot
SELECT VendorID, [250] AS Emp1, [251] AS Emp2, [256] AS Emp3, [257] AS Emp4, [260] AS Emp5  
FROM   
(SELECT PurchaseOrderID, EmployeeID, VendorID  
FROM Purchasing.PurchaseOrderHeader) p  
PIVOT  
(  
COUNT (PurchaseOrderID)  
--FOR as filter for column
FOR EmployeeID IN  
( [250], [251], [256], [257], [260] )  
) AS pvt  
ORDER BY pvt.VendorID;  

--unpivot
CREATE TABLE pvt (VendorID INT, Emp1 INT, Emp2 INT,  
    Emp3 INT, Emp4 INT, Emp5 INT);  
GO  
INSERT INTO pvt VALUES (1,4,3,5,4,4);  
INSERT INTO pvt VALUES (2,4,1,5,5,5);  
INSERT INTO pvt VALUES (3,4,3,5,4,4);  
INSERT INTO pvt VALUES (4,4,2,5,5,4);  
INSERT INTO pvt VALUES (5,5,1,5,5,5);  
GO  
select * from pvt
-- Unpivot the table.  
SELECT VendorID, Employee, Orders  
FROM   
   (SELECT VendorID, Emp1, Emp2, Emp3, Emp4, Emp5  
   FROM pvt) p  
UNPIVOT  
	--Orders is Value column
	--Employee is Attribute column
	--values for all rows will be in  Orders
   (Orders 
	--FOR as filter for column names
	FOR Employee IN   
   --column names pre-unpivot to unpivot
      (Emp1, Emp2, Emp3, Emp4, Emp5)  
)AS unpvt;  
GO  


/*
XML
*/

/*
	FOR XML
*/

GO	
SELECT 
      Cust.CustomerID,
--       OrderHeader.CustomerID,
       OrderHeader.SalesOrderID,
       OrderHeader.Status
FROM Sales.Customer Cust 
INNER JOIN Sales.SalesOrderHeader OrderHeader
ON Cust.CustomerID = OrderHeader.CustomerID
--FOR = Parse/generateXML
FOR XML RAW;

SELECT  1 as Tag,  
        0 as Parent,  
        SalesOrderID  as [OrderHeader!1!SalesOrderID],  
        OrderDate     as [OrderHeader!1!OrderDate],  
        CustomerID    as [OrderHeader!1!CustomerID],  
        NULL          as [SalesPerson!2!SalesPersonID],  
        NULL          as [OrderDetail!3!SalesOrderID],  
        NULL          as [OrderDetail!3!LineTotal],  
        NULL          as [OrderDetail!3!ProductID],  
        NULL          as [OrderDetail!3!OrderQty]  
FROM   Sales.SalesOrderHeader  
WHERE     SalesOrderID=43659 or SalesOrderID=43661  
UNION ALL   
SELECT 2 as Tag,  
       1 as Parent,  
        SalesOrderID,  
        NULL,  
        NULL,  
        SalesPersonID,    
        NULL,           
        NULL,           
        NULL,  
        NULL           
FROM   Sales.SalesOrderHeader  
WHERE     SalesOrderID=43659 or SalesOrderID=43661  
UNION ALL  
SELECT 3 as Tag,  
       1 as Parent,  
        SOD.SalesOrderID,  
        NULL,  
        NULL,  
        SalesPersonID,  
        SOH.SalesOrderID,  
        LineTotal,  
        ProductID,  
        OrderQty     
FROM    Sales.SalesOrderHeader SOH,Sales.SalesOrderDetail SOD  
WHERE   SOH.SalesOrderID = SOD.SalesOrderID  
AND     (SOH.SalesOrderID=43659 or SOH.SalesOrderID=43661)  
ORDER BY [OrderHeader!1!SalesOrderID], [SalesPerson!2!SalesPersonID],  
         [OrderDetail!3!SalesOrderID],[OrderDetail!3!LineTotal]  
--FOR = Parse/generateXML
FOR XML EXPLICIT;  

/*
	OPENXML

*/
DECLARE @idoc INT, @doc VARCHAR(1000);  
SET @doc ='  
<ROOT>  
<Customer CustomerID="VINET" ContactName="Paul Henriot">  
   <Order CustomerID="VINET" EmployeeID="5" OrderDate="1996-07-04T00:00:00">  
      <OrderDetail OrderID="10248" ProductID="11" Quantity="12"/>  
      <OrderDetail OrderID="10248" ProductID="42" Quantity="10"/>  
   </Order>  
</Customer>  
<Customer CustomerID="LILAS" ContactName="Carlos Gonzlez">  
   <Order CustomerID="LILAS" EmployeeID="3" OrderDate="1996-08-16T00:00:00">  
      <OrderDetail OrderID="10283" ProductID="72" Quantity="3"/>  
   </Order>  
</Customer>  
</ROOT>';  
--Create an internal representation of the XML document.  
EXEC sp_xml_preparedocument @idoc OUTPUT, @doc;  
-- Execute a SELECT statement that uses the OPENXML rowset provider.  
SELECT    *  
FROM       OPENXML (@idoc, '/ROOT/Customer',1)  
            WITH (CustomerID  VARCHAR(10))
            ,  
--OPENXML mapping between columns and XML attributes
DECLARE @idoc INT, @doc VARCHAR(1000);   
SET @doc ='  
<ROOT>  
<Customer CustomerID="VINET" ContactName="Paul Henriot">  
   <Order OrderID="10248" CustomerID="VINET" EmployeeID="5"   
           OrderDate="1996-07-04T00:00:00">  
      <OrderDetail ProductID="11" Quantity="12"/>  
      <OrderDetail ProductID="42" Quantity="10"/>  
   </Order>  
</Customer>  
<Customer CustomerID="LILAS" ContactName="Carlos Gonzlez">v  
   <Order OrderID="10283" CustomerID="LILAS" EmployeeID="3"   
           OrderDate="1996-08-16T00:00:00">  
      <OrderDetail ProductID="72" Quantity="3"/>  
   </Order>  
</Customer>  
</ROOT>';   
  
--Create an internal representation of the XML document.  
EXEC sp_xml_preparedocument @idoc OUTPUT, @doc;   
  
-- SELECT stmt using OPENXML rowset provider  
SELECT *  
FROM   OPENXML (@idoc, '/ROOT/Customer/Order/OrderDetail',2)   
         WITH (OrderID       int         '../@OrderID',
               CustomerID  varchar(10) '../@CustomerID',
               OrderDate   datetime    '../@OrderDate',
               ProdID      int         '@ProductID',
               Qty         int         '@Quantity');
  

--OPENXML Edge table
DECLARE @idoc INT, @doc VARCHAR(1000);   
SET @doc ='  
<ROOT>  
<Customers CustomerID="VINET" ContactName="Paul Henriot">  
   <Orders CustomerID="VINET" EmployeeID="5" OrderDate=  
           "1996-07-04T00:00:00">  
      <Order_x0020_Details OrderID="10248" ProductID="11" Quantity="12"/>  
      <Order_x0020_Details OrderID="10248" ProductID="42" Quantity="10"/>  
   </Orders>  
</Customers>  
<Customers CustomerID="LILAS" ContactName="Carlos Gonzlez">  
   <Orders CustomerID="LILAS" EmployeeID="3" OrderDate=  
           "1996-08-16T00:00:00">  
      <Order_x0020_Details OrderID="10283" ProductID="72" Quantity="3"/>  
   </Orders>  
</Customers>  
</ROOT>';  
  
--Create an internal representation of the XML document.  
EXEC sp_xml_preparedocument @idoc OUTPUT, @doc;   
  
-- SELECT statement that uses the OPENXML rowset provider.  
SELECT    *  
FROM       OPENXML (@idoc, '/ROOT/Customers')   
EXEC sp_xml_removedocument @idoc;

/*
JSON
*/

select * from INFORMATION_SCHEMA.COLUMNS where DATA_TYPE like '%json%'
/*
	FOR JSON
*/
SELECT PersonID,FullName,
  JSON_QUERY(CustomFields,'$.OtherLanguages') AS Languages
FROM Application.People
SELECT StockItemID, StockItemName,
         JSON_QUERY(Tags) as Tags,
         JSON_QUERY(CONCAT('["',ValidFrom,'","',ValidTo,'"]')) ValidityPeriod
FROM Warehouse.StockItems


SELECT 
      Cust.CustomerID,
--       OrderHeader.CustomerID,
       OrderHeader.SalesOrderID,
       OrderHeader.Status
FROM Sales.Customer Cust 
INNER JOIN Sales.SalesOrderHeader OrderHeader
ON Cust.CustomerID = OrderHeader.CustomerID
--FOR = Parse/generate JSON
FOR JSON PATH

/*
	OPENJSON

*/
/*
DECLARE @json NVARCHAR(2048) = N'{
   "String_value": "John",
   "DoublePrecisionFloatingPoint_value": 45,
   "DoublePrecisionFloatingPoint_value": 2.3456,
   "BooleanTrue_value": true,
   "BooleanFalse_value": false,
   "Null_value": null,
   "Array_value": ["a","r","r","a","y"],
   "Object_value": {"obj":"ect"}
}';

SELECT * FROM OpenJson(@json);

DECLARE @json NVARCHAR(4000) = N'{  
      "path": {  
            "to":{  
                 "sub-object":["en-GB", "en-UK","de-AT","es-AR","sr-Cyrl"]  
                 }  
              }  
 }';

SELECT [key], value
FROM OPENJSON(@json,'$.path.to."sub-object"')
*/
DECLARE @json NVARCHAR(MAX) = N'[  
  {  
    "Order": {  
      "Number":"SO43659",  
      "Date":"2011-05-31T00:00:00"  
    },  
    "AccountNumber":"AW29825",  
    "Item": {  
      "Price":2024.9940,  
      "Quantity":1  
    }  
  },  
  {  
    "Order": {  
      "Number":"SO43661",  
      "Date":"2011-06-01T00:00:00"  
    },  
    "AccountNumber":"AW73565",  
    "Item": {  
      "Price":2024.9940,  
      "Quantity":3  
    }  
  }
]'  
   
SELECT *
FROM OPENJSON ( @json )  
WITH (   
              Number   VARCHAR(200)   '$.Order.Number',  
              Date     DATETIME       '$.Order.Date',  
              Customer VARCHAR(200)   '$.AccountNumber',  
              Price FLOAT            '$.Item.Price',  
              Quantity INT            '$.Item.Quantity',  
              [Order]  NVARCHAR(MAX)  AS JSON  

 )
 DECLARE @pSearchOptions NVARCHAR(4000) = N'[1,2,3,4]'
/*
 --Convert a JSON array to a temporary table
SELECT *
FROM Production.ProductCategory product
INNER JOIN OPENJSON(@pSearchOptions) AS productTypes
 ON product.ProductCategoryID = productTypes.value

-- Merge properties from two JSON objects
 DECLARE @json1 NVARCHAR(MAX),@json2 NVARCHAR(MAX)

SET @json1=N'{"name": "John", "surname":"Doe"}'

SET @json2=N'{"name": "John", "age":45}'

SELECT *
FROM OPENJSON(@json1)
UNION ALL
SELECT *
FROM OPENJSON(@json2)
WHERE [key] NOT IN (SELECT [key] FROM OPENJSON(@json1))

--Join rows of JSON with CROSS APPLY
SELECT SalesOrderID,OrderDate,value AS Reason
FROM Sales.SalesOrderHeader
CROSS APPLY OPENJSON(comment)

select distinct c.DATA_TYPE from INFORMATION_SCHEMA.COLUMNS c

SELECT store.title, location.street, location.lat, location.long  
FROM store  
CROSS APPLY OPENJSON(store.jsonCol, 'lax $.location')   
     WITH (street VARCHAR(500) ,  postcode VARCHAR(500) '$.postcode' ,  
     lon int '$.geo.longitude', lat int '$.geo.latitude')  
     AS location
*/
--import JSON
DROP TABLE JSON_Sample
DECLARE @jsonr NVARCHAR(max)  = N'{  
  "id" : 2,  
  "firstName": "John",  
  "lastName": "Smith",  
  "isAlive": true,  
  "age": 25,  
  "dateOfBirth": "2015-03-25T12:00:00",  
  "spouse": null  
  }';  
   
 -- INSERT INTO Person  
  SELECT *  INTO JSON_Sample 
  FROM OPENJSON(@jsonr)  
  WITH (id INT,  
        firstName NVARCHAR(50), lastName NVARCHAR(50),   
        isAlive BIT, age INT,  
        dateOfBirth DATETIME, spouse NVARCHAR(50))
----simple cross apply example
  SELECT *  FROM JSON_Sample

DECLARE @JSONX NVARCHAR(MAX) = N'[
{
"OrderNumber":"SO43659",
"OrderDate":"2011-05-31T00:00:00",
"AccountNumber":"AW29825",
"ItemPrice":2024.9940,
"ItemQuantity":1
},
{
"OrderNumber":"SO43661",
"OrderDate":"2011-06-01T00:00:00",
"AccountNumber":"AW73565",
"ItemPrice":2024.9940,
"ItemQuantity":3
}
]'

/*SELECT root.* --AS [Order]
--,TheValues.[key], TheValues.[value]
FROM OPENJSON ( @JSONX ) AS root
*/
SELECT root.[key] AS [Order]
,TheValues.[key], TheValues.[value]
FROM OPENJSON ( @JSONX ) AS root
CROSS APPLY OPENJSON ( root.value) AS TheValues


/*
	Hierarchy
*/

CREATE TABLE ParentChildOrg  
   (  
    BusinessEntityID int PRIMARY KEY,  
    ManagerId int REFERENCES ParentChildOrg(BusinessEntityID),  
    EmployeeName nvarchar(50)   
   ) ;  
GO 
CREATE TABLE XMLOrg   
    (  
    Orgid int,  
    Orgdata xml  
    ) ;  
GO
CREATE TABLE HostedSites   
   (  
    SiteId hierarchyid, PageId hierarchyid  
   ) ;  
GO
CREATE TABLE Organization  
   (  
    BusinessEntityID hierarchyid,  
    OrgLevel as BusinessEntityID.GetLevel(),   
    EmployeeName nvarchar(50) NOT NULL  
   ) ;  
GO  
  
CREATE CLUSTERED INDEX Org_Breadth_First   
    ON Organization(OrgLevel,BusinessEntityID) ;  
GO  
  
CREATE UNIQUE INDEX Org_Depth_First   
    ON Organization(BusinessEntityID) ;  
GO  
CREATE TABLE SimpleDemo  
(
    Level hierarchyid NOT NULL,  
    Location nvarchar(30) NOT NULL,  
    LocationType nvarchar(9) NULL
);

INSERT SimpleDemo  
    VALUES   
('/1/', 'Europe', 'Continent'),  
('/2/', 'South America', 'Continent'),  
('/1/1/', 'France', 'Country'),  
('/1/1/1/', 'Paris', 'City'),  
('/1/2/1/', 'Madrid', 'City'),  
('/1/2/', 'Spain', 'Country'),  
('/3/', 'Antarctica', 'Continent'),  
('/2/1/', 'Brazil', 'Country'),  
('/2/1/1/', 'Brasilia', 'City'),  
('/2/1/2/', 'Bahia', 'State'),  
('/2/1/2/1/', 'Salvador', 'City'),  
('/3/1/', 'McMurdo Station', 'City');  

SELECT CAST(Level AS nvarchar(100)) AS [Converted Level], *   
    FROM SimpleDemo ORDER BY Level;

	INSERT SimpleDemo  
    VALUES ('/1/3/1/', 'Kyoto', 'City'), ('/1/3/1/', 'London', 'City');  
SELECT CAST(Level AS nvarchar(100)) AS [Converted Level], * FROM SimpleDemo ORDER BY Level;

  if OBJECT_ID('HumanResources.EmployeeDemo') is not null
 drop table HumanResources.EmployeeDemo 

 SELECT emp.BusinessEntityID AS EmployeeID, emp.LoginID, 
  (SELECT  man.BusinessEntityID FROM HumanResources.Employee man 
	    WHERE emp.OrganizationNode.GetAncestor(1)=man.OrganizationNode OR 
		    (emp.OrganizationNode.GetAncestor(1) = 0x AND man.OrganizationNode IS NULL)) AS ManagerID,
       emp.JobTitle, emp.HireDate
INTO HumanResources.EmployeeDemo   
FROM HumanResources.Employee emp ;

SELECT   
    Mgr.EmployeeID AS MgrID, Mgr.LoginID AS Manager,   
    Emp.EmployeeID AS E_ID, Emp.LoginID, Emp.JobTitle  
FROM HumanResources.EmployeeDemo AS Emp  
LEFT JOIN HumanResources.EmployeeDemo AS Mgr  
ON Emp.ManagerID = Mgr.EmployeeID  
ORDER BY MgrID, E_ID  

CREATE TABLE HumanResources.NewOrg  
(  
  OrgNode hierarchyid,  
  EmployeeID int,  
  LoginID nvarchar(50),  
  ManagerID int  
CONSTRAINT PK_NewOrg_OrgNode  
  PRIMARY KEY CLUSTERED (OrgNode)  
);  
GO
CREATE TABLE #Children   
   (  
    EmployeeID int,  
    ManagerID int,  
    Num int  
);  
GO
INSERT #Children (EmployeeID, ManagerID, Num)  
SELECT EmployeeID, ManagerID,  
  ROW_NUMBER() OVER (PARTITION BY ManagerID ORDER BY ManagerID)   
FROM HumanResources.EmployeeDemo  
GO
WITH paths(path, EmployeeID)   
AS (  
-- This section provides the value for the root of the hierarchy  
SELECT hierarchyid::GetRoot() AS OrgNode, EmployeeID   
FROM #Children AS C   
WHERE ManagerID IS NULL   

UNION ALL   
-- This section provides values for all nodes except the root  
SELECT   
CAST(p.path.ToString() + CAST(C.Num AS varchar(30)) + '/' AS hierarchyid),   
C.EmployeeID  
FROM #Children AS C   
JOIN paths AS p   
   ON C.ManagerID = P.EmployeeID   
)  
INSERT HumanResources.NewOrg (OrgNode, O.EmployeeID, O.LoginID, O.ManagerID)  
SELECT P.path, O.EmployeeID, O.LoginID, O.ManagerID  
FROM HumanResources.EmployeeDemo AS O   
JOIN Paths AS P   
   ON O.EmployeeID = P.EmployeeID  
GO
DROP TABLE #Children  
GO
ALTER TABLE HumanResources.NewOrg   
   ADD H_Level AS OrgNode.GetLevel() ;  
CREATE UNIQUE INDEX EmpBFInd   
   ON HumanResources.NewOrg(H_Level, OrgNode) ;  
GO
SELECT OrgNode.ToString() AS LogicalNode,  
OrgNode, H_Level, EmployeeID, LoginID  
FROM HumanResources.NewOrg   
ORDER BY OrgNode;  

SELECT OrgNode.ToString() AS LogicalNode,  
OrgNode, H_Level, EmployeeID, LoginID   
FROM HumanResources.NewOrg   
ORDER BY H_Level, OrgNode;  

SELECT OrgNode.ToString() AS LogicalNode,  
OrgNode, H_Level, EmployeeID, LoginID   
FROM HumanResources.NewOrg   
ORDER BY EmployeeID;  
GO
ALTER TABLE HumanResources.NewOrg DROP COLUMN ManagerID ;  
GO
DROP INDEX EmpIDs_unq ON HumanResources.NewOrg ;  
ALTER TABLE HumanResources.NewOrg DROP COLUMN EmployeeID ;  
GO