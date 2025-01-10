-- ЗАДАЧА 47-2

WITH tab AS (
    SELECT *
    FROM employees
    WHERE chief_of _department = 1
)

SELECT
    e.user_id,
    department_id
FROM employee AS e
INNER JOIN tab ON e.department_id = tab.department_id AND e.user_id <> tab.user_id
WHERE e.birthday_date > tab.birthday_date;
