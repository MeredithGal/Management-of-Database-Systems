-- SELECT statement with WHERE Clause (IN)
-- Minoo Modares

--In SQL, there are special operators available that return logical values, and therefore can be used in place of a logical expression.

-------------------------------------------------------------------------------------USING an IN Operator
--IN operator is a logical operator so it returns True/False (1/0). --Since the IN operator is a logical operator, it is usually included in the WHERE clause.

--The general syntax for the IN operator is expression1 IN (list of expressions). 
--The value on the left will be compared with the value in the right and return a true or false. 

--for example, the statement below shows the records that have a CategoryID of either 2 or 3 

SELECT   ProductID,
         CategoryID,
         unitprice,
         ProductName
FROM     Products
WHERE    CategoryID IN (2,3)  
ORDER BY CategoryID,ProductName ASC 

-- it evaluates the CategoryIDs by common sense just like it sounds..this query gives us all the products from the two categories (2 or 3)
-- we compare what's on the left with the list on the right and if the category ID for a record is one of the items here then keep the record otherwise discard the record 

--So you can equivalently, phrase this as an OR statement:

SELECT   ProductID,
         CategoryID,
         unitprice,
         ProductName
FROM     Products
WHERE    CategoryID =2 
OR       CategoryID =3
ORDER BY CategoryID DESC, ProductName DESC 

-- Any IN expression can be written as a sequence of OR expressions. So  the IN operator is not necessary!
--So, why would you use the IN clause rather than the list?  It is mainly for clarity. Less code has less potential for bugs.

-- here's an example of having a longer list of ID's that are possible matches

SELECT   ProductID,
         CategoryID,
         unitprice,
         ProductName
FROM     Products
WHERE    CategoryID= 1
OR       CategoryID= 3
OR       CategoryID= 4
OR       CategoryID= 5
ORDER BY CategoryID ASC

--this is a much clearer way of phrasing it and possibly has less potential for creating a bug  

SELECT   ProductID,
         CategoryID,
         unitprice,
         ProductName
FROM     Products
WHERE    CategoryID IN (1,3,4,5)
ORDER BY CategoryID DESC

--Another example to show you that IN can be used with other data types: We can show the first names of people whose last name is either Smith or Jones. 

SELECT    firstName,
          lastName
FROM      Person
WHERE     lastName IN ('Smith', 'Jones') 
ORDER BY lastName, firstName

--The above SELECT statement can be written equivalently as:

SELECT   firstName, lastName
FROM     Person
WHERE    (lastName='Smith')
OR       (lastName='Jones')
ORDER BY lastName, firstName ASC

--In summary:
---IN operator is a logical operator so it returns True/False (1/0) ----It is usually included in the WHERE clause.
---The general syntax for the IN operator is expression1 IN (list of expressions).  The value on the left will be compared with the value in the right and return a true or false. 
---IN  returns TRUE(1) if the reference value is *in* the list of values--
---IN is usually used to replace a series of logical expressions connected with ORs