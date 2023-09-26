-- HW5: SUBQUERIES
-- Tabitha Hagen

USE Northwind

---------------------------------------------------------------------
-- Subqueries: From the table Orders 
--    List all orders with above-average freight costs. 
---------------------------------------------------------------------
-- Looking at the Orders table
SELECT *
FROM    Orders      -- 831 rows, 14 columns

-- Looking at the average freight cost 
SELECT   AVG(freight)  AS [Average Freight Cost]
FROM     Orders          --$78.15 is the average freight cost
---------------------------------------------------------------------

SELECT   OrdersTable.OrderID AS [ORDER #],          -- List the OrderID Column from the Orders Table 
         OrdersTable.CustomerID AS [CUSTOMER #],    -- List the CustomerID Column from the Orders Table
         OrdersTable.OrderDate AS [Order DATE],     -- List the Order Date Column from the Orders Table
         OrdersTable.Freight AS [FREIGHT Cost ($)]  -- List the Freight Column from the Orders Table
FROM Orders OrdersTable                             -- Rename table to be less confusing  with other tables
WHERE    Freight >= (                               -- Only list freight greater than average freight costs
         SELECT  AVG(Freight)                       -- Simple subquery retrieves the average freight cost from the Orders table
         FROM   Orders )                            -- $78.15 is the average freight cost
ORDER BY Freight   DESC                             -- ordered in descending order by Freight cost

-- Results in table with 242 rows and 4 columns
---------------------------------------------------------------------