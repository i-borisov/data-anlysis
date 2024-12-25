-- ЗАДАЧА 11-1

SELECT
    width,
    height,
    depth,
    (widt * height + height * depth + width * depth) * 2 AS area,
    (width * height * depth) AS volume
FROM box
ORDER BY area, volume, width, height, depth;


-- ЗАДАЧА 11-2

SELECT mpg * fuel_left >= distance_to_pump AS answer
FROM zerofuel;


-- ЗАДАЧА 11-3
WITH days_and_week AS (
    SELECT
        employee_id,
        attendance_date,
        DATE_PART('dow', attendance_date) AS day_of_week,
        EXTRACT(WEEK FROM attendance_date) AS week_of_year
    FROM tab
    WHERE attendance_date BETWEEN '2023-01-01' AND '2023-12-31'
), workdays_count AS (
    SELECT
        employee_id,
        COUNT(day_of_week) AS days_count
    FROM days_and_week
    WHERE day_of_week IN (6, 7)
    GROUP BY employee_id
), weekends_count AS (
    SELECT
        employee_id,
        COUNT(DISTINCT week_of_year) AS weekends_count
    FROM days_and_week
    WHERE day_of_week IN (6, 7)
)

SELECT
    dc.employee_id,
    dc.days_count,
    wc.weekends_count
FROM workdays_count AS dc
INNER JOIN weekends_count AS wc ON dc.employee_id = wc.employee_id;
