-- What’s the total outstanding for a organisation given a Camber of Commerce number and date?

SELECT cus.coc_number
     , day.date
     , SUM(outstanding_start)
FROM dmt.fct_leases fct

INNER JOIN dmt.dim_customers cus
ON (cus.customers_sk = fct.customers_sk)

INNER JOIN dmt.dim_day day
ON (day.date = fct.date)

WHERE     cus.coc_number = '73999881'
      AND day.date = TO_DATE('2024-08-27', 'YYYY-MM-DD')

GROUP BY cus.coc_number
       , day.date

ORDER BY day.date DESC;