CREATE TYPE ZScoresType AS TABLE
(
	id varchar(50) primary key,    
	observation float
)


CREATE PROCEDURE GetZScores
@DataForScores ZScoresType READONLY  
AS
BEGIN     

DECLARE @σ_sigma float,        
		@μ_mu float

SELECT @σ_sigma = STDEV(observation) FROM @DataForScores
SELECT @μ_mu = AVG(observation) FROM @DataForScores

SELECT id, (observation - @μ_mu) / @σ_sigma z_score
FROM @DataForScores
END

DECLARE @TripsType ZScoresType
INSERT INTO @TripsType SELECT TripNo, Trip_Time  FROM Trips
EXECUTE GetZScores @TripsType