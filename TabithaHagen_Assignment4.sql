-- Tabitha Hagen
-- Week 4 Assignment 4      HAVING

USE Northwind   -- Define which database to use

-- TASK:  From the table Products:

-- Select * from Products -- Look at Complete Table

-- 1. Show Category ID, the minimum, average, and maximum unit price of products for each category (9 records). 

SELECT   CategoryID,                -- List the CategoryID column
   MIN(UnitPrice) AS [MINIMUM Price($)],            -- List the Minimum Price in a column
   AVG(UnitPrice) AS [AVERAGE Price($)],        -- List the Average Price in a column
   MAX(UnitPrice) AS [MAXIMUM Price($)]             -- List the Maximum Price in a column
FROM Products                       -- The Table source
GROUP BY CategoryID                 -- Group by CategoryID 
ORDER BY CategoryID DESC            -- Order by Category ID descending

-- 2. Show CategoryID and the count of products in each category. Make sure to count the primary key of the products table.  Order by the number of products descending (9 records).

SELECT   CategoryID,                -- List the CategoryID column
   Count(CategoryID) AS [Count of Products]             -- List the number of Products in a column
FROM Products                       -- The Table source
GROUP BY CategoryID                 -- Group by CategoryID 
ORDER BY Count(CategoryID) DESC     -- Order by number of products descending, left to right, left to right

-- 3. Show Category ID and the average unit price of products for each category. Only include products packaged in boxes (have the word 'box' in the QuantityPerUnit). Order by average unit price descending (6 records). 

SELECT   CategoryID,                -- List the CategoryID column
   Avg(UnitPrice) AS [Average Unit Price of Products]   -- List the Average Unit Price of Products in a column
FROM Products                       -- The Table source
WHERE QuantityPerUnit LIKE '%box%'  -- Only Include Products that are packed in boxes
GROUP BY CategoryID                 -- Group by CategoryID 
ORDER BY Avg(UnitPrice) DESC        -- Order by average unit price descending, left to right, left to right


-- 4. Show Category ID and the average unit price of products in each category. Only include categories with an average unit price of above $10.  Order by average unit price descending (8 records).

SELECT   CategoryID,                -- List the CategoryID column
   Avg(UnitPrice) AS [Average Unit Price of Products]   -- List the Average Unit Price of Products in a column
FROM Products                       -- The Table source
WHERE UnitPrice > 10                -- Only Include Products with more than $10 unit price
GROUP BY CategoryID                 -- Group by CategoryID 
ORDER BY Avg(UnitPrice) DESC        -- Order by average unit price descending, left to right

-- 5. Show Category ID and the average unit price of products in each category. Only include products packaged in boxes (have the word 'box' in the QuantityPerUnit). Only include categories with an average unit price of above $10.  Order by average unit price descending (4 records).

SELECT   CategoryID,                -- List the CategoryID column
   Avg(UnitPrice) AS [Average Unit Price of Products]   -- List the Average Unit Price of Products in a column
FROM Products                       -- The Table source
WHERE UnitPrice > 10                -- Only Include Products with more than $10 unit price
   AND QuantityPerUnit LIKE '%box%'  -- Only Include Products that are packed in boxes
GROUP BY CategoryID                 -- Group by CategoryID 
ORDER BY Avg(UnitPrice) DESC        -- Order by average unit price descending, left to right