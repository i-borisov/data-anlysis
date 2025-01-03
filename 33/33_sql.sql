-- ЗАДАЧА 33-1

SELECT
    t1.name,
    COUNT(t1.id)
FROM t1
LEFT JOIN t2 ON t1.id = t2.id
GROUP BY t1.name;

/*
Результат запроса:
a-1
b-1
c-1
d-0
*/


-- ЗАДАЧА 33-2

/*

Неясны условия задачи.

Если все значения в таблицах одинаковы, то INNER JOIN вернёт 24 строки.

Если значения одинаковы только в рамках одной таблицы, то INNER JOIN вернёт 0 строк.

*/
