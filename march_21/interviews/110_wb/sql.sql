-- ЗАДАЧА 1

--1 (Postgres)
SELECT
    DATE_PART('quarter', Date) AS quarter,
    Brand,
    SUM(Sales) AS amount
FROM sales
GROUP BY DATE_PART('quarter', Date), Brand
HAVING SUM(Sales) > 10000000
ORDER BY quarter;

--2 (Clickhouse)
SELECT
    toQuarter(Date) AS quarter,
    Brand,
    SUM(Sales) AS amount
FROM sales
GROUP BY quarter, Brand
HAVING amount > 10000000
ORDER BY quarter;


-- ЗАДАЧА 2

--1 (Postgres)
WITH unnest_table AS (
    SELECT
        UNNEST(Brand) AS Brand,
        UNNEST(Sale) AS Sale
    FROM sales
)

SELECT
    Brand,
    COUNT(Brand) AS count,
    SUM(Sale) AS amount
FROM unnest_table
WHERE Brand = 'ZARA'
GROUP BY Brand;

--2 (Clickhouse)
SELECT
    arrayJoin(Brand) AS Brand,
    COUNT(*) AS count,
    SUM(arrayJoin(Sale)) AS amount
FROM sales
WHERE arrayJoin(Brand) = 'Zara'
GROUP BY Brand;


-- ЗАДАЧА 3

SELECT DISTINCT
    Дата AS dt,
    "Метод Платежа" AS payment_method,
    ROUND((100.0 * SUM(Оборот) OVER (PARTITION BY Дата, "Метод платежа") / SUM(Оборот) OVER (PARTITION BY Дата)), 2) AS rate
FROM tab;


-- ЗАДАЧА 4

--вариант 1
WITH top AS (
SELECT employee_id
FROM tab
WHERE manager_id = 1 AND manager_id <> employee_id
), middle AS (
    SELECT tab.employee_id
    FROM top
    INNER JOIN tab ON top.employee_id = tab.manager_id
), low AS (
    SELECT tab.employee_id
    FROM middle
    INNER JOIN tab ON middle.employee_id = tab.manager_id
)

SELECT employee_id
FROM top

UNION

SELECT employee_id
FROM middle    

UNION

SELECT employee_id
FROM low;

--вариант 2

SELECT t1.employee_id
FROM tab AS t1
LEFT JOIN tab AS t2 ON t1.employee_id = t2.manager_id
LEFT JOIN tab AS t3 ON t2.employee_id = t3.manager_id
WHERE t1.manager_id = 1 AND t1.employee_id <> t1.manager_id;
