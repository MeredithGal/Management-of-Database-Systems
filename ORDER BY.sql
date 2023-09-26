-- SELECT statement with ORDER BY Clause
-- Minoo Modares

USE Northwind
--Review the SELECT materials before you start working on these examples

----------------------------------------------------------------SELECT statement with FROM and ORDER BY Clauses
--we can add ORDER BY clauses to the SELECT statement to control the *order* of the rows:

--SELECT <column-expression-list>
--FROM    <source-expression>
--ORDER BY <sort-expression-list>

--with this statement, we can control:
--which columns with the SELECT statement
--the order of the columns with the SELECT statement 
--the source of the data with the FROM clause
--the order of the rows with the ORDER BY clause

--for example, we can select CompanyName, ContactName, Country, and CustomerID in this order of columns from the table Customers and order the results by CustomerID in ascending order

SELECT   CompanyName,
         ContactName,
         Country,
         CustomerID
FROM     Customers
ORDER BY CustomerID ASC --the source & order of the columns with the SELECT statement 

-- the ordering is alphabetical, because CustomerID is not numeric - it is character-based
-- or we can order descending

SELECT   CompanyName,
         ContactName,
         Country,
         CustomerID
FROM     Customers
ORDER BY CustomerID DESC  --the source & order of the columns with the SELECT statement

--by default, the ordering of a sort key is ascending

SELECT   CompanyName,
         ContactName,
         Country,
         CustomerID
FROM     Customers
ORDER BY CustomerID  --the source & order of the columns with the SELECT statement

--the sort key does not need to be the first column
--the sort key does not need to be in any other clause of the SELECT statement
--For example:

SELECT   CompanyName,
         ContactName,
         Country       
FROM     Customers
ORDER BY CustomerID  --the source & order of the columns with the SELECT statement

--it is also possible to use multiple sort keys

SELECT   CompanyName,
         ContactName,
         Country,
         CustomerID
FROM     Customers
ORDER BY Country,
         CustomerID  --the source & order of the columns with the SELECT statement

-- NULLs are considered to be smaller than numeric values and characters

--Sorting is a very important operation used to create high-value information from raw data, 
--and it is common to use multiple sort keys to create information for a specific purpose.
