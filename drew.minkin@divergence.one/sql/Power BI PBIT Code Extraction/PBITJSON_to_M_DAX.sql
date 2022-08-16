DECLARE @jsonisland nvarchar(max);
DECLARE @jsonpowerbi nvarchar(max)
/*

STEPS TO GET CODE READY FOR EXPORT
1.  Save .PBIX file as a .PBIT template
2.  Rename the file to a .ZIP file 
    (may require unchecking "Hide extension for known file types")
    from the View OPtions in Fiel Explorer
3.  Navigate to the DataModelSchema file and 
    replace any ' characters to ` 
4.  Copy the entire JSON from string or SELECT into nvarchar(max) from table
5.  replace <insert_json_here> with teh JSON
*/
set @jsonpowerbi = N'<insert_json_here>'

--get island of schema with table definitions
SELECT @jsonisland = edgetable
  FROM OPENJSON(@jsonpowerbi) 
 with (edgetable nvarchar(max) '$.model.tables' AS JSON )

/*
earlier way to do it from table
with 
    [pbix_model]
AS
(
    SELECT 
        * 
    FROM 
        JSON_PBIT 
    where 
        [key] = 'model'
)
SELECT 
    @jsonisland =  table_list.value 
FROM 
    [pbix_model]
CROSS APPLY 
OPENJSON(value)
    table_list
where 
    table_list.[key] = 'tables'
;
*/


--DAX columns

SELECT 
    table_name as [Table]
    ,'DAX Column' AS [Object]
    , col_name 
        + ' = '
        +  replace
            (
                DAX
                ,'`'
                ,char(39)
            ) as [Code]
from
    OPENJSON(@jsonisland)
        WITH
            (
                table_name VARCHAR(max) '$.name',
                col_list NVARCHAR(max) '$.columns' AS JSON
            )
cross apply 
    OPENJSON(col_list)
        with 
            (
                col_name VARCHAR(max) '$.name'
                ,DAX VARCHAR(max) '$.expression'
            ) 
            col_details
        WHERE 
            col_details.DAX is not null
UNION ALL
--DAX measures
SELECT 
    'DAX Measure' AS DAX_Object
    ,table_name AS [Table]
    , col_name 
        + ' = '
        +  replace
            (
                DAX
                ,'`'
                ,char(39)
            )  AS DAX
from
    OPENJSON(@jsonisland)
        WITH
            (
                table_name VARCHAR(max) '$.name',
                col_list NVARCHAR(max) '$.measures' AS JSON
            )
cross apply 
    OPENJSON(col_list)
        with 
            (
                col_name VARCHAR(max) '$.name'
                ,DAX VARCHAR(max) '$.expression'
            ) 
            col_details
        WHERE 
            col_details.DAX is not null            
UNION ALL
--DAX or M for Table Definition 
SELECT 
    CASE
	WHEN substring(DAX,1,3) = 'let' THEN 'M Query' else 'DAX Table' END AS DAX_Object
    ,table_name as [Table]
    , DAX as [DAX]
from
    OPENJSON(@jsonisland)
        WITH
            (
                table_name VARCHAR(max) '$.name',
                col_list NVARCHAR(max) '$.partitions' AS JSON
            )
cross apply 
    OPENJSON(col_list)
        with 
            (
                col_name VARCHAR(max) '$.name'
                ,DAX VARCHAR(max) '$.source.expression'
            ) 
            col_details
        WHERE 
            col_details.DAX is not null
ORDER BY 2,1