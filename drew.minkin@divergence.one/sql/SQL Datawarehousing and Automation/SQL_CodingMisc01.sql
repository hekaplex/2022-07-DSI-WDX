IF EXISTS( select * from sys.views where name= 'SumInvoices')
DROP VIEW SumInvoices


CREATE VIEW SumInvoices
AS
SELECT
count(*) qty
,SUM(InvoiceTotal - PaymentTotal - CreditTotal) totaloutstandingbalances
FROM
	Invoices
GO

select * from SumInvoices
GO
--mini green screen app

--declaring a script local variable
	DECLARE @TotalDue money

	--assigning a scalar aggregate to a variable
	SET @TotalDue  = ( SELECT SUM(InvoiceTotal - PaymentTotal - CreditTotal) 
	FROM
		Invoices
		)
	--control flow with a conditional block
	IF @TotalDue > 0
		PRINT 'Total Invoices due = $'+CONVERT(varchar,@TotalDue,1);
	ELSE
		PRINT 'Invoices paid in full'
--calculations with SQL variables
DECLARE
	@MaxInvoice money
	,@MinInvoice money
	,@PctDiff decimal(8,2)
	,@InvoiceQty int
	,@VendorIDVar int
SET
	@VendorIDVar = 95
SET
	@MaxInvoice =
		(SELECT	MAX(InvoiceTotal)
			FROM Invoices
				WHERE VendorID = @VendorIDVar)
--Populating data fro two variablesin one select
SELECT
	@MinInvoice =
			MIN(InvoiceTotal),
	@InvoiceQty =
		 COUNT(*)
			FROM Invoices
				WHERE VendorID = @VendorIDVar
SET @PctDiff =
--operator precedence
	((@MaxInvoice - @MinInvoice)/@MinInvoice) * 100

PRINT 'Max Invoice is $'+CONVERT(varchar,@MaxInvoice ,1)+'.';
PRINT 'Min Invoice is $'+CONVERT(varchar,@MinInvoice ,1)+'.';
PRINT 'Maximum is '+CONVERT(varchar,@PctDiff)+'% more than minimum.';
PRINT 'Number of Invoices: '+CONVERT(varchar,@InvoiceQty)+'.';

--table variable
DECLARE @BigVendors table
(
	VendorID INT
	,VendorName varchar(50)
);
INSERT
	@BigVendors
SELECT
	VendorID
	,VendorName
FROM
	Vendors
WHERE
VendorID IN
	(
	SELECT
		VendorID
	FROM
		Invoices	
	WHERE
		InvoiceTotal > 5000
	)

SELECT * FROM @BigVendors

--local temporary table
SELECT
	VendorID
	,VendorName
INTO
	##TopVendors
FROM
	Vendors
WHERE
VendorID IN
	(
	SELECT
		VendorID
	FROM
		Invoices	
	WHERE
		InvoiceTotal > 5000
	)
SELECT * from #TopVendors

select * from tempdb.sys.tables

SELECT LEFT(
				CAST(
					CAST(
							CEILING(RAND()*10000000000)
						as bigint)
					AS varchar
					)
			,9
			)
--global temprary table
CREATE TABLE ##RandomSSN
(
	SSN_ID int IDENTITY
	,SSN char(9)
		DEFAULT
			LEFT(
				CAST(
					CAST(
							CEILING(RAND()*10000000000)
						as bigint)
					AS varchar
					)
			,9
			)
)
INSERT ##RandomSSN VALUES(DEFAULT)
SELECT NEWID() --GUID Globally Unique Identifier
SELECT * FROM ##RandomSSN
--structured error handling
--try block - code that expect errors to happen in
-- example of Msg erro number 208 : select * from boing

BEGIN TRY
	INSERT Invoices
	 VALUES (799, 'ZXK-799', '2020-03-07', 299.95, 0, 0,
           1, '2020-04-06', NULL);
	PRINT 'Success in insert!'
END TRY
--catch block - handle error
BEGIN CATCH
	PRINT 'Error!';
	PRINT 'Msg: '+CONVERT(varchar, ERROR_NUMBER(),1)
			+ ' : ' + ERROR_MESSAGE();
	SELECT ERROR_NUMBER() as ErrNum, ERROR_MESSAGE() as Errmsg ;
END CATCH;

--global variables
SELECT @@SERVERNAME
SELECT @@IDENTITY
UPDATE Invoices set InvoiceDate = InvoiceDate
SELECT @@ROWCOUNT

SELECT COUNT(*) FROM ##RandomSSN
SELECT * FROM ##RandomSSN

--dynamic SQL
DECLARE @SSN char(9)
DECLARE @SQLStmt varchar(8000)
SET @SSN = '123456789'
SET @SQLStmt = 'INSERT ##RandomSSN VALUES('''+@SSN+''')'
PRINT @SQLStmt
EXEC ( @SQLStmt)

select * from sys.columns

SELECT * FROM INFORMATION_SCHEMA.COLUMNS

--stored procedures

ALTER PROCEDURE [dbo].[spInvCount]
--input parameters
--implicit DECLARE IN CREATE PROC with defaults
       @DateVar smalldatetime = NULL,
       @VendorVar varchar(40) = '%',
	   @InvCount int Output
AS
IF @DateVar IS NULL
   SELECT @DateVar = MIN(InvoiceDate) FROM Invoices;
--PRINT 'datevar: '+convert(varchar,@DateVar)
--PRINT 'vendvar: '+convert(varchar,@VendorVar)
--DECLARE @InvCount int;
SELECT @InvCount = COUNT(InvoiceID)
FROM Invoices JOIN Vendors
    ON Invoices.VendorID = Vendors.VendorID
WHERE (InvoiceDate >= @DateVar) AND
      (VendorName LIKE @VendorVar);
--output scalar
--PRINT 'invoices: '+ convert(varchar,@InvCount)
SELECT @InvCount as Invoiceqty;
RETURN @InvCount 
GO
--explicit parameters
EXEC [spInvCount] @VendorVar = 'United Parcel Service', @DateVar = '2015-12-08' 
--default parameters
EXEC [spInvCount] 
--parameters in default order
EXEC [spInvCount] '2015-12-08',  'United Parcel Service'


select * from Invoices where VendorID = 122

DECLARE @qty int, @DateVar smalldatetime ,@VendorVar varchar(40)
EXEC [spInvCount] @InvCount = @qty, @DateVar = '2015-12-08', @VendorVar = 'United Parcel Service'
PRINT @qty


SELECT COUNT(InvoiceID)
FROM Invoices JOIN Vendors
    ON Invoices.VendorID = Vendors.VendorID
WHERE (InvoiceDate >= '2015-12-08') AND
      (VendorName LIKE 'United Parcel Service')

ALTER PROCEDURE VendorDetails @Vendor int = 95
AS
DECLARE
	@MaxInvoice money
	,@MinInvoice money
	,@PctDiff decimal(8,2)
	,@InvoiceQty int
	,@VendorIDVar int
SET
	@VendorIDVar = @Vendor
SET
	@MaxInvoice =
		(SELECT	MAX(InvoiceTotal)
			FROM Invoices
				WHERE VendorID = @VendorIDVar)
--Populating data fro two variablesin one select
SELECT
	@MinInvoice =
			MIN(InvoiceTotal),
	@InvoiceQty =
		 COUNT(*)
			FROM Invoices
				WHERE VendorID = @VendorIDVar
SET @PctDiff =
--operator precedence
	((@MaxInvoice - @MinInvoice)/@MinInvoice) * 100
PRINT 'Vendor ID: '+ CONVERT(varchar,@Vendor)
PRINT 'Max Invoice is $'+CONVERT(varchar,@MaxInvoice ,1)+'.';
PRINT 'Min Invoice is $'+CONVERT(varchar,@MinInvoice ,1)+'.';
PRINT 'Maximum is '+CONVERT(varchar,@PctDiff)+'% more than minimum.';
PRINT 'Number of Invoices: '+CONVERT(varchar,@InvoiceQty)+'.';
GO
VendorDetails 1
--
CREATE PROCEDURE spInsertINvi
AS
BEGIN TRY
	INSERT Invoices
	 VALUES (799, 'ZXK-799', '2020-03-07', 299.95, 0, 0,
           1, '2020-04-06', NULL);
	PRINT 'Success in insert!'
END TRY
--catch block - handle error
BEGIN CATCH
	PRINT 'Error!';
	PRINT 'Msg: '+CONVERT(varchar, ERROR_NUMBER(),1)
			+ ' : ' + ERROR_MESSAGE();
	SELECT ERROR_NUMBER() as ErrNum, ERROR_MESSAGE() as Errmsg ;
END CATCH;
GO
--SQL Type 

CREATE TYPE BigVendorsType
AS
TABLE
(
	VendorID INT
	,VendorName varchar(50)
)
GO
--CREATE PROCEDURE getBigVendors
--@BigVendors BigVendorsType

DECLARE @BigVendors BigVendorsType
INSERT INTO @BigVendors VALUES (1,'Microsoft')
SELECT * FROM @BigVendors 