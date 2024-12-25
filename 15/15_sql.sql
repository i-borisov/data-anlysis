-- ЗАДАЧА 15-1

SELECT
    date,
    COUNT(video_id) AS watch_daily,
    COUNT(DISTINCT user_id) AS users
FROM reports_stg.watch_content
GROUP BY date;


-- ЗАДАЧА 15-2

WITH w_1 AS (
    SELECT DISTINCT user_id
    FROM reports_stg.watch_content
    WHERE video_id = 1
), w_3 AS (
    SELECT DISTINCT user_id
    FROM reports_stg.watch_content
    WHERE video_id = 3
), w_13 AS (
    SELECT user_id
    FROM w_1
    INNER JOIN w_3 ON w_1.user_id = w_3.user_id
), w_2 AS (
    SELECT DISTINCT user_id
    FROM reports_stg.watch_content
    WHERE video_id = 2
)

SELECT w_13.user_id
FROM w_13
LEFT JOIN w_2 ON w_2.user_id = w_13.user_id
WHERE w_2.user_id IS NULL;
