-- ЗАДАЧА 1-1

Значения таблицы tab: 5, 7, 3, 4
Результат запроса: 19, 4, 4, 4, 7, 3


-- ЗАДАЧА 1-2

WITH tmp AS (
    SELECT
        DATE_TRUNC('month', created_at) AS dt,
        COUNT(title) AS count
    FROM tab
    GROUP BY DATE_TRUNC('month', created_at)
)

SELECT
    dt,
    count,
    100 * (count - LAG(count) OVER (ORDER BY dt)) / LAG(count) OVER (ORDER BY dt) AS prcnt_grow
FROM tmp;


-- ЗАДАЧА 2-1

INNER JOIN:
1-1
3-3

LEFT JOIN:
1-1
2-NULL
3-3

FULL OUTER JOIN:
1-1
2-NULL
3-3
NULL-4
NULL-6


-- ЗАДАЧА 2-2

SELECT
DISTINCT
FROM
JOIN
WHERE
GROUP BY
HAVING
ORDER BY
LIMIT
OFFSET
UNION


-- ЗАДАЧА 2-3

WITH tab AS (
    SELECT
        good_id,
        inventory_dt,
        inventory_cnt,
        LAG(inventory_cnt, 1, 0) OVER (PARTITION BY good_id ORDER BY inventory_dt) AS previous_day
    FROM inventory
)

SELECT
    good_id,
    inventory_dt,
    ABS(inventory_cnt - previous_day) as inventory_cnt
FROM tab
WHERE inventory_cnt - previous_day <> 0;


-- ЗАДАЧА 3-1

Запрос вернёт все строки таблицы.


-- ЗАДАЧА 3-2

WITH tab AS (
    SELECT
        user_id,
        DATE_TRUNC('month', date) AS month
    FROM logins
)

SELECT
    t1.month,
    COUNT(DISTINCT t1.user_id)
FROM tab AS t1
INNER JOIN tab AS t2 ON t1.month = t2.month - INTERVAL '1 month' AND t1.user_id = t2.user_id
GROUP BY month;


-- ЗАДАЧА 4-2

WITH tab AS (
    SELECT
        dt,
        product_id,
        MIN(dt) OVER (PARTITION BY product_id) AS first_purchase
        MAX(dt) OVER (PARTITION BY product_id) AS last_purchase
    FROM fact_purchases
    WHERE DATE_TRUNC(dt) = '2023-05-01'
)

SELECT
    product_id,
    first_purchase,
    last_purchase
FROM tab
WHERE first_purchase <> last_purchase
ORDER BY product_id, last_purchase;


-- ЗАДАЧА 4-3

WITH tab AS (
    SELECT
        user_id,
        DATE_TRUNC(order_date) AS order_month
    FROM orders
)

SELECT
    user_id
FROM tab
GROUP BY user_id
HAVING COUNT(DISTINCT order_month) = 6


-- ЗАДАЧА 5-1

WITH tab AS (
    SELECT
        id,
        adr,
        dt,
        ROW_NUMBER() OVER (PARTITION BY id ORDER BY dt DESC) AS rn
    FROM atm
    WHERE dt < '2023-01-01'
)

SELECT
    id,
    adr,
    dt
FROM tab
WHERE rn = 1;


-- ЗАДАЧА 6-1

SELECT cat.name
FROM cat
INNER JOIN art ON cat.id = art.category_id
GROUP BY cat.name
HAVING AVG(art.deposit_price) > 5000;


-- ЗАДАЧА 6-2

SELECT art.id
FROM art
LEFT JOIN cat ON art.category_id = cat.id
WHERE cat.id IS NULL;


-- ЗАДАЧА 6-3

WITH tab AS (
    SELECT
        oplog.user_id,
        ins.id
        ROW_NUMBER() OVER (PARTITION BY oplog.user_id ORDER BY oplog.date_borrowed DESC) AS rn
    FROM oplog
    LEFT JOIN ins ON oplog.instance_id = ins.id
)

SELECT
    user_id,
    id
FROM tab
WHERE rn < 4;


-- ЗАДАЧА 6-4

WITH tab AS (
    SELECT DISTINCT instance_id
    FROM oplog
    WHERE date_part('month', date_borrowed) BETWEEN 6 AND 8
)

SELECT DISTINCT article_id
FROM ins
LEFT JOIN tab ON ins.id = tab.instance_id
WHERE tab.instance_id IS NULL;


-- ЗАДАЧА 7-1

WITH tab AS (
    SELECT
        p.ProductName,
        COUNT(o.OrderID) AS Count,
        SUM(p.Price) AS TotalAmount
    FROM Products AS p
    LEFT JOIN Orders AS o ON p.ProductID = o.ProductID
    GROUP BY p.ProductName
)

SELECT
    p.ProductName,
    Count,
    TotalAmount
    DENSE_RANK() OVER (ORDER BY Count DESC) AS rank
FROM tab
ORDER BY Count DESC;


-- ЗАДАЧА 8-1
-- ч.1

SELECT
    transaction_date,
    SUM(transaction_sum) AS sum_for_date
FROM money
GROUP BY transaction_date
ORDER BY transaction_date;

-- ч.2

WITH tab AS (
    SELECT
        transaction_date,
        SUM(transaction_sum) AS sum_for_date
    FROM money
    GROUP BY transaction_date
)

SELECT
    transaction_date,
    SUM(sum_for_date) OVER (ORDER BY transaction_date) AS cumulative_amount
FROM tab;

-- ч.3

WITH tab AS (
    SELECT
        transaction_date,
        SUM(transaction_sum) AS sum_for_date
    FROM money
    GROUP BY transaction_date
)

SELECT
    transaction_date,
    SUM(sum_for_date) OVER () AS total_amount
FROM tab;


-- ЗАДАЧА 9-1

WITH tab AS (
    SELECT customer_id
    FROM transactions
    WHERE success_flg = TRUE
    GROUP BY customer_id
    HAVING SUM(amount_rur) > 100000
), tab_2 AS (
    SELECT DISTINCT
        customer_id,
        FIRST_VALUE(transaction_id) OVER (PARTITION BY customer_id ORDER BY transaction_dttm ASC) AS first_transaction
FROM transactions AS t
WHERE success_flg = TRUE
INNER JOIN tab ON t.customer_id = tab.customer_id
)

SELECT
    tab_2.first_transaction AS transaction_id,
    t.customer_id,
    t.amount_rur,
    t.transaction_dttm
FROM transactions AS t
INNER JOIN tab_2 ON t.transaction_id = tab_2.transaction_id;


-- ЗАДАЧА 9-2

WITH tab AS (
    SELECT
        transaction_id,
        amount_rur,
        LAG(amount_rur, 1, 0) OVER (PARTITION BY customer_id OVER BY transaction_dttm) AS previous,
        LEAD(amount_rur, 1, 0) OVER (PARTITION BY customer_id OVER BY transaction_dttm) AS next
    FROM transactions
)

SELECT transaction_id
FROM tab
WHERE amount_rur > previous AND amount_rur > next;


-- ЗАДАЧА 9-3

WITH active_accounts AS (
    SELECT
        c.id AS client_id,
        c.name AS client_name,
        a.id AS account_id
    FROM account AS a
    INNER JOIN client AS c ON a.client_id = c.id
    WHERE (a.open_dt <= CURRENT_DATE - INTERVAL '1 year') AND (close_dt IS NULL)
), outcome_transactions AS (
    SELECT
        account_id,
        amount
    FROM transaction
    WHERE (type = 'out') AND (transaction_date > CURRENT_DATE - INTERVAL '1 month')
), transactions_and_names AS (
    SELECT
        aa.client_id,
        aa.client_name,
        ot.account_id,
        ot.amount
    FROM outcome_transactions AS ot
    INNER JOIN active_accounts AS aa ON aa.account_id = ot.account_id
)

SELECT
    client_id,
    client_name
FROM transactions_and_names
GROUP BY client_id, client_name
HAVING SUM(amount) < 5000;


-- ЗАДАЧА 9-4

WITH tmp AS (
    SELECT
        t1.id AS id_first,
        t2.id AS id_second
        CASE
            WHEN t1.points > t2.points THEN 1
            ELSE 0
        END AS score
    FROM competition AS t1
    INNER JOIN competition AS t2 ON t1.id <> t2.id
), score AS (
SELECT
    id_first AS id
    SUM(score) AS scores
FROM tmp
GROUP BY id_first
)

SELECT
    id,
    DENSE_RANK() OVER (ORDER BY scores DESC) AS rating
FROM score
ORDER BY rating ASC;

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


-- ЗАДАЧА 11-1

SELECT
    width,
    height,
    depth,
    (widt * height + height * depth + width * depth) * 2 AS area,
    (width * height * depth) AS volume
FROM box
ORDER BY area, volume, width, height, depth;


-- ЗАДАЧА 11-2

SELECT mpg * fuel_left >= distance_to_pump AS answer
FROM zerofuel;


-- ЗАДАЧА 11-3
WITH days_and_week AS (
    SELECT
        employee_id,
        attendance_date,
        DATE_PART('dow', attendance_date) AS day_of_week,
        EXTRACT(WEEK FROM attendance_date) AS week_of_year
    FROM tab
    WHERE attendance_date BETWEEN '2023-01-01' AND '2023-12-31'
), workdays_count AS (
    SELECT
        employee_id,
        COUNT(day_of_week) AS days_count
    FROM days_and_week
    WHERE day_of_week IN (6, 7)
    GROUP BY employee_id
), weekends_count AS (
    SELECT
        employee_id,
        COUNT(DISTINCT week_of_year) AS weekends_count
    FROM days_and_week
    WHERE day_of_week IN (6, 7)
)

SELECT
    dc.employee_id,
    dc.days_count,
    wc.weekends_count
FROM workdays_count AS dc
INNER JOIN weekends_count AS wc ON dc.employee_id = wc.employee_id;


-- ЗАДАЧА 12-1

-- ч.1:
12 и 0

-- ч.2:
12 и 3

-- ч.3:
12 и 4

--ч.3:
12 и 12


-- ЗАДАЧА 12-2

SELECT value
FROM T
GROUP BY value
HAVING COUNT(value) > 1;


-- ЗАДАЧА 12-3
WITH salary_rank AS (
    SELECT
        empl_fio,
        empl_dep,
        DENSE_RANK() OVER (PARTITION BY empl_dep ORDER BY amount DESC) as dr
    FROM Salary
    WHERE DATE_TRUNC('month', value_day) = '2023-04-01'
)

SELECT
    empl_fio,
    empl_dep
FROM salary_rank
WHERE dr = 2;


-- ЗАДАЧА 12-4

WITH tab AS (
    SELECT
        value_day,
        empl_fio,
        amount
        LAG(amount) OVER (PARTITION BY empl_fio ORDER BY value_day) AS prev_amount
    FROM salary
), tab_1 AS (
SELECT
    empl_fio,
    amount,
    prev_amount,
    DENSE_RANK() OVER (ORDER BY amount) AS dr
FROM tab
WHERE DATE_TRUNC('month', value_day) = '2024-05-01'
)

SELECT
    empl_fio,
    (amount - prev_amount) AS diff
FROM tab_1
WHERE dr <= 3;


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


-- ЗАДАЧА 15-1

SELECT
    date,
    COUNT(video_id) AS watch_daily,
    COUNT(DISTINCT user_id) AS users
FROM reports_stg.watch_content
GROUP BY date;


-- ЗАДАЧА 15-2

WITH w_1 AS (
    SELECT DISTINCT user_id
    FROM reports_stg.watch_content
    WHERE video_id = 1
), w_3 AS (
    SELECT DISTINCT user_id
    FROM reports_stg.watch_content
    WHERE video_id = 3
), w_13 AS (
    SELECT user_id
    FROM w_1
    INNER JOIN w_3 ON w_1.user_id = w_3.user_id
), w_2 AS (
    SELECT DISTINCT user_id
    FROM reports_stg.watch_content
    WHERE video_id = 2
)

SELECT w_13.user_id
FROM w_13
LEFT JOIN w_2 ON w_2.user_id = w_13.user_id
WHERE w_2.user_id IS NULL;


-- ЗАДАЧА 16-1

WITH tab (
    SELECT
        DATE_TRUNC('week', hitTime) AS start_of_week,
        COUNT(hitId) week_hits
    FROM hits
    GROUP BY DATE_TRUNC('week', hitTime)
)

SELECT
    start_of_week,
    week_hits,
    LAG(week_hits) OVER (ORDER BY start_of_week) AS previous_week
FROM tab;


-- ЗАДАЧА 17-1

SELECT
    tariff,
    COUNT(abonent_id) AS abonents
FROM abnt
GROUP BY tariff;


-- ЗАДАЧА 17-2

SELECT
    a.tariff,
    AVG(c.all_clc) AS average
FROM abnt AS a
INNER JOIN clcd AS c ON a.abonent_id = c.abonent_id
WHERE DATE_TRUNC('month', c.table_business_mont) = '2019-05-01'
GROUP BY a.tariff;


-- ЗАДАЧА 17-3

SELECT
    a.tariff,
    AVG(t.data_traffic_GB) AS average_traffic
FROM abnt AS a
LEFT JOIN traf AS t ON a.abonent_id = t.abonent_id
WHERE DATE_TRUNC('month', t.table_business_mont) = '2019-04-01'
GROUP BY a.tariff


-- ЗАДАЧА 17-4

WITH tab AS (
SELECT
    abonent_id,
    CASE
    WHEN activation_date > CURRENT_DATE - INTERVAL '1 week' THEN 'last_week',
    WHEN activation_date > CURRENT_DATE - INTERVAL '1 month' THEN 'last_month',
    WHEN activation_date > CURRENT_DATE - INTERVAL '3 month' THEN 'last_quarter',
    WHEN activation_date > CURRENT_DATE - INTERVAL '6 month' THEN 'last_half-year',
    ELSE 'more half-year'
    END AS groups
FROM abnt
)

SELECT
    groups,
    COUNT(abonent_id) AS abonents
FROM tab
GROUP BY groups;


-- ЗАДАЧА 18-1

1. OVER.
2. JOIN можно делать по любым условиям.
3. С помощью GROUP BY или оконок (ROW_NUMBER, например).
4. 10 и 50.


-- ЗАДАЧА 19-1

SELECT
    DATE_TRUNC('day', o.order_date) as order_date,
    p.name,
    COUNT(o.payment_dat) AS order_count
FROM orders AS o
INNER JOIN platforms AS p ON o.platform = p.platform
GROUP BY p.name, DATE_TRUNC('day', o.order_date)
ORDER BY order_date, p.name;


-- ЗАДАЧА 19-2

SELECT
    experience_id,
    COUNT(order_id) AS orders_count
FROM orders
GROUP BY experience_id
ORDER BY order_count DESC
LIMIT 10;


-- ЗАДАЧА 19-3

SELECT user_id
FROM orders
WHERE order_status = 'Забронировано'
GROUP BY user_id
HAVING COUNT(order_id) > 1


-- ЗАДАЧА 20-1

SELECT e1.id
FROM employee AS e1
INNER JOIN employee AS e2 ON e1.department_id = e2.department_id AND e2.chief_flg = 1
WHERE chief_flg = 0 AND e1.birth_dt < e2.birth_dt;


-- ЗАДАЧА 21-1

WITH best_clients AS (
    SELECT
        client_id,
        SUM(value) AS all_value
    FROM table
    GROUP BY client_id
    HAVING COUNT(DISTINCT category) = (SELECT COUNT(DISTINCT category) FROM table)
)

SELECT DISTINCT
    t.client_id,
    100 * (SUM(t.amount) OVER (PARTITION BY t.client_id, t.category)) / bs.all_value AS percent
FROM best_clients AS bs
INNER JOIN table AS t ON bs.client_id = t.client_id;
