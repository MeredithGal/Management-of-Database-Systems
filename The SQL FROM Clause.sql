-- SELECT FROM 
-- Minoo Modares

--review the SELECT statement before working on this example

USE Northwind

--we can use the SELECT statement to create tablular results
SELECT  'Lily'     AS [Flower],
        'Yellow'   AS [Color]
        
--The SELECT statement can also be used to drawn data from a table:
SELECT  CustomerID --name of column
FROM    Customers  --name of table 
--the FROM statement sets the source of the data 
--Customers is the name of a table in the Northwind database

SELECT  CustomerID,   --name of column
        CompanyName,  --name of column
        ContactName,
        ABC           --INVALID name of column
FROM    Customers     --name of table   
--when i run this part of the code, I get an "invalid column name" error

SELECT *         --all the names of columns
FROM  Customers  --name of table 
--if I don't know what the columns are or if I want to select all the columns in a table
--after the SELECT clause, we normally put a column name
-- when you put a * (asterisk) instead, it returns "all columns" in a table
-- ** SELECT * means ALL COLUMNS


-- remember how you can rename a column in the SELECT?
SELECT      CustomerID   AS [ID],        --Rename name of column
            CompanyName  AS [Company],   --Rename name of column
            ContactName  AS [Contact]    --Rename name of column
FROM        Customers                    --name of table 

-- you can also do this for the table names
SELECT      CustomerID   AS [ID],        --Rename name of column
            CompanyName  AS [Company],   --Rename name of column
            ContactName  AS [Contact]    --Rename name of column
FROM        Customers    AS [c]          --Rename name of table in select statement only
-- this is called an alias 
-- c is an alias for Customers
-- c is a name that was made up in the SELECT statement - it doesn't exist in the table

-- you can use the AS statement or you can leave it out:
SELECT      CustomerID   AS [ID],        --Rename name of column
            CompanyName  AS [Company],   --Rename name of column
            ContactName  AS [Contact]    --Rename name of column
FROM        Customers    [c]             --Rename name of table in select statement only

-- you can also do this without brackets:
SELECT      CustomerID   AS ID,         --Rename name of column
            CompanyName  AS Company,    --Rename name of column
            ContactName  AS Contact     --Rename name of column
FROM        Customers    c              --Rename name of table in select statement only
-- note also that the square brackets are not necessary
-- however, it is good practice to use them to highlight the aliasing


-- there are times that you MUST alias a table or column name to achieve your objective 
-- (for example: same table in the FROM multiple times - more advanced)

-- it also has implications to "qualifying" a column name
-- here is the same query fully qualified
SELECT      Customers.CustomerID,    --name of column from Customers Table
            Customers.CompanyName,   --name of column from Customers Table
            Customers.ContactName    --name of column from Customers Table
FROM        Customers , Orders       --name of tables 
--- when you have multiple tables in the FROM,
-- you'll NEED to fully qualify to resolve ambiguities
-- AND to write safe, high quality code

-- the *not* fully qualified:
SELECT      CustomerID   AS [ID], -- Both tables have CustomerID in them
            CompanyName  AS [Company],
            ContactName  AS [Contact]
FROM        Customers, Orders

-- sometimes you'll see this:
SELECT      [c].CustomerID,     --name of column from Customers Table
            [c].CompanyName,    --name of column from Customers Table
            [c].ContactName     --name of column from Customers Table
FROM        Customers  [c]      --Rename name of table in select statement only
-- the Customers table is aliased to c
-- which forces us to use [c] to qualify the fields

-- the code below doesn't work:
SELECT      Customers.CustomerID,     --name of column from Customers Table
            Customers.CompanyName,    --name of column from Customers Table
            Customers.ContactName     --name of column from Customers Table
FROM        Customers  [c]            --Rename name of table in select statement only
-- once a table is renamed, the original name doesn't exist anymore in the context of this statement

-- also, note that many would write the above statement without the square brackets:
SELECT      c.CustomerID,      --name of column from Customers Table
            c.CompanyName,     --name of column from Customers Table
            c.ContactName      --name of column from Customers Table
FROM        Customers  c       --Rename name of table in select statement only

-- the alternative names for the tables work fine-- and it will sometimes save quite a bit of typing
-- however, if you have a lot of tables, it becomes *very* difficult to understand and track the alternative names
-- as your statements get bigger with more tables,
-- I think this is a better option even if you have to type more.. your code will be readable to others
SELECT      Customers.CustomerID,       --name of column from Customers Table
            Customers.CompanyName,      --name of column from Customers Table
            Customers.ContactName       --name of column from Customers Table
FROM        Customers                   --name of table

--Another thing to note about the SELECT statement: the expression was a column name. 
--Not only can a column name be used as an expression, but a column name can be used in an expression:
SELECT  discounttype,    --name of column from Customers Table
        discount         --name of column from Customers Table
FROM    discounts        --name of table

SELECT      discounttype,   --name of column from Customers Table
            100-discount AS [Price after Discount for $100 shopping] --expression new column
FROM        discounts        --name of table

-- in summary,
-- FROM is to state the source table(s)
-- you can alias table names in the FROM
-- you can, and sometimes HAVE TO,
--   *fully qualify* your column names
--   by using this format: 
--   tableName.columnName 