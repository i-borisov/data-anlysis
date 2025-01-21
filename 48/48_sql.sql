-- ЗАДАЧА 48-1

SELECT
    CASE
    WHEN COUNT(*) = 0 THEN NULL
    ELSE MAX(num)
    END AS result
FROM MyNumber
GROUP BY num
HAVING COUNT(num) = 1;


-- ЗАДАЧА 48-2

-- LEFT JOIN
1-1
1-1
2-2
2-2
3-NULL

-- INNER JOIN
1-1
1-1
2-2
2-2

-- CROSS JOIN
1-1
1-1
1-2
1-2
2-1
2-1
2-2
2-2
3-1
3-1
3-2
3-2
