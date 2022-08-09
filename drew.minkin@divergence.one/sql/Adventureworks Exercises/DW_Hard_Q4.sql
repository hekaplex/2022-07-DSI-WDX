/*
1. Show how many orders are in the following ranges (in $):

    | RANGE | Num Orders |
    | ----------- | ----------- |  
    | 0 - 99 | |
    | 100- 999 | |
    | 1000-9999 | |
    | 10000+ | |

*/
--range = SUM(SalesAmount) at grain/lvl of detail of SONum

-- Internet + Reseller 
WITH
	agg_base
AS
(
SELECT 
	[SalesOrderNumber]
	,SUM(SalesAmount) OrderAmount
FROM [dbo].[FactInternetSales]
GROUP BY
		[SalesOrderNumber]
UNION ALL
SELECT 
	[SalesOrderNumber]
	,SUM(SalesAmount) OrderAmount
FROM [dbo].[FactResellerSales]
GROUP BY
		[SalesOrderNumber]) 
--bin columns
,
rangecolumn
AS
(
SELECT 
	CASE
		WHEN OrderAmount BETWEEN 0 AND 100 THEN '0 - <100'
		WHEN OrderAmount BETWEEN 100 AND 1000 THEN '100 - <1000'
		WHEN OrderAmount BETWEEN 1000 AND 10000 THEN '1000 - <10000'
		ELSE '10000+'
	END
		AS [RANGE]
	, OrderAmount
	from agg_base
--	ORDER BY OrderAmount ASC
)
SELECT [RANGE], COUNT(*) [Num Orders] 
--,MIN(OrderAmount), MAX(OrderAmount)
from rangecolumn
GROUP BY [RANGE]
ORDER BY [RANGE]
--bin aggregate
--SELECT OrderAmount, Count(*) from agg_base
--GROUP BY OrderAmount
--ORDER BY OrderAmount