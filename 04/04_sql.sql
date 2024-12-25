-- ЗАДАЧА 4-2

WITH tab AS (
    SELECT
        dt,
        product_id,
        MIN(dt) OVER (PARTITION BY product_id) AS first_purchase
        MAX(dt) OVER (PARTITION BY product_id) AS last_purchase
    FROM fact_purchases
    WHERE DATE_TRUNC(dt) = '2023-05-01'
)

SELECT
    product_id,
    first_purchase,
    last_purchase
FROM tab
WHERE first_purchase <> last_purchase
ORDER BY product_id, last_purchase;


-- ЗАДАЧА 4-3

WITH tab AS (
    SELECT
        user_id,
        DATE_TRUNC(order_date) AS order_month
    FROM orders
)

SELECT
    user_id
FROM tab
GROUP BY user_id
HAVING COUNT(DISTINCT order_month) = 6;
