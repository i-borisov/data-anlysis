-- ЗАДАЧА 22-1

WITH tmp AS (
SELECT
    col,
    DENSE_RANK() OVER (ORDER BY col DESC) AS rank
    FROM table
)

SELECT col
FROM tmp
WHERE RANK = 2;


-- ЗАДАЧА 22-2

SELECT s.client_id
FROM fct_sales AS s
INNER JOIN dim_sku AS d ON s.sku_id = d.sku_id
WHERE dttm > dttm - INTERVAL '1 month'
GROUP BY s.client_id
HAVING SUM(s.sku_cnt * d.weight) > 2;


-- ЗАДАЧА 22-3
    s.client_id,
    s.dttm,
    SUM(s.sku_cnt * d.price) OVER (PARTITION BY s.client_id OVER s.dttm) AS cumulative_amount
FROM fct_sales AS s
INNER JOIN dim_sku AS d ON s.sku_id = d.sku_id;
