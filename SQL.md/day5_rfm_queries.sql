DESCRIBE online_retail;

SELECT
    CustomerID,
    DATEDIFF(
        (SELECT MAX(STR_TO_DATE(InvoiceDate, '%m/%d/%Y %H:%i'))
         FROM online_retail),
        MAX(STR_TO_DATE(InvoiceDate, '%m/%d/%Y %H:%i'))
    ) AS Recency
FROM online_retail
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY Recency;

SELECT
    CustomerID,
    COUNT(DISTINCT Invoice) AS Frequency
FROM online_retail
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY Frequency DESC;

SELECT
    CustomerID,
    SUM(Quantity * Price) AS Monetary
FROM online_retail
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID
ORDER BY Monetary DESC;