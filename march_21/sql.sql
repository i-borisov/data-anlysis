-- ЗАДАЧА 1-1

INNER JOIN t1.a = t2.a -- 2
LEFT JOIN t1.a = t2.a -- 3
FULL OUTER JOIN t1.a = t2.a -- 5


-- ЗАДАЧА 1-2

-- Запрос 1
1-1
1-1
2-2
2-2
2-2
2-2
3-3
4-NULL
NULL-NULL

-- Запрос 2
1-1
1-1
2-2
2-2
2-2
2-2
3-3


-- ЗАДАЧА 1-3

INNER JOIN -- 0/12
LEFT JOIN -- 3/12
FULL JOIN -- 4/12
CROSS JOIN -- 12/12


-- ЗАДАЧА 1-4

INNER JOIN tab ON column != 5 -- Да. Джойнить можно по любым условиям.


-- ЗАДАЧА 1-5

min/max: LEFT JOIN 5 строк к 10 строкам -- 10/50


-- ЗАДАЧА 1-6

min/max: INNER JOIN 10 и 100 строк -- 0/1000


-- ЗАДАЧА 1-7

1-1
1-1
2-2
2-2
3-NULL
4-NULL
5-NULL
7-NULL
9-9
NULL-NULL


-- ЗАДАЧА 1-8

SELECT t1.name
FROM t1
LEFT JOIN t2 ON t1.id = t2.id;

-- вывод:
a
b
c
NULL

SELECT COUNT(1)
FROM t1;

-- вывод:
4


-- ЗАДАЧА 1-9

INNER JOIN вернёт 24 строки, так как все значения одинаковые, а значит они задублируются.


-- ЗАДАЧА 1-10

SELECT 8; -- Вернётся значение '8'

SELECT 8 FROM table; -- Вернётся значение '8' в кол-ве равному кол-ву строк в таблице


-- ЗАДАЧА 1-11

Может, если в таблицах разное количество строк или разные значения, например.


-- ЗАДАЧА 1-12

INNER JOIN


-- ЗАДАЧА 1-13

100/1000

-- ЗАДАЧА 1-14

-- INNER
1-1
1-1
2-2
2-2
2-2
2-2
4-4

-- LEFT
1-1
1-1
2-2
2-2
2-2
2-2
NULL-NULL
4-4
5-NULL
NULL-NULL

-- RIGHT
2-2
2-2
1-1
NULL-3
4-4
NULL-NULL
1-1
2-2
2-2

-- FULL
1-1
1-1
2-2
2-2
2-2
2-2
NULL-NULL
4-4
5-NULL
NULL-NULL
NULL-3
NULL-NULL


-- ЗАДАЧА 1-16

1-1
1-2
1-3
1-4
NULL-5

Без WHERE -- 5/20

С WHERE -- 0/5


-- ЗАДАЧА 1-17

LEFT JOIN -- 5
INNER JOIN -- 4
CROSS JOIN -- 12


-- ЗАДАЧА 1-18

LEFT JOIN -- 5
INNER JOIN -- 4
CROSS JOIN -- 12


-- ЗАДАЧА 2-1

a
5
7
3
4

SUM(a) -- 19
COUNT(a) -- 4
COUNT(*) -- 4
COUNT(DISTINCT a) -- 4
MAX(a) -- 7
MIN(a) -- 3


-- ЗАДАЧА 2-2

1-1
NULL-1


-- ЗАДАЧА 3-1
