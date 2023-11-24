--macro maybe??
{{ config(materialized='table') }}

WIth prep AS (
    SELECT ins.installment_no                            AS installment_no
         , CAST(ins.t AS INTEGER)                        AS t
         , dat.date                                      AS date_from
         , lead(dat.date) OVER (
                PARTITION BY installment_no
                ORDER BY to_number(t, '99999999999') ASC
                ) - 1                                    AS date_to

         , CAST(ins.installment       AS NUMERIC)        AS installment
         , CAST(ins.principal         AS NUMERIC)        AS principal
         , CAST(ins.interest          AS NUMERIC)        AS interest
         , CAST(ins.outstanding_start AS NUMERIC)        AS outstanding_start
    FROM ods.ods_installments ins

    CROSS JOIN LATERAL (
        SELECT TO_DATE(SUBSTR(ins.date, 1, 10), 'YYYY-MM-DD') AS date
    ) dat
)

SELECT prp.installment_no                                               AS installment_no
     , prp.t                                                            AS t
     , day.date                                                         AS date

     , ind_payment_date                                                 AS ind_payment_date
     , CASE WHEN     dat.ind_payment_date = 1 
                 AND t = 1
              THEN 1
            ELSE 0
       END                                                              AS ind_start_date

     , CASE WHEN dat.ind_payment_date = 1
              THEN prp.installment
            ELSE NULL
       END                                                              AS installment
     , CASE WHEN dat.ind_payment_date = 1
              THEN prp.principal
            ELSE NULL
       END                                                              AS principal
     , CASE WHEN dat.ind_payment_date = 1
              THEN prp.interest
            ELSE NULL
       END                                                              AS interest
     , CASE WHEN prp.outstanding_start = 0
              THEN NULL --important in case of
            ELSE prp.outstanding_start
       END                                                              AS outstanding_start
FROM prep prp

LEFT JOIN {{ ref('dim_day') }} day
ON (day.date BETWEEN prp.date_from AND COALESCE(prp.date_to, prp.date_from))

CROSS JOIN LATERAL (
    SELECT CASE WHEN prp.date_from = day.date THEN 1 ELSE 0 END AS ind_payment_date
) dat