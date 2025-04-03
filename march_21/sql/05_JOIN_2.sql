-- ЗАДАЧА 5-1

SELECT
    DATE_TRUNC('month', l1.date) as month,
    COUNT(DISTINCT user_id)
FROM logins AS l1
INNER JOIN logins AS l2 ON l1.user_id = l2.user_id
AND
DATE_TRUNC('month', l1.date) - INTERVAL '1 month' = DATE_TRUNC('month', l2.date)
GROUP BY DATE_TRUNC('month', l1.date);
