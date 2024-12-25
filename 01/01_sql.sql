-- ЗАДАЧА 1-1

Значения таблицы tab: 5, 7, 3, 4
Результат запроса: 19, 4, 4, 4, 7, 3


-- ЗАДАЧА 1-2

WITH tmp AS (
    SELECT
        DATE_TRUNC('month', created_at) AS dt,
        COUNT(title) AS count
    FROM tab
    GROUP BY DATE_TRUNC('month', created_at)
)

SELECT
    dt,
    count,
    100 * (count - LAG(count) OVER (ORDER BY dt)) / LAG(count) OVER (ORDER BY dt) AS prcnt_grow
FROM tmp;
