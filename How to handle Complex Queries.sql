-- How to approach a more complex query (that might include all the DML statements: JOINs, WHERE, HAVING, GROUP BY)?

-- For example:
-- List  products that have created more than $5000 in revenue in 1996.
-- Show productname, productID, and categoryname. Order by productname.

-- the basic order of the clauses is: 

-- SELECT 
-- FROM 
-- WHERE
-- GROUP BY
-- HAVING
-- ORDER BY

-- but we don't start at the top! 
-- general rule: take small steps, run it often!  if it dosn't run , you need to redo your last small step  

-- Here is a good practice:

-- 1. read the question carefully: 
--    what tables? you need to check the data models to answer this question.
--    what will I need?
--    GROUP BY
--    Outer JOIN
--    subqueries
--    big expressions?

-- 2. run SELECT * FROM Table to see what columns and how many rows you have in each required table

-- 3. get some working codes. 
--    get the joins right 
--    write any expressions and verify them (you can test your expressions in the SELECT statement and then move them)
--    write any where clause expressions and verify them
--    arrange any columns and rows in preparation for grouping
--    add the grouping
--    add the HAVING
--    add the Order BY
--    tidy up the code


-- Going back to the example:

-- List  products that have created more than $5000 in revenue in 1996.
-- Show productname, productID, and categoryname. Order by productname.

-- 1. We will be working with the tables products, orders, order details, and categories

 --2. check the tables
SELECT * FROM Products -- we need productname and productID from this table
SELECT * FROM Categories -- we need categoryname from this table
SELECT * FROM Orders --  we need orderdate from this table
SELECT * FROM [Order Details]--  we need quantity, unitprice, and discount from this table

--3. 

-- get some working code

SELECT p.productID 
FROM   Products p

-- get the joins right

-- we have four tables and three joins in the FROM cluase - I will run each one to make sure it works 

SELECT p.productID 
FROM   Products p
    JOIN Categories c ON c.CategoryID = p.CategoryID
    JOIN [Order Details] d ON d.ProductID = p.ProductID
    JOIN Orders o ON o.OrderID = d.OrderID

-- write any expressions and verify them (you can test your expressions in the SELECT statement and then move them)

-- I will start with the year() function. I will add YEAR(o.orderdate) to the select statement and add the orderdate to make sure the function is correct. I will run the query and verify it.

SELECT p.productID, 
        o.OrderDate,
        YEAR(o.orderdate) AS [year]
FROM   Products p
    JOIN Categories c ON c.CategoryID = p.CategoryID
    JOIN [Order Details] d ON d.ProductID = p.ProductID
    JOIN Orders o ON o.OrderID = d.OrderID

-- now, we need to calculate the revenue which will be an expression. Let's also see the individual pieces - we will later remove them.

SELECT p.productID, 
        YEAR(o.orderdate) AS [year],
        d.Quantity,
        d.UnitPrice,
        d.Discount,
        d.Quantity * d.UnitPrice  AS [Sales],
        d.Quantity * d.UnitPrice * (1-d.Discount) AS [Line Revenue]
FROM   Products p
    JOIN Categories c ON c.CategoryID = p.CategoryID
    JOIN [Order Details] d ON d.ProductID = p.ProductID
    JOIN Orders o ON o.OrderID = d.OrderID

--   write any where clause expressions and verify them

SELECT p.productID, 
        o.orderdate,
        YEAR(o.orderdate) AS [year],
        d.Quantity,
        d.UnitPrice,
        d.Discount,
        d.Quantity * d.UnitPrice * (1-d.Discount) AS [Line Revenue]
FROM   Products p
    JOIN Categories c ON c.CategoryID = p.CategoryID
    JOIN [Order Details] d ON d.ProductID = p.ProductID
    JOIN Orders o ON o.OrderID = d.OrderID
WHERE   YEAR(o.orderdate) = 1996
ORDER BY  o.orderdate -- I will add an o.orderdate to visually verify the Where clause expression. I will remove this later.

--   arrange any columns and rows in preparation for grouping

SELECT  p.ProductName, -- this statement will be in the grouping
        p.productID, -- this statement will be in the grouping
        c.CategoryName, -- this statement will be in the grouping
        d.Quantity * d.UnitPrice * (1-d.Discount) AS [Revenue]  -- this statement will be in the SUM () function
FROM   Products p
    JOIN Categories c ON c.CategoryID = p.CategoryID
    JOIN [Order Details] d ON d.ProductID = p.ProductID
    JOIN Orders o ON o.OrderID = d.OrderID
WHERE   YEAR(o.orderdate) = 1996
Order By p.ProductName, 
        p.productID,
        c.CategoryName

-- looking at the records, I realize the Alic Mutton product was in the eight orders. 
-- So, after grouping, I will have one record for the Alice Mutton product and the Sum of revenues from all the eight orders

--    add the grouping

SELECT  p.ProductName,
        p.productID,
        c.CategoryName,
        SUM (d.Quantity * d.UnitPrice * (1-d.Discount)) AS [Revenue]
FROM   Products p
    JOIN Categories c ON c.CategoryID = p.CategoryID
    JOIN [Order Details] d ON d.ProductID = p.ProductID
    JOIN Orders o ON o.OrderID = d.OrderID
WHERE   YEAR(o.orderdate) = 1996
GROUP BY p.ProductName,
         p.productID,
         c.CategoryName
Order By  p.ProductName, 
          p.productID, 
          c.CategoryName
         
--    add the having

SELECT  p.ProductName,
        p.productID,
        c.CategoryName,
        SUM (d.Quantity * d.UnitPrice * (1-d.Discount)) AS [Revenue]
FROM   Products p
    JOIN Categories c ON c.CategoryID = p.CategoryID
    JOIN [Order Details] d ON d.ProductID = p.ProductID
    JOIN Orders o ON o.OrderID = d.OrderID
WHERE   YEAR(o.orderdate) = 1996
GROUP BY p.ProductName,
         p.productID,
         c.CategoryName
HAVING   SUM (d.Quantity * d.UnitPrice * (1-d.Discount)) > 5000.0
Order By  p.ProductName, 
          p.productID, 
          c.CategoryName

--  add Order by

-- Here, I will add an Order By statement that the consumer of the final report is looking for. In the question, it says Order by productname.

SELECT  p.ProductName,
        p.productID,
        c.CategoryName,
        SUM (d.Quantity * d.UnitPrice * (1-d.Discount)) AS [Revenue]
FROM   Products p
    JOIN Categories c ON c.CategoryID = p.CategoryID
    JOIN [Order Details] d ON d.ProductID = p.ProductID
    JOIN Orders o ON o.OrderID = d.OrderID
WHERE   YEAR(o.orderdate) = 1996
GROUP BY p.ProductName,
         p.productID,
         c.CategoryName
HAVING   SUM (d.Quantity * d.UnitPrice * (1-d.Discount)) > 5000.0
ORDER BY p.ProductName,
         p.productID -- I will keep this since productID is the primary key of the table product 

--  I will check the code, clean up the code, and check if I can make it more efficient.

