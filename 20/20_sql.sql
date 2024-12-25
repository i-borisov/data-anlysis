-- ЗАДАЧА 20-1

SELECT e1.id
FROM employee AS e1
INNER JOIN employee AS e2 ON e1.department_id = e2.department_id AND e2.chief_flg = 1
WHERE chief_flg = 0 AND e1.birth_dt < e2.birth_dt;
