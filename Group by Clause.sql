--SELECT - Group by:
--Minoo Modares

--Group by clause  divides the query result into groups of rows and returns one row per group.


-- consider these two queries:

SELECT   Max(unitprice) AS [Max price of category 1 products]
FROM     Products
WHERE    categoryID = 1

SELECT   Max(unitprice) AS [Max price of category 2 products]
FROM     Products
WHERE    categoryID = 2

-- What if you have 100 or 1000 categories
-- wouldn't it be nice to have a table that shows a list of categories, and the max for each category?
-- like this: 
------------------------
-- |CategoryID |  Max   |
------------------------
-- |      1    |  263.5 |
-- |      2    |  43.9  |
-- |      3    |  81.0  |
-- |    ...    |  ...   |
------------------------

-- we can do this using a GROUP BY clause:

SELECT   CategoryID,
         Max(unitprice) AS [Max unitprice]
FROM     Products
GROUP BY CategoryID -- new clause
ORDER BY CategoryID

--  the GROUP BY clause has to be before the ORDER BY clause, and after the WHERE clause

-- the group by is telling the database engine that arrange these products into different groups by their category IDs 
-- and then show me the max unit price for each of those category IDs


--Aggregate functions are often used with the GROUP BY clause of the SELECT statement.
-- once the grouping is established, I can ask other aggregate questions:

SELECT  AVG(unitprice)    AS [average unit price],
        MIN(unitprice)    AS [minimum unit price],
        MAX(unitprice)    AS [maximum unit price],
        STDEV(unitprice)  AS [standard deviation of unit price],
        VAR(unitprice)    AS [variance of unit price],
        COUNT(productID)  AS [number of products],
        SUM(unitsinStock) AS [total number of units in stock]
From    Products
GROUP BY CategoryID
ORDER BY CategoryID
-- 
-- so let's look at the process of what's going on here?

SELECT   CategoryID
FROM     Products
ORDER BY CategoryID

-- From the products table, select all the categories and order them by the category ID.
-- so what I see here is that: 
---- one record in NULL
---- twelve records in category 1
---- twelve records  in category 2
---- and so on

-- now now let's start to group these records:

SELECT   CategoryID
FROM     Products
GROUP BY CategoryID
ORDER BY CategoryID

-- what happens is that :
---- there is one record that represents category ID of NULL
---- there is one record  for the group of products that have a category ID of 1, 
---- there is one record  for the group of products that have a category ID of 2,
---- and so on

-- each of the 9 resulting records represents a group of products that have a common categoryID (you can also do this with DISTINCT,--  but that's for another video)

-- now let's add some attributes that we're interested in:

SELECT   CategoryID,
         Unitprice
FROM     Products
ORDER BY CategoryID,
         ProductID


-- we're looking to get the maximum unit price by category

-- looking at the left column, we can see values that will become groups 
---- the  NULL categoryID will become a group
---- the next twelve records with categoryID=1 will become the next group
---- and so on

-- We can "convert" the above statement into an aggregate
-- (you can get abetter understanding of what's happening here, by exporting the results to a csv file and calculating the max for each category.)

SELECT   CategoryID,
         MAX(unitprice) AS [maximum unit price] -- the MAX function is new
FROM     Products
GROUP BY CategoryID    -- the GROUP BY is new
ORDER BY CategoryID
-- you have to do those two changes together
-- you have to add the grouping and an aggregate function like a max at the same time

-- you can also visualize the results using Azure Data Studio


--So: "a count of products by category"
-- when someone says "... by category" 
-- they usually mean that the categoryID should be in the first column (the leftmost column)
-- and that the records should be GROUP BY'ed categoryID
-- and that the records should be ORDER BY'ed categoryID

-- More examples:

-- Manager Ava: "run a report and show me the total value of inventory by category"
-- here's what Manager Ava most likely wants:

SELECT      CategoryID,     -- category in first column
            SUM(unitprice * UnitsInStock) AS [value of inventory]
FROM        Products
GROUP BY    CategoryID     -- category is the basis for grouping
ORDER BY    CategoryID     -- records ordered by category

-- Manager Ava: "run a report and show me the average reorderlevel of products by supplier"
-- here's what Manager Ava most likely wants:

SELECT      SupplierID,    -- supplier in first column
            AVG(ReorderLevel) AS [Average reorder]
FROM        Products       
GROUP BY    SupplierID     -- supplier is the basis for grouping
ORDER BY    SupplierID     -- records ordered by supplier


--In summary:
--      SELECT
--      FROM 
 --     WHERE 
 --     Group BY
 --     ORDER BY

--GROUP BY clause:  divides the query result into groups of rows and returns one row per group.
-------- It is usually used for the purpose of performing one or more aggregations on each group. 
--WHERE clause: removes rows that do not meet the conditions in the WHERE clause before any grouping operation is performed.
--ORDER BY clause: orders the result set. The GROUP BY clause does not order the result set.