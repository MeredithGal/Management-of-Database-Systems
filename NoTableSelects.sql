--Basic no-table SQL statements
-- Minoo Modares
USE Northwind

SELECT 54
--in the results, notice that this is a one-row, one-column table. There is no name for the column

SELECT 'Hello'
--the result is similar to the first example, but with text characters
--note that the numbers are shown in green (in Azure data studio) and character strings are shown in red

SELECT '54'
--here the result is NOT a number.

SELECT 54 AS myNumber
--in this example, we assigned a name to the column
--now we can refer to the column in the future
--note that "reserved words" are shown in blue

SELECT 3+2
--in this example, a mathematical expression is evaluated by the SQL engine on the remote server and we will see the results

SELECT 3+2 AS [The Number 5]

SELECT 3*(16/8) AS [Mathematical Expression Result]
-- The order of operations in ADS is similar to a spreadsheet
-- you can use parentheses to control the order of operations
-- here the numbers are integer

SELECT 3.0*(17.0/8.0) AS [Mathematical Expression Result]
-- here the numbers are floating point numbers with decimal points

SELECT 'P' + 'ink' AS [This is a name]
--in this example, we use a character string expression
-- concatenating two character strings into a single character string

SELECT 'Pink' + ' '+ 'Panther' AS [This is a Cartoon Character]
-- three strings concatenated to produce phrases with a space between 

SELECT SQRT(49) AS [Square Root of 49]
-- we use functions in an expression
-- in this example, the SQRT function, that shows up in dark red color, calculates the square root of the number 

SELECT SQRT(49)              AS [Square Root of 49],
    'Pink' + ' '+ 'Panther'  AS [This is a Cartoon Character]
-- in this example, we are generating more than one column in a table 
-- the table is created by the SELECT and two columns are defined using a comma between them

SELECT SQRT(49)                 AS [Square Root of 49],
    'Pink' + ' '+ 'Panther'     AS [This is a Cartoon Character],
     3*(16/8)                   AS [Mathematical Expression Result]
-- here are three columns
-- note the formatting and spacing in the code above that makes it easy to read


