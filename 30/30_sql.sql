-- ЗАДАЧА 30-1

SELECT
    group_id,
    SUM(rub) AS amount,
    COUNT(DISTINCT receipt_id) AS receipt_count
FROM tab
GROUP BY group_id;


-- ЗАДАЧА 30-2

SELECT
    sale_date,
    CAST(receipt_id AS INT) AS receipt_id,
    group_id,
    rub,
    qty
FROM offline

UNION ALL

SELECT
    CAST(date_complete AS DATE) AS sale_date,
    order_id AS receipt_id,
    group_id,
    rub,
    qty
FROM online;


-- ЗАДАЧА 30-3

SELECT
    sale_date,
    CAST(receipt_id AS INT) AS receipt_id,
    group_id,
    rub,
    qty
FROM offline
WHERE from_online <> 1

UNION ALL

SELECT
    CAST(date_complete AS DATE) AS sale_date,
    order_id AS receipt_id,
    group_id,
    rub,
    qty
FROM online;


-- ЗАДАЧА 30-4

WITH t1 AS (
    SELECT
        sale_date AS date,
        tag,
        group_id,
        SUM(rub) AS rub_offline,
        SUM(qty) AS qty_offline
    FROM offline
    GROUP BY sale_date, tag, group_id
), t2 AS (
    SELECT
        CAST(date_complete AS DATE) AS date,
        tag,
        group_id,
        SUM(rub) AS rub_online,
        SUM(qty) AS qty_online
    FROM online
    GROUP BY CAST(date_complete AS DATE), tag, group_id
), t3 AS (
    SELECT
        COALESCE(t1.date, t2.date) AS date,
        COALESCE(t1.tag, t2.tag) AS tag,
        COALESCE(t1.group_id, t2.group_id) AS group_id
        t1.rub_offline,
        t1.qty_offline,
        t2.rub_online,
        t2.qty_online
    FROM t1
    FULL JOIN t2 ON t1.date = t2.date AND t1.tag = t2.tag AND t1.group_id = t2.group_id
)

SELECT
    *,
    MAX(rub_offline) OVER (PARTITION BY group_id) AS max_rubl_off
FROM t3;
