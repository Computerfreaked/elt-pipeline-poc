-- What’s the total daily outstanding given a year? 

SELECT day.year
     , day.date
     , SUM(outstanding_start)
FROM dmt.fct_leases fct

INNER JOIN dmt.dim_day day
ON (day.date = fct.date)

GROUP BY day.year
       , day.date

ORDER BY day.year
       , day.date
;