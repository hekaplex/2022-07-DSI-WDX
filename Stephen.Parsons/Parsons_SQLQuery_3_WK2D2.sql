/* How many vendor ids do we have filled between 15 and 30?*/
SELECT C.FirstName
    , C.LastName
    , C.VendorID
FROM ContactUpdates C
WHERE VendorID >15
INTERSECT
SELECT C.FirstName
    , C.LastName
    , C.VendorID
FROM ContactUpdates C
WHERE VendorID BETWEEN 15 and 30
