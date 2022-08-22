
SELECT 
STDEV([SalesAmount]) -- Sigma 928.489878330098
,AVG([SalesAmount]) -- Mu 486.086921
,MIN([SalesAmount]) 
,MAX([SalesAmount]) 
from dbo.FactInternetSales
;
SELECT 3578.27/2.29	 as ratio_min_max
--1562.563318
WITH score
as 
(
SELECT 
(SalesAmount - 486.086921)/928.489878330098 zscore
FROM
	FactResellerSales
	)
SELECT
MIN(zscore) 
,MAX(zscore) 
from score
select 32.856527347252487803/-0.522048686057590789 as ratio_min_max_zscore
--"ideal variance" = six sigma

select 32.856527347252487803 - -0.522048686057590789 as stdev_range_zscore

SELECT COUNT(*) from FactInternetSales
--60398

WITH score
as 
(
SELECT 
(SalesAmount - 486.086921)/928.489878330098 zscore
FROM
	FactResellerSales
	)
SELECT ROUND(zscore,0) as zscore_bin
, COUNT(*)/603.980 as [pctage]
from score
GROUP BY ROUND(zscore,0) 
ORDER BY ROUND(zscore,0) ASC


