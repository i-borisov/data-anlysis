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
