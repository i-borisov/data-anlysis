-- ЗАДАЧА 13-1

-- ч.1:

SELECT client_fio
FROM CLIENTS
WHERE client_type = 'Пенсионер' AND client_address NOT LIKE '%Москва%';

-- ч.2:

SELECT
    c.client_fio,
    d.document_no
FROM DOCUMENTS AS d
INNER JOIN CLIENTS AS c ON d.client_id = c.client_id
WHERE d.valid_to = '2220-01-01';

--  ч.3:

SELECT client_id
FROM DOCUMENTS
WHERE valid_to IS NULL;

-- ч.4:

SELECT client_id
FROM DOCUMENTS
WHERE valid_to = '2220-01-01'
GROUP BY client_id
HAVING COUNT(valid_to) > 1

-- ч.5:

SELECT c.client_fio
FROM CLIENTS AS c
LEFT JOIN DOCUMENTS AS d ON c.client_id = d.client_id
WHERE d.client_id IS NULL;
