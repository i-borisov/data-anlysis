-- ЗАДАЧА 5-1

SELECT
    DATE_TRUNC('month', l1.date) as month,
    COUNT(DISTINCT user_id)
FROM logins AS l1
INNER JOIN logins AS l2 ON l1.user_id = l2.user_id
AND
DATE_TRUNC('month', l1.date) - INTERVAL '1 month' = DATE_TRUNC('month', l2.date)
GROUP BY DATE_TRUNC('month', l1.date);


-- ЗАДАЧА 5-2

SELECT
    s.prod_cat,
    SUM(s.price * s.cnt) AS total_amt
FROM sale AS s
INNER JOIN product AS p ON s.prod_nm = p.prod_nm  AND s.sale_dt BETWEEN p.dt_from AND p.dt_to
GROUP BY s.prod_cat
ORDER BY prod_cat;


-- ЗАДАЧА 5-3 (Дубль задачи 5-2)


-- ЗАДАЧА 5-4

SELECT
    a1.color,
    a2.color
FROM a AS a1
INNER JOIN a AS a2 ON a1.clolr < a2.color;
