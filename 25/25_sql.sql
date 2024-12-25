-- ЗАДАЧА 25-1

WITH tab AS (
SELECT
    user_id,
    DATE_TRUNC('month', order_date) AS order_month
FROM orders
)

SELECT user_id
FROM tab
GROUP BY user_id
HAVING COUNT(DISTINCT order_month) = 6;


-- ЗАДАЧА 25-2

-- ч.1:

WITH tmp AS (
    SELECT
        team,
        DENSE_RANK() OVER (ORDER BY points DESC) AS place
    FROM tab
)

SELECT place
FROM tmp
WHERE team = 'Название команды';

-- ч.2:

WITH tmp AS (
    SELECT
        t1.team,
        CASE
        WHEN t1.points <= t2.points THEN 0
        ELSE 1
        END AS points
    FROM t1
    INNER JOIN t2 ON t1.team <> t2.team
), tmp_2 AS (
    SELECT
        team,
        SUM(points) + 1 AS place
    FROM tmp
    GROUP BY team
)

SELECT place
FROM tmp_2
WHERE team = 'Название команды';
