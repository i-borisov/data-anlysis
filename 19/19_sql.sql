-- ЗАДАЧА 19-1

SELECT
    DATE_TRUNC('day', o.order_date) as order_date,
    p.name,
    COUNT(o.payment_dat) AS order_count
FROM orders AS o
INNER JOIN platforms AS p ON o.platform = p.platform
GROUP BY p.name, DATE_TRUNC('day', o.order_date)
ORDER BY order_date, p.name;


-- ЗАДАЧА 19-2

SELECT
    experience_id,
    COUNT(order_id) AS orders_count
FROM orders
GROUP BY experience_id
ORDER BY order_count DESC
LIMIT 10;


-- ЗАДАЧА 19-3

SELECT user_id
FROM orders
WHERE order_status = 'Забронировано'
GROUP BY user_id
HAVING COUNT(order_id) > 1;
