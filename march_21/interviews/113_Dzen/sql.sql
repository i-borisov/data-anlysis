-- ЗАДАЧА 1

-- 1 и 2
WITH users_cohort AS (
    SELECT
        user_id,
        MIN(DATE_TRUNC('day', datetime)) AS cohort
    FROM table
    GROUP BY user_id
)
SELECT
    uc.cohort,
    COUNT(DISTINCT uc.user_id) AS users,
    COUNT(DISTINCT t.user_id) / COUNT(DISTINCT uc.user_id) AS retention
FROM users_cohort AS uc
LEFT JOIN table AS t ON uc.user_id = t.user_id
AND DATE_TRUNC('day', t.datetime) <> uc.cohort
AND DATE_TRUNC('day', t.datetime) <= uc.cohort + INTERVAL '7 days' 
GROUP BY cohort;

--3
WITH tmp AS (
    SELECT
        user_id,
        campaign,
        DATE_TRUNC('day', datetime) AS dt,
        ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY datetime) AS rn
    FROM table
), channels AS (
    SELECT
        user_id,
        campaign,
        dt
    FROM tmp
    WHERE rn = 1
)

SELECT
    campaign,
    COUNT(c.user_id) AS users_count,
    COUNT(tmp.user_id) / NULLIF(COUNT(c.user_id), 0) AS retention
FROM channels AS c
LEFT JOIN tmp ON c.user_id = tmp.user_id AND tmp.rn = 2
WHERE tmp.dt <= c.dt + INTERVAL '7 days'
GROUP BY campaign;
