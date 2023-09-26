-- Tabitha Hagen
-- Week 6 Assignment 6      Subqueries and CASE 

USE Northwind   -- Define which database to use

---------------------------------------------------------------------
--Let's look at the Order Details table
SELECT *
FROM [Order Details]                            -- 2,155 rows, 5 columns

-- Looking at the average Unit Price 
SELECT   AVG(UnitPrice)  AS [Average Unit Price]
FROM     Products                               -- $28.4962 is the Average Unit Price
---------------------------------------------------------------------
-- 1. From the table [Order Details] - List all details of all the above-average priced products (simple subquery) (718 records).

SELECT   *                                      -- Display all details
FROM     [Order Details]                        -- From the table Order Details
WHERE    UnitPrice > (                          -- If the unit Price is above average
                       SELECT   AVG(UnitPrice)  -- Simple subquery to get Average Unit Price
                       FROM     Products )      -- From Products table
ORDER BY [Order Details].UnitPrice, [Order Details].ProductID   -- Order results by Ascending Unit Price

------ !!!   Results in table with 679 rows and 5 columns  !!! ------
---------------------------------------------------------------------