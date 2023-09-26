use northwind
---------------------------------------------------------------------------------------
-- INNER JOINS

-- the below queries are  INNER JOINS
-- In SQL, by default, "JOIN" means "INNER JOIN"
-- the result of the following queries are equivalent 

SELECT         Products.ProductID,
               Products.ProductName,
               Products.SupplierID,
               Suppliers.SupplierID,
               Suppliers.CompanyName
FROM           Products
    JOIN  Suppliers ON Products.SupplierID = Suppliers.SupplierID
ORDER BY       Suppliers.SupplierID

-- equivalent results
SELECT         Products.ProductID,
               Products.ProductName,
               Products.SupplierID,
               Suppliers.SupplierID,
               Suppliers.CompanyName
FROM           Products
   INNER JOIN  Suppliers ON Products.SupplierID = Suppliers.SupplierID
ORDER BY       Suppliers.SupplierID

---------------------------------------------------------------------------------------
-- a join can be restrictive

SELECT COUNT(productID) AS [Number of Products]
FROM   Products
-- 78 products

SELECT   COUNT(products.productID) AS [Number of Products]
FROM     Products
   JOIN  Suppliers ON Products.SupplierID=Suppliers.SupplierID
-- 77 products joined with Suppliers?  

-- in the code above, the "ON Products.SupplierID=Suppliers.SupplierID" is known as the "join condition."
-- with this condition, we missed the products with the NULL SupplierID

SELECT   ProductID,
         ProductName,
         SupplierID
FROM     Products
ORDER BY SupplierID

-- in particular, these products with null suppliers don't satisfy the join condition
-- ProductName = pencils has no SupplierID

SELECT   ProductID,
         ProductName,
         SupplierID
FROM     Products
WHERE    SupplierID IS NULL

-- so we get this, 77 products instead of 78:

SELECT   Products.ProductID,
         Products.ProductName,
         Products.SupplierID,
         Suppliers.SupplierID,
         Suppliers.CompanyName
FROM     Products
   JOIN  Suppliers ON Products.SupplierID = Suppliers.SupplierID
ORDER BY Products.ProductID

-- so what if we also wanted in our result, the information about products even with "NUL" SupplierID?
-- the manager asks to see *every* product *even if* it has a NULL value for the supplierID
-- in other words:-- "show *every* product, and if that product has a supplier associated with it, show me that too."

-- this is the concept behind outer joins.
---------------------------------------------------------------------------------------
-- -->  --> Left outer joins <--  <-- --

SELECT         Products.ProductID,
               Products.ProductName,
               Products.SupplierID,
               Suppliers.SupplierID
FROM           Products LEFT OUTER JOIN Suppliers   -- the change is in this line
                  ON Products.SupplierID = Suppliers.SupplierID
ORDER BY       Suppliers.SupplierID

-- what the left outer join does, is:
-- it takes all the records from the table on the "left" side of the join 
-- and if there are records from the left table doesn't satisfy the join condition, it is still added to the results

-- in this case, Products is on the left, so every product record is shown, even if it doesn't satisfy the join condition (all 78 records)

-- INNER joins are known as "exclusive" joins,
-- because they *exclude* records that don't satisfy the join condition

-- OUTER joins are also known as "inclusive" joins,
-- because they *include* records that don't satisfy the join condition

-- we can abbreviate and omit the OUTER keyword 

SELECT         Products.ProductID,
               Products.ProductName,
               Products.SupplierID,
               Suppliers.SupplierID,
               Suppliers.CompanyName
FROM           Products LEFT JOIN Suppliers 
                  ON Products.SupplierID = Suppliers.SupplierID
ORDER BY       Suppliers.SupplierID

---------------------------------------------------------------------------------------
-- what about the Suppliers that don't supply any products or, in other words, don't satisfy the join condition?

SELECT COUNT(SupplierID) AS [Number of Suppliers in Suppliers table]
FROM   Suppliers
-- there are 30 Suppliers

SELECT COUNT(DISTINCT SupplierID) AS [Number of Suppliers in Products table]
FROM   Products
-- only 29 appear in the products table
-- but which 29?
-- we can't look for a NULL foreign key...

-- we can inspect the actual records...

SELECT   SupplierID
FROM     Suppliers
ORDER BY SupplierID

SELECT   DISTINCT SupplierID  
FROM     Products
ORDER BY SupplierID

-- SupplierID 30 does not appear in the Products table

-- but what if there are thousands of suppliers and millions of products?

-- we can use the outer joins
-- we can swap the order of products and suppliers tables in the left join and put suppliers on the left instead.

SELECT         Products.ProductID,
               Products.ProductName,
               Products.SupplierID,
               Suppliers.SupplierID,
               Suppliers.CompanyName
FROM           Suppliers LEFT JOIN Products   -- includes the NULL SupplierID b/c its in the left table
                  ON Products.SupplierID = Suppliers.SupplierID
ORDER BY       Suppliers.SupplierID

-- but we don't need to swap our tables every time
-- SQL  has an outer join called the right outer join.

--Right outer joins

SELECT   Suppliers.CompanyName,
         Suppliers.SupplierID,
         Products.SupplierID,
         Products.productID,
         Products.productName
FROM     Products RIGHT OUTER JOIN Suppliers   -- includes the NULL SupplierID b/c its in the right table
            ON Products.SupplierID= Suppliers.SupplierID
ORDER BY Suppliers.SupplierID,
         Products.ProductID

-- so this includes *every* Supplier, 
-- even the ones that don't satisfy the join
-- and also shows the Supplier/product combinations that do satisfy the join

--Again, -- we can abbreviate and omit the OUTER keyword 

SELECT   Suppliers.CompanyName,
         Suppliers.SupplierID,
         Products.SupplierID,
         Products.productID,
         Products.productName
FROM     Products RIGHT JOIN Suppliers 
            ON Products.SupplierID= Suppliers.SupplierID
ORDER BY Suppliers.SupplierID,
         Products.ProductID

--note:
-- we can "find unmatched" query using outer joins
-- limit to only the Suppliers with no products

SELECT   Suppliers.CompanyName,
         Products.productID,
         Products.productName
FROM     Products RIGHT JOIN Suppliers
            ON Products.SupplierID= Suppliers.SupplierID
WHERE    Products.SupplierID IS NULL   -- Finding the unmatched query (NULLs)
ORDER BY Suppliers.CompanyName,
         Products.productName
-------------------------------------------------------------------------------
-- FULL OUTER JOIN

--what if we want to have unmatched records from both the left and the right appear in our result?
-- that's what's called the full outer join.

-- in our case, we want to show *every* Supplier and *every* product
-- even the ones that don't satisfy the join condition
-- its the left and the right together

SELECT   Suppliers.CompanyName,
         Suppliers.SupplierID,
         Products.SupplierID,
         Products.productID,
         Products.productName
FROM     Products FULL OUTER JOIN Suppliers   -- includes all in the left & right tables
            ON Products.SupplierID= Suppliers.SupplierID
ORDER BY Suppliers.CompanyName,
         Products.productName

-- and formatted consistently with the above examples

SELECT               Suppliers.CompanyName,
                     Suppliers.SupplierID,
                     Products.SupplierID,
                     Products.productID,
                     Products.productName
FROM                 Products 
   FULL OUTER JOIN   Suppliers ON Products.SupplierID= Suppliers.SupplierID
ORDER BY             Suppliers.CompanyName,
                     Products.productName

-- ** notice that the ON statement does not change
--    across INNER, LEFT, RIGHT, and Full joins

-- The SELF JOIN is used to join a table to itself. To use a self join, the table must contain a column (call it X) that acts as the primary key and a different column (call it Y) that stores values that can be matched up with the values in Column X. The values of Columns X and Y do not have to be the same for any given row, and the value in Column Y may even be null. A table alias is used to assign different names to the table within the query.

--The following SQL statement shows employees' names and titles and their managers' names and titles from the table employees:
SELECT e.FirstName + ' ' + e.LastName AS [Employee Name],
       e.Title AS [Employee Title],
       m.FirstName + ' ' + m.LastName AS [Manager],
       m.Title AS [Manager Title]
FROM   Employees e JOIN Employees m
 ON    m.EmployeeID = e.ReportsTo


-- The following SQL statement shows the names of employees and their managers from the table sales.staffs:
--SELECT e.last_name AS [Employee Name],
--       m.last_name AS [Manager]
--FROM   sales.staffs e JOIN sales.staffs m
-- ON    m.staff_id = e.manager_id





-- Note: the ON statement does not change across INNER, LEFT, RIGHT, and Full joins 
--       we can abbreviate and omit the OUTER keyword
--       qualify all the fields in your query