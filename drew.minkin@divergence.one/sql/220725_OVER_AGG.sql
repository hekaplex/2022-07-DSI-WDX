WITH
BaseAgg
AS
(
	SELECT YEAR(CONVERT(char(20),[OrderDateKey],112)) SalesYear
		  ,Month(CONVERT(char(20),[OrderDateKey],112)) SalesMonth
		  ,[SalesTerritoryKey] Territory
		  ,SUM([SalesAmount]) [SalesTotal]
		 -- ,PromotionKey
	  FROM [dbo].[FactInternetSales]
	  GROUP BY 
	  YEAR(CONVERT(char(20),[OrderDateKey],112)) 
		  ,Month(CONVERT(char(20),[OrderDateKey],112)) 
		  ,[SalesTerritoryKey]
	--,PromotionKey
)
SELECT 
	--Territory, SalesYear, count(*)
	*
	,SUM(SalesTotal)  OVER (PARTITION BY Territory, SalesYear ORDER BY SalesMonth ASC) as YTD
	,LAG([SalesTotal],1,0) OVER (PARTITION BY Territory, SalesYear ORDER BY SalesMonth ASC) YTD_PrevMon
	from 
	BaseAgg
--	group by Territory, SalesYear
--2012	SM4	Terr 4	39284.1955	1	282795.0815