-- ЗАДАЧА 35-1

/*
Первичный ключ нужен, чтобы однозначно идентифицировать строку в таблице.
*/


-- ЗАДАЧА 35-2

/*
Внешний ключ нужен для связи между таблицами.
*/


-- ЗАДАЧА 35-3

8


-- ЗАДАЧА 35-4

/*
Строки с цифрой 8, количество которых будет равно количеству строк в таблице.
*/

-- ЗАДАЧА 35-5

/*
Может, так как NULL - это по сути не значение, а его отсутствие.
*/


-- ЗАДАЧА 35-6

WITH t1 AS (
    SELECT
        DATE_TRUNC('month', Дата) AS Дата,
        'Категория товара',
        Товар,
        SUM(Сумма) AS Сумма
    FROM sales
    GROUP BY DATE_TRUNC('month', Дата), 'Категория товара', Товар
), t2 AS (
SELECT
    Дата,
    'Категория товара',
    Товар,
    Сумма,
    ROW_NUMBER() OVER (PARTITION BY Дата, 'Категория товара' ORDER BY Сумма DESC) AS rn
FROM t1
)

SELECT
    Дата,
    'Категория товара',
    Товар,
    Сумма
FROM t2
WHERE rn <=5;
