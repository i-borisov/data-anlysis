-- ЗАДАЧА 1

SELECT id_client
FROM (
    SELECT
    id_client,
    datetime_purchase,
    MAX(datetime_purchase) OVER (PARTITION BY id_client) AS last_purchase
    FROM sales
    ) AS tab
WHERE datetime_purchase >= last_purchase - INTERVAL '3 month'
GROUP BY id_client
HAVING COUNT(*) > 10;
