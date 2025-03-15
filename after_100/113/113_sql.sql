-- 1. Количество новых пользователей по дням (размер когорт):

WITH visits AS (
SELECT
    user_id,
    DATE(datetime) AS visit_date,
    ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY datetime) AS rn
FROM sandbox.visits_ivan_b
)

SELECT
    visit_date,
    COUNT(user_id) AS user_count
FROM visits
WHERE rn = 1
GROUP BY visit_date;

-- 2. Retention первой недели по когортам:

WITH visits AS (
SELECT
    user_id,
    DATE(datetime) AS visit_date,
    ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY datetime) AS rn
FROM sandbox.visits_ivan_b
), first_visit AS (
SELECT
    user_id,
    visit_date AS visit_1
FROM visits
WHERE rn = 1
), second_visit AS (
SELECT
    user_id,
    visit_date AS visit_2
FROM visits
WHERE rn = 2
)

SELECT
    fv.visit_1 AS first_visit,
    100 * COUNT(sv.user_id) / COUNT(fv.user_id) AS retention
FROM first_visit AS fv
LEFT JOIN second_visit AS sv ON fv.user_id = sv.user_id AND visit_2 - INTERVAL '7 day' <= visit_1
GROUP BY first_visit;

--3. Retention первых 7 дней по каналам.

WITH visits AS (
SELECT
    user_id,
    campaign,
    DATE(datetime) AS visit_date,
    ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY datetime) AS rn
FROM sandbox.visits_ivan_b
), first_visit AS (
SELECT
    visit_date AS visit_1,
    campaign,
    user_id
FROM visits 
WHERE rn = 1
), second_visit AS (
SELECT
    visit_date AS visit_2,
    campaign,
    user_id
FROM visits 
WHERE rn = 2
)


SELECT
fv.campaign,
100 * COUNT(sv.user_id) / COUNT(fv.user_id) AS retention
FROM first_visit AS fv
LEFT JOIN second_visit AS sv ON fv.user_id = sv.user_id AND visit_2 - INTERVAL '7 day' <= visit_1
GROUP BY fv.campaign;
