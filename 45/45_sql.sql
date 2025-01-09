-- ЗАДАЧА 45-2

WITH tab_2 AS (
    SELECT
        numbers,
        DENSE_RANK() OVER (PARTITION BY numbers ORDER BY numbers ASC) as rank
    FROM tab_1
)

SELECT numbers
FROM tab_1
WHERE rank = 2;
