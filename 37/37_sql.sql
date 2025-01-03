-- ЗАДАЧА 37-1

SELECT t1.column
FROM t1
LEFT JOIN t2 ON t1.column = t2.column
WHERE t2.column IS NULL;


-- ЗАДАЧА 37-2

SELECT
    employee_id,
    COUNT(employee_id) AS count_vacations
FROM vacations
WHERE (DATE_PART('year', date_start) = 2024) OR (DATE_PART('year', date_end) = 2024)
GROUP BY employee_id
HAVING COUNT(employee_id) > 2;


-- ЗАДАЧА 37-3

SELECT sum_val
FROM tab
WHERE t_date <= CURRENT_DATE
ORDER BY t_date DESC
LIMIT 1;
