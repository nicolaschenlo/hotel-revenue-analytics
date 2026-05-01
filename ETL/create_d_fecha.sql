-- Cambia start_date y end_date según tu rango 
CREATE OR REPLACE TABLE d_fecha AS
WITH params AS (
SELECT '2017-01-01'::DATE AS start_date,
'2019-12-31'::DATE AS end_date ),
date_spine AS ( SELECT DATEADD('day', SEQ4(), p.start_date) AS calendar_date 
FROM TABLE(GENERATOR(ROWCOUNT => 3653)) g, params p 
WHERE DATEADD('day', SEQ4(), p.start_date) <= p.end_date -- ✅ WHERE en lugar de QUALIFY 
) 
SELECT calendar_date as FECHA, 
YEAR(calendar_date) AS year_num, 
MONTH(calendar_date) AS month_num, 
DAY(calendar_date) AS day_num, 
DAYOFWEEK(calendar_date) AS day_of_week, 
DAYOFYEAR(calendar_date) AS day_of_year, 
WEEKOFYEAR(calendar_date) AS week_of_year, 
DAYNAME(calendar_date) AS day_name, 
MONTHNAME(calendar_date) AS month_name, 
QUARTER(calendar_date) AS quarter_num, 
CASE WHEN MONTH(calendar_date) <= 6 THEN 1 ELSE 2 END AS semester_num, 
TO_NUMBER(TO_CHAR(calendar_date, 'YYYYMMDD')) AS date_key, 
TO_CHAR(calendar_date, 'YYYY-MM') AS year_month,
(DAYOFWEEK(calendar_date) IN (0, 6)) AS is_weekend, 
NOT (DAYOFWEEK(calendar_date) IN (0, 6)) AS is_weekday
FROM date_spine 
ORDER BY calendar_date;