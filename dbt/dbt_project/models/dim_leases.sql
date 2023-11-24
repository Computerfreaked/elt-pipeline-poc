{{ config(materialized='table') }}

SELECT clock_timestamp()                    AS etl_refresh_dt
     , ROW_NUMBER() OVER (ORDER BY lea.id)  AS leases_sk
     , cast(lea.id          AS INTEGER)     AS id

     , CAST(lea.customer_id AS INTEGER)     AS customer_id
     , lea.reference                        AS reference
     , lea.installment_no                   AS installment_no
     , lea.lane                             AS lane
     , lea.team                             AS team
     , lea.object_brand                     AS object_brand
     , lea.object_type                      AS object_type
FROM ods.ods_leases lea

UNION ALL

SELECT clock_timestamp()                    AS etl_refresh_dt
     , -1                                   AS leases_sk
     , NULL                                 AS id

     , NULL                                 AS customer_id
     , NULL                                 AS reference
     , NULL                                 AS installment_no
     , NULL                                 AS lane
     , NULL                                 AS team
     , NULL                                 AS object_brand
     , NULL                                 AS object_type

UNION ALL

SELECT clock_timestamp()                    AS etl_refresh_dt
     , -2                                   AS leases_sk
     , NULL                                 AS id

     , NULL                                 AS customer_id
     , NULL                                 AS reference
     , NULL                                 AS installment_no
     , NULL                                 AS lane
     , NULL                                 AS team
     , NULL                                 AS object_brand
     , NULL                                 AS object_type