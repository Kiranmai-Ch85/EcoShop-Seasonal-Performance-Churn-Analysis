EXPLAIN
SELECT
    CustomerID,
    SUM(Quantity * Price) AS Monetary
FROM online_retail
GROUP BY CustomerID;

SELECT *
FROM customer_rfm;