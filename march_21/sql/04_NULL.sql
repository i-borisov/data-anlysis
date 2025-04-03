-- ЗАДАЧА 4-1

/* Вернуться все строки */


-- ЗАДАЧА 4-2

SELECT art.id
FROM art
LEFT JOIN cat ON art.category_id = cat.id
WHERE cat.id IS NULL;


-- ЗАДАЧА 4-3

WITH tmp AS (
    SELECT instance_id
    FROM oplog
    WHERE DATE_PART('month', date_borrowed) BETWEEN 6 AND 8
)

SELECT article_id
FROM ins
LEFT JOIN tmp ON ins.id = tmp.instance_id
WHERE tmp.instance_id IS NULL;


-- ЗАДАЧА 4-4

SELECT c.name
FROM account AS a
INNER JOIN client AS c on a.client_id = c.id
INNER JOIN transaction AS t ON a.id = t.account_id
WHERE open_dt < CURRENT_DATE() - INTERVAL '1 year' AND close_dt IS NULL
GROUP BY c.name
HAVING SUM(amount) < 5000;


-- ЗАДАЧА 4-5

/* 1 */
SELECT Client_FIO
FROM CLIENTS
WHERE CLient_Address NOT LIKE '%Москва%' AND Client_Type = 'Пенсионер';

/* 2 */
SELECT
    c.Client_FIO,
    d.Document_no
FROM DOCUMENTS AS d
INNER JOIN CLIENTS AS c ON d.Client_id = c.Client_id
WHERE d.Valid_to = '2220-01-01';

/* 3 */
SELECT Client_id
FROM DOCUMENTS
GROUP BY Client_id
HAVING MAX(Valid_to) <> '2220-01-01';

/* 4 */
SELECT Client_id
FROM DOCUMENTS
WHERE Valid_to = '2220-01-01'
GROUP BY Client_id
HAVING COUNT(Valid_to) > 1;

/* 5 */
SELECT Client_FIO
FROM CLIENTS AS c
LEFT JOIN DOCUMENTS AS d ON c.Client_id = d.Client_id
WHERE d.Client_id IS NULL;


-- ЗАДАЧА 4-6

SELECT DISTINCT d.NAME
FROM EMPLOYEE AS e1
LEFT JOIN EMPLOYEE AS e2 ON e1.ID = e2.ID AND (e2.NAME ILIKE '%z%' AND e2.NAME ILIKE '%w%')
INNER JOIN DEPARTMENT AS d ON e1.DEPARTMENT_ID = d.ID
WHERE e2.ID IS NULL;


-- ЗАДАЧА 4-7

1. Отобразятся все сотрудники из департамента HR и amount тех сотрудников, у кого он больше 100000.
Для остальных будет NULL.

2. Отобразятся только компенсации для сотрудников HR-отдела. Если компенсаций нет - будет NULL.


-- ЗАДАЧА 4-8

/* 1 */
SELECT DISTINCT
    c.client_id,
    c.fio
FROM clients AS c
LEFT JOIN credist AS cr ON c.client_id = cr.client_id
WHERE cr.client_id IS NULL;

/* 2 */
SELECT
    c.client_id,
    c.fio
FROM clients
WHERE client_id NOT IN (SELECT DISTINCT client_id FROM credits WHERE client_id IS NOT NULL);

/* 3 */
SELECT
    c.client_id,
    c.fio
FROM clients as c
WHERE NOT EXISTS ( SELECT 1 FROM credits AS cr WHERE c.client_id = cr.client_id);


-- ЗАДАЧА 4-9

SELECT NULL + 5: -- Будет NULL.


-- ЗАДАЧА 4-10

Нет. ORDER BY просто сортирует строки.


-- ЗАДАЧА 4-11

/* 1 */
1-A-1-A
2-B-NULL-NULL
3-C-NULL-NULL

/* 2 */
1-A-1-A
