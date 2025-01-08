-- ЗАДАЧА 41-1

WITH pods AS (
    SELECT Customer_name
    FROM orders
    WHERE Prod_Name = 'Airpods'
)

SELECT o.Customer_name
FROM orders
LEFT JOIN pods AS p on o.Customer_name = p.Customer_name
WHERE o.Prod_Name = 'Iphone' AND p.Prod_Name IS NULL



SELECT Customer_name
FROM orders
GROUP BY Customer_name
HAVING COUNT(Prod_Name) FILTER (WHERE Prod_Name = 'iPhone') > 0 AND COUNT(Prod_Name) FILTER (WHERE Prod_Name = 'Airpods') = 0;
