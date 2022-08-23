
WITH
journey_seq
AS
(SELECT 
      [lrno]
      ,[arrdate]
      ,[saildate]
      ,[portname]
      ,[countryname]
      ,[priorportname]
      ,[priorcountryname]
      ,[movetype]
      ,[datecreated]
	  ,ROW_NUMBER() OVER (PARTITION BY lrno ORDER BY arrdate) journey_seq_number
  FROM [AutoShipments].[dbo].[Calls_Cap1]
  WHERE movetype = 'NA'
)
,
journey_length
AS
(
SELECT
	src.lrno
	,src.portname src_portname
	,src.arrdate src_arrdate
	,dst.portname dst_portname
	,dst.arrdate dst_arrdate
	,DATEDIFF(HOUR,src.arrdate,dst.arrdate) journey_dur_hr
FROM 
	journey_seq src
JOIN
	journey_seq dst
ON dst.lrno = src.lrno
AND dst.journey_seq_number - 1 = src.journey_seq_number 
)
SELECT
src_portname
,dst_portname
,AVG (journey_dur_hr) AVG_journey_dur_hr
from journey_length
group by 
src_portname
,dst_portname
order by 1
