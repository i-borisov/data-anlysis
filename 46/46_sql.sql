-- ЗАДАЧА 46-1

SELECT
    an.name,
    an_price
FROM Analysis
INNER JOIN Orders ON an_id = ord_an
WHERE DATE_TRUNC('day', ord_datetime) BETWEEN '2024-08-05' AND ('2024-08-05' + INTERVAL '1 week')


-- ЗАДАЧА 46-2

WITH tab AS (
    SELECT
        DATE_TRUNC('month', ord_datetime) AS date,
        an_group,
        COUNT(an_id) AS an_count
    FROM Analysis
    INNER JOIN Orders ON ord_an = an_id
    GROUP BY DATE_TRUNC('month', ord_datetime), an_group
)

SELECT
    date,
    an_group,
    SUM(an_count) OVER (PARTITION BY date ORDER BY an_group) AS cumulative_count
FROM tab;
