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

--1 (Clickhouse)
SELECT
    toQuarter(Date) AS quarter,
    Brand,
    SUM(Sales) AS amount
FROM sales
GROUP BY quarter, Brand
HAVING amount > 10000000
ORDER BY quarter;


--2 (Postgres)
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











