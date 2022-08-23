
SELECT
	VendorName
	,VendorState
	,ROW_NUMBER() OVER (ORDER BY VendorName) As RowNum_Name
	,ROW_NUMBER() OVER (ORDER BY VendorState) As RowNum_State
	,ROW_NUMBER() OVER (PARTITION BY VendorState ORDER BY VendorState) As RowNum_StatePartition
	,ROW_NUMBER() OVER (PARTITION BY VendorState ORDER BY VendorName) As RowNum_StatePartition
FROM
	Vendors
ORDER BY 2

SELECT
	VendorName
	,VendorState
, COUNT(*) FROM
	Vendors
group by 	VendorName
	,VendorState

ORDER BY 2
