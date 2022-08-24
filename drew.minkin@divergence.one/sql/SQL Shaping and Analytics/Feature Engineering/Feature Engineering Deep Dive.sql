SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[Getfeatures]()
RETURNS @features TABLE 
(
	 [DISTANCE]	int null
	,[DISTANCE_BIN_EQUAL_RANGE_06] float	null
	,[DISTANCE_CUT_median]	[nvarchar](50) null
	,[DISTANCE_BIN_APPROX_03]	[nvarchar](50) null
	,[DISTANCE_BIN_EQUAL_SIZE_04]	int null
	,[DISTANCE_BIN_EQUAL_SIZE_100]	int null
	,[DISTANCE_SCALED_0_to_1]	float null
	,[DISTANCE_SCALED_1_to_100]	float null
)
AS 
BEGIN
	declare @avg_d float
	declare @std_d float
	select @avg_d = AVG(DISTANCE) from ADF.FlightFact;
	select @std_d = STDEV(DISTANCE) from ADF.FlightFact;
WITH
bin_equal_size
as
(
SELECT
	DISTANCE
	,ROUND((((DISTANCE -31.0)/(4983.0-31.0))
				* 
				--num_bins+1
				(100.0/20)
			,0
			--truncate
			,1
			) AS	DISTANCE_BIN_EQUAL_RANGE_06
, CASE WHEN DISTANCE > 701 THEN 'LONG FLIGHT' ELSE 'SHORT FLIGHT' END DISTANCE_CUT_median
, CASE 
	--top 70% NTILE<= 30 starts at 
	WHEN DISTANCE > 1020 THEN 'TOP FLIGHT DISTANCE'  
	--middle 40% starts at 
	WHEN DISTANCE > 447 THEN 'MEDIUM FLIGHT DISTANCE'  
	ELSE 'BOTTOM FLIGHT DISTANCE'
	END AS DISTANCE_BIN_APPROX_03
,NTILE(4) OVER(ORDER BY [DISTANCE]DESC) as DISTANCE_BIN_EQUAL_SIZE_04
,NTILE(100) OVER(ORDER BY [DISTANCE]DESC) as DISTANCE_BIN_EQUAL_SIZE_100
,(DISTANCE -31.0)/(4983.0-31.0) AS DISTANCE_SCALED_0_to_1
,100*((DISTANCE -31.0)/(4983.0-31.0))+1 AS DISTANCE_SCALED_1_to_100
--,(DISTANCE - @avg_d)/@std_d AS Z_SCORE
from ADF.FlightFact
)
--INSERT INTO @features 
SELECT  * from 	bin_equal_size 

		END
RETURN
END;







/*
declare @avg_d float
declare @std_d float

select @avg_d = AVG(DISTANCE) from ADF.FlightFact;
select @std_d = STDEV(DISTANCE) from ADF.FlightFact;
WITH
bin_equal_size
as
(
SELECT
DISTANCE
	,ROUND(
			--scaled 0 to 1
			(
			(DISTANCE -31.0)/(4983.0-31.0)
			*100.0
			)
			/20
			,0
			--truncate
			,1
			) AS	DISTANCE_BIN_EQUAL_RANGE_06
, CASE WHEN DISTANCE > 701 THEN 'LONG FLIGHT' ELSE 'SHORT FLIGHT' END DISTANCE_CUT_median
, CASE 
	--top 70% NTILE<= 30 starts at 
	WHEN DISTANCE > 1020 THEN 'TOP FLIGHT DISTANCE'  
	--middle 40% starts at 
	WHEN DISTANCE > 447 THEN 'MEDIUM FLIGHT DISTANCE'  
	ELSE 'BOTTOM FLIGHT DISTANCE'
	END AS DISTANCE_BIN_APPROX_03
,NTILE(4) OVER(ORDER BY [DISTANCE]DESC) as DISTANCE_BIN_EQUAL_SIZE_04
,NTILE(100) OVER(ORDER BY [DISTANCE]DESC) as DISTANCE_BIN_EQUAL_SIZE_100
,(DISTANCE -31.0)/(4983.0-31.0) AS DISTANCE_SCALED_0_to_1
,100*((DISTANCE -31.0)/(4983.0-31.0))+1 AS DISTANCE_SCALED_1_to_100
,(DISTANCE - @avg_d)/@std_d AS Z_SCORE
from ADF.FlightFact
)



DISTANCE_BIN_EQUAL_RANGE_06,MIN(DISTANCE) min_d
	,MAX(DISTANCE) max_d
	,count(*) support
	from 
	bin_equal_size
GROUP BY DISTANCE_BIN_EQUAL_RANGE_06
ORDER BY DISTANCE_BIN_EQUAL_RANGE_06

*/

/*
modeling phases
Phase 0 - diagnostics
Phase 0a - FE in diagnostics 
Phase 1 - domain based models
Phase 1a - apply theories from SME/EDA
Phase 2 - bakeoff of algorithms
Phase 2a - permutations of features
Phase 3 - hyperparameter tuning
Phase 3a - cross validation/resampling
*/


--USE [AdventureWorks2019]

/****** Object:  UserDefinedFunction [dbo].[ufnGetContactInformation]    Script Date: 2/21/2021 12:05:11 PM ******/
