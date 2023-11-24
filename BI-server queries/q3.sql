-- What’s the total outstanding per team and lane given a date?

SELECT les.team
     , les.lane
     , day.date
     , SUM(outstanding_start)
FROM dmt.fct_leases fct

INNER JOIN dmt.dim_leases les
ON (les.leases_sk = fct.leases_sk)

INNER JOIN dmt.dim_day day
ON (day.date = fct.date)

WHERE day.date = TO_DATE('2019-06-18', 'YYYY-MM-DD')

GROUP BY les.team
       , les.lane
       , day.date;