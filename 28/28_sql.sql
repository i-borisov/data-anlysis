-- ЗАДАЧА 29-1

SELECT
    program_id,
    COUNT(order_id) AS orders_count
FROM orders
WHERE DATE_TRUNC('month', order_date) = DATE_TRUNC('month', CURRENT_DATE)
GROUP BY program_id
ORDER BY orders_count DESC
LIMIT 5;


-- ЗАДАЧА 29-2

SELECT
    program_id,
    SUM(order_sum) AS amount
FROM orders
WHERE state = 'success'
GROUP BY program_id;


-- ЗАДАЧА 29-3

WITH analytics AS (
    SELECT DISTINCT id
    FROM programs
    WHERE direction = 'Аналитика'
)

SELECT program_id
FROM orders AS o
INNER JOIN analytics AS a ON o.program_id = a.id
WHERE (order_date BETWEEN '2021-11-01' AND '2021-12-31') AND (state = 'success')
GROUP BY program_id
HAVING SUM(order_sum) >= 1000000;


-- ЗАДАЧА 29-4

SELECT DISTINCT
    user_id,
    FIRST_VALUE(program_id) OVER (PARTITION BY user_id ORDER BY buy_date) AS first_program
FROM orders
WHERE sate = 'success';


-- ЗАДАЧА 29-5

SELECT DISTINCT
    user_id,
    LEAD(program_id, 3) OVER (PARTITION BY user_id ORDER BY buy_date) AS third_program
FROM orders
WHERE sate = 'success';


-- ЗАДАЧА 29-6

WITH tmp AS (
    SELECT DISTINCT
        user_id,
        order_id,
        LEAD(program_id, 2) OVER (PARTITION BY user_id ORDER BY buy_date) AS third,
        FIRST_VALUE(program_id) OVER (PARTITION BY user_id ORDER BY buy_date) AS first
    FROM orders
    WHERE sate = 'success'
)

SELECT
    user_id,
    CASE
    WHEN third IS NULL THEN first
    ELSE third
    END AS program_id
FROM tmp;
