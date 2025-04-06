WITH tmp AS (
    SELECT
        DATE_TRUNC('month', date) AS month_date,
        SUM(income) AS month_amount
    FROM transactions_ivb
    GROUP BY DATE_TRUNC('month', date)
), tmp2 AS (
    SELECT
        month_date,
        AVG(month_amount) OVER (ORDER BY month_date ROWS BETWEEN 3 PRECEDING AND 1 PRECEDING) AS avg_amount
    FROM tmp
)

SELECT
    t.id,
    t.date,
    t.income,
    ROUND(t2.avg_amount, 2)
FROM transactions_ivb AS t
INNER JOIN tmp2 AS t2 ON DATE_TRUNC('month', t.date) = t2.month_date
ORDER BY t.id;
