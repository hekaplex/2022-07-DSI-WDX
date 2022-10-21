SELECT
	*
FROM
	dbo.Transit;

ALTER TABLE
	Transit
ALTER COLUMN
	Dwell_Time
		FLOAT

-----------------------------------------------------------

SELECT
	STDEV([Dwell_Time]),--2.19434603137259
	AVG([Dwell_Time]),--0.538377607117378
	MIN([Dwell_Time]),-- 0
	MAX([Dwell_Time]) --244
FROM
	dbo.Transit
;
SELECT 0/244
	AS 
		Ratio_Min_Max
-- 0
;

WITH 
	Score
AS
	(
SELECT 
	(Dwell_Time - 0.538377607117378)/2.19434603137259 zScore
FROM
	dbo.Transit
	)
SELECT
	MIN(zScore)
	,MAX(zScore)
	FROM
		Score
	SELECT 110.94951247985/-0.245347634065087
		AS
			ratio_min_max_zscore
--	-452.21350066256102507341
	SELECT 110.94951247985 - -0.245347634065087
		AS
			stdev_range_zscore
-- 111.194860113915087
;


WITH
	Score
AS
	(
SELECT 
	(Dwell_Time - 0.538377607117378)/2.19434603137259 zScore
FROM
	dbo.Transit
	)
SELECT ROUND(zscore,0)
	AS 
		zScore_bin,
	COUNT(*)/119145.0 as Density
FROM
	Score
GROUP BY
	ROUND(zscore,0)
ORDER BY
	ROUND(zscore,0) ASC




SELECT COUNT (*) 
FROM Transit
-- 119145

-----------------------------------------------------------------
