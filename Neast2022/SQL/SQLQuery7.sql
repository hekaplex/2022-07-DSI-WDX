SELECT 
STDEV([InvoiceTotal]) -- Sigma 5542.21707881523
,AVG([InvoiceTotal]) -- Mu 1967.8571
,MIN([InvoiceTotal]) 
,MAX([InvoiceTotal]) 
from dbo.Invoices;

SELECT 37966.19/6.0 AS ratio_min_max
--6327.698333 

WITH score
as 
(
SELECT 
--(x-mu)/sigma
(InvoiceTotal - 486.086921)/928.489878330098 zscore
FROM
	Invoices
	)
SELECT
MIN(zscore) 
,MAX(zscore) 
from score
--max z/min z
select 32.856527347252487803/-0.522048686057590789 as ratio_min_max_zscore
--"ideal variance" = six sigma
--max z minus min z
select 32.856527347252487803 - -0.522048686057590789 as stdev_range_zscore
-- actual is 33+ sigma

SELECT COUNT(*) from Invoices
--60398
;
--Create View InvoiceTotalZ AS
WITH score
as 
(
SELECT 
(InvoiceTotal - 486.086921)/928.489878330098 zscore
FROM
	Invoices
	)
SELECT ROUND(zscore,0) as zscore_bin
--Results of line 31 / 100
, COUNT(*)/603.980 as [pctage]
from score
GROUP BY ROUND(zscore,0) 
ORDER BY ROUND(zscore,0) DESC