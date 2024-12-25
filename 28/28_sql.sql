-- ЗАДАЧА 28-1

SELECT
    p.name,
    COUNT(order_id) AS orders_count
FROM orders AS o
INNER JOIN programs AS p ON o.program_id = p.id
WHERE DATE_TRUNC('month', order_date) = DATE_TRUNC('month', CURRENT_TIME)
GROUP BY p.name
ORDER BY orders_count DESC
LIMIT 5;
