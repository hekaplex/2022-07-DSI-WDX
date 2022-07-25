/****** Script for SelectTopNRows command from SSMS  ******/
SELECT 
      [Equilibrium_Temperature_K]
      ,COUNT(*)
  FROM [dbo].[Updated and Filtered Exoplanet Data]
      GROUP BY [Equilibrium_Temperature_K]
	  ORDER BY 2 DESC

SELECT 
      AVG([Equilibrium_Temperature_K])
  FROM [dbo].[Updated and Filtered Exoplanet Data]
WHERE [Equilibrium_Temperature_K] IS NOT NULL
--909

SELECT Planet_Name
,Host_Name
,Number_of_Planets
,Planet_Radius_Earth_Radius
,Planet_Mass_or_Mass_sin_i_Earth_Mass
,(Planet_Mass_or_Mass_sin_i_Earth_Mass/(Planet_Radius_Earth_Radius*Planet_Radius_Earth_Radius)) AS 'Planet Surface Gravity (g)'
,Equilibrium_Temperature_K
,Spectral_Type
,Distance_ly
FROM [Updated and Filtered Exoplanet Data]
--Filter out planets more than 100 ly away
WHERE 
(Distance_ly<=100
--Filter out planets where distance was unknown and returned values of 0 ly away
AND Distance_ly>0
--Filter out planets with surface gravity too high or low for humans to live in, approximately 0.5g to 1.5g
AND (Planet_Mass_or_Mass_sin_i_Earth_Mass/(Planet_Radius_Earth_Radius*Planet_Radius_Earth_Radius)) BETWEEN 0.5 AND 1.5
--Filter out gas giants
AND Planet_Mass_or_Mass_sin_i_Earth_Mass<=10
--Filter out planets with equilibrium temp over 50 C, or 122 F, or below -50 C, or -58 F. Allow nulls since unknown equilibrium temps shouldn't disqualify.
AND Equilibrium_Temperature_K<=323.15 
AND Equilibrium_Temperature_K>=223.15)
OR 

(Distance_ly<=100
AND Distance_ly>0
AND (Planet_Mass_or_Mass_sin_i_Earth_Mass/(Planet_Radius_Earth_Radius*Planet_Radius_Earth_Radius)) BETWEEN 0.5 AND 1.5
AND Planet_Mass_or_Mass_sin_i_Earth_Mass<=10
AND Equilibrium_Temperature_K IS NULL)
EXCEPT
SELECT Planet_Name
,Host_Name
,Number_of_Planets
,Planet_Radius_Earth_Radius
,Planet_Mass_or_Mass_sin_i_Earth_Mass
,(Planet_Mass_or_Mass_sin_i_Earth_Mass/(Planet_Radius_Earth_Radius*Planet_Radius_Earth_Radius)) AS 'Planet Surface Gravity (g)'
,Equilibrium_Temperature_K
,Spectral_Type
,Distance_ly
FROM [Updated and Filtered Exoplanet Data]
--Filter out planets more than 100 ly away
WHERE 
Distance_ly<=100
--Filter out planets where distance was unknown and returned values of 0 ly away
AND Distance_ly>0
--Filter out planets with surface gravity too high or low for humans to live in, approximately 0.5g to 1.5g
AND (Planet_Mass_or_Mass_sin_i_Earth_Mass/(Planet_Radius_Earth_Radius*Planet_Radius_Earth_Radius)) BETWEEN 0.5 AND 1.5
--Filter out gas giants
AND Planet_Mass_or_Mass_sin_i_Earth_Mass<=10
--Filter out planets with equilibrium temp over 50 C, or 122 F, or below -50 C, or -58 F. Allow nulls since unknown equilibrium temps shouldn't disqualify.
AND Equilibrium_Temperature_K<=323.15 
AND Equilibrium_Temperature_K>=223.15
OR 
Distance_ly<=100
AND Distance_ly>0
AND (Planet_Mass_or_Mass_sin_i_Earth_Mass/(Planet_Radius_Earth_Radius*Planet_Radius_Earth_Radius)) BETWEEN 0.5 AND 1.5
AND Planet_Mass_or_Mass_sin_i_Earth_Mass<=10
AND Equilibrium_Temperature_K IS NULL

--AND ISNULL(Equilibrium_Temperature_K,909) = 909
ORDER BY Distance_ly;

SELECT 1286.0/1553.0