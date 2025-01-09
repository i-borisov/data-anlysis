-- ЗАДАЧА 42-1

WITH sales AS (
    SELECT
        fact.customer_code,
        SUM(fact.product_code * price.gross_price) AS gross_sales
    FROM fact_sales_montly AS fact
    INNER JOIN dim_gross_price AS price ON fact.product_code = price.product_code AND fact.fiscal_year = price.fiscal_year
    WHERE fact.fiscal_year = '2021'
    GROUP BY fact.customer_code
), channels AS (
    SELECT
        c.channel,
        SUM(gross_sales) / 1000000 AS gross_sales_mln
    FROM dim_customer AS c
    LEFT JOIN sales AS s ON c.customer_code = s.customer_code
    GROUP BY c.channel
)

SELECT
    channel,
    gross_sales_mln,
    100 * gross_sales_mln / (SELECT SUM(gross_sales_mln) FROM channels) AS percent
FROM channels;
