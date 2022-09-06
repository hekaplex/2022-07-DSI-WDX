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
       @InvTotal money OUTPUT,
       @DateVar date = NULL,
       @VendorVar varchar(40) = '%'
AS

--sets @DateVar if NULL
IF @DateVar IS NULL
   SELECT @DateVar = MIN(InvoiceDate) FROM Invoices;

SELECT @InvTotal = SUM(InvoiceTotal)
FROM Invoices JOIN Vendors
    ON Invoices.VendorID = Vendors.VendorID
WHERE (InvoiceDate >= @DateVar) AND
      (VendorName LIKE @VendorVar);

DECLARE @MyInvTotal money;
PRINT '$' + CONVERT(varchar,isnull(@MyInvTotal,'99999999'),1);
EXEC spInvTotal3 @MyInvTotal OUTPUT,  @VendorVar ='P%' , @DateVar ='2020-01-01';
PRINT '$' + CONVERT(varchar,@MyInvTotal,1);

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

DECLARE @InvCount int;
EXEC @InvCount = spInvCount '2020-01-01', 'P%';
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

BEGIN TRY
    EXEC spInsertInvoice 
         799,'ZXK-799','2020-03-01',299.95,1,'2020-04-01';
END TRY
BEGIN CATCH
    PRINT 'An error occurred.';
    PRINT 'Message: ' + CONVERT(varchar, ERROR_MESSAGE());
    IF ERROR_NUMBER() >= 50000
        PRINT 'This is a custom error message.';
END CATCH;

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
    THROW 50001, 'Invalid InvoiceDate.', 1;
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
        THROW 50001, 'Invalid InvoiceDueDate.', 1;
IF @PaymentDate < @InvoiceDate OR
        DATEDIFF(dd, @PaymentDate, GETDATE()) > 14
    THROW 50001, 'Invalid PaymentDate.', 1;

INSERT Invoices
VALUES (@VendorID, @InvoiceNumber, @InvoiceDate, @InvoiceTotal,
        @PaymentTotal, @CreditTotal, @TermsID, @InvoiceDueDate, 
        @PaymentDate);
RETURN @@IDENTITY;
GO

BEGIN TRY
    DECLARE @InvoiceID int;
    EXEC @InvoiceID = spInsertInvoice
         @VendorID = 799,
         @InvoiceNumber = 'RZ99381',
         @InvoiceDate = '2020-02-12',
         @InvoiceTotal = 1292.45;
    PRINT 'Row was inserted.';
    PRINT 'New InvoiceID: ' + CONVERT(varchar, @InvoiceID);
END TRY
BEGIN CATCH
    PRINT 'An error occurred. Row was not inserted.';
    PRINT 'Error number: ' + CONVERT(varchar, ERROR_NUMBER());
    PRINT 'Error message: ' + CONVERT(varchar, ERROR_MESSAGE());
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
AS
    INSERT INTO InvoiceLineItems
    SELECT *
    FROM @LineItems;

GO

-- delete old line item data
DELETE FROM InvoiceLineItems WHERE InvoiceID = 114;

-- declare a variable for the LineItems type
DECLARE @LineItems LineItems;

-- insert rows into the LineItems variable
INSERT INTO @LineItems VALUES (114, 1, 553, 127.75, 'Freight');
INSERT INTO @LineItems VALUES (114, 2, 553, 29.25, 'Freight');
INSERT INTO @LineItems VALUES (114, 3, 553, 48.50, 'Freight');

-- execute the stored procedure
EXEC spInsertLineItems @LineItems;

-- view the data
SELECT * FROM InvoiceLineItems WHERE InvoiceID = 114;

IF OBJECT_ID('fnVendorID') IS NOT NULL
    DROP FUNCTION fnVendorID;
GO

CREATE FUNCTION fnVendorID
    (@VendorName varchar(50))
    RETURNS int
BEGIN
    RETURN (SELECT VendorID FROM Vendors WHERE VendorName = @VendorName);
END;


SELECT InvoiceDate, InvoiceTotal
FROM Invoices
WHERE VendorID = dbo.fnVendorID('IBM');


CREATE FUNCTION fnTopVendorsDue
    (@CutOff money = 0)
    RETURNS TABLE
RETURN
	(SELECT VendorName, SUM(InvoiceTotal) AS TotalDue
	FROM Vendors JOIN Invoices ON Vendors.VendorID = Invoices.VendorID
	WHERE InvoiceTotal - CreditTotal - PaymentTotal > 0
	GROUP BY VendorName
	HAVING SUM(InvoiceTotal) >= @CutOff);


SELECT * FROM dbo.fnTopVendorsDue(5000);

SELECT Vendors.VendorName, VendorCity, TotalDue
FROM Vendors JOIN dbo.fnTopVendorsDue(DEFAULT) AS TopVendors
     ON Vendors.VendorName = TopVendors.VendorName;
GO

IF OBJECT_ID('fnCreditAdj') IS NOT NULL
    DROP FUNCTION fnCreditAdj;
GO

CREATE FUNCTION fnCreditAdj (@HowMuch money)
    RETURNS @OutTable table
           (InvoiceID int, VendorID int, InvoiceNumber varchar(50),
            InvoiceDate smalldatetime, InvoiceTotal money,
            PaymentTotal money, CreditTotal money)
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


SELECT VendorName, SUM(CreditTotal) AS CreditRequest
FROM Vendors JOIN dbo.fnCreditAdj(25000) AS CreditTable
     ON Vendors.VendorID = CreditTable.VendorID
GROUP BY VendorName;

