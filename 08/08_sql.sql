-- ЗАДАЧА 8-1
-- ч.1

SELECT
    transaction_date,
    SUM(transaction_sum) AS sum_for_date
FROM money
GROUP BY transaction_date
ORDER BY transaction_date;

-- ч.2

WITH tab AS (
    SELECT
        transaction_date,
        SUM(transaction_sum) AS sum_for_date
    FROM money
    GROUP BY transaction_date
)

SELECT
    transaction_date,
    SUM(sum_for_date) OVER (ORDER BY transaction_date) AS cumulative_amount
FROM tab;

-- ч.3

WITH tab AS (
    SELECT
        transaction_date,
        SUM(transaction_sum) AS sum_for_date
    FROM money
    GROUP BY transaction_date
)

SELECT
    transaction_date,
    SUM(sum_for_date) OVER () AS total_amount
FROM tab;
