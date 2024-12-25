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
