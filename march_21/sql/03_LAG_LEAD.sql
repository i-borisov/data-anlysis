-- ЗАДАЧА 3-1

WITH tmp AS (
    SELECT
        DATE_TRUNC('month', created_at) AS month,
        COUNT(title) AS pub_count
    FROM tab
    GROUP BY DATE_TRUNC('month', created_at)
)

SELECT
    month,
    pub_count,
    (pub_count - LAG(pub_count) OVER (ORDER BY month ASC)) / LAG(pub_count) OVER (ORDER BY month ASC) * 100 AS prcnt_growth
FROM tmp
ORDER BY month ASC;


-- ЗАДАЧА 3-2

WITH tmp AS (
    SELECT
        good_id,
        inventory_dt,
        ABS(LAG(inventory_cnt, 1, 0) OVER (PARTITION BY good_id ORDER BY inventory_dt) - inventory_cnt) AS inventory_cnt
    FROM inventory
)

SELECT
    good_id,
    inventory_dt,
    inventory_cnt
FROM tmp
WHERE inventory_cnt <> 0;


-- ЗАДАЧА 3-3

WITH tmp AS (
    SELECT
        transaction_id,
        amount_rur,
        LAG(amount_rur, 1, 0) OVER (PARTITION BY customer_id ORDER BY transaction_dttm) AS prev,
        LEAD(amount_rur, 1, 0) OVER (PARTITION BY customer_id ORDER BY transaction_dttm) AS next
    FROM transaction
)

SELECT transaction_id
FROM tmp
WHERE amount_rur > prev AND amount_rur > next;


-- ЗАДАЧА 3-4

SELECT
    Товар,
    "Дата с",
    LEAD("Дата с", 1, '31.12.9999') OVER (PARTITION BY Товар ORDER BY "Дата с") - INTERVAL '1 day' AS "Дата по",
    Цена
FROM tab
ORDER BY Товар, "Дата с";


-- ЗАДАЧА 3-5

WITH min_salary AS (
    SELECT
        empl_fio,
        amount
    FROM salary
    WHERE DATE_TRUNC('month', value_day) = '2023-05-01'
    ORDER BY amount ASC
    LIMIT 3
), diff AS (
    SELECT
        DATE_TRUNC('month', value_day) AS salary_month,
        empl_fio,
        amount - LAG(amount, 1, 0) OVER (PARTITION BY DATE_TRUNC('month', value_day), empl_fio) AS diff
    FROM salary AS s
    INNER JOIN min_salary AS m ON s.empl_fio = m.empl_fio
)

SELECT
    empl_fio,
    diff
FROM diff
WHERE salary_month = '2023-05-01';


-- ЗАДАЧА 3-6

WITH tmp AS (
    SELECT
        DATE_TRUNC('week', hitTime) AS week,
        COUNT(hitID) AS present
    FROM hits
    GROUP BY DATE_TRUNC('week', hitTime)
)

SELECT
    week,
    present,
    LAG(present, 1, 0) OVER (ORDER BY week ASC) AS prev
FROM tmp;


-- ЗАДАЧА 3-7

WITH tmp AS (
    SELECT
        num,
        LAG(num) OVER () AS prev,
        LEAD(num) OVER () AS next
    FROM tab_a
)

SELECT num
FROM tmp
WHERE num + 1 = next AND num - 1 <> prev;


-- ЗАДАЧА 3-8

WITH tmp AS (
    SELECT
        some_id,
        LEAD(some_id, 1, some_id + 1) OVER () AS next
    FROM table
)

SELECT
    some_id + 1 AS start,
    next - 1 AS finish
FROM tmp
WHERE next - some_id > k;


-- ЗАДАЧА 3-9

WITH tmp AS (
    SELECT
        DATE_TRUNC('month', order_date) AS month,
        COUNT(DISTINCT client_id) AS clients
    FROM tab
    GROUP BY DATE_TRUNC('month', order_date)
), tmp_2 AS (
    SELECT
        month,
        clients,
        LAG(clients, 1, 0) OVER (ORDER BY month ASC) AS prev_clients
    FROM tmp
)

SELECT
    month,
    ROUND((clients - prev_clients) / prev_clients * 100.0, 2) AS percent
FROM tmp_2;
