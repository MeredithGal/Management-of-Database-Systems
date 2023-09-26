-- HAVING - how to limit which groups are shown

-- you might want to review the GROUP by videos 

-- the HAVING clause specifies a search condition for a group or an aggregate
-- a general syntax for having is:
-- [ HAVING <search condition> ]  

-- the WHERE clause specifies which records will be included in the SELECT results.

-- however, when you use GROUP BY, each resulting record represents a group, e.g., a record for each month’s total sales.
-- there must be a way to control which group records are returned


USE Northwind

SELECT*
from Orders

-- let's use a simple query from the Orders table:

SELECT    CustomerID,
          OrderID,
          Freight
FROM      Orders
ORDER BY  CustomerID,
          OrderID

-- I'm showing the customerid and the orderid and my intent is to group by the customers and then aggregate something about the orders

-- now I am grouping by customerid and calculating average freight charges

SELECT    CustomerID,
          AVG(Freight) AS [Average Freight]
FROM      Orders
GROUP BY  CustomerID
ORDER BY  CustomerID

-- now suppose that we'd like to only see
-- high freight charges

-- we could maybe do this:

SELECT    CustomerID,
          AVG(Freight) AS [Average Freight]
FROM      Orders
GROUP BY  CustomerID
ORDER BY  [Average Freight] DESC

-- now the higher freigt charges are at the top

-- but maybe one wants to see something over a certain amount or just limited categories not all of them
-- in that case, I can use the non-ANSI-standard
-- TOP clause like this:

SELECT    TOP 5
          CustomerID,
          AVG(Freight) AS [Average Freight]
FROM      Orders
GROUP BY  CustomerID
ORDER BY  [Average Freight] DESC

-- here I'm getting the top five customers when I order by the average freight descending 

-- but what if I want a cut-off
-- only show customers whose average freight charges are above $100
-- there's a statement for that: HAVING

SELECT    CustomerID,
          AVG(Freight) AS [Average Freight]
FROM      Orders
GROUP BY  CustomerID
HAVING    AVG(Freight) > 100 -- this is the new piece
ORDER BY  [Average Freight] DESC

-- the new part is the HAVING clause (coming after the GROUP BY clause)
-- the HAVING clause is similar to the WHERE clause
-- in that it specifies a logical expression 
-- that can be evaluated as true or false

-- however:
---- with the HAVING clause, the logical expression is evaluated for each *group* (in our case, each group represents a customer)
---- with the WHERE clause, the logical expression is evaluated for each *record* (in our case, each record represents an order)

--In general, if you use a regular (not aggregated) field in the HAVING clause, the database engine will give you a syntax error.

-- consider this example

SELECT    CustomerID,
          AVG(Freight) AS [Average Freight]
FROM      Orders
GROUP BY  CustomerID
HAVING    Count(OrderID) > 20 -- this is the new piece
ORDER BY  [Average Freight] DESC

-- here we are saying, only show customers that have at least 20 orders 
-- notice that the HAVING doesn't have to be something in the SELECT clause

-- consider this example

SELECT    CustomerID,
          AVG(Freight) AS [Average Freight]
FROM      Orders
GROUP BY  CustomerID
HAVING    AVG(Freight) > 100
  AND     Count(OrderID) > 20   
ORDER BY  [Average Freight] DESC

-- here, only show customers whose average freight charges are above $100
-- AND have at least 20 orders 

-- the average freight charge does not change for each customer
-- what changes, is which customers are displayed

-- now consider these:

SELECT    CustomerID,
          AVG(Freight) AS [Average Freight]
FROM      Orders
GROUP BY  CustomerID
HAVING    AVG(Freight) > 100
ORDER BY  [Average Freight] DESC

SELECT    CustomerID,
          AVG(Freight) AS [Average Freight]
FROM      Orders
WHERE     Year(OrderDate) < 1997 -- this is the new piece
GROUP BY  CustomerID
HAVING    AVG(Freight) > 100 
ORDER BY  [Average Freight] DESC

select *
from Orders

-- notice that the average freight charges change -- and potentially, the order of the rows could change
-- this is because only orders before 1997 are included in the groups
-- and therefore, the aggregations (AVG, MIN, MAX, COUNT, etc.) change

-- so, here is a good way to think about the order in which the operations are performed:
---- WHERE comes first - records are eliminated before the grouping
---- GROUP BY comes next - remaining records are arranged into groups
---- HAVING comes next - groups are eliminated
---- ORDER BY comes last - what's left gets ordered

--another example:

SELECT    CustomerID,
          AVG(Freight) AS [Average Freight]
FROM      Orders
WHERE     ShipCountry != 'USA' 
   OR     YEAR(OrderDate) = 1997
GROUP BY  CustomerID
HAVING    AVG(Freight) > 100 
   AND    Count(OrderID) > 20   
ORDER BY  [Average Freight] DESC


--In summary:
--HAVING specifies a search condition for a group or an aggregate
--HAVING can be used only with the SELECT statement. 
--HAVING is typically used with a GROUP BY clause. 
--when GROUP BY is not used, there is an implicit single, aggregated group.

--a general syntax for having is:
--[ HAVING <search condition> ]  

-- Aggregating is an important way to produce valuable information from raw data. 
-- It addresses information overload by summarizing the attributes of each group (SUM, COUNT, MIN, etc.) rather than the details of every item in the group. 
-- Aggregated values are commonly used as the upper levels of drilldown reports. 
-- Managers and decision makers at higher levels of management in an organization are likely to require information aggregated specifically to their level of management.
-- For exampe, a sales manager in charge of sales in the New Hanover County in North Carolina will likely want sales reports grouped by the county that she is in charge of, 
-- rather than reports of every individual sale, or reports grouped by states or countries.