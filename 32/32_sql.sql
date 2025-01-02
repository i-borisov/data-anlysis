-- ЗАДАЧА 32-1

1-1
1-1
2-2
2-2
3-NULL
4-NULL
5-NULL
7-NULL
9-9
NULL-NULL


-- ЗАДАЧА 32-2

WITH tmp AS (
    SELECT Name
    FROM tab
    WHERE Mark = 5
    GROUP BY Name
    HAVING COUNT(Mark) >= 10
)

SELECT
    tab.name,
    COUNT(tab.Mark)
FROM tab
INNER JOIN tmp ON tab.Name = tmp.Name
WHERE Mark = 2
GROUP BY Name;


-- ЗАДАЧА 32-3

-- ч.1

WITH tmp AS (
    SELECT
        t1.client_id,
        AVG(t2.amount) AS average_amount
    FROM t1
    LEFT JOIN t2 ON t1.card_id = t2.card_id
    WHERE DATE_TRUNC('month', t2.transaction_date) = '2024-05-01'
    GROUP BY t1.client_id
)

SELECT
    client_id,
    COALESCE(average_amount, 0) AS average_amount
FROM tmp;

-- ч.2

WITH tmp AS (
    SELECT
        card_id,
        SUM(amount) AS card_amount
    FROM t2
    GROUP BY card_id
), tmp2 AS (
    SELECT
        t1.client_id,
        tmp.card_id,
        ROW_NUMBER() OVER (PARTITION BY t1.client_id ORDER BY card_amount DESC) AS rn
    FROM tmp
    LEFT JOIN t1 ON tmp.card_id = t1.card_id
)

SELECT
    client_id,
    card_id
FROM tmp2
WHERE rn = 1;


-- ЗАДАЧА 32-4

WITH tab AS (
    SELECT
        num,
        LEAD(num) OVER (ORDER BY num ASC) AS next_num,
        LAG(num) OVER (ORDER BY num ASC) AS previous_num
    FROM A
)

SELECT num
FROM tab
WHERE (num + 1 = next_num) AND (num - 1 <> previous_num)


-- ЗАДАЧА 32-5

-- ч.1

SELECT
    MIN(t1.A),
    MAX(t1.A),
    MIN(t2.B),
    MAX(t2.B)
FROM Table1 AS t1
CROSS JOIN Table2 AS t2;

-- ч.2

WITH tab AS (
    SELECT A
    FROM Table1

    UNION ALL

    SELECT B AS A
    FROM Table2
)

SELECT
    MIN(A),
    MAX(A),
    SUM(A),
    COUNT(A)
FROM tab;


-- ЗАДАЧА 32-6

SELECT
    customer_rk,
    report_dt,
    SUM(transaction_rur_amt) FILTER (WHERE mcc_group_cd = 'Супермаркеты') AS supermarkets,
    SUM(transaction_rur_amt) FILTER (WHERE mcc_group_cd = 'Кафе и рестораны') AS restaurant,
    SUM(transaction_rur_amt) FILTER (WHERE mcc_group_cd = 'АЗС') AS fuel
FROM tab
GROUP BY customer_rk, report_dt;
