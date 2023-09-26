-- Tabitha Hagen
-- Week 5 Assignment 5      JOIN

USE Northwind   -- Define which database to use

-- TASK:  From the table Products and Categories:

Select * from Products -- Look at Complete Table
-- Select * from Categories -- Look at Complete Table
---------------------------------------------------------------------
-- 1. Show the category IDs and names of categories with products ([INNER] JOIN, DISTINCT) (8 records).

SELECT DISTINCT  Categories.CategoryName AS [Category Name],  -- add CategoryName column to results table
         Products.CategoryID                     -- add Category ID column to results table
FROM     Products                                -- from the Products table inner joined with Suppliers table
  JOIN   Categories ON Products.CategoryID= Categories.CategoryID   -- In SQL, by default, "JOIN" means "INNER JOIN"
ORDER BY Categories.CategoryName                 -- ordereded in ascending order by the Category Name

-- Results in table with 8 rows and 8 columns
---------------------------------------------------------------------
-- 2. Show the category IDs and names of categories. Include categories even if they don't have any products in them (LEFT [OUTER] JOIN, DISTINCT) (10 records).

SELECT DISTINCT  Products.CategoryID,           -- add Category ID column to results table
         Categories.CategoryName AS [Category Name]  -- add CategoryName column to results table        
FROM     Categories                             -- from the Products table inner joined with Suppliers table
  LEFT OUTER JOIN   Products ON  Categories.CategoryID = Products.CategoryID   -- connect Categories and Products tables
ORDER BY Products.CategoryID                    -- ordereded in ascending order by the Category ID

-- Results in table with 10 rows and 2 columns
---------------------------------------------------------------------
-- 3. Show the category IDs and names of categories that do not have products in them. (LEFT  [OUTER]  JOIN, WHERE IS NULL) (2 records).

SELECT DISTINCT  Products.CategoryID,          -- add Category ID column to results table
         Categories.CategoryName AS [Category Name]  -- add CategoryName column to results table        
FROM     Categories                            -- from the Products table inner joined with Suppliers table
  LEFT OUTER JOIN   Products ON  Categories.CategoryID = Products.CategoryID   -- connect Product and Categories tables
WHERE    Products.ProductID IS NULL   -- Finding the unmatched query (NULLs)
ORDER BY Products.CategoryID                   -- ordereded in ascending order by the Category ID

-- Results in table with 2 rows and 2 columns
---------------------------------------------------------------------
-- 4. Show the category IDs, names of categories, and product names for categories with products. Only include discontinued products with non-zero units in stock. Order by categories' categoryID ([INNER] JOIN)  (4 records).

SELECT DISTINCT  Products.CategoryID,          -- add Category ID column to results table
         Categories.CategoryName AS [Category Name],  -- add CategoryName column to results table        
         Products.ProductName                  -- add Product Name column to results table 
FROM     Categories                            -- from the Products table inner joined with Suppliers table
  INNER JOIN   Products ON  Categories.CategoryID = Products.CategoryID   -- connect Product and Categories tables
WHERE    Products.Discontinued = 1             -- Only include Discontinued Products
    AND Products.UnitsInStock <> 0             -- Only include products with non-zero units in stock
ORDER BY Products.CategoryID                   -- ordered in ascending order by the Category ID

-- Results in table with 4 rows and 3 columns
