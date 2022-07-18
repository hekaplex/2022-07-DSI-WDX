/****** Object:  UserDefinedFunction [dbo].[fnBalanceDue2]    Script Date: 7/15/2022 11:17:11 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[fnBalanceDueMini]
	(
		@InvoiceTotal money
		,@PaymentTotal money
		,@CreditTotal money
)
RETURNS money
BEGIN
RETURN 
		 @InvoiceTotal
		-@PaymentTotal
		-@CreditTotal 
END;
GO

CREATE VIEW SampleVIew 
as
SELECT top 100 percent
	VendorName
	,InvoiceNumber
	,InvoiceDate
	,InvoiceTotal	
--INTO 
--	Sampletable
FROM 
	Vendors 
INNER JOIN 
	Invoices 
ON 
	Vendors.VendorID= Invoices.VendorID
WHERE 
	InvoiceTotal>= 500
ORDER BY 
	VendorName
	, InvoiceTotal 
	DESC;

DELETE FROM Sampletable

SELECT * FROM Sampletable

INSERT INTO Invoices (VendorID, InvoiceNumber,
InvoiceDate, InvoiceTotal, TermsID, InvoiceDueDate)
VALUES (12, '3289175', '2/18/2020', 165, 3, '3/18/2020');




CREATE PROCEDURE spVendorsByState @StateVar Varchar(2) AS
SELECT VendorName, VendorState, VendorPhone
FROM Vendors
WHERE VendorState= @StateVar
ORDER BY VendorName;

Murach’s

spVendorsByState 'NJ'




Select InvoiceNumber, InvoiceDate, InvoiceTotal
, dbo.fnBalanceDuemini(InvoiceTotal,PaymentTotal,CreditTotal) As BalanceDue
From Invoices
Where dbo.fnBalanceDuemini(InvoiceTotal,PaymentTotal,CreditTotal) > 0
Order By InvoiceDate;