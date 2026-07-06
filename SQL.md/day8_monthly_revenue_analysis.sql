WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(STR_TO_DATE(InvoiceDate,'%m/%d/%Y %H:%i'),'%Y-%m') AS Month,
        SUM(Quantity * Price) AS Revenue
    FROM online_retail
    GROUP BY DATE_FORMAT(STR_TO_DATE(InvoiceDate,'%m/%d/%Y %H:%i'),'%Y-%m')
)

SELECT
    Month,
    Revenue,
    LAG(Revenue) OVER (ORDER BY Month) AS Previous_Month_Revenue,
    ROUND(
        (
            (Revenue - LAG(Revenue) OVER (ORDER BY Month))
            / LAG(Revenue) OVER (ORDER BY Month)
        ) * 100,
        2
    ) AS Growth_Rate_Percentage
FROM monthly_revenue;

SELECT
    DATE_FORMAT(STR_TO_DATE(InvoiceDate,'%m/%d/%Y %H:%i'),'%Y-%m') AS Month,
    ROUND(
        SUM(Quantity * Price) / COUNT(DISTINCT Invoice),
        2
    ) AS Average_Order_Value
FROM online_retail
GROUP BY DATE_FORMAT(STR_TO_DATE(InvoiceDate,'%m/%d/%Y %H:%i'),'%Y-%m')
ORDER BY Month;

CREATE VIEW monthly_revenue_timeseries AS
SELECT
    DATE_FORMAT(STR_TO_DATE(InvoiceDate,'%m/%d/%Y %H:%i'),'%Y-%m') AS Month,
    SUM(Quantity * Price) AS Revenue
FROM online_retail
GROUP BY DATE_FORMAT(STR_TO_DATE(InvoiceDate,'%m/%d/%Y %H:%i'),'%Y-%m')
ORDER BY Month;

SELECT *
FROM monthly_revenue_timeseries;