-- SELECT statement with WHERE Clause (NOT, AND, OR)
-- Minoo Modares

USE Northwind

--we can add the WHERE clause and limit the results to only the products that their unit price are more than $50
--The WHERE clause contains a logical expression (unitprice > 50) and for every record that statement will either be true or false.

SELECT   ProductID,
         unitprice,
         ProductName,
         Discontinued
FROM     Products
WHERE    unitprice > 50

SELECT unitprice,
    CONVERT(bit, Case when unitprice>50 then 1 else 0 end) AS[expensive products]
    From Products

--Don't pay attention to the convert expression
--I can test wether or not a unitprice is more that 50

--now the same thing but only show  the expensive products

SELECT unitprice,
    CONVERT(bit, Case when unitprice>50 then 1 else 0 end) AS[expensive products]
    From Products
    WHERE    unitprice > 50

--another example:

SELECT   ProductID,
         unitprice,
         ProductName,
         Discontinued
FROM     Products
WHERE    unitprice >= 30

SELECT   ProductID,
         unitprice,
         ProductName,
         Discontinued
FROM     Products
WHERE    ProductName != 'Chai'

--with an embedded expression

SELECT   ProductID,
         unitprice,
         ProductName,
         Discontinued
FROM     Products
WHERE    (UnitPrice)/10 > 5

--(UnitPrice)/10  is a mathematical expression that evaluates as a number
--(UnitPrice)/10 > 5 is a logical expression that evaluates as true or false


--We can use other logical operators to add logical expressions and create new logical expressions.The available logical operators are NOT, AND, and OR. 
-- for logical expressions you have the option of using not, and, and or. this works similar to a spreadsheet. if you have taken a formal logic course 
--these are classic logical operators
--This makes the WHERE clause quite powerful but can also make it complex. 

-------------------------------------------------------------------------------AND
-- The AND operator evaluates the possible combinations of two or more logical expressions. 
--The general syntax for the AND operator is (logical expression) AND (logical expression). 
--(True)  AND  (True) --> True
--(True)  AND  (False) --> False
--(False)  AND (True) --> False
--(False)  AND (False) --> False

--for example, we can find items that are greater than 10 in price and are discontinued 

SELECT   ProductID,
         unitprice,
         ProductName,
         Discontinued
FROM     Products
WHERE    unitprice > 10
  AND    Discontinued = 1

--We are evaluating whether unit price is greater than 10 that might be true or false and 
--also We are evaluating whether the field discontinued is equal to 1 that might be true or false
--then we are taking the ones where both logical expressions are true

--another example: We can retrieve All last names of people whose first name is John AND their last names are Smith:

SELECT   lastName,
         firstName
FROM     Person
WHERE    firstName='John'
  AND    lastName='Smith'
---------------------------------------------------------------------------------OR
--We can also combine two logical expressions using OR. The general syntax for the OR operator is (logical expression) OR (logical expression).
--(True) OR (True) --> True
--(True) OR (False) --> True
--(False) OR (True) --> True
--(False) OR (False) --> False

--We can  retrieve products that are discontinued OR the price is greater than 10

SELECT   ProductID,         
         unitprice,         
         ProductName,         
         Discontinued
FROM     Products
WHERE    unitprice > 10
  OR     Discontinued = 1

--We can retrieve All last names of people whose first name is either Alex or Ellie from the person table.

SELECT   lastName,
         firstName
FROM     Person
WHERE    firstName='Ellie'
  OR     firstName='Alex'

--Note that if we run the same query but of people whose first name is Alex and Ellie, we won't get any results back. 
--Because it is impossible for a person in our example to have two first names.

SELECT  lastName,
         firstName
FROM     Person
WHERE    firstName='Ellie'
  AND    firstName='Alex'
-------------------------------------------------------------------------------NOT
--Not operates on one logical expression. The general syntax for the NOT operator is NOT(logical expression). 
--The NOT operator takes any logical expression and negates it:

--NOT(an expression that evaluates True) --> False
--NOT(an expression that evaluates False) --> True

--For example, we can retrieve products that are not discontinued. 
--We are evaluating whether discontinued is equal to one that might be true or false and then taking the oposite of it

SELECT   ProductID,         
         unitprice,         
         ProductName,        
         Discontinued
FROM     Products
WHERE    NOT (discontinued= 1)


--Or, from the person table, we can retrieve all first names of people whose first name is not Alex
--We are evaluating whether firstname is Alex-- that might be true or false and then we are taking the oposite of it

SELECT   firstName
FROM     Person
WHERE    NOT (firstName='Alex')

-----------------------------------------------------------------------------More examples:
--we can control the order of evaluation with parentheses.
-- the expressions get evaluated left to right if you don't supply parentheses so 
SELECT   ProductID,         
         unitprice,         
         ProductName,         
         Discontinued
FROM     Products
WHERE    NOT Discontinued = 1 AND unitprice > 10
  
  --which is the same as:
SELECT   ProductID,         
         unitprice,         
         ProductName,         
         Discontinued
FROM     Products
WHERE    (NOT Discontinued = 1) AND unitprice > 10

--which is different than:
SELECT   ProductID,         
         unitprice,         
         ProductName,         
         Discontinued
FROM     Products
WHERE    NOT (Discontinued = 1 AND unitprice > 10)

--here I'm performing the and before I perform the not 

