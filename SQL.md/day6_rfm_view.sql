CREATE VIEW customer_rfm AS
SELECT
    r.CustomerID,
    r.Recency,
    f.Frequency,
    m.Monetary
FROM
(
    SELECT
        CustomerID,
        DATEDIFF(
            (SELECT MAX(STR_TO_DATE(InvoiceDate,'%m/%d/%Y %H:%i'))
             FROM online_retail),
            MAX(STR_TO_DATE(InvoiceDate,'%m/%d/%Y %H:%i'))
        ) AS Recency
    FROM online_retail
    WHERE CustomerID IS NOT NULL
    GROUP BY CustomerID
) r

JOIN

(
    SELECT
        CustomerID,
        COUNT(DISTINCT Invoice) AS Frequency
    FROM online_retail
    WHERE CustomerID IS NOT NULL
    GROUP BY CustomerID
) f

ON r.CustomerID = f.CustomerID

JOIN

(
    SELECT
        CustomerID,
        SUM(Quantity * Price) AS Monetary
    FROM online_retail
    WHERE CustomerID IS NOT NULL
    GROUP BY CustomerID
) m

ON r.CustomerID = m.CustomerID;

SELECT * FROM customer_rfm
LIMIT 10;

SELECT
SUM(Quantity * Price) AS Total_Revenue
FROM online_retail;

CREATE INDEX idx_customer
ON online_retail(CustomerID);

SHOW INDEX
FROM online_retail;