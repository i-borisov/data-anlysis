-- ЗАДАЧА 26-1

WITH max_id_tab AS (
    SELECT
        department_id,
        MAX(id) AS max_id
    FROM employee
    GROUP BY department
)

SELECT
    d.name AS department_name,
    e.name AS employee_name
FROM employee AS e
INNER JOIN max_id_tab AS m ON e.id = m.max_id
INNER JOIN department AS d ON m.department_id = d.id;


-- ЗАДАЧА 26-2

WITH tmp AS (
    SELECT DISTINCT department_id
    FROM employee
    WHERE name NOT LIKE '%[Zz]%[Ww]%' AND name NOT LIKE '%[Zz]%[Ww]%'
)

SELECT d.name AS department_name
FROM department AS d
LEFT JOIN tmp AS t ON d.id = t.department_id
WHERE t.department_id IS NULL;


-- ЗАДАЧА 26-3

WITH tab_1 AS (
    SELECT
        id,
        name,
        department_id,
        MAX(id) OVER (PARTITION BY department_id, salary) AS max_id
    FROM employee
), tab_2 AS (
    SELECT
        id,
        name,
        department_id,
        max_id
        LEAD(max_id) OVER (PARTITION BY department_id ORDER BY salary) AS next_id
    FROM tab_1
)

SELECT
    t2.name,
    e.name,
    e.salary
FROM tab_2 AS t2
LEFT JOIN employee AS e ON t2.next_id = e.id;


-- ЗАДАЧА 26-4

WITH tmp AS (
SELECT
    d.name,
    SUM(d.name) AS department_salary
FROM employee AS e
INNER JOIN department AS d ON e.department_id = d.id
GROUP BY d.name
)

SELECT
    name,
    department_salary
    SUM(department_salary) OVER (ORDER BY department_salary ASC) AS cumulative_salary
FROM tmp
ORDER BY department_salary ASC;
