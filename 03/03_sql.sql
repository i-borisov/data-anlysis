-- ЗАДАЧА 3-1

Запрос вернёт все строки таблицы.


-- ЗАДАЧА 3-2

WITH tab AS (
    SELECT
        user_id,
        DATE_TRUNC('month', date) AS month
    FROM logins
)

SELECT
    t1.month,
    COUNT(DISTINCT t1.user_id)
FROM tab AS t1
INNER JOIN tab AS t2 ON t1.month = t2.month - INTERVAL '1 month' AND t1.user_id = t2.user_id
GROUP BY month;
