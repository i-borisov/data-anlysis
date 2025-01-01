-- ЗАДАЧА 31-1

200


-- ЗАДАЧА 31-2

1


-- ЗАДАЧА 31-3

50


-- ЗАДАЧА 31-4

SELECT
    d.department_id,
    d.department_name
FROM department_tb AS d
LEFT JOIN employee_tb AS t ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
HAVING COUNT(DISTINCT e.employee_id) > 10
ORDER BY COUNT(DISTINCT e.employee_id) DESC, d.department_id ASC;


-- ЗАДАЧА 31-5

2, 3, 1, 2, 3, 4


-- ЗАДАЧА 31-6

1-1
NULL-1


-- ЗАДАЧА 31-7

-- Вариант 1

SELECT cl.clients_id
FROM CLIENTS AS cl
LEFT JOIN CREDITS AS cr ON cl.client_id = cr.client_id
GROUP BY cl.clients_id
HAVING COUNT(cr.credit_id) = 0;

-- Вариант 2

WITH tab AS (
    SELECT DISTINCT client_id
    FROM CREDITS
)

SELECT c.client_id
FROM CLIENTS AS c
LEFT JOIN tab AS t ON c.client_id = t.client_id
WHERE t.client_id IS NULL;

-- Вариант 3

SELECT client_id
FROM CLIENTS

EXCEPT

SELECT client_id
FROM CREDITS;
