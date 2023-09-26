-- GROUP BY - NULL Handling & Count
-- Minoo Modares

USE Northwind

-- see GROUP BY video

-- How do we handle NULL values in aggregation functions?

SELECT SUM(weight)/COUNT(ID)             AS [manual average weight],
       AVG(weight)                       AS [correct average weight],
       SUM(weight)/COUNT(ID)-AVG(weight) AS [difference]
FROM   Person

-- I'm summing up the weight and counting the number of people and then dividing and hoping that it's a correct average 
-- then I'm using the average function 
-- next I'm taking the difference between the two 

-- normally, you would expect these two averages to agree
-- but we have a person in the Person's table with a NULL weight:

SELECT *
FROM   Person
WHERE  weight IS NULL

-- so let's look at all the pieces to see what's happening

SELECT SUM(weight)              AS [total weight],
       COUNT(ID)                AS [number of records],
       SUM(weight)/COUNT(ID)    AS [manual average weight],
       AVG(weight)              AS [correct average weight]
FROM   Person

-- the problem here is that there are 11642 total records
-- but 11641 non-NULL weights (1 is NULL)

-- the sum function excludes the null because it's an unknown value, so the sum is calculated over 11641 records
-- $$$ the count function is counting up 11642 records $$$ 
-- then the sum divided by the incorrect number of Records gives me that manual average 

-- the AVG function handles the NULL appropriately and only considers 11641 records

-- in general, only non-NULL values are included in MIN, MAX, SUM, STDEV, VAR, AVG, etc.

-- $$$$$ SO,aggregation functions (except count) will appropriately handle NULL values $$$$$$

SELECT SUM(weight)              AS [Total Weight],  --the total weight of all people with non-null weights
       AVG(weight)              AS [Average Weight], --the average weight of all people with non-null weights
       STDEV(weight)            AS [Standard Deviation Weight], --the standard deviation weight of all people with non-null weights
       VAR(weight)              AS [Variance Weight]--the variance weight of all people with non-null weights
FROM   Person


-- note the difference in the two number returned below:

SELECT   COUNT(ID)       AS [number of non-NULL IDs],
         COUNT(weight)   AS [number of non-NULL weights]
FROM    Person

-- the Count function  will include records that have a NULL and non-NULL value in a specified field

-- but what about using an asterisk in a Count function?

SELECT   COUNT(*)          AS [count of people]
FROM     Person

-- an asterisk in the SELECT clause is shorthand for 'all fields'
-- so the above can be interpreted as: "check all fields for non-NULL values, and include any field has a non-NULL value"

-- And in a relational database, if a table has a primary key, then the table can be guaranteed to have at least one field that is non-NULL (the primary key field)

-- $$$$$ therefore, it is recommended that the asterisk should be avoided in the count function $$$$$
-- $$$$$ it is much clearer to count the primary key of the entity that you intend to count $$$$$

SELECT   COUNT(ID)          AS [count of people]
FROM     Person


--Another example:
-- note the difference in the two number returned below:

SELECT *
FROM   Person
WHERE  gender IS NULL  -- It shows all fields for the entry that has an empty gender field

-- you can see the difference in the two number using the query below from Assignment 4:
-- when using count(ID) you see the NULL but count(gender) doesn't see the NULL at all

SELECT    gender    AS [Gender],
          count(ID) AS [Count]
FROM      Person
GROUP BY  gender
ORDER BY  gender 

--versus:

SELECT    gender    AS [Gender],
          count(gender) AS [Count]
FROM      Person
GROUP BY  gender
ORDER BY  gender 


--Another example:
-- note the difference in the two number returned below:

SELECT * -- gives all the columns for entries with empty first names
FROM   Person
WHERE  firstname IS NULL

SELECT   COUNT(ID)          AS [number of non-NULL IDs],  -- #11642 - all of them
         COUNT(firstname)   AS [number of non-NULL firstname]  -- #11638 - NULLS left out
FROM    Person

-- you can see the difference in the two number using the query below from Assignment 4:

SELECT    firstName AS [First Name] ,
          count(ID) AS [Count] -- gives a column of non-NULL IDs (11642 - all of them) and a column of non-NULL fnames (11638) - NULLS left out
FROM      Person
GROUP BY firstName
ORDER BY firstName

SELECT    firstName AS [First Name] ,
          count(firstName) AS [Count]   -- includes NULL as the top entry and a 0 count and 1921 other fNames
FROM      Person
GROUP BY firstName
ORDER BY firstName