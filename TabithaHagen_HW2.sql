-- HW2 - Tables and SELECT 
-- Tabitha Hagen

USE Northwind

-- 1. From the table Employees: Show the last name and firstname like this "Smith, Janet" in a single column, then the title and hire date of all employees. Title the columns and [Full Name], [Title], and [Date of Hire]. Order the employees by hire date descending so the new employees are at the top.

SELECT   (LastName + ', ' + FirstName) AS [Full Name],  -- Concatenate FirstName and LastName into Full Name
          Title,        -- List the Title column
          HireDate AS 'Date of Hire'  -- List the Hiredate column with new name
FROM Employees          -- The Table source
ORDER BY HireDate DESC  -- The order of the columns within the SELECT statement


 -- 2. Bonus - From the table Suppliers: Show the SupplierID, contact names, and contacts' first names. Rename the columns to [ID], [contact full name], and [contact first name]—order by contact names. You need to use the LEFT () function:  

 SELECT   (SupplierID) AS 'ID', -- List SupplierID Column
          ContactName AS 'Contact Full Name',        -- List the Title column
         --LEN(ContactName) - CHARINDEX(' ', ContactName) AS '# of chars to extract',  -- Create a column with # of characters to extract
          LEFT(ContactName, (CHARINDEX(' ', ContactName)-1 )) AS 'Contact First Name'  -- Create the First Name column with from ContactName
FROM Suppliers   -- The Table source
WHERE ContactName IS NOT NULL -- Don't include Null values
ORDER BY ContactName -- The order of the columns within the SELECT statement