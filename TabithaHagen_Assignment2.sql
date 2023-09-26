-- Tabitha Hagen
-- Week 2 Assignment 2

USE Northwind   -- Define which database to use
SELECT * FROM Products   -- View original table
SELECT * FROM Customers   -- View original table

 -- TASK:  We want to check the status of the products we have in our inventory and also learn more about our customers. 

-- From the Products table:

   --> 1. Select product ID and product name. Order by product name.

SELECT ProductID, ProductName    -- List the Product Name and ID
From Products                    -- The Table source
ORDER BY ProductName ASC         -- The order of the columns within the SELECT statement

   --> 2. Select product ID, product name, and the total inventory value for each product. The total value is found by multiplying units in stock and unit price. Name the new column [inventory value]. Order by inventory value descending.

SELECT ProductID,                                -- List the Product ID
       ProductName,                              -- List the Product Name
       (UnitsInStock * UnitPrice) AS Total_Value -- List Total Value calculated by the Units in Stock and price
From Products                    -- The Table source
ORDER BY ProductName ASC         -- The order of the columns within the SELECT statement

-- From the Customers table:

   --> 3. Show the customer ID, contact name, and contact's last name. Rename the columns to [ID], [contact full name], and [contact last name]—order by contact names. You need to use the RIGHT(), the CHARINDEX(), and the LEN() functions.

      ---> RIGHT(the string to extract from, the number of characters to extract)

 SELECT   (CustomerID) AS 'ID',                       -- List the Customer ID
          ContactName AS 'Contact Full Name',         -- List the Contact Full Name column
          --LEN(ContactName) - (CHARINDEX(' ', REVERSE(ContactName))-1) AS '# of chars to extract',  -- Create a column with # of characters to extract
          RIGHT(ContactName, (CHARINDEX(' ', REVERSE(ContactName))-1)) AS 'Contact Last Name'  -- Create the Last Name column with from ContactName
From Customers                                        -- The Table source
WHERE ContactName IS NOT NULL                         -- Don't include Null values
ORDER BY ContactName ASC                              -- The order of the columns within the SELECT statement

   --> 4. Show the customer ID, company name, and City and Country concatenated together with a comma (Use the plus sign). The city, Country should be all in one column called [Address]. For example, Paris, France. 

SELECT   (CustomerID) AS 'Customer ID',                       -- List the Customer ID
          CompanyName AS 'Company Name',              -- List the Contact Full Name column
          (City + ', ' + Country) AS [Address]       -- Concatenate City and Country into Address column
From Customers                                       -- The Table source
WHERE Country IS NOT NULL                         -- Don't include Null values
ORDER BY Country ASC                              -- The order of the columns within the SELECT statement