-- ЗАДАЧА 1

SELECT DISTINCT
    e.user_id,
    FIRST_VALUE(i.price) OVER (PARTITION BY e.user_id ORDER BY e.event_datetime) AS price
FROM stage.lo_events AS e
INNER JOIN stage.items AS i ON e.product_id = i.item_id
WHERE event_name = 'add_to_cart'
ORDER BY e.user_id;


-- ЗАДАЧА 2

WITH tmp AS (
    SELECT
        user_id,
        SUM(CASE WHEN product_id = 101 THEN 1 ELSE 0 END) AS item_101,
        SUM(CASE WHEN product_id = 102 THEN 1 ELSE 0 END) AS item_102,
        SUM(CASE WHEN product_id = 104 THEN 1 ELSE 0 END) AS item_104
    FROM stage.lo_events
    WHERE event_name = 'add_to_cart'
    GROUP BY user_id
)

SELECT user_id
FROM tmp
WHERE item_101 > 0 AND item_102 > 0 AND item_104 = 0;
