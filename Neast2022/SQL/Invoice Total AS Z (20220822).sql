SELECT 
STDEV([InvoiceTotal]) -- Sigma 5542.21707881523
,AVG([InvoiceTotal]) -- Mu 1967.8571
,MIN([InvoiceTotal]) 
,MAX([InvoiceTotal]) 
from dbo.Invoices;

SELECT 37966.19/6.0 AS ratio_min_max
--6327.698333 
;

WITH score
as 
(
SELECT 
--(x-mu)/sigma
(InvoiceTotal - 1967.8571)/5542.21707881523 zscore
FROM
	Invoices
	)
SELECT
MIN(zscore) 
,MAX(zscore) 
from score
--max z/min z
select 6.49529464257/-0.35206796707 as ratio_min_max_zscore
--"ideal variance" = six sigma
--max z minus min z
select 6.49529464257 - -0.35206796707 as stdev_range_zscore
-- actual is 6.8 sigma

SELECT COUNT(*) from Invoices
--120
;
--Create View InvoiceTotalZ AS
WITH score
as 
(
SELECT 
(InvoiceTotal - 0.35206796707)/6.49529464257 zscore
FROM
	Invoices
	)
SELECT ROUND(zscore,0) as zscore_bin
--Results of line 31 / 100
, COUNT(*)/120 as [pctage]
from score
GROUP BY ROUND(zscore,0) 
ORDER BY ROUND(zscore,0) DESC