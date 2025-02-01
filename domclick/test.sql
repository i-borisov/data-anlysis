--  ЗАДАЧА 1

WITH tab1 AS (
    SELECT DISTINCT
        deal_id,
        MIN(created_at) OVER (PARTITION BY deal_id) AS first_status,
        MAX(created_at) OVER (PARTITION BY deal_id) AS last_status
FROM status_log
), tab2 AS (
SELECT
        t1.deal_id,
        t1.first_status,
        t1.last_status,
        (
            SELECT COUNT(type)
            FROM calendar
            WHERE type = 'hol' AND
            dt BETWEEN DATE_TRUNC('day', t1.first_status) AND DATE_TRUNC('day', t1.last_status)
        ) AS count_hol
    FROM tab1 AS t1
)

SELECT
    deal_id,
    ((EXTRACT(EPOCH FROM last_status) - EXTRACT(EPOCH FROM first_status)) / 3600) - (24 * count_hol) AS hours_fact
FROM tab2;


-- ЗАДАЧА 2

WITH tab1 AS (
    SELECT
        status_id,
        created_at,
        LEAD(created_at) OVER (PARTITION BY deal_id ORDER BY created_at) AS status_changed
    FROM status_log
), tab2 AS (
    SELECT
        t1.status_id,
        t1.created_at,
        t1.status_changed,
        (EXTRACT(EPOCH FROM t1.status_changed) - EXTRACT(EPOCH FROM t1.created_at)) / 3600 AS hours_between_status,
        (
            SELECT COUNT(type)
            FROM calendar
            WHERE type = 'hol' AND
            dt BETWEEN DATE_TRUNC('day', t1.created_at) AND DATE_TRUNC('day', t1.status_changed)
        ) AS count_hol
    FROM tab1 AS t1
), tab3 AS (
    SELECT
        status_id,
        AVG(hours_between_status - (24 * count_hol)) AS avg_time
    FROM tab2
    GROUP BY status_id
), tab4 AS (
    SELECT
        status_id,
        COUNT(status_id) AS status_count
    FROM status_log
    GROUP BY status_id
)

SELECT
    t3.status_id,
    t3.avg_time,
    t4.status_count - 1 AS status_repeat
FROM tab3 AS t3
LEFT JOIN tab4 AS t4 ON t3.status_id = t4.status_id
ORDER BY t3.status_id;
