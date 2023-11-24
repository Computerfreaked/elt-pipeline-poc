{{ config(materialized='table') }}

SELECT DISTINCT
       ROW_NUMBER() OVER ()                 AS installments_sk
     , ins.t                                AS t    
     , ins.ind_payment_date                 AS ind_payment_date
     , ins.ind_start_date                   AS ind_start_date
FROM {{ ref('installments') }} ins