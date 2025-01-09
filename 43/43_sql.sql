-- ЗАДАЧА 43-1

1-A-1-A
2-B-NULL-NULL
3-C-NULL-NULL

1-A-1-A


-- ЗАДАЧА 43-2

SELECT *
FROM tab
WHERE (date_from BETWEEN '2019-03-01' AND '2021-03-01') OR (date_to BETWEEN '2019-03-01' AND '2021-03-01');


-- ЗАДАЧА 43-3

WITH last_records AS (
SELECT
    id,
    MAX(raw_dt) AS last_record
FROM abnt
GROUP BY id
)

SELECT
    a.id,
    a.msisdn,
    a.tarif_plan_id,
    a.account_id,
    a.raw_dt
FROM abnt AS a
INNER JOIN last_records AS r ON a.id = r.id AND a.raw_dt = r.last_record;


-- ЗАДАЧА 43-4

SELECT
    p.prod_cat,
    SUM(s.price * s.cnt) AS total_amt
FROM sale AS s
INNER JOIN product AS p ON (s.prod_nm = p.prod_nm) AND (s.sale_dt BETWEEN p.eff_dt AND p.exp_dt)
GROUP BY p.prod_cat;


-- ЗАДАЧА 43-5

WITH tab AS (
    SELECT
        color
        ROW_NUMBER() OVER (PARTITION BY color) AS rn
    FROM a
)

SELECT
    a.color,
    tab.color
FROM a
INNER JOIN tab ON a.rn < tab.rn;
