SELECT
-- Using this to find each vendor with a NET 30 payment
    V.VendorState
	,T.TermsDescription
	,T.TermsID
From Vendors V
JOIN Terms T
	ON T.TermsID = V.DefaultTermsID
	Where TermsID = 4
	Order BY V.VendorState
