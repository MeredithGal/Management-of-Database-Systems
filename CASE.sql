--The CASE statement 

-- Example 1
-- The following example adjusts the suppliers' country names. 
-- Here, the result set will contain a field named Country Name along with SupplierID and Company Name.
-- The value of Country Name will be:

------United States of America if the country is USA
------United Kingdom if the country is UK
------Country Names as is if neither USA nor UK (because of the ELSE clause).

SELECT * from Suppliers;

SELECT SupplierID, CompanyName,
CASE
    WHEN country = 'USA' THEN 'United States of America'
    WHEN country = 'UK' THEN 'United Kingdom'
    ELSE Country
END AS [Country Name]
FROM Suppliers
WHERE Country IS NOT NULL
Order By [Country Name] DESC;

--In plain English, here's what's happening:

--for the first WHEN statement, the CASE statement checks each row to see if the conditional statement is true country = 'USA'.
--for any given row, if that conditional statement is true, 'United States of America' gets printed in the column that we have named [Country Name].
--for the second WHEN statement, the CASE statement checks each row to see if the conditional statement is true country = 'UK'.
--for any given row, if that conditional statement is true, 'United Kingdom' gets printed in the column that we have named [Country Name].
--In any row for which the conditional statement is false, nothing happens in that row, leaving the original country name in the [Country Name] column.
-- At the same time all this is happening, SQL is retrieving and displaying all the values in the SupplierID and CompanyName columns.


-- Example 2
--The following example displays the unit price as a text comment based on the price range of  a product.

SELECT * from Products;

SELECT ProductID,
    ProductName,
    CASE
        WHEN UnitPrice = 0 THEN 'not for resale'
        WHEN UnitPrice < 50 THEN 'Under $50'
        WHEN UnitPrice >= 50 AND UnitPrice < 250 THEN 'Under $250'
        WHEN UnitPrice >= 250 AND UnitPrice < 1000 THEN 'Under $1000'
        ELSE 'Over $1000'
END AS [Price Range]
FROM Products
ORDER BY [Price Range];


--hint you can write the above statement as below: 
SELECT ProductID,
    ProductName,
    [Price Range] = CASE
        WHEN UnitPrice = 0 THEN 'not for resale'
        WHEN UnitPrice < 50 THEN 'Under $50'
        WHEN UnitPrice >= 50 AND UnitPrice < 250 THEN 'Under $250'
        WHEN UnitPrice >= 250 AND UnitPrice < 1000 THEN 'Under $1000'
        ELSE 'Over $1000'
END 
FROM Products
ORDER BY [Price Range];