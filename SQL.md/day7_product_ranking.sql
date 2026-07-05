SELECT
    Country,
    StockCode,
    Description,
    SUM(Quantity * Price) AS Revenue
FROM online_retail
GROUP BY Country, StockCode, Description
ORDER BY Country, Revenue DESC
LIMIT 10;

SELECT
    Country,
    StockCode,
    SUM(Quantity * Price) AS Total_Revenue
FROM online_retail
GROUP BY Country, StockCode
ORDER BY Total_Revenue DESC;

SELECT
    Country,
    StockCode,
    SUM(Quantity * Price) AS Revenue,
    RANK() OVER (
        PARTITION BY Country
        ORDER BY SUM(Quantity * Price) DESC
    ) AS Product_Rank
FROM online_retail
GROUP BY Country, StockCode;

SELECT
    Country,
    StockCode,
    SUM(Quantity * Price) AS Revenue,
    DENSE_RANK() OVER (
        PARTITION BY Country
        ORDER BY SUM(Quantity * Price) DESC
    ) AS Product_Rank
FROM online_retail
GROUP BY Country, StockCode;