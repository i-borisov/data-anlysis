-- ЗАДАЧА 6-1

WITH tmp AS (
    SELECT
        product_id,
        FIRST_VALUE(dt) OVER (PARTITION BY product_id ORDER BY dt ASC) AS first_purchases,
        FIRST_VALUE(dt) OVER (PARTITION BY product_id ORDER BY dt DESC) AS last_purchases
    FROM fact_purchases
    WHERE DATE_TRUNC('month', dt) = '2023-05-01'
)

SELECT DISTINCT product_id
FROM tmp
WHERE first_purchases <> last_purchases;
