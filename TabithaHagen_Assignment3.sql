-- Tabitha Hagen
-- Week 3 Assignment 3      WHERE and logical expressions

USE Northwind   -- Define which database to use
-- Select * from Products -- Look at Complete Table

-- TASK:  We want to check the status of the products we have in our inventory and also learn more about our customers. 

-- 1. Show product ID, product name, and unit price of all products with more than $50 unit price. Order by unit price descending (7 records).

SELECT   ProductID,                 -- List the ProductID column
         ProductName,               -- List the ProductName column
         UnitPrice                  -- List the UnitPrice column
FROM Products                       -- The Table source
WHERE UnitPrice > 50                -- Only Include Products with more than $50 unit price
ORDER BY UnitPrice DESC             -- The order of the columns within the SELECT statement, left to right

-- 2. Show product ID, category ID, product name, and unit price of all products that are in category 3 AND cost more than $15—order by unit price  (7 records).

SELECT   ProductID,                 -- List the ProductID column
         CategoryID,                -- List the CategoryID column
         ProductName,               -- List the ProductName column
         UnitPrice                  -- List the UnitPrice column
FROM Products                       -- The Table source
WHERE CategoryID IN (3)             -- Only Include Products in categories 2,6 & 7
   AND UnitPrice > 15               -- Only Include Products with more than $15 unit price
ORDER BY UnitPrice ASC              -- The order of the columns within the SELECT statement

-- 3. Show product ID, category ID, product name, and unit price of all products that are in category 3 OR cost more than $15—order by unit price  (57 records).

SELECT   ProductID,                 -- List the ProductID column
         CategoryID,                -- List the CategoryID column
         ProductName,               -- List the ProductName column
         UnitPrice                  -- List the UnitPrice column
FROM Products                       -- The Table source
WHERE CategoryID = (3)             -- Only Include Products in categories 3
   OR UnitPrice > 15               -- Only Include Products with more than $15 unit price
ORDER BY UnitPrice ASC              -- The order of the columns within the SELECT statement

-- 4. Show supplier ID, product ID, product name, and quantity per unit of all products that are packaged in jars (have the word 'jars' in the QuantityPerUnit). Use the LIKE operator—order by supplier ID and then product ID (8 records).

SELECT   SupplierID,                -- List the SuplierID column
         ProductID,                 -- List the ProductID column
         ProductName,               -- List the ProductName column
         QuantityPerUnit            -- List the QuantityPerUnit column
FROM Products                       -- The Table source
WHERE QuantityPerUnit LIKE '%jar%'  -- Only Include Products that are packed in jars
ORDER BY SupplierID ASC, ProductID  -- The order of the columns within the SELECT statement, left to right

-- 5. Show supplier ID, product ID, product name, and unit price and all products supplied by suppliers 12, 14, or 17. Use the IN operator—order by supplier ID and then product ID (11 records).

SELECT   SupplierID,                -- List the SuplierID column
         ProductID,                 -- List the ProductID column
         ProductName,               -- List the ProductName column
         UnitPrice                  -- List the UnitPrice column
FROM Products                       -- The Table source
WHERE SupplierID IN (12, 14, 17)    -- Only Include Suppliers in categories 12, 14, or 17
ORDER BY SupplierID, ProductID ASC  -- The order of the columns within the SELECT statement, left to right