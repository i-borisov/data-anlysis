-- ЗАДАЧА 39-1

SELECT
    id,
    name
FROM Passenger
WHERE LENGTH(name) = (SELECT MAX(LENGTH(name)) FROM Passenger);


-- ЗАДАЧА 39-2

SELECT COUNT(sc.id) AS count
FROM Class AS c
LEFT JOIN Student_in_class AS sc ON c.id = sc.class
WHERE c.name = '10 В';
