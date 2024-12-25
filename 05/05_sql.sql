-- ЗАДАЧА 5-1

WITH tab AS (
    SELECT
        id,
        adr,
        dt,
        ROW_NUMBER() OVER (PARTITION BY id ORDER BY dt DESC) AS rn
    FROM atm
    WHERE dt < '2023-01-01'
)

SELECT
    id,
    adr,
    dt
FROM tab
WHERE rn = 1;
