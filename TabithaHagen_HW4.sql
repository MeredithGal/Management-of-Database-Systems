-- HW4: Aggregation, GROUP BY, and HAVING
-- Tabitha Hagen

USE Northwind

-- 1. From the table Orders:  We want to know the number of orders processed by each employee. Show the EmployeeID and the number of orders—order by the count of orders descending.  See if you can filter the results of the previous question by only including employees who processed more than 50 orders in the year 1997. 

-- Select * from Orders -- Look at Orders Table

SELECT   EmployeeID,                           -- List the EmployeeID column
         COUNT(OrderID) AS [Number of Orders Processed]   -- List the number of orders for each employee in a column
FROM     Orders                                -- The Table source
WHERE    Year(OrderDate) = 1997                -- Only Include employees who processed orders in 1997
Group By EmployeeID                            -- Group by EmployeeID 
HAVING   COUNT(OrderID) > 50                     -- Only Include employees who processed more than 50 orders
ORDER BY COUNT(OrderID) DESC                   -- The order of the columns within the SELECT statement