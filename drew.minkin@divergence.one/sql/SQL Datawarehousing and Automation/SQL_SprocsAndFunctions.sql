Use AP

IF OBJECT_ID('spInvoiceReport') IS NOT NULL
  DROP PROC spInvoiceReport;
GO
CREATE PROC spInvoiceReport
AS

SELECT VendorName, InvoiceNumber, InvoiceDate, InvoiceTotal
FROM Invoices JOIN Vendors
     ON Invoices.VendorID = Vendors.VendorID
WHERE InvoiceTotal - CreditTotal - PaymentTotal > 0
ORDER BY VendorName;


EXEC spInvoiceReport;

IF OBJECT_ID('spCopyInvoices') IS NOT NULL
    DROP PROC spCopyInvoices;
GO

CREATE PROC spCopyInvoices
AS
    IF OBJECT_ID('InvoiceCopy') IS NOT NULL
        DROP TABLE InvoiceCopy;
    SELECT *
    INTO InvoiceCopy
    FROM Invoices;
GO
IF OBJECT_ID('spInvTotal3') IS NOT NULL
    DROP PROC spInvTotal3;
GO
CREATE PROC spInvTotal3
--parameters to invoke at execution
       @InvTotal money OUTPUT,
       @DateVar date = NULL,
       @VendorVar varchar(40) = '%'
AS

--sets @DateVar if NULL
--variable @DateVar
IF @DateVar IS NULL
   SELECT @DateVar = MIN(InvoiceDate) FROM Invoices;
--variable @InvTotal 
SELECT @InvTotal = SUM(InvoiceTotal)
FROM Invoices JOIN Vendors
    ON Invoices.VendorID = Vendors.VendorID
WHERE (InvoiceDate >= @DateVar) AND
      (VendorName LIKE @VendorVar);
GO
--variable @MyInvTotal
DECLARE @MyInvTotal money;
PRINT '$' + CONVERT(varchar,@MyInvTotal,1);

--parameter @MyInvTotal, @VendorVar , @DateVar 
EXEC spInvTotal3 @MyInvTotal OUTPUT,  @VendorVar ='P%' , @DateVar ='2020-01-01';
PRINT '$' + CONVERT(varchar,@MyInvTotal,1);

DECLARE @MyInvTotal money;
EXEC spInvTotal3 @MyInvTotal  OUTPUT
SELECT @MyInvTotal 

--to be continued
IF OBJECT_ID('spInvCount') IS NOT NULL
    DROP PROC spInvCount;
GO

CREATE PROC spInvCount
       @DateVar date = NULL,
       @VendorVar varchar(40) = '%'
AS

IF @DateVar IS NULL
   SELECT @DateVar = MIN(InvoiceDate) FROM Invoices;

DECLARE @InvCount int;

SELECT @InvCount = COUNT(InvoiceID)
FROM Invoices JOIN Vendors
    ON Invoices.VendorID = Vendors.VendorID
WHERE (InvoiceDate >= @DateVar) AND
       (VendorName LIKE @VendorVar);
RETURN @InvCount;
GO

--SELECT COUNT(*) FROM Invoices JOIN Vendors
--    ON Invoices.VendorID = Vendors.VendorID
--WHERE (InvoiceDate >= NULL)
--AND VendorName LIKE '%'
DECLARE @InvCount int;
EXEC @InvCount = spInvCount '2015-01-01', 'P%';
PRINT 'Invoice count: ' + CONVERT(varchar, @InvCount);
GO

IF OBJECT_ID('spInsertInvoice') IS NOT NULL
    DROP PROC spInsertInvoice;
GO

CREATE PROC spInsertInvoice
       @VendorID    int,  @InvoiceNumber  varchar(50),
       @InvoiceDate date, @InvoiceTotal   money,
       @TermsID     int,  @InvoiceDueDate date
AS

IF EXISTS(SELECT * FROM Vendors WHERE VendorID = @VendorID)
    INSERT Invoices
    VALUES (@VendorID, @InvoiceNumber,
            @InvoiceDate, @InvoiceTotal, 0, 0,
            @TermsID, @InvoiceDueDate, NULL);
ELSE 
    THROW 50001, 'Not a valid VendorID!', 1;
GO
--SEH Structured Exception Handling -- How not to blow things up

--TRY block BEGIN
BEGIN TRY
    EXEC spInsertInvoice 
         100,'ZXK-799','2020-03-01',299.95,1,'2020-04-01';
END TRY
--TRY block END
--CATCH block BEGIN
BEGIN CATCH
    PRINT 'An error occurred.';
    PRINT 'Message: ' + CONVERT(varchar, ERROR_MESSAGE());
    IF ERROR_NUMBER() >= 50000
        PRINT 'This is a custom error message.';
END CATCH;
--CATCH block END
GO

IF OBJECT_ID('spInsertInvoice') IS NOT NULL
    DROP PROC spInsertInvoice;
GO


CREATE PROC spInsertInvoice
       @VendorID       int = NULL,
       @InvoiceNumber  varchar(50) = NULL,
       @InvoiceDate    date = NULL,
       @InvoiceTotal   money = NULL,
       @PaymentTotal   money = NULL,
       @CreditTotal    money = NULL,
       @TermsID        int = NULL,
       @InvoiceDueDate date = NULL,
       @PaymentDate    date = NULL
AS

IF NOT EXISTS (SELECT * FROM Vendors WHERE VendorID = @VendorID)
    THROW 50001, 'Invalid VendorID.', 1;
IF @InvoiceNumber IS NULL
    THROW 50001, 'Invalid InvoiceNumber.', 1;
IF @InvoiceDate IS NULL OR @InvoiceDate > GETDATE() 
        OR DATEDIFF(dd, @InvoiceDate, GETDATE()) > 30
    THROW 50001, 'Invalid InvoiceDate. Past 30 days from invoice date', 1;
IF @InvoiceTotal IS NULL OR @InvoiceTotal <= 0
    THROW 50001, 'Invalid InvoiceTotal.', 1;
IF @PaymentTotal IS NULL
    SET @PaymentTotal = 0;
IF @CreditTotal IS NULL
    SET @CreditTotal = 0;
IF @CreditTotal > @InvoiceTotal
    THROW 50001, 'Invalid CreditTotal.', 1;
IF @PaymentTotal > @InvoiceTotal - @CreditTotal
    THROW 50001, 'Invalid PaymentTotal.', 1;
IF NOT EXISTS (SELECT * FROM Terms WHERE TermsID = @TermsID)
    IF @TermsID IS NULL
        SELECT @TermsID = DefaultTermsID
        FROM Vendors
        WHERE VendorID = @VendorID;
    ELSE  -- @TermsID IS NOT NULL
        THROW 50001, 'Invalid TermsID.', 1;
IF @InvoiceDueDate IS NULL
	BEGIN
	  DECLARE @TermsDueDays int;
	  SELECT @TermsDueDays = TermsDueDays FROM Terms WHERE TermsID = @TermsID;
	  SET @InvoiceDueDate = DATEADD(day, @TermsDueDays, @InvoiceDate);
	END
ELSE  -- @InvoiceDueDate IS NOT NULL
    IF @InvoiceDueDate < @InvoiceDate OR
            DATEDIFF(dd, @InvoiceDueDate, @InvoiceDate) > 180
        THROW 50001, 'Invalid InvoiceDueDate - must be within 180 days of invoice date.', 1;
IF @PaymentDate < @InvoiceDate OR
        DATEDIFF(dd, @PaymentDate, GETDATE()) > 14
    THROW 50001, 'Invalid PaymentDate - must be logged within 14 days', 1;

INSERT Invoices
VALUES (@VendorID, @InvoiceNumber, @InvoiceDate, @InvoiceTotal,
        @PaymentTotal, @CreditTotal, @TermsID, @InvoiceDueDate, 
        @PaymentDate);
RETURN @@IDENTITY;
GO

BEGIN TRY
    DECLARE @InvoiceID int;
    EXEC @InvoiceID = spInsertInvoice
         @VendorID = 111,
         @InvoiceNumber = 'RZ99381',
         @InvoiceDate = '2020-02-12',
         @InvoiceTotal = 1292.45;
    PRINT 'Row was inserted.';
    PRINT 'New InvoiceID: ' + CONVERT(varchar, @InvoiceID);
END TRY
BEGIN CATCH
    PRINT 'An error occurred. Row was not inserted.';
    PRINT 'Error number: ' + CONVERT(varchar, ERROR_NUMBER());
    PRINT 'Error message: ' + CONVERT(varchar(60), ERROR_MESSAGE());
END CATCH;

-- drop stored procedure if it exists already
IF OBJECT_ID('spInsertLineItems') IS NOT NULL
    DROP PROC spInsertLineItems;
GO

-- drop table type if it exists already
IF  EXISTS (SELECT * FROM sys.types WHERE name = 'LineItems')
    DROP TYPE LineItems;
GO

-- create the user-defined table type named LineItems
CREATE TYPE LineItems AS
TABLE
(InvoiceID        INT           NOT NULL,
InvoiceSequence   SMALLINT      NOT NULL,
AccountNo         INT           NOT NULL,
ItemAmount        MONEY         NOT NULL,
ItemDescription   VARCHAR(100)  NOT NULL,
PRIMARY KEY (InvoiceID, InvoiceSequence));

GO

-- create a stored procedure that accepts the LineItems type
CREATE PROC spInsertLineItems
    @LineItems LineItems READONLY
	,@Rowcount int OUTPUT
AS
    INSERT INTO InvoiceLineItems
    SELECT *
    FROM @LineItems;

	SELECT @Rowcount = @@ROWCOUNT
	RETURN @Rowcount 
GO

-- delete old line item data
DELETE FROM InvoiceLineItems WHERE InvoiceID = 114;

-- declare a variable for the LineItems type
DECLARE @LineItems LineItems;

-- insert rows into the LineItems variable
INSERT INTO @LineItems VALUES (114, 1, 553, 127.75, 'Freight');
INSERT INTO @LineItems VALUES (114, 2, 553, 29.25, 'Freight');
INSERT INTO @LineItems VALUES (114, 3, 553, 48.50, 'Freight');

--SELECT * from @LineItems 

-- execute the stored procedure
DECLARE @Rowcount   int
EXEC spInsertLineItems @LineItems , @Rowcount OUTPUT;
PRINT @Rowcount  
-- view the data
SELECT * FROM InvoiceLineItems WHERE InvoiceID = 114;


IF OBJECT_ID('fnVendorID') IS NOT NULL
    DROP FUNCTION fnVendorID;
GO

--Scalar valued function
CREATE FUNCTION fnVendorID
    (@VendorName varchar(50))
    RETURNS int
BEGIN
    RETURN (SELECT VendorID FROM Vendors WHERE VendorName = @VendorName);
END;

SELECT dbo.fnVendorID('IBM')

SELECT InvoiceDate, InvoiceTotal
FROM Invoices
WHERE VendorID = dbo.fnVendorID('IBM');


IF OBJECT_ID('fnTopVendorsDue') IS NOT NULL
    DROP FUNCTION fnTopVendorsDue;
GO

ALTER FUNCTION fnTopVendorsDue
    (@CutOff money = 0)
    RETURNS TABLE
RETURN
	(SELECT 
	--TOP 100 percent 
	VendorName, SUM(InvoiceTotal) AS TotalDue
	FROM Vendors JOIN Invoices ON Vendors.VendorID = Invoices.VendorID
	WHERE InvoiceTotal - CreditTotal - PaymentTotal > 0
	GROUP BY VendorName
	HAVING SUM(InvoiceTotal) >= @CutOff
	--ORDER BY SUM(InvoiceTotal) DESC
	);

	--SELECT TOP 100 percent VendorName, SUM(InvoiceTotal) AS TotalDue
	--FROM Vendors JOIN Invoices ON Vendors.VendorID = Invoices.VendorID
	--WHERE InvoiceTotal - CreditTotal - PaymentTotal > 0
	--GROUP BY VendorName
	--HAVING SUM(InvoiceTotal) >= 5000
	--ORDER BY SUM(InvoiceTotal) DESC
GO

SELECT * FROM dbo.fnTopVendorsDue(5000)
ORDER BY TotalDue ASC;

SELECT Vendors.VendorName, VendorCity, TotalDue
FROM Vendors JOIN dbo.fnTopVendorsDue(DEFAULT) AS TopVendors
     ON Vendors.VendorName = TopVendors.VendorName
ORDER BY TotalDue ASC;
GO

CREATE TYPE [dbo].[InvoiceInfo] AS TABLE(
 InvoiceID int					NULL
, VendorID int					NULL
, InvoiceNumber varchar(50)		NULL
, InvoiceDate smalldatetime		NULL
, InvoiceTotal money			NULL
, PaymentTotal money			NULL
, CreditTotal money				NULL
)
GO

IF OBJECT_ID('fnCreditAdj') IS NOT NULL
    DROP FUNCTION fnCreditAdj;
GO

CREATE FUNCTION fnCreditAdj (@HowMuch money)
    RETURNS @OutTable table (
	 InvoiceID int				
	, VendorID int				
	, InvoiceNumber varchar(50)	
	, InvoiceDate smalldatetime	
	, InvoiceTotal money		
	, PaymentTotal money		
	, CreditTotal money			
	)

BEGIN
    INSERT @OutTable
        SELECT InvoiceID, VendorID, InvoiceNumber, InvoiceDate, 
               InvoiceTotal, PaymentTotal, CreditTotal
        FROM Invoices
        WHERE (InvoiceTotal - CreditTotal - PaymentTotal) > 0;
    WHILE (SELECT SUM(InvoiceTotal - CreditTotal - PaymentTotal)
           FROM @OutTable) >= @HowMuch

        UPDATE @OutTable
        SET CreditTotal = CreditTotal + .01
        WHERE (InvoiceTotal - CreditTotal - PaymentTotal) > 0;
				 
    RETURN;
END;
GO

SELECT VendorName, SUM(CreditTotal) AS CreditRequest
FROM Vendors JOIN dbo.fnCreditAdj(25000) AS CreditTable
     ON Vendors.VendorID = CreditTable.VendorID
GROUP BY VendorName;

SELECt * from dbo.fnCreditAdj(25000)