-- ЗАДАЧА 49-1

WITH tmp AS (
    SELECT
        some_id,
        LEAD(some_id) OVER (ORDER BY some_id ASC) AS next_id
    FROM table
)

SELECT
    (some_id + 1) AS start,
    (next_id - 1) AS end
FROM tmp
WHERE some_id + k < next_id;
