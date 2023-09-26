USE Northwind
------------------------------------------------------------------------------------LIKE

--The LIKE operator is a logical operator that evaluates if a set of characters matches a pattern. If it matches it returns True (1), otherwise, it returns false (0). 

--Since the LIKE operator is a logical expression, it is usually included in the WHERE clause. --Because the WHERE clause expects a logical expression.--
--The LIKE operator gives string matching capability based on the expressions in the WHERE clause.

--let's look at all the Last names in the table Person

SELECT lastName
FROM Person

--Now, let's limit the results using a where clause to show just certain records in this case we're showing all the last names that begin with the letter M:

SELECT  firstName,
        lastName
FROM    Person
WHERE   lastName LIKE 'M%'

-- Now lets look at all people whose last name ends with the letter M

SELECT  firstName,
        lastName
FROM    Person
WHERE   lastName LIKE '%M'

--Let's show all people whose last name has the letter m anywhere in their last names

SELECT  firstName,
        lastName
FROM    Person
WHERE   lastName LIKE '%m%'

--Or, all people whose last name starts with the letter S and end with the letter h

SELECT  firstName,
        lastName
FROM    Person
WHERE   lastName LIKE 'S%h'

--All products that have the word stainless in their description, (i.e., all the stainless steel products)

SELECT productID
FROM   Products
WHERE  productName LIKE '%stainless%'

--As you can see, "%" (the percentage character)  is a special character that can match on zero or more characters. 
--the percent actually means something to the like statement 


--before we go on, the general syntax of the LIKE operator is: [stringExpression] LIKE [formatExpression]
--The [stringExpression] is any expression that results in a string of characters 
--and [formatExpression] is a special string of characters that defines the matching condition.

--in this example: 
--[string expression] LIKE [format expression]
--last Name           LIKE 'M%'

-- so the way I'm doing this is with the like statement:  I look at the last name which is the column that's being evaluated and each column is a set 
--of characters or a sequence of characters and then the percent M is the rule by which the like statement is evaluating the last name


--There are two special characters for LIKE:
--"%" (the percentage character)  is a special character that can match on zero or more characters. 
--_ (underscore) is the second special character that matches exactly one character


--For example, we can show all people whose last name has the letter t as the third and has has exactly 3characters

SELECT  firstName,
        lastName
FROM    Person
WHERE   lastName LIKE '__t' --2 underscores

--For example, we can show all people whose last name starts with J and ends with t and has exactly 4 characters

SELECT  firstName,
        lastName
FROM    Person
WHERE   lastName LIKE 'J__t'--2 underscores

--For example, we can show all people whose last name has exactly 4 characters

SELECT firstName,
       lastName
FROM   Person
WHERE  lastName LIKE '____' --4 underscores


--We can combine the special characters:

--For example, we can show all people whose last name starts with the letter T and have at least 6 character

SELECT  firstName,
        lastName
FROM    Person
WHERE   lastName LIKE 'T_____%'--5underscores

--For example, we can show all people whose last name:
--contains a t
-- t must not be the first or last letter
--implies at least 3 characters

SELECT  firstName,
        lastName
FROM    Person
WHERE   lastName LIKE '%_t_%'

--In summary,
--LIKE is a comparison operator
--LIKE compares a character string to a format string
--"%" is a special character that can match on zero or more characters.
--_ (underscore) matches exactly one character