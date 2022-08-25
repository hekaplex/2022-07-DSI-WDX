/*
Calculating Z-Score



A measure of how many standard deviations below or above the population mean a raw score is -- standard measure of distance from the mean.  Range from +-3 standard deviations from the mean.



Need to know the mean and the population standard deviation.



Formula
z = (x – µ) / s
    z = standard score, sigma
    x = datapoint, a score
    µ = population mean, mu
    s = population standard deviation
*/
WITH 
	port_visit
AS
(
	SELECT 
		ROW_NUMBER() OVER(ORDER BY lrno) AS [[Journey No]]
		,lrno
		,saildate
		,arrdate
		,portname
		,countryname
	FROM
		Calls
	WHERE 
		portname <> 'NA'
)
,

	journey
AS
(
	SELECT 
		dep.[Journey No]
		,CASE
			WHEN 
				dep.portname < arr.portname
			THEN 
				CONCAT('(',dep.portname,',',arr.portname,')')
			ELSE 
				CONCAT('(',arr.portname,',',dep.portname,')')
		END AS [Journey Coord]
		,DATEDIFF(HOUR, dep.saildate, arr.arrdate) AS [Journey Time]

	FROM 
		port_visit dep
	JOIN 
		port_visit arr
	ON 
		dep.lrno = arr.lrno
	AND
		dep.[Journey No] = arr.[Journey No]+1
)
,

journey_coords 
AS
(
	SELECT
		[Journey Coord]
		,AVG([Journey Time]) [Journey Time]
	FROM 
		journey
	GROUP BY
		[Journey Coord]
)
SELECT 
	journey_coords.[Journey Time]
	,(journey_coords.[Journey Time] - AVG(journey_coords.[Journey Time]) over()) / STDEV(journey_coords.[Journey Time]) over() 'Z-Score'
FROM 
	journey_coords
GROUP BY 
	journey_coords.[Journey Time];