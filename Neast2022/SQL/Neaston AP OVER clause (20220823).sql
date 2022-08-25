SELECT
	VendorName
	,VendorState,VendorZipCode
	,ROW_NUMBER() OVER (ORDER BY VendorName) As RowNum_Name
	,ROW_NUMBER() OVER (ORDER BY VendorZipCode) As RowNum_State
	,ROW_NUMBER() OVER (PARTITION BY VendorZipCode ORDER BY VendorZipCode) As RowNum_ZipPartition
	,ROW_NUMBER() OVER (PARTITION BY VendorZipCode ORDER BY VendorName) As RowNum_ZipPartition
FROM
	Vendors
ORDER BY 3

SELECT
	VendorName
	,VendorState,VendorZipCode
, COUNT(*) FROM
	Vendors
group by 	VendorName
	,VendorState, VendorZipCode

ORDER BY 3
