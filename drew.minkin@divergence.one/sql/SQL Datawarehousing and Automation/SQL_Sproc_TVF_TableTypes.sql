GO 
Use AdventureWorks2019
GO
/* Create a table type. */
CREATE TYPE LocationTableType AS TABLE
( LocationName VARCHAR(50)
, CostRate INT );
GO

/* Create a procedure to receive data for the table-valued parameter. */
CREATE PROCEDURE usp_InsertProductionLocation
    @TVP LocationTableType READONLY
    AS
    SET NOCOUNT ON
    INSERT INTO [AdventureWorks2019].[Production].[Location]
       ([Name]
       , [CostRate]
       , [Availability]
       , [ModifiedDate])
    SELECT *, 0, GETDATE()
    FROM @TVP;
GO

/* Declare a variable that references the type. */
DECLARE @LocationTVP
AS LocationTableType;

/* Add data to the table variable. */
INSERT INTO @LocationTVP (LocationName, CostRate)
    SELECT [Name], 0.00
    FROM
    [AdventureWorks2019].[Person].[StateProvince];

/* Pass the table variable data to a stored procedure. */
EXEC usp_InsertProductionLocation @LocationTVP;
GO

CREATE TYPE ZScoresType AS TABLE
(    id varchar(50) primary key,    observation float
)
CREATE PROCEDURE GetZScores 
@DataForScores ZScoresType READONLY   
AS
BEGIN     --SET NOCOUNT ON   --no clue what this is for   --INSERT INTO ZScoreType  --populate Table Type with table passed as argument   --SELECT id, observation FROM @DataForScores

DECLARE @σ_sigma float,        @μ_mu float

SELECT @σ_sigma = STDEV(observation) FROM @DataForScores
SELECT @μ_mu = AVG(observation) FROM @DataForScores
 --Does this return need to be here?
SELECT id, (observation - @μ_mu) / @σ_sigma as [z_score]
FROM @DataForScores
END
GO

DECLARE @INV ZScoresType
INSERT INTO @INV (id,observation) SELECT [InvoiceNumber], AVG ([InvoiceTotal]) from [dbo].[Invoices] GROUP BY [InvoiceNumber]
DEClARE @sanitycheck ZScoresType
INSERT INTO @sanitycheck EXEC GetZScores @INV
SELECT AVG(observation), STDEV(observation) from @sanitycheck 



DECLARE @σ_sigma float,        @μ_mu float
SELECT @σ_sigma = STDEV(observation) FROM @INV
PRINT (@σ_sigma )





/* Create a table type. */
CREATE TYPE LocationTableType 
   AS TABLE
      ( LocationName VARCHAR(50)
      , CostRate INT );
GO
/* Create a procedure to receive data for the table-valued parameter. */
CREATE FUNCTION dbo.tvf_InsertProductionLocation
   (@TVP LocationTableType READONLY )
RETURNS TABLE
      AS
      RETURN
	  (
	  SELECT *, 0 as int_02, GETDATE() as dT_03
      FROM @TVP
	  );
GO
/* Declare a variable that references the type. */
DECLARE @LocationTVP AS LocationTableType;
/* Add data to the table variable. */
INSERT INTO @LocationTVP (LocationName, CostRate)
   SELECT Name, 0.00
   FROM AdventureWorks2019.Person.StateProvince;
  
/* Pass the table variable data to a stored procedure. */
SELECT * FROM dbo.tvf_InsertProductionLocation (@LocationTVP);