-- ЗАДАЧА 1

/* Запрос вернёт только 3 */


-- ЗАДАЧА 2

SELECT UPPER(REGEXP_REPLACE(merchant_src, '[^A-Za-z0-9_]', '', 'g')) AS merchant
FROM some_table;


-- ЗАДАЧА 3

WITH tmp AS (
    SELECT
        client_id,
        SUM(amount) AS amount
        ROW_NUMBER() OVER (ORDER BY SUM(amount) DESC) AS rn
    FROM transactions
    WHERE DATE_TRUNC('month', trans_time) = DATE_TRUNC('month', CURRENT_DATE())
    GROUP BY client_id
)

SELECT client_id
FROM tmp
WHERE rn = 5;
