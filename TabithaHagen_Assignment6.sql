-- Tabitha Hagen
-- Week 6 Assignment 6      Subqueries and CASE 

USE Northwind   -- Define which database to use

------------------------------------------------------------------------------------------------------------
-- 1. From the table [Order Details] - List all details of all the above-average priced products (simple subquery) (718 records).
------------------------------------------------------------------------------------------------------------

--Let's look at the Order Details table
-- SELECT *
-- FROM [Order Details]                            -- 2,155 rows, 5 columns
------------------------------------

-- Looking at the average Unit Price 
-- SELECT   AVG(UnitPrice)  AS [Average Unit Price]
-- FROM     Products                               -- $28.4962 is the Average Unit Price
-----------------------------------

-- List all details of all the above-average priced products
SELECT   *                                      -- Display all details
FROM     [Order Details]                        -- From the table Order Details
WHERE    UnitPrice > (
                        SELECT AVG(UnitPrice)
                        FROM [Order Details])

-- Results in table with 718 rows and 5 columns

------------------------------------------------------------------------------------------------------------
-- 2. From the tables [Order Details] and Orders - List any products that have appeared on an order in 1996. Use the YEAR() function. (subquery with IN) (405 records).
------------------------------------------------------------------------------------------------------------

--Let's look at the Order Details table
-- SELECT *
-- FROM [Order Details]                            
-- Results in table with 2,155 rows and 5 columns
------------------------------------

--Let's look at the Orders table
-- SELECT *
-- FROM [Orders]                            
-- Results in table with 831 rows and 14 columns
------------------------------------

-- Looking at the year 1996
-- SELECT   *, YEAR(Orders.OrderDate)  AS [Year Ordered]
-- FROM     [Orders]                            -- returns year of Order Date in Orders Table
-- WHERE Year(Orders.OrderDate) = 1996
-- ORDER BY Orders.OrderDate   -- Order results by Ascending Order Date
 -- Results in table with 152 rows and 15 columns NOT including 1 NULL
-----------------------------------

-- List any products that have appeared on an order in 1996
--SELECT Orders.OrderID,                   -- add Order ID column to results table from the Orders table
--        [Order Details].OrderID,                   -- add Order ID column to results table from the Order Details table
--        Orders. OrderDate,                         -- add Order Date column to results table from the Orders table
--         Year(Orders.OrderDate) AS [Year Ordered]  -- add Order Year derived from Order Date column to results table              
--FROM     Orders                                    -- from the Orders table inner joined with Order Details table
--   INNER JOIN   [Order Details] ON  Orders.OrderID = [Order Details].OrderID   -- connect Orders and Order Details tables
--   WHERE    Year(Orders.OrderDate) = 1996          -- Only include orders from the year 1996 from the Orders table
 -- Results in table with 405 rows and 4 columns NOT including 1 NULL

-----------------------------------

-- List any products that have appeared on an order in 1996
SELECT DISTINCT          
        [Order Details].*                          -- Add all of the DISTINCT Order Details columns to the results table
FROM     [Order Details]                           -- From the Orders table inner joined with Order Details table
   INNER JOIN   [Orders] ON  [Order Details].OrderID = Orders.OrderID   -- Connect Orders and Order Details tables
   --WHERE    Year(Orders.OrderDate) = 1996        -- Only include orders from the year 1996 from the Orders table
   WHERE    Year(Orders.OrderDate) IN              -- Only include orders from the years in the Orders table
        (SELECT Year(Orders.OrderDate)             -- Select only the years from the Order Date     
        FROM Orders                                -- From the Orders Table
        WHERE    Year(Orders.OrderDate) = 1996  )  -- Where the year is 1996     
 -- Results in table with 405 rows and 5 columns NOT including 1 NULL 

------------------------------------------------------------------------------------------------------------
-- 3. From the tables Products and [Order Details] - List all details of products that have been sold (any date). We need this to run fast, and we don't really want to see anything from the [order details] table, so use EXISTS (77 records).
------------------------------------------------------------------------------------------------------------

--Let's look at the Order Details table
-- SELECT *
-- FROM [Order Details]                            
-- Results in table with 2,155 rows and 5 columns
------------------------------------

--Let's look at the Products table
-- SELECT *
-- FROM [Products]                            
-- Results in table with 78 rows and 10 columns
------------------------------------

-- List all details of products that have been sold (any date) - given the # rows in Products table
-- SELECT *
-- FROM   Products                                    -- Add all of the DISTINCT Products columns to the results table 
-- WHERE  EXISTS ( SELECT 78 )                        -- This query depends on being given the # rows in Products table in the previous step
-- Results in table with 78 rows and 10 columns including 1 NULL
------------------------------------

-- List all details of the orders that have been sold (any date)
-- SELECT [Order Details].*                           -- Add all of the DISTINCT Order Details columns to the results table        
--FROM   [Order Details]                             -- From [Order Details] table
--   INNER JOIN   [Products] ON  Products.ProductID = [Order Details].ProductID  -- Connect Products and Order Details tables
--WHERE  EXISTS                                      -- That EXISTS in the following subquery
--   (SELECT DISTINCT Products.ProductID             -- Choose the DISTINCT Product IDs column
--    FROM Products                                  -- From the Products Table
--    WHERE Products.ProductID = [Order Details].ProductID )   -- Connect Orders and Order Details tables  
-- Results in table with 2155 rows and 5 columns including 1 NULL
------------------------------------

-- List the Product ID of products that have been sold (any date)
SELECT DISTINCT Products.*
    FROM Products                                  -- Choose all the columns in the [Order Details] table
   INNER JOIN   [Order Details] ON  Products.ProductID = [Order Details].ProductID  -- Connect Products and Order Details tables
    WHERE EXISTS                                   -- That EXISTS in the following subquery
        (SELECT *                                  -- Add all the columns
                From Products                      -- From the Proiducts table
                WHERE Products.ProductID = [Order Details].ProductID )  -- Value in Both the Products and Order Details tables 
    -- Results in table with 77 rows and 1 columns NOT including 1 NULL
------------------------------------------------------------------------------------------------------------

-- 4. We want to assess the need for the urgency of reordering products using the CASE statement:
   -- From the table Products - List ProductID, ProductName, and a column called [Reorder Level]. The value of the Reorder Level will be a text comment:
        -- 'no reorder' if the difference between the reorder level and the inventory in stock for a product is greater than 10. 
        -- 'reorder is needed' if the difference between the reorder level and the inventory in stock for a product is between 5 and 10. 
        -- ' reorder immediately' for other values (the ELSE clause).
------------------------------------------------------------------------------------------------------------

--Let's look at the Products table
 SELECT *
 FROM [Products]                            
-- Results in table with 78 rows and 10 columns
------------------------------------

-- List ProductID, ProductName, and a column called [Reorder Level]
SELECT ProductID,                                  -- Add the Product ID column to the results table
    ProductName,                                   -- Add the Product Name column to the results table
    [Reorder Level] = CASE                         -- In the case that [Reorder Level] is: 
        WHEN (UnitsInStock - ReorderLevel) > 10 THEN 'no reorder'              -- Greater than 10
        WHEN ((UnitsInStock - ReorderLevel) < 10 AND (UnitsInStock - ReorderLevel) > 5) THEN 'reorder is needed' -- Between 5 and 10
        ELSE '! reorder immediately !'             -- Lower then 6
    END                                            -- END Case Statement
FROM Products                                      -- From the Products table
ORDER BY [Reorder Level] ;                         -- Group by [Reorder Level] 

-- Results in table with  78 rows and 3  columns
---------------------------------------------------------------------