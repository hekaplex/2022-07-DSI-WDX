--variation of details per order
WITH agg as
(
--level 2 analytics - aggregation by [SalesOrderID]
--how many line items/details per invoice
	SELECT 
		[SalesOrderID]
		,COUNT(*) number_of_line_items_per_invoice
	FROM
		[Sales].[SalesOrderDetail]
	GROUP BY 	[SalesOrderID]
)
--level 3 avg num of lines per invoice
--SELECT max(number_of_line_items_per_invoice) avg_num_of_lines_per_invoice
--FROM agg
--mu = 3, sigma = 7.2149, min = 1, max =72
--level 3 distribution of number by aggregation of number_of_line_items_per_invoice

SELECT
	number_of_line_items_per_invoice
	,count(*) number_of_cases
from agg
group by number_of_line_items_per_invoice
order by number_of_line_items_per_invoice asc

SELECT 
STDEV([SalesOrderID]) -- Sigma 9083.30744644629	
,AVG([SalesOrderID]) -- Mu 59391
,MIN([SalesOrderID]) 
,MAX([SalesOrderID]) 
from Sales.SalesOrderHeader
;
SELECT 75123/43659.0	 as ratio_min_max
;
--1562.563318
WITH score
as 
(
SELECT 
	([SalesOrderID] - AVG([SalesOrderID]) over ()) /(stdev([SalesOrderID]) over ()) AS zscore
FROM
	Sales.SalesOrderHeader
	)
SELECT
MIN(zscore) 
,MAX(zscore) 
from score

--- HARD CODED SIGMA/MU -1.7319682387448982	1.7319682387448982
--- over IMPLEMENTATION -1.7319682387449	1.7319682387449
select -1.7319682387448982/1.7319682387448982 as ratio_min_max_zscore
--"ideal variance" = six sigma

select 1.7319682387448982 -	-1.7319682387448982 as stdev_range_zscore
-- actual is <3.5 sigma
;
SELECT COUNT(*) from Sales.SalesOrderHeader
--31465
SELECT COUNT(DISTINCT [SalesOrderID]) from Sales.SalesOrderHeader

;
WITH score
as 
(
SELECT 
([SalesOrderID] - 59391)/9083.30744644629	 zscore FROM
	Sales.SalesOrderHeader
	)
SELECT ROUND(zscore,0) as zscore_bin
, COUNT(*)/314.65 as [pctage]
from score
GROUP BY ROUND(zscore,0) 
ORDER BY ROUND(zscore,0) ASC
/*
-2.0000000000000000	6.699507
-1.0000000000000000	28.866995
0.0000000000000000	28.866995
1.0000000000000000	28.866995
2.0000000000000000	6.699507
*/

SELECT 
STDEV([SalesOrderID]*1.0) -- Sigma 9009.14790159376
,AVG ([SalesOrderID]*1.0) -- Mu 57827.363782
,MIN ([SalesOrderID]*1.0) 
,MAX ([SalesOrderID]*1.0) 
from Sales.SalesOrderDetail
;

WITH score
as 
(
SELECT 
([SalesOrderID] - 57827.363782)/9009.14790159376 zscore
FROM
	Sales.SalesOrderDetail
	)
SELECT
MIN(zscore) 
,MAX(zscore) 
from score

SELECT 1.9197860227092422 - -1.5726641339180979	 as z_score_detail_range
--3.4924501566273401


SELECT COUNT(*) FROM Sales.SalesOrderdetail;

WITH score
as 
(
SELECT 
([SalesOrderID] - 57827.363782)/9009.14790159376 zscore FROM
	Sales.SalesOrderdetail
	)
SELECT ROUND(zscore,0) as zscore_bin
, COUNT(*)/1213.17 as [pctage]
from score
GROUP BY ROUND(zscore,0) 
ORDER BY ROUND(zscore,0) ASC