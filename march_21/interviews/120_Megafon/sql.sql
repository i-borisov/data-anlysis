-- ЗАДАЧА 1

WITH orders AS (
    SELECT * FROM orders
    WHERE 1=1
    AND status = 'shipped'
    AND udt = '2024-10-01'
)

SELECT c.customer, c.order_id, MAX(end_date) FROM customer c
LEFT JOIN orders o
ON c.order_id = o.order_id
FULL JOIN customer_lists cl
ON c.customer = cl.customer
WHERE 1=1
      AND c.end_date = '2999-12-31'
      AND c.udt = '2024-10-01'
      AND c.start_date <= '2024-09-30'
GROUP BY c.customer, c.order_id
ORDER BY c.customer DESC;
