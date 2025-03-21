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

-- ЗАДАЧА 3

WITH uniq_client AS (
    SELECT DISTINCT
        client_id,
        client_name,
        partition_date AS actual_number,
        LEAD(partition_date, 1, '2100-01-01') OVER (PARTITION BY client_id ORDER BY partition_date) AS next_number
    FROM clients_phones_ivb
ORDER BY client_id)

SELECT DISTINCT
    DATE_TRUNC('month', o.order_date) AS MONTH,
    o.client_id,
    u.client_name,
    SUM(order_price) OVER (PARTITION BY DATE_TRUNC('month', o.order_date), o.client_id, u.client_name)
FROM orders_ivb AS o
INNER JOIN uniq_client AS u ON o.client_id = u.client_id AND (o.order_date >= u.actual_number AND o.order_date < u.next_number)
ORDER BY o.client_id, month;
