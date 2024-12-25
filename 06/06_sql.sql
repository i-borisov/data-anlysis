-- ЗАДАЧА 6-1

SELECT cat.name
FROM cat
INNER JOIN art ON cat.id = art.category_id
GROUP BY cat.name
HAVING AVG(art.deposit_price) > 5000;


-- ЗАДАЧА 6-2

SELECT art.id
FROM art
LEFT JOIN cat ON art.category_id = cat.id
WHERE cat.id IS NULL;


-- ЗАДАЧА 6-3

WITH tab AS (
    SELECT
        oplog.user_id,
        ins.id
        ROW_NUMBER() OVER (PARTITION BY oplog.user_id ORDER BY oplog.date_borrowed DESC) AS rn
    FROM oplog
    LEFT JOIN ins ON oplog.instance_id = ins.id
)

SELECT
    user_id,
    id
FROM tab
WHERE rn < 4;


-- ЗАДАЧА 6-4

WITH tab AS (
    SELECT DISTINCT instance_id
    FROM oplog
    WHERE date_part('month', date_borrowed) BETWEEN 6 AND 8
)

SELECT DISTINCT article_id
FROM ins
LEFT JOIN tab ON ins.id = tab.instance_id
WHERE tab.instance_id IS NULL;
