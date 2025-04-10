-- ЗАДАЧА 1

2
3


-- ЗАДАЧА 2

/* Это аналог CROSS JOIN - каждая строка соединится с каждой */


-- ЗАДАЧА 3

--1
10-10

--2
2-NULL
5-NULL
10-10


-- ЗАДАЧА 4

WITH tmp AS (
    SELECT
        dt,
        taking,
        SUM(taking) OVER (ORDER BY dt ASC) AS amount
    FROM t1
)

SELECT
    dt,
    taking,
    CASE
      WHEN amount <= 100000 THEN 0
      WHEN amount > 100000 AND taking * 0.03 < 100 THEN 100
      ELSE taking * 0.03
    END AS comission
FROM tmp; 


-- ЗАДАЧА 6

SELECT
    DATE_TRUNC('day', dt1) AS dt,
    ROUND(100.0 * SUM(dt2) / SUM(dt1), 2) AS delivery_percent,
    AVG(dt2 - dt1)
FROM tab
GROUP BY DATE_TRUNC('day', dt1)
ORDER BY DATE_TRUNC('day', dt1);
