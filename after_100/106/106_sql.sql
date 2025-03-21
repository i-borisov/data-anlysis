-- ЗАДАЧА 1

1. 4 строки
2. 5 строк
3. 12 строк

-- ЗАДАЧА 2

WITH tmp AS (
    SELECT
        DATE_TRUNC('month', order_date) AS month,
        COUNT(DISTINCT client_id) AS clients_month
    FROM Orders
    GROUP BY DATE_TRUNC('month', order_date)
)

SELECT
    month,
    clients_month,
    LAG(clients_month) OVER (ORDER BY month) AS clients_prev_month
FROM tmp
ORDER BY month DESC;
