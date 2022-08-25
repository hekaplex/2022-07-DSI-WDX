SELECT 
STDEV([CARRIER_DELAY]) -- 30.306 Sigma 
,AVG([CARRIER_DELAY]) -- 4.616 Mu
,MIN([CARRIER_DELAY]) 
,MAX([CARRIER_DELAY]) 
FROM dbo.Flight
;
SELECT 30.306/4.616	 as ratio_min_max
--6.565
WITH score
as 
(
SELECT 
(CARRIER_DELAY - 4.616)/30.306 zscore
FROM
	Flight
	)
SELECT
MIN(zscore) 
,MAX(zscore) 
from score
select 30.306/-4.9033 as ratio_min_max_zscore
--"ideal variance" = six sigma

select 30.3063 - -4.9033 as stdev_range_zscore
-- actual is 30+4 sigma

SELECT COUNT(*) from Flight

WITH score
as 
(
SELECT 
(CARRIER_DELAY - 30.306)/4.616 zscore
FROM
	Flight
	)
SELECT ROUND(zscore,0) as zscore_bin
, COUNT(*)/603.980 as [pctage]
from score
GROUP BY ROUND(zscore,0) 
ORDER BY ROUND(zscore,0) ASC
