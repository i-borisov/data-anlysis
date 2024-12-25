-- ЗАДАЧА 12-1

-- ч.1:
12 и 0

-- ч.2:
12 и 3

-- ч.3:
12 и 4

--ч.3:
12 и 12


-- ЗАДАЧА 12-2

SELECT value
FROM T
GROUP BY value
HAVING COUNT(value) > 1;


-- ЗАДАЧА 12-3
WITH salary_rank AS (
    SELECT
        empl_fio,
        empl_dep,
        DENSE_RANK() OVER (PARTITION BY empl_dep ORDER BY amount DESC) as dr
    FROM Salary
    WHERE DATE_TRUNC('month', value_day) = '2023-04-01'
)

SELECT
    empl_fio,
    empl_dep
FROM salary_rank
WHERE dr = 2;


-- ЗАДАЧА 12-4

WITH tab AS (
    SELECT
        value_day,
        empl_fio,
        amount
        LAG(amount) OVER (PARTITION BY empl_fio ORDER BY value_day) AS prev_amount
    FROM salary
), tab_1 AS (
SELECT
    empl_fio,
    amount,
    prev_amount,
    DENSE_RANK() OVER (ORDER BY amount) AS dr
FROM tab
WHERE DATE_TRUNC('month', value_day) = '2024-05-01'
)

SELECT
    empl_fio,
    (amount - prev_amount) AS diff
FROM tab_1
WHERE dr <= 3;
