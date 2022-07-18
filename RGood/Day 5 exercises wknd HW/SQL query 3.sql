SELECT
-- Using this to find each vendor with a NET 30 payment
--This is only putting out one result, not sure why it is truncated
    V.VendorState
	,T.TermsDescription
	,T.TermsID
From Vendors V
JOIN Terms T
	ON T.TermsID = V.VendorID
	Where TermsID = 4
