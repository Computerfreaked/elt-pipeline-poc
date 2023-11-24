{{ config(materialized='table') }}

WITH dates AS(
  SELECT * FROM generate_series(
  '2015-01-01'::timestamp,
  '2100-12-31',
  '1 day') AS DATE
)
SELECT TO_NUMBER(TO_CHAR(dat.date, 'YYYYMMDD'), '99999999') AS date_id
     , dat.date                                             AS date
     , TO_NUMBER(TO_CHAR(dat.date, 'YYYY')    , '9999')     AS year   --yields numeric, convert to int?
     , TO_NUMBER(TO_CHAR(dat.date, 'YYYYMM')  , '999999'  ) AS month_id
FROM dates dat

UNION ALL

SELECT 99991231                                             AS date_id
     , TO_DATE('31-12-9999', 'DD-MM-YYYY')                  AS date
     , 9999                                                 AS year
     , 999912                                               AS month_id