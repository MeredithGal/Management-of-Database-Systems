use northwind

-- refresher
-- we can join two tables to filter records that don't satisfy the join

SELECT   Products.ProductID,
         Products.ProductName,
         Products.SupplierID,
         Suppliers.SupplierID,
         Suppliers.CompanyName
FROM     Products
   JOIN  Suppliers ON Products.SupplierID = Suppliers.SupplierID  -- Check on the condition of the Join
ORDER BY Products.ProductID

--we can use the where clause and get the same thing:
SELECT   Products.ProductID,
         Products.ProductName,
         Products.SupplierID,
         Suppliers.SupplierID,
         Suppliers.CompanyName
FROM     Products,
         Suppliers 
WHERE  Products.SupplierID = Suppliers.SupplierID
ORDER BY Products.ProductID

--the above queries are equivalent, but the join clause, in particular, is used as a hint to the query processor on how to execute the query.
 
-- we can also Join with additional conditions:

SELECT   Products.ProductName, 
         Suppliers.CompanyName,
         Suppliers.City 
FROM     Products
  JOIN   Suppliers ON Products.SupplierID= Suppliers.SupplierID
WHERE    Suppliers.Country='USA' 
ORDER BY Suppliers.City

-- a larger example

SELECT   Suppliers.CompanyName,
         SUM(Products.unitprice * Products.unitsInStock)   AS [Value of Inventory]
FROM     Products
   JOIN  Suppliers   ON Products.SupplierID = Suppliers.SupplierID
WHERE    Products.CategoryID IN (1, 3)
GROUP BY Suppliers.CompanyName,
         Suppliers.SupplierID
HAVING   COUNT(ProductID) > 1
ORDER BY [Value of Inventory] DESC

-- in English:
-- show the dollar value of inventory by the supplier
-- only include products in categories 1 and 3
-- only include suppliers that supply more than one product
-- order the suppliers by descending value of inventory

-- a few things to note
-- the GROUP BY has a Suppliers.SupplierID to ensure a unique grouping
-- The WHERE clause could be changed without affecting any other part
-- THE HAVING clause could be changed without affecting any other part
-- (of course, the results change...)


-- We can use select distinct to only show unique supplier id and company name of suppliers that supply us products:

SELECT  Distinct Suppliers.SupplierID,
         Suppliers.CompanyName
FROM     Products
  JOIN   Suppliers ON Products.SupplierID= Suppliers.SupplierID

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

--
SELECT         Products.ProductID,
               Products.ProductName,
               Products.SupplierID,
               Suppliers.SupplierID,
               Suppliers.CompanyName
FROM           Products
   INNER JOIN  Suppliers ON Products.SupplierID = Suppliers.SupplierID
ORDER BY       Suppliers.SupplierID

---------------------------------------------------------------------------------------


