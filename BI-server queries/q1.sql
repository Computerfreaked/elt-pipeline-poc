-- Whats the outstanding for a lease given a reference and a date

SELECT les.reference
     , day.date
     , SUM(outstanding_start)
FROM dmt.fct_leases fct

INNER JOIN dmt.dim_leases les
ON (les.leases_sk = fct.leases_sk)

INNER JOIN dmt.dim_day day
ON (day.date = fct.date)

WHERE     les.reference = 'BQ11764.1901.14'
      AND day.date = TO_DATE('2019-06-30', 'YYYY-MM-DD')

GROUP BY les.reference
       , day.date;