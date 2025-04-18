-- ЗАДАЧА 1

INNER JOIN -- 4 строки
LEFT JOIN  -- 5 строк
CROSS JOIN -- 12 строк


-- ЗАДАЧА 2

WITH tmp AS (
    SELECT
        DATE_TRUNC('month', order_date) AS month,
        COUNT(DISTINCT client_id) AS clients_month
    FROM Orders
    GROUP BY DATE_TRUNC('month', order_date)
)

SELECT
    *,
    LAG(clients_month) OVER (ORDER BY month) AS clients_prev_month
FROM tmp
ORDER BY month DESC;


-- ЗАДАЧА 3

WITH Names AS (
    SELECT
        client_id,
        client_name,
        partition_date AS phone_add,
        LEAD(partition_date) OVER (PARTITION BY client_id ORDER BY partiton_date) AS phone_change
    FROM ClientsPhones
)

SELECT
    DATE_TRUNC('month', o.order_date),
    n.client_id,
    n.client_name
    SUM(order_pricse) AS amount
FROM Orders AS o
INNER JOIN Names AS n ON o.client_id = n.client_id AND o.order_date BETWEEN n.phone_add AND n.phone_change - INTERVAL '1 day'
GROUP BY DATE_TRUNC('month', o.order_date), n.client_id, n.client_name;
