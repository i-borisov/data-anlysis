-- ЗАДАЧА 21-1

WITH best_clients AS (
    SELECT
        client_id,
        SUM(value) AS all_value
    FROM table
    GROUP BY client_id
    HAVING COUNT(DISTINCT category) = (SELECT COUNT(DISTINCT category) FROM table)
)

SELECT DISTINCT
    t.client_id,
    100 * (SUM(t.amount) OVER (PARTITION BY t.client_id, t.category)) / bs.all_value AS percent
FROM best_clients AS bs
INNER JOIN table AS t ON bs.client_id = t.client_id;
