-- HW7: CASE
-- Tabitha Hagen

USE Northwind

---------------------------------------------------------------------
-- CASE statement: From the table Suppliers - 
  -- list all suppliers' company names and a field called supplier type. We want to know whether the supplier is domestic or foreign. 
  -- If the supplier is based in the USA, it is domestic. Else, it is a foreign supplier.
---------------------------------------------------------------------

------------------- Looking at the Suppliers table ------------------
SELECT *
FROM    Suppliers      
------------------------ 30 rows, 12 columns ------------------------

---------------------------------------------------------------------

SELECT   Suppliers.CompanyName AS [Company Name],          -- List the Company Name Column from the Suppliers Table 
         Suppliers.Country AS [Country Name],              -- List the Country Name Column from the Suppliers Table 
   CASE  WHEN  Suppliers.Country = 'USA' THEN 'Domestic'   -- List the Supplier type derived from the Country Column from the Suppliers Table 
      ELSE 'Foreign'                                       -- List the Supplier type derived from the Country Column from the Suppliers Table 
   END AS [Supplier Type]                                  -- End Case ... End Statement
FROM Suppliers                                             -- From Suppliers Table
WHERE Suppliers.Country IS  NOT NULL                       -- For values without a NULL which are not included in the result
ORDER BY [Country Name];                                   -- Put in order by the COuntry Names 

------------------------ 29 rows, 3 columns ------------------------
---------------------------------------------------------------------