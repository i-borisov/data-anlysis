-- ЗАДАЧА 1

SELECT
    phone,
    number_of_takes
FROM users
GROUP BY phone
HAVING COUNT(phone) > 1
ORDER BY number_of_takes DESC;


-- ЗАДАЧА 2

SELECT
    page,
    COUNT(DISTINCT userid) as hits_count
FROM user_hits
WHERE business_dt > CURRENT_DATE - INTERVAL '7 day'
GROUP BY page
ORDER BY hits_count DESC
LIMIT 5;


-- ЗАДАЧА 3

SELECT
    u.user_id,
    u.name
FROM transactions AS t
INNER JOIN users AS u ON t.user_id = u.user_id
WHERE DATE_TRUNC('month', t.transaction_date) = DATE_TRUNC('month', CURRENT_DATE)
GROUP BY u.user_id, u.name
HAVING SUM(t.amount) > 1000;


-- ЗАДАЧА 4

SELECT price
FROM baza
WHERE date <= '2024-02-20'
ORDER BY date DESC
LIMIT 1;
