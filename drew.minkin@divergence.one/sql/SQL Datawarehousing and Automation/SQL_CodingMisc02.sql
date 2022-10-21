DECLARE @EarliestInvoiceDue date;

SELECT 
	@EarliestInvoiceDue 
	= MIN(InvoiceDueDate) 
FROM 
	Invoices 
WHERE 
	InvoiceTotal - PaymentTotal - CreditTotal > 0;

IF 
	@EarliestInvoiceDue < GETDATE()
    PRINT 'Outstanding invoices overdue!';
GO
DECLARE 
	 @MinInvoiceDue money
	,@MaxInvoiceDue money
	,@EarliestInvoiceDue date
	,@LatestInvoiceDue date;

SELECT 
	@MinInvoiceDue = MIN(InvoiceTotal - PaymentTotal - CreditTotal),
    @MaxInvoiceDue = MAX(InvoiceTotal - PaymentTotal - CreditTotal),
    @EarliestInvoiceDue = MIN(InvoiceDueDate),
    @LatestInvoiceDue = MAX(InvoiceDueDate)
FROM 
	Invoices
WHERE
	InvoiceTotal - PaymentTotal - CreditTotal > 0;

IF @EarliestInvoiceDue < GETDATE()
    BEGIN
        PRINT 'Outstanding invoices overdue!';
        PRINT 'Dated ' + CONVERT(varchar,@EarliestInvoiceDue,1) + 
            ' through ' + CONVERT(varchar,@LatestInvoiceDue,1) + '.';
        PRINT 'Amounting from $' + CONVERT(varchar,@MinInvoiceDue,1) +
            ' to $' + CONVERT(varchar,@MaxInvoiceDue,1) + '.';
    END;
ELSE --@EarliestInvoiceDue >= GETDATE()
    PRINT 'No overdue invoices.';


--
BEGIN TRY
    INSERT Invoices
    VALUES (799, 'ZXK-799', '2020-03-07', 299.95, 0, 0,
            1, '2020-04-06', NULL);
    PRINT 'SUCCESS: Record was inserted.';
END TRY
BEGIN CATCH
    PRINT 'FAILURE: Record was not inserted.';
    PRINT 'Error ' + CONVERT(varchar, ERROR_NUMBER(), 1) 
        + ': ' + ERROR_MESSAGE();
END CATCH;

BEGIN TRY
	INSERT Invoices
	VALUES (799, 'ZXK-799', '2020-03-07', 299.95, 0, 0,
			1, '2020-04-06', NULL);
	PRINT 'SUCCESS: Record was inserted.';
END TRY
BEGIN CATCH
	PRINT 'FAILURE: Record was not inserted.';
	-- You can use a SELECT statement to return a
	-- result set that contains data about the error
	SELECT 
		ERROR_NUMBER() AS ErrorNumber, 
		ERROR_MESSAGE() AS ErrorMessage;
END CATCH
--
IF OBJECT_ID('tempdb..#InvoiceCopy') IS NOT NULL
    DROP TABLE #InvoiceCopy;

SELECT * INTO #InvoiceCopy FROM Invoices 

SELECT count(*), MAX(CreditTotal ) FROM #InvoiceCopy 
WHERE InvoiceTotal - CreditTotal - PaymentTotal > 0;

WHILE 1 = 1
	BEGIN
    UPDATE #InvoiceCopy
    SET CreditTotal = CreditTotal + .05
    WHERE InvoiceTotal - CreditTotal - PaymentTotal > 0;

    IF (SELECT MAX(CreditTotal) FROM #InvoiceCopy) > 13400
        BREAK;
    ELSE --(SELECT MAX(CreditTotal) FROM #InvoiceCopy) <= 3000
        CONTINUE
	END
--

DECLARE @MyIdentity int, @MyRowCount int;

INSERT Vendors (VendorName, VendorAddress1, VendorCity, VendorState,
    VendorZipCode, VendorPhone, DefaultTermsID, DefaultAccountNo)
VALUES ('Peerless Binding', '1112 S Windsor St', 'Hallowell', 'ME',
    '04347', '(207) 555-1555', 4, 400);

SET @MyIdentity = @@IDENTITY;
SET @MyRowCount = @@ROWCOUNT;

IF @MyRowCount = 1
    INSERT Invoices
    VALUES (@MyIdentity, 'BA-0199', '2020-03-01', 4598.23,
        0, 0, 4, '2020-04-30', NULL);
DECLARE @TableNameVar varchar(128);
SET @TableNameVar = 'Invoices';
EXEC ('SELECT * FROM ' + @TableNameVar + ';');
DECLARE @DynamicSQL varchar(8000);
PRINT(@DynamicSQL)
PRINT(@MyIdentity)
PRINT(@MyRowCount)
EXEC(@DynamicSQL)

IF OBJECT_ID('XtabVendors') IS NOT NULL
    DROP TABLE XtabVendors;

DECLARE @DynamicSQL varchar(max)

--creates concatenated string from a coulmn in table of results
SET @DynamicSQL = 'CREATE TABLE XtabVendors ('
    SELECT @DynamicSQL = @DynamicSQL + '[' + VendorName + '] bit,'
    FROM Vendors 
    WHERE VendorID IN
        (SELECT VendorID 
        FROM Invoices 
        WHERE InvoiceTotal - CreditTotal - PaymentTotal > 0)
    ORDER BY VendorName;
SET @DynamicSQL = @DynamicSQL + ');';
PRINT (@DynamicSQL)
EXEC (@DynamicSQL);

   SELECT '[' + VendorName + ']' 
    FROM Vendors 
    WHERE VendorID IN
        (SELECT VendorID 
        FROM Invoices 
        WHERE InvoiceTotal - CreditTotal - PaymentTotal > 0)
    ORDER BY VendorName;

SELECT VENDORNAME , COUNT(*), MIN(VENDORID), MaX(VENDORID)  FROM vENDORS
GROUP BY VENDORNAME 
HAVING COUNT(*) > 1

SELECT * FROM XtabVendors;


IF OBJECT_ID('tempdb..#TableSummary') IS NOT NULL
    DROP TABLE #TableSummary;

SELECT sys.tables.name AS TableName, sys.columns.name AS ColumnName,
    sys.types.name AS Type 
INTO #TableSummary
FROM sys.tables
    JOIN sys.columns ON sys.tables.object_id = sys.columns.object_id
    JOIN sys.types ON sys.columns.system_type_id = sys.types.system_type_id
WHERE sys.tables.name IN 
    (SELECT name 
    FROM sys.tables
    WHERE name NOT IN ('dtproperties', 'TableSummary', 'AllUserTables'));

SELECT * FROM	#TableSummary