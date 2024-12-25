-- ЗАДАЧА 17-1

SELECT
    tariff,
    COUNT(abonent_id) AS abonents
FROM abnt
GROUP BY tariff;


-- ЗАДАЧА 17-2

SELECT
    a.tariff,
    AVG(c.all_clc) AS average
FROM abnt AS a
INNER JOIN clcd AS c ON a.abonent_id = c.abonent_id
WHERE DATE_TRUNC('month', c.table_business_mont) = '2019-05-01'
GROUP BY a.tariff;


-- ЗАДАЧА 17-3

SELECT
    a.tariff,
    AVG(t.data_traffic_GB) AS average_traffic
FROM abnt AS a
LEFT JOIN traf AS t ON a.abonent_id = t.abonent_id
WHERE DATE_TRUNC('month', t.table_business_mont) = '2019-04-01'
GROUP BY a.tariff


-- ЗАДАЧА 17-4

WITH tab AS (
SELECT
    abonent_id,
    CASE
    WHEN activation_date > CURRENT_DATE - INTERVAL '1 week' THEN 'last_week',
    WHEN activation_date > CURRENT_DATE - INTERVAL '1 month' THEN 'last_month',
    WHEN activation_date > CURRENT_DATE - INTERVAL '3 month' THEN 'last_quarter',
    WHEN activation_date > CURRENT_DATE - INTERVAL '6 month' THEN 'last_half-year',
    ELSE 'more half-year'
    END AS groups
FROM abnt
)

SELECT
    groups,
    COUNT(abonent_id) AS abonents
FROM tab
GROUP BY groups;
