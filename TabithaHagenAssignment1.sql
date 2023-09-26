-- Tabitha Hagen
-- Week 1 Assignment 1

-- 1. Show 'Ava', 'Smith', 'female', and 27 in a one-row, four-column table. The columns should be named [First Name], [Last Name], [gender], and [age].

SELECT 'Ava' AS [First Name], 
    'Smith' AS [Last Name],
    'female' AS [gender],
    27 AS [age];

-- 2. Show the SQRT (square root) of the number 8597 in a one-column, one-row table. The column name should be [Square Root].

SELECT SQRT(8597) AS [Square Root];

-- 3. Show the result of this calculation in a one-row, one-column table: ((54.0*77.0)+6.0)/2.0. Name the column [Result].

SELECT ((54.0*77.0)+6.0)/2.0 AS [Result];

-- 4. Show a 3-column, 1-row table that has 875, 'Boo', 857/25 in the columns. The columns should be named [Number], [Name], and [Calculation Result].

SELECT 875 AS [Number], 
    'Boo' AS [Name],
    857/25 AS [Calculation Result];

-- 5. Combine the strings 'James', 'P. ', and 'Sullivan' with a space between them in a single-row, single-column table using a single SELECT statement and + operators. This should be a concatenation of five strings: 'James', ' ', 'P. ', ' ', and 'Sullivan'. Name the column [MonsterName].

SELECT 'James' + ' ' + 'P.' + ' ' + 'Sullivan' AS [Monster Name];

-- 6. Show the current server time in a column named [Current System Time]. Use the GETDATE() function.

SELECT GETDATE() AS [Current System Time]