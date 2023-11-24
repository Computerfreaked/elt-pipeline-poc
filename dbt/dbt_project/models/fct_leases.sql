{{ config(materialized='table') }}

SELECT les.id                                                       AS leases_id        --debug
     , les.customer_id                                              AS customer_id      --debug

     , ins.installment_no                                           AS installment_no   --debug
     , ins.t                                                        AS t                --debug

     -- measures
     , ins.installment                                              AS installment
     , ins.principal                                                AS principal
     , ins.interest                                                 AS interest
     , ins.outstanding_start                                        AS outstanding_start

     -- sk's
     , les.leases_sk                                                AS leases_sk  
     , COALESCE(cus.customers_sk,        -1)                        AS customers_sk
     , COALESCE(din.installments_sk,     -1)                        AS installments_sk

     , COALESCE(day.date, TO_DATE('31-12-9999', 'DD-MM-YYYY'))      AS date
FROM {{ ref('dim_leases') }} les

LEFT JOIN {{ ref('dim_customers') }} cus
ON (cus.id = les.customer_id)

LEFT JOIN {{ ref('installments') }} ins
ON (ins.installment_no = les.installment_no)

LEFT JOIN {{ ref('dim_jnk_installments') }} din
ON (    din.t = ins.t
    AND din.ind_payment_date = ins.ind_payment_date
   )

LEFT JOIN {{ ref('dim_day') }} day
ON (day.date = ins.date)
