-- DISTINCT - removing duplicates

-- suppose we want to know the list of suppliers in the Products table

SELECT   productname, SupplierID
FROM     Products

-- notice the repeats
-- to remove the repeats, I can do this:

SELECT   DISTINCT SupplierID  -- DISTINCT counts NULL as a Supplier
FROM     Products

-- you might be saying, why not just do this:
SELECT   SupplierID
FROM     Suppliers
Order by supplierID

-- my response is: that's a different list
-- it's the list of all suppliers in the supplier table

-- What I'm looking for is the list of all suppliers
-- in the products table

-- Let's look at another example:

SELECT   firstName  -- there are 4 NULLs and multiple people with the same fName
FROM     Person
ORDER BY firstName 

-- this is a list of all people's first names
-- as we scroll down, we'll start to see repeats
-- in other words, multiple people have the same firstname

-- now let's say we want a list of all first distinct firstnames

SELECT   DISTINCT firstName
FROM     Person
ORDER BY firstName 

-- Notice that 'distinct' doesn't know anything about primary keys or anything about the underlying table(s)
-- it doesn't give distinct Person records; there's a record returned for every unique firstname
-- it only considers values from the fields you provide

-- also note that NULL is considered to be a unique firstname

-- now consider this:

SELECT   DISTINCT lastname
FROM     Person

-- here, there's a record returned for every unique lastname , not the primary key

--Distinct vs. Group by

-- you might say, why not use Group By to do this?
-- like this:

SELECT   firstName
FROM     Person
GROUP BY firstName
ORDER BY firstName

-- logically, it returns the same records and always will
-- however, GROUP BY is a more complicated query
-- it sets up groups of records in preparation to calculate aggregates like SUM, COUNT, AVG, etc.

-- *** DISTINCT is much faster and simpler ***
-- if it sees a value it has seen before, it just throws it out
-- in other words, it doesn't group the records
-- it just makes a list of unique values

-- so, don't use GROUP BY when you what you  need is DISTINCT
-- use GROUP BY when you have aggregation functions

-- Also, the distinct applies to the *combination* of all the fields in the SELECT clause
-- in this example, all unique *combinations* of gender and firstname are shown

SELECT   DISTINCT 
         gender,
         firstname
FROM     Person
ORDER BY gender,
         firstname

-- in summary,
-- distinct removes duplicates
-- it removes duplicates based on all fields in the SELECT list

