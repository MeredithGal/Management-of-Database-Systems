-- SELECT statement with WHERE Clause
-- Minoo Modares

USE Northwind

--refresher
--we can use the SELECT statement to create tabular results:

SELECT  'Lily'     AS [Flower],
        'Yellow'   AS [Color]  
        
--we can also use the SELECT statement to retreive data from a table
--we can display all the columns from the table Customers (the * or asterisk will show ALL columns in the table Customers):

SELECT *
FROM   Customers

--but how do we specify *which* rows to select? we need the WHERE clause for that.

--For example, from the Customers table, we can only select the customers in the USA 

SELECT *
FROM   Customers
WHERE  Country = 'USA'

--and we can select the customers outside of the USA:

SELECT   *
FROM     Customers
WHERE    Country != 'USA'

--One way to think of how the WHERE clause works is to imagine that the database server will actually perform the following steps:
--Retrieve all records from the table Customers
 --Look at each record
----if the value of the field country for this record is equal to ’USA’, keep it
----otherwise, throw it out
--Keep all the fields from the table Customers
--Return what’s left

--Of course, the database server may not actually do all of those steps, but it is helpful to think of the WHERE clause in this way as you learn it.

--The general format for a SELECT statement now looks like:
--SELECT    <column-expression-list>
--FROM      <source-expression>
--WHERE     <logical-expression>

--The WHERE clause contains a logical expression. 
--The logical-expression in the WHERE CLAUSE is a statement that is either true or false. The logical expression is evaluated for each row/record, retaining those rows for which the condition is true and discarding the others.

--records that evaluate (logical expression) as TRUE (1) are included
--records that evaluate (logical expression) as False (0) are not included

--comparison operators >, <, >=, <=, =, <>, !=

--for demonstartion purposes
--lets run some example queries where a record with "True" is shown if the WHERE clause evaluates to true.

SELECT 'True'
WHERE 2=2

SELECT 'True'
WHERE 2>2

SELECT 'True'
WHERE 2<2

SELECT 'True'
WHERE 2>=2

SELECT 'True'
WHERE 2<=2

SELECT 'True'
WHERE 2<>2

SELECT 'True'
WHERE 2<>3



