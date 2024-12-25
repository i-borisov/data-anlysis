-- ЗАДАЧА 27-1

SELECT
    p.prod_cat,
    SUM(s.price * s.cnt) AS total_amt
FROM sale AS s
INNER JOIN product AS p ON (s.prod_nm = p.prod_nm) AND (s.sale_date BETWEEN p.dt_from AND p.dt_to)
GROUP BY p.prod_cat
ORDER BY total_amt;


-- ЗАДАЧА 27-2

SELECT s.customer_id
FROM sales AS s
INNER JOIN products AS p ON s.product_id = p.product_id
GROUP BY customer_id
HAVING COUNT(DISTINCT p.product_category) = (SELECT COUNT(DISTINCT product_category FROM products));
