-- ЗАДАЧА 1

INNER JOIN: 0/12
LEFT JOIN: 3/12
FULL JOIN: 4/12
CROSS JOIN: 12/12


-- ЗАДАЧА 2

SELECT value
FROM T
GROUP BY value
HAVING COUNT(value) > 1;


-- ЗАДАЧА 3

WITH tmp AS (
    SELECT
        EMPL_FIO,
        EMPL_DEP,
        DENSE_RANK() OVER (ORDER BY AMOUNT DESC) AS rank
    FROM Salary
    WHERE DATE_TRUNC('month', VALUE_DAY) = '2023-04-01'
)

SELECT
    EMPL_FIO,
    EMPL_DEP
FROM tmp
WHERE rank = 2;


-- ЗАДАЧА 4

SELECT
    s1.EMPL_FIO,
    s1.EMPL_DEP,
    s1.AMOUNT - s2.AMOUNT AS diff
FROM Salary AS s1
INNER JOIN Salary AS s2 ON
    s1.EMPL_FIO = s2.EMPL_FIO
    AND s1.EMPL_DEP = s2.EMPL_DEP
    AND DATE_TRUNC('month', s1.VALUE_DAY) = DATE_TRUNC('month', s2.VALUE_DAY) - INTERVAL "1 month"
WHERE DATE_TRUNC('month', s1.VALUE_DAY) = '2023-05-01'
ORDER BY s1.AMOUNT ASC
LIMIT 3;


-- ЗАДАЧА 5

/* Партицирование - это разделение таблицы на части - чаще всего по дате и чаще всего именно физическое.
Т.е. разные даты хранятся на разных дисках. */

/* Индекс - это такой виртуальный столбец, который добавляется к таблице и служит для ускорения поиска дынных в ней.
Он занимает место в операвтиной памяти, поэтому нельзя навешивать индекс на каждый столбец.
Его следует создавать только для данных с низкой кардинальностью (например, город в котором живёт клиент),
и не следует создавать для столбцов, где хранятся даты и время транзакций, например. */

/* Шардирование - это разделение данных и хранение их на разных серверах - шардах */

/* Физические джойны - это способы объединения таблиц на уровне CУБД.
Есть Nested Loop Join - перебор строк, Hash Join - использует хэш-таблицы.
Merge Join - применяется для отсортированных данных.
СУБД сама выбирает тип физического джойна на основываясь на плане запроса. */

/* EXPLAIN показывает информацию о выполнении запроса - ожидаемое кол-во строк, используемые индексы,
тип соединения, стоимость выполнения.
 
EXPLAINE ANALYZE - показывает фактичекие дынные выполнения и время выполнения каждого шага. */
