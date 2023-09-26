--Introduction to Aggregation
--Minoo Modares

USE Northwind

-- here's a simple SELECT statement from the Products table

SELECT   ProductID,
         productname,
         unitprice,
         UnitsInStock
FROM     Products
ORDER BY ProductID

-- with no where clause,  we get a record here for every product in the products table

-- but what if your manager asks you to display a *summary* of the products? 
-- this summarization is known as "aggregating" or "aggregation".  -- we can use aggregating functions for that.

-- in SQL, there are built-in aggregating functions 
--AVG()   
--MIN()    
--MAX()
--COUNT() 
--SUM() 
--STDEV()  
--VAR() 
   
--note that Except for COUNT(*), aggregate functions ignore null values. 

--For example:

SELECT   MAX(unitprice)  AS [maximum unit price]
FROM     Products

-- in this case, we have summarized all the prices of all products
-- into a single number -  the max

-- we aggregate (summarize) all the product records into a single group,-- then we can ask questions about the group

-- what else can we find out about the group?

SELECT  AVG(unitprice)    AS [average unit price],
        MIN(ReorderLevel) AS [minimum reorder level],
        MIN(unitprice)    AS [minimum unit price],
        MAX(unitprice)    AS [maximum unitprice]
From    Products

SELECT  STDEV(unitprice)  AS [standard deviation of unit price],
        VAR(unitprice)    AS [variance of unit price],
        COUNT(productID)  AS [number of products],
        SUM(unitsinStock) AS [total number of units in stock]
From    Products

-- we can also include expressions in an aggregate function:
--for example, your manager is asking you about the total value of orders you have received

SELECT   SUM(unitprice * unitsonorder) AS [total value of orders]
FROM     Products

-- in the above examples we were aggregating over the whole table
-- by adding a WHERE clause, you can limit the aggregation 
-- for example, the MAX is calculated over  unit prices of products in the stated categories

SELECT   MAX(unitprice)     AS [maximum unit price]
FROM     Products
WHERE    CategoryID IN (1, 2, 3)

-- think of the above example as happening in this order
-- 1 - the WHERE clause - records are eliminated first based on the specified condition
-- 2 - the max - aggregate calculated over remaining records

--Another example:
--The average of uniteprices for products that are not discontinued and the unit price is more than $100

SELECT  AVG(unitprice)    AS [average unit price]
From    Products
WHERE   Discontinued=0 
   AND  unitprice > 100


