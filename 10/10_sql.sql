-- ЗАДАЧА 10-1

-- ч.1: left join

1-1
1-1
2-2
2-2
2-2
2-2
3-3
4-null
null-null

-- ч.2: inner join

1-1
1-1
2-2
2-2
2-2
2-2
3-3


-- ЗАДАЧА 10-2

WITH best_students AS (
    SELECT
        fio
    FROM journal
    WHERE mark = 5
    GROUP BY fio
    HAVING COUNT(mark) >= 10
)

SELECT
    j.fio
    COUNT(mark) AS two
FROM journal AS j
INNER JOIN best_students AS bs ON j.fio = bs.fio
WHERE mark = 2
GROUP BY fio;


-- ЗАДАЧА 10-3

SELECT
    Товар,
    'Дата с',
    LEAD('Дата с' - INTERVAL '1 day', 1, '31.12.9999') OVER (PARTITION BY Товар ORDER BY 'Дата с') AS 'Дата по',
    Цена
FROM tab;
