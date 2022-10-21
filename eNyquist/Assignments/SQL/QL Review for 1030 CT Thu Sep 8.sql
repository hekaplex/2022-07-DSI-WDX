-- Table altered (columns erased)

SELECT
	*
FROM
	Ships

SELECT
	*
FROM
	Calls


---Create new tables with inputted values using Inner Join
USE
	GDTAutoMvt
-- Create Vessel Operator Table
CREATE TABLE
	#VesselOperators(vessel_# INT, ship_name varchar(250), ship_owner varchar(250), ship_manager varchar(250), reg_nation varchar(250))
-- Create Vessel Dimension Table
CREATE TABLE 
	#VesselMeasure(vessel_# INT, capacity decimal, loa decimal, breadth decimal, depth decimal)
-- Create Vessel Transit Table
CREATE TABLE
	#Transit(vessel_# INT, port_# INT, port_name geography, port_country geography, entry_date date, depart_date date)


-- Insert values into TABLES


SELECT
*
FROM
    #VesselOperators
    INNER JOIN
    Ships
        ON Ships.lrno = Calls.lrno
    INNER JOIN 
    Calls
        ON Calls.lrno = Ships.lrno



SELECT  
	Ships.lrno
    Ships.vesselname,
    owner,
    shipmanager, 
    operator 
INTO result
FROM
	Ships
	INNER JOIN
    Calls
        ON Ships.lrno = Calls.lrno
WHERE
	vesseloperators like vessel_#

SELECT *
FROM
Ships

SELECT *
FROM
Details

--Create Procdure Example--

CREATE PROCEDURE
	ShipAll
AS
SELECT
	* 
FROM 
	Ships
GO;

EXEC ShipAll;

--Create View Example--

CREATE VIEW
	ManagementTravel
	AS
SELECT
	Ships.operator,
	Ships.owner,
	Ships.shipmanager
FROM
	Ships
WHERE
	vesselname = 'MORNING SPRUCE'
	vesselname = 'MADAME BUTTERFLY'
AND
	AS
SELECT
	Details.sdestination,
	Details.sstatus
FROM
	Details
WHERE
	sname = 'MORNING SPRUCE'
	sname = 'MADAME BUTTERFLY';

CREATE VIEW
	ManagementTravel3
	AS
SELECT
	Ships.operator,
	Ships.owner,
	Ships.shipmanager,
	Details.sdestination,
	Details.sstatus
FROM
	Ships,
	Details
WHERE
	sname = 'MADAME BUTTERFLY'
	AND
	sname = 'MORNING SPRUCE';

