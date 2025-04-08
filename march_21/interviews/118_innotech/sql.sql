-- ЗАДАЧА 1

--1
SELECT *
FROM Table_1
ORDER BY col_1, col_2 DESC;

--2
1-1
2-2
NULL-NULL

--3
1-1
2-2
4-NULL
NULL-NULL
NULL-NULL

--4
/* Запрос завершится ошибкой */

--5
/* FROM, WHERE, SELECT */


--6
/* Запрос вернёт все записи */

--7
/* Запрос вернёт все строки, где значение username не NULL

--8
/* Для удаления дубликатов в таблице */

--9
/* 1 строка, так как UNION удаляет все дубли */

--10
/* Первый запрос считает все строки, второй - уникальные значения в столбце */


-- ЗАДАЧА 2

CREATE TABLE teacher (
    id SERIAL PRIMARY KEY,
    teacher_name VARCHAR(50) NOT NULL,
    position VARCHAR(50)
);

CREATE TABLE discipline (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    hours INT,
    attestation VARCHAR(50)
);

CREATE TABLE assignment (
    teacher_id INT REFERENCES teacher(id),
    discipline_id INT REFERENCES discipline(id),
    PRIMARY KEY (teacher_id, discipline_id)
);
