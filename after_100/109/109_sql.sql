SELECT id_client
FROM (
SELECT
    id_client,
    CASE
        WHEN DATE(datetime_purchase) >= (MAX(DATE(datetime_purchase)) OVER (PARTITION BY id_client)) - INTERVAL '3 month' THEN 1
        ELSE 0
    END AS count_purchase
FROM purchases_ivb
)
GROUP BY id_client
HAVING SUM(count_purchase) > 10;
