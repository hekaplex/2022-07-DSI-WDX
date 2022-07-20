SELECT *,
CASE
	WHEN VendorPhone like '(301)%' Then 'Local'
	ELSE 'Not Local' 
	END AS Point
	FROM Vendors 
	ORDER BY
		VendorZipCode