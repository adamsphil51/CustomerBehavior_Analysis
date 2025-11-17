-- Project: CustomerBehavior_Analysis
-- Company: xxxxxxxxxx Company (Kenya)
-- Purpose: Track customer behavior and campaign performance

-- 1. Create Customers table
CREATE TABLE Adona_Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    SignupDate DATE
);

-- Insert customers
INSERT INTO Adona_Customers (CustomerID, CustomerName, SignupDate) VALUES
(1, 'Customer A', '2024-01-10'),
(2, 'Customer B', '2024-02-18'),
(3, 'Customer C', '2024-03-05');

-- 2. Create Campaign table
CREATE TABLE Adona_Campaigns (
    CampaignID INT PRIMARY KEY,
    CampaignName VARCHAR(100),
    StartDate DATE,
    EndDate DATE
);

-- Insert campaign
INSERT INTO Adona_Campaigns (CampaignID, CampaignName, StartDate, EndDate) VALUES
(1, 'Adona Spring Promo', '2024-03-01', '2024-03-31');

-- 3. Create Orders table
CREATE TABLE Adona_Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    CampaignID INT,
    OrderAmount DECIMAL(10,2),
    OrderDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Adona_Customers(CustomerID),
    FOREIGN KEY (CampaignID) REFERENCES Adona_Campaigns(CampaignID)
);

-- Insert orders in Kenyan Shillings (KES)
INSERT INTO Adona_Orders (OrderID, CustomerID, CampaignID, OrderAmount, OrderDate) VALUES
(1, 1, 1, 12000.50, '2024-03-05'),
(2, 1, 1, 15000.00, '2024-03-15'),
(3, 2, 1, 7500.00, '2024-03-20'),
(4, 3, 1, 18000.00, '2024-03-22');

-- 4. Query: Total spend per customer for Sssss campaign
SELECT 
    c.CustomerID,
    c.CustomerName,
    SUM(o.OrderAmount) AS TotalSpent
FROM Adona_Customers c
JOIN Adona_Orders o ON c.CustomerID = o.CustomerID
JOIN Adona_Campaigns cm ON o.CampaignID = cm.CampaignID
WHERE cm.CampaignName = 'ccccc Spring Promo'
GROUP BY c.CustomerID, c.CustomerName
ORDER BY TotalSpent DESC;

-- 5. Optional: Average spend per customer
SELECT 
    AVG(TotalSpent) AS AvgSpendPerCustomer
FROM (
    SELECT CustomerID, SUM(OrderAmount) AS TotalSpent
    FROM Adona_Orders
    GROUP BY CustomerID
) AS CustomerTotals;

-- 6. Optional: Top 2 customers by spend
SELECT 
    c.CustomerID,
    c.CustomerName,
    SUM(o.OrderAmount) AS TotalSpent
FROM Adona_Customers c
JOIN Adona_Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CustomerName
ORDER BY TotalSpent DESC
LIMIT 2;
