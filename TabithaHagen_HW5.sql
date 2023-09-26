-- HW5: JOINS
-- Tabitha Hagen

USE Northwind

---------------------------------------------------------------------
-- From Products and Categories Tables:
-- Write an INNER JOIN to show category names and product names. Order by category names.

-- Let's look at the products table
SELECT *
FROM    Products                          -- 78 rows, 10 columns

--Let's look at the categories table
SELECT *
FROM Categories                            -- 10 rows, 4 columns

-- let's calculate the number of categories:
SELECT COUNT(CategoryID) AS [Category Count]
FROM   Categories                          -- 10 Categories

-- let's calculate the number of products:
SELECT COUNT(ProductID) AS [ProductCount]
FROM   Products                           -- 78 products

---------------------------------------------------------------------

SELECT   Categories.CategoryName,                -- add CompanyName column to results table
         Products.ProductName                    -- add ProductName column to results table
FROM     Products                                -- from the Products table inner joined with Suppliers table
  JOIN   Categories ON Products.CategoryID= Categories.CategoryID   -- In SQL, by default, "JOIN" means "INNER JOIN"
ORDER BY Categories.CategoryName                 -- ordereded in ascending order by the Category Name

-- Results in table with 77 rows and 2 columns
---------------------------------------------------------------------

-- Bonus - join with additional conditions. 

--From the tables: Orders, [Order Details], and Employees: We want to know the total revenues by an employee. Show the EmployeeID, lastname, title, then their total revenues. Don't include freight. 

---------------------------------------------------------------------
-- Let's look at the orders table
SELECT *
FROM    Orders                          -- 831 rows, 14 columns

--Let's look at the Employees table
SELECT *
FROM Employees                            -- 10 rows, 19 columns

--Let's look at the Order Details table
SELECT *
FROM [Order Details]                           -- 2,155 rows, 5 columns

---------------------------------------------------------------------
SELECT   Employees.EmployeeID,              -- add Employee's ID column to results table
         Employees.LastName,                -- add Employee's Last Name column to results table
         Employees.Title,                   -- add Employee's Title column to results table     
         SUM([Order Details].UnitPrice * [Order Details].Quantity) AS [Total Revenue]    -- add Total Revenue column to results table
FROM     Employees                          -- from the Employees table inner joined with Orders and Orders Details tables
  JOIN   Orders ON Employees.EmployeeID= Orders.EmployeeID            -- In SQL, by default, "JOIN" means "INNER JOIN"
  JOIN   [Order Details] ON [Order Details].OrderID= Orders.OrderID   -- In SQL, by default, "JOIN" means "INNER JOIN"
GROUP BY Employees.Title,
         Employees.LastName,
         Employees.EmployeeID,
         Orders.EmployeeID
ORDER BY [Total Revenue] DESC               -- ordered in descending order by the Total Revenue
-- Results in table with 9 rows and 3 columns
---------------------------------------------------------------------

SELECT   p.ProductName, 
         s.CompanyName
FROM     Products p
 JOIN    Suppliers  s ON p.SupplierID= s.SupplierID