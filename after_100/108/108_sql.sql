-- ЗАДАЧА 1

LEFT JOIN - 7 и 49
INNER JOIN - 0 и 49


-- ЗАДАЧА 2

SELECT DISTINCT
    user_id,
    country_id,
    ROUND(100.0 * (SUM(order_sum) OVER (PARTITION BY user_id)) / (SUM(order_sum) OVER (PARTITION BY country_id)), 2) AS user_rate
FROM orders_ivb
WHERE order_success = 1;
