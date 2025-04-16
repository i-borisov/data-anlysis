-- ЗАДАЧА 1

LEFT JOIN  -- 7/49
INNER JOIN -- 0/49


-- ЗАДАЧА 2

SELECT DISTINCT
    user_id,
    country_id,
    ROUND(SUM(order_sum) OVER (PARTITION BY country_id, user_id) /
    SUM(order_sum) OVER (PARTITION BY country_id) * 100.0, 2) AS rate
FROM orders
WHERE order_success = 1;
