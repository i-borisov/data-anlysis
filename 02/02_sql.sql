-- ЗАДАЧА 2-1

INNER JOIN:
1-1
3-3

LEFT JOIN:
1-1
2-NULL
3-3

FULL OUTER JOIN:
1-1
2-NULL
3-3
NULL-4
NULL-6


-- ЗАДАЧА 2-2

SELECT
DISTINCT
FROM
JOIN
WHERE
GROUP BY
HAVING
ORDER BY
LIMIT
OFFSET
UNION


-- ЗАДАЧА 2-3

WITH tab AS (
    SELECT
        good_id,
        inventory_dt,
        inventory_cnt,
        LAG(inventory_cnt, 1, 0) OVER (PARTITION BY good_id ORDER BY inventory_dt) AS previous_day
    FROM inventory
)

SELECT
    good_id,
    inventory_dt,
    ABS(inventory_cnt - previous_day) as inventory_cnt
FROM tab
WHERE inventory_cnt - previous_day <> 0;
