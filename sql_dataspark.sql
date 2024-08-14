-- Create the DataSpark database
CREATE DATABASE IF NOT EXISTS DataSpark;
USE DataSpark;


-- Create the Customers table
CREATE TABLE Customers (
    CustomerKey INT PRIMARY KEY,
    Gender VARCHAR(10),
    Name VARCHAR(100),
    City VARCHAR(100),
    `State Code` VARCHAR(100),
    State VARCHAR(50),
    `Zip Code` VARCHAR(10),
    Country VARCHAR(50),
    Continent VARCHAR(50),
    Birthday DATE
);

SELECT * FROM Customers;

-- Create the Products table
CREATE TABLE Products (
    ProductKey INT PRIMARY KEY,
    `Product Name` VARCHAR(100),
    Brand VARCHAR(50),
    Color VARCHAR(50),
    `Unit Cost USD` DECIMAL(10,2),
    `Unit Price USD` DECIMAL(10,2),
    SubcategoryKey INT,
    Subcategory VARCHAR(50),
    CategoryKey INT,
    Category VARCHAR(50)
);
SELECT * FROM Products;
DESCRIBE Products;


-- Create the Sales table
CREATE TABLE Sales (
    `Order Number` INT,
    `Line Item` INT,
    `Order Date` DATE,
    `Delivery Date` DATE,
    CustomerKey INT,
    StoreKey INT,
    ProductKey INT,
    Quantity INT,
    `Currency Code` VARCHAR(10),
    PRIMARY KEY (`Order Number`, `Line Item`),
    FOREIGN KEY (CustomerKey) REFERENCES Customers(CustomerKey),
    FOREIGN KEY (ProductKey) REFERENCES Products(ProductKey)
);

SELECT * FROM Sales;
DESCRIBE Sales;

-- Create the Stores table
CREATE TABLE Stores (
    StoreKey INT PRIMARY KEY,
    Country VARCHAR(50),
    State VARCHAR(50),
    `Square Meters` DECIMAL(10,2),
    `Open Date` DATE
);
SELECT * FROM Stores;
DESCRIBE Stores;

-- Create the ExchangeRates table
CREATE TABLE ExchangeRates (
    Date DATE,
    Currency VARCHAR(10),
    Exchange DECIMAL(10,4),
    PRIMARY KEY (Date, Currency)
);
SELECT * FROM ExchangeRates;
DESCRIBE ExchangeRates;





-- SQL Queries for Analysis
-- 1. Demographic Distribution of Customers by Gender and Age

SELECT 
    Gender, 
    FLOOR(DATEDIFF(CURDATE(), Birthday)/365) AS Age, 
    COUNT(*) AS CustomerCount
FROM 
    Customers
GROUP BY 
    Gender, Age
ORDER BY 
    Age, Gender;
    
    
-- 2. Customer Distribution by Location ( Country, Continent)

SELECT 
    Continent, 
    COUNT(*) AS CustomerCount
FROM 
    Customers
GROUP BY 
     Country, Continent
ORDER BY 
    CustomerCount DESC;

-- 3. Average Order Value by Customer

SELECT 
    s.CustomerKey, 
    AVG(s.Quantity * p.`Unit Price USD`) AS AvgOrderValue
FROM 
    Sales s
JOIN 
    Products p ON s.ProductKey = p.ProductKey
GROUP BY 
    s.CustomerKey
ORDER BY 
    AvgOrderValue DESC;


-- 4. Frequency of Purchases by Customer

SELECT 
    CustomerKey, 
    COUNT(`Order Number`) AS PurchaseFrequency
FROM 
    Sales
GROUP BY 
    CustomerKey
ORDER BY 
    PurchaseFrequency DESC;


-- 5. Preferred Products by Quantity Sold


SELECT 
    ProductKey, 
    SUM(Quantity) AS TotalQuantitySold
FROM 
    Sales
GROUP BY 
    ProductKey
ORDER BY 
    TotalQuantitySold DESC;

-- 6. Total Revenue Over Year

SELECT 
    YEAR(`Order Date`) AS Year, 
    SUM(s.Quantity * p.`Unit Price USD`) AS TotalRevenue
FROM 
    Sales s
JOIN 
    Products p ON s.ProductKey = p.ProductKey
GROUP BY 
    YEAR(`Order Date`)
ORDER BY 
    Year;




-- 7. Sales by Product

SELECT 
    p.`Product Name`, 
    SUM(s.Quantity) AS TotalQuantitySold, 
    SUM(s.Quantity * p.`Unit Price USD`) AS TotalRevenue
FROM 
    Sales s
JOIN 
    Products p ON s.ProductKey = p.ProductKey
GROUP BY 
    p.`Product Name`
ORDER BY 
    TotalRevenue DESC;


-- 8. Revenue by Store
 
SELECT 
    StoreKey, 
    SUM(s.Quantity * p.`Unit Price USD`) AS TotalRevenue
FROM 
    Sales s
JOIN 
    Products p ON s.ProductKey = p.ProductKey
GROUP BY 
    StoreKey
ORDER BY 
    TotalRevenue DESC;

-- 9. Sales by Currency

SELECT 
    `Currency Code`, 
    SUM(s.Quantity * p.`Unit Price USD`) AS TotalRevenue
FROM 
    Sales s
JOIN 
    Products p ON s.ProductKey = p.ProductKey
GROUP BY 
    `Currency Code`
ORDER BY 
    TotalRevenue DESC;

-- 10. Profit Margins by Product

SELECT 
    `Product Name`, 
    SUM(s.Quantity * (p.`Unit Price USD` - p.`Unit Cost USD`)) AS ProfitMargin
FROM 
    Sales s
JOIN 
    Products p ON s.ProductKey = p.ProductKey
GROUP BY 
    `Product Name`
ORDER BY 
    ProfitMargin DESC;
