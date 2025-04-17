-- ЗАДАЧА 1

CREATE, ALTER, DROP, TRUNCATE -- определение структуры БД
SELECT, INSERT, UPDATE, DELETE --для работы с данными
GRANT, REVOKE -- управление доступом
COMMIT, ROLLBACK, SAVEPOINT -- управление транзакциями
EXPLAINE, DESCRIBE, SHOW -- получение сведений о данных


-- ЗАДАЧА 2

SELECT
    column_1,
    SUM(column_2)
FROM t1
INNER JOIN t2 ON t1.id = t2.id
WHERE column_1 > 100
GROUP BY column_1
HAVING SUM(column_2) > 1000
ORDER BY column_1 DESC
LIMIT 3;


-- ЗАДАЧА 3

LEFT JOIN, RIGHT JOIN, INNER JOIN, FULL JOIN, CROSS JOIN

UNION, UNION ALL

EXCEPT


-- ЗАДАЧА 3-1

LEFT JOIN -- запрос вернёт все строки t1 и соотвествующие строки t2. Для значений t1, у которых нет совпадений будет NULL.


-- ЗАДАЧА 3-2

-- Запрос вернёт все строки t1, а для t2 будут NULL, так как условие 1 = 2 всегда FALSE.


-- ЗАДАЧА 4

-- Разница будет, если в столбце val есть NULL-значения. COUNT(*) считает все строки, а COUNT(val) - только неNULL значения.


-- ЗАДАЧА 5

SELECT COUNT(NULL) -- 0, так как COUNT не считает NULL-значения.
SELECT 1 WHERE 1 = NULL
SELECT 1 WHERE 1 <> NULL -- оба запроса не вернёт никаких строк, так как использование = и <> с NULL возвращает FALSE.


-- ЗАДАЧА 6-1

SELECT d.department_name
FROM sql_test_department AS d
LEFT JOIN sql_test_personnel AS p ON d.department_id = p.department_id 
GROUP BY d.department_name
HAVING COUNT(p.pers_id) <= 3;


-- ЗАДАЧА 6-2

WITH avg_salary AS (
SELECT
    pers_id,
    pers_name,
    pers_salary,
    AVG(pers_salary) OVER (PARTITION BY department_id) AS avg_salary
FROM sql_test_personnel
)

SELECT
    pers_id,
    pers_name
FROM avg_salary
WHERE pers_salary > avg_salary;


-- ЗАДАЧА 6-3

SELECT pers_name
FROM sql_test_personnel
WHERE SPLIT_PART(pers_name, ' ', 2) LIKE 'А%';


-- ЗАДАЧА 6-4

WITH tmp AS (
    SELECT
        pers_id,
        pers_name,
        CASE WHEN d.department_head = t.pers_id THEN 1 ELSE 0 END AS a,
        CASE WHEN p.gender = 'M' THEN 1 ELSE 0 END AS b,
        CASE WHEN d.department_name = 'Маркетинг' THEN 1 ELSE 0 END AS c,
        CASE WHEN p.pers_bd >= CURRENT_DATE - INTERVAL '30 year' THEN 1 ELSE 0 END AS d,
        CASE WHEN p.pers_salary > 70000 THEN 1 ELSE 0 END AS f
    FROM sql_test_personnel AS t
    LEFT JOIN sql_test_department AS p ON t.department_id = d.department_id
)

SELECT
    pers_id,
    pers_name
FROM tmp
WHERE a + b + c + d + f >= 3;


-- ЗАДАЧА 6-5


WITH tmp AS (
    SELECT pers_id
    FROM sql_test_personnel
    GROUP BY pers_id
    HAVING COUNT(pers_id) > 1
)

SELECT *
FROM sql_test_personnel AS p
INNER JOIN tmp ON p.pers_id = tmp.pers_id;


-- ЗАДАЧА 6-6

SELECT
    *,
    ROW_NUMBER() OVER () AS rn,
    ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY pers_bd DESC, pers_salary DESC) AS rn_2
FROM sql_test_personnel;


-- ЗАДАЧА 6-7

SELECT
    calc.credit_id,
    SUM(CASE WHEN calc.status = 'EXPIRED' THEN 1 ELSE 0 END) AS expired_days
FROM credit_calculations AS calc
INNER JOIN credit AS c ON calc.credit_id = c.credit_id
WHERE DATE_TRUNC('year', c.issued_date) = DATE_TRUNC('year', CURRENT_DATE)
GROUP BY calc.credit_id;


-- ЗАДАЧА 6-8

SELECT
    e1.id,
    e1.chief_id,
    e1.salary
FROM employee AS e1
INNER JOIN employee AS e2 ON e1.chief_id = e2.id
WHERE e1.hire_date < e2.hire_date;
