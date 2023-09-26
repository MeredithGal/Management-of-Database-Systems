
use Northwind

-- Subqueries (nested SELECT statements)

-- Subqueries in the WHERE clause 

-- It’s  possible to put subqueries in the SELECT or FROM clause of a SELECT statement. 
-- Using subqueries in the SELECT and FROM clause is less common and generally less useful than using a
-- subquery in the WHERE clause. So, we won't cover them in this module

--------------------------------------------------------------------------------
-- WHERE expression comparison_operator (subquery): 

--  We start with our basic select statement 
--  we will add to the condition part of the select statement to include sub-queries.

SELECT ProductID, 
       ProductName,
       UnitPrice
FROM   Products

-- suppose we want to show all products with below-average unit price

-- we can find the average unitprice first

SELECT   AVG(unitprice)  AS [average unitprice]
FROM     Products          --$28.4962 is the average unit price

-- but which products are products with below-average unit price?

-- this doesn't work! An aggregate may not appear in the WHERE clause unless it is in a subquery contained in a HAVING clause or a select list, and the column being aggregated is an outer reference.
SELECT   ProductID,
         AVG(unitprice)   AS [average unitprice]
FROM     Products
WHERE    unitprice < AVG(unitprice)
GROUP BY ProductID

-- so let's look at the average again:
SELECT   AVG(unitprice)   AS [average unitprice]
FROM     Products

-- then use it in a second query
-- value = 28.4962

SELECT   ProductID,
         ProductName,
         UnitPrice
FROM     Products
WHERE    unitprice < 28.4962
ORDER BY UnitPrice DESC

-- It took two select statements to run this 
-- and in a dynamic environment the average value might have changed in the time between execution of the two SELECT statements

-- we can use subquesries:
-- so here's the simple  subquery

SELECT   ProductID,             -- OUTSIDE QUERY:
         ProductName,           -- compares the unit price of every products with the average unit price and 
         UnitPrice              -- returns ProductIDs, ProductNames, and UnitPrices of products with below-average UnitPrices 
FROM     Products
WHERE    unitprice < ( 
                        SELECT  AVG(unitprice)  -- simple subquery retrieves the average unit price from the Products table
                        FROM   Products ) 
ORDER BY unitprice

-- this is a Simple  Subquery
-- it's a subquery, because it is a fully-formed SELECT statement
-- it's simple, because it can be executed independently of outer query
-- (it's *not* a correlated subquery)

-- note that: you can't put an ORDER BY in the subquery

-- you will understand a nested query better by reading it from the "inside out":
-- the inside SELECT statement (the subquery) retrieves the average unit price from the Products table, 
-- and then the outside SELECT compares the unit price of every products with the average unit price and returns ProductIDs, ProductNames, and UnitPrices of products with below-average UnitPrices 

-- product with maximum price 

SELECT   ProductID,
         ProductName,
         UnitPrice AS [MAX Price]
FROM     Products
WHERE    UnitPrice = ( 
                       SELECT   MAX(UnitPrice) 
                       FROM     Products ) 
ORDER BY UnitPrice

-- product with minimum  price

SELECT   ProductID,
         ProductName,
         UnitPrice AS [MIN Price]
FROM     Products
WHERE    UnitPrice = (  
                       SELECT   MIN(UnitPrice) 
                       FROM     Products ) 
ORDER BY unitprice

-- above average priced product

SELECT   ProductID,
         ProductName,
         UnitPrice AS [AVG Price]
FROM     Products
WHERE    UnitPrice > ( 
                       SELECT   AVG(UnitPrice) 
                       FROM     Products ) 
ORDER BY UnitPrice


use Northwind
----------------------------------------------------------------------------------------------
-- WHERE expression [NOT] IN (subquery)

-- We can use IN operator with subqueries. The result of a subquery introduced with IN (or with NOT IN) is a list of values. 
-- After the subquery returns the list of values, the outer query makes use of them. 

-- In the example below, we want to show the “suppliers who supply us products”

SELECT CompanyName
FROM   Suppliers
WHERE  SupplierID IN 
       (SELECT SupplierID   -- Identify the Suppliers in the Products Table
        FROM   Products)

--  Here the subquery provides a list of supplierIDs in the Products table. 
-- Then the outer query limits the records in the Suppliers table to only those that appear in the result of the subquery. 

-- The same result could be accomplished with a join:

SELECT Distinct CompanyName
FROM   Suppliers 
  JOIN Products  ON  Suppliers.SupplierID = Products.SupplierID

-- note that we need to use DISTINCT to remove duplicates

--  there are often several different ways to write a query in SQL.
--  Many SQL statements that include subqueries can be alternatively formulated as joins. But there are cases where a join gives better performance and in other cases, a nested query will produce better results.

-- Note that: A join can always be expressed as a subquery. A subquery can often, but not always, be expressed as a join. 
-- This is because joins (inner joins) are symmetric: you can join table A to B in either order and get the same answer. The same is not true if a subquery is involved.

-- We can also use the NOT IN operator:
-- list of company names that provides products with product names  that do not start with A

SELECT CompanyName
FROM   Suppliers
WHERE  SupplierID NOT IN 
        (SELECT SupplierID 
        FROM Products 
        WHERE ProductName LIKE 'A%')

---------------------------------------------------------------------------------------------
-- WHERE [NOT] EXISTS (subquery):  A subquery checking for existence

-- This is a short video on using the EXIST clause

-- Instead of IN and NOT IN operators, we can apply the EXISTS operator to sub-queries to test whether they're empty or not empty.

-- the EXISTS clause is a logical operator that evaluates a subquery for the existence of records
---- if the subquery has one or more records, EXISTS returns true
---- if the subquery has no records, EXISTS returns false

-- since EXISTS returns a logical value, it is common to use EXISTS in the WHERE clause, which expects logical expressions

-- using EXISTS can make some queries faster and sometimes makes your query clearer

-- here is a simple example

SELECT *
FROM   Products   -- below is a simple query b/c it can be run w/o the outside query
WHERE  EXISTS ( SELECT 15 )   -- (SELECT 15) always returns a record (a 1-row, 1-column table)

-- which returns all records in the Products table
-- the logic is that EXISTS is evaluated for each record in the Products table
-- for each record, EXISTS (SELECT 15) is evaluated,
-- and since (SELECT 15) always returns a record (a 1-row, 1-column table), 
-- EXISTS returns TRUE for all records

-- that's not a very practical example but it shows the concept of EXISTS

-- here is another example: Lets look at "Categories that have products"

SELECT CategoryName
FROM   Categories
WHERE  EXISTS 
         (SELECT *
          FROM   Products       -- if it is in the Products table & in the Categories table
          WHERE  Products.CategoryID = Categories.CategoryID)  -- correclated b/c Categories in not mentioned in the FROM clause in the subquery


-- In the above example, the query retrieves one instance of each categoryname for categories that match up with a record over in the products table.

--               For each record in the Categories table, the database engine: 
--               a. Evaluate the subquery, using the Categories.CategoryID from the main (outer) query. 
--                  The subquery may contain records, or may not, depending on 
--                  whether there are products from the Products table that Products.CategoryID matches Categories.CategoryID from the outer query.
--              b. EXISTS returns true if the subquery has at least one record
--              c. EXISTS returns false if the subquery has zero records in it
--              d. Include the record if EXISTS = true for the record


-- The other thing to note is: the above subquery is a "correlated subquery", 
-- which means it references a table outside the subquery 
-- in this case, the table Categories is not mentioned in the FROM clause of the subquery
-- the correlation is on Categories.CategoryID


-- you can do this same thing like this:

SELECT  DISTINCT CategoryName
FROM     Categories
   JOIN  Products   ON  Products.CategoryID = Categories.CategoryID

-- *** note that we need to use DISTINCT to remove duplicates *** --

-- so why not always use the JOIN version?

-- there are often several different ways to write a query in SQL.

-- notice we don't really need to get any fields from the Products table
-- it's only there to figure out which categories to show

-- consider an extreme case where there are 3 categories and 30 billion products

-- the EXISTS version is FASTER when it does this:
---- for category 1
---- look through products until it finds a product in category 1
---- stop
---- for category 2
---- look through products until it finds a product in category 2
---- stop
---- for category 3
---- look through products until it finds a product in category 3
---- stop

-- the JOIN w/DISTINCT version is SLOWER when it does this:
---- join the 3 categories with all 30 billion products
---- remove the 29,999,999,998 duplicates
   
-- so you can see that the EXISTS version can be much faster
-- depending on the situation

-- EXISTS is logically very similar to IN

-- here's another way to do the query above

SELECT CategoryName
FROM   Categories
WHERE  CategoryID IN  -- stops as soon as the 1st instance is found
         (SELECT CategoryID
          FROM   Products)

-- reminder of EXISTS

SELECT CategoryName
FROM   Categories
WHERE  EXISTS   -- if it finds one instance, it is set to TRUE & stops
          (SELECT *
           FROM   Products
           WHERE  Products.CategoryID = Categories.CategoryID)

-- the work that the database engine has to do
-- is very similar here
-- the "IN" can stop as soon as it finds the first instance
-- it doesn't need to search through all the products

-- however, NOT EXISTS (and NOT IN) does not usually have the same performance benefit:

SELECT CategoryName
FROM   Categories
WHERE  NOT EXISTS -- This has to go through all the records - NOT FAST
         (SELECT *
          FROM   Products
          WHERE  Products.CategoryID = Categories.CategoryID)

-- logically, this will give you the correct records
-- however, proving that something DOES NOT exist means checking all of them
-- in our example above with 3 categories, and 30 billion products
-- assume that category 3 doesn't have any products
-- to prove that category 3 doesn't exist in Products,
-- all 30 billion products need to be checked

-- a not EXISTS is is tougher than  EXISTS 
-- to prove something doesn't exist you have to check all of the records

-- in summary, EXISTS can sometimes improve the performance of a query like this, over a JOIN

SELECT CategoryName
FROM   Categories
WHERE  EXISTS 
         (SELECT *
          FROM   Products
          WHERE  Products.CategoryID = Categories.CategoryID)

-- also, EXISTS can sometimes to be used to more clearly phrase a query:

SELECT CategoryName
FROM   Categories
WHERE  EXISTS 
         (SELECT <a really complicated condition>
          WHERE  Products.CategoryID = Categories.CategoryID)


---------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------
-- Additional Materials:
-- Subqueries in the SELECT or FROM clause

-- It’s possible to put subqueries in the SELECT or FROM clause of a SELECT statement (Inspired by database by Doug).

--here is a simple example to find out how many suppliers there are for each product:

SELECT ProductID,
       ProductName,
       (SELECT COUNT(SupplierID)                -- subquery is in no way related to the main (outer) query
        FROM   Suppliers)       AS [Count]
FROM Products

-- Notice that the subquery is in no way related to the main (outer) query. You can see this by noting that
-- the SupplierCount does not change from product record to product record.

-- Here’s another example of a subquery in the FROM clause:

SELECT SupplierID,
       ProductCount
FROM (SELECT SupplierID AS [SupplierID],        -- subquery in the FROM clause
             COUNT(ProductID) AS [ProductCount]
      FROM Products
      GROUP BY SupplierID) [SupplierProductCounts]
WHERE ProductCount > 2

-- In this case, the subquery creates a table called [SupplierProductCounts], from which the main query
-- selects only some of the records. You might look at this and realize that there is a special SQL word
-- created to do exactly this kind of operation, without using a subquery: HAVING. Here is how to write a
-- logically equivalent SELECT statement that is more direct:

SELECT    SupplierID,   
          COUNT(ProductID) AS [ProductCount]    -- Count of products that each supplier makes
FROM      Products
GROUP BY  SupplierID
HAVING    COUNT(ProductID) > 2

-- So, the HAVING clause is not strictly necessary in Structured Query Language, because it can be
-- accomplished with a subquery and a WHERE clause. However, the HAVING clause is much clearer and
-- more succinct.

-- In summary, subqueries can be used in both the SELECT clause and the FROM clause of a SELECT statement:

-- In the SELECT clause, to generate a value in each row
-- In the FROM clause to generate a “temporary” table from which to extract rows

-- Using subqueries in the SELECT and FROM clause is less common and generally less useful than using a
-- subquery in the WHERE clause. With the primary goal of creating clear, understandable SQL statements,
-- these type of subqueries should be avoided where a more standard phrasing is available. However,
-- sometimes it is easier to work through the logic, or more clearly document your intentions by using a
-- subquery this way. In these cases, it makes sense to use a subquery. 