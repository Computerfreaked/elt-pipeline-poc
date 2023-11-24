{{ config(materialized='table') }}

SELECT clock_timestamp()                    AS etl_refresh_dt
     , ROW_NUMBER() OVER (ORDER BY cus.id)  AS customers_sk
     , cast(cus.id         AS INTEGER)      AS id

     , CAST(cus.coc_number AS INTEGER)      AS coc_number
     , name                                 AS name
FROM ods.ods_customers cus

UNION ALL

SELECT clock_timestamp()                    AS etl_refresh_dt
     , -1                                   AS customers_sk
     , NULL                                 AS id

     , NULL                                 AS coc_number
     , NULL                                 AS name

UNION ALL

SELECT clock_timestamp()                    AS etl_refresh_dt
     , -2                                   AS customers_sk
     , NULL                                 AS id

     , NULL                                 AS coc_number
     , NULL                                 AS name