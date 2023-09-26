-- HW3 - WHERE and logical expressions
-- Tabitha Hagen

USE Northwind

-- 1. For the table Products: Show the ProductID and Productname of all products from categories 2, 6, and 7 that are packaged in jars. Use IN and LIKE. Please include a screenshot of the results table.

--Select * from Products -- Look at Complete Table

SELECT   ProductID,      -- List the ProductID column
         ProductName     -- List the ProductName column
         -- ,CategoryID   -- Testing Statement to check WHERE IN clause
         -- ,QuantityPerUnit   -- Testing Statement to check WHERE LIKE clause
FROM Products           -- The Table source
WHERE CategoryID IN (2, 6, 7)   -- Only Include Products in categories 2,6 & 7
    AND QuantityPerUnit LIKE '%jar%'  -- Only Include Products that are packed in jars
ORDER BY ProductName ASC  -- The order of the columns within the SELECT statement

