-- ЗАДАЧА 23-1

WITH max_salary AS (
    SELECT MAX(salary) AS salary
    FROM employee
)

SELECT
    e.id,
    e.name,
    e.salary
FROM employee AS e
INNER JOIN max_salary AS m ON e.salary = m.salary;
