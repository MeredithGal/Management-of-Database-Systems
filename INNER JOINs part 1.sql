USE Northwind

-- Let's look at our products and suppliers tables to figure out who is the supplier of each product
-- So, how do we get fields from both of those tables into one select statement?

--Let's look at all the columns of the table products

SELECT *
FROM    Products

--you can see the products table has a field called SupplierID which is a foreign key and that refers to the
-- primary key in the suppliers table. Each supplier provides many products 

-- So, let's look at the products table -- so what supplier is SupplierID 1? 2?

--Let's look at the columns in the suppliers table

SELECT *
FROM Suppliers

-- there we can read the company name and other information of each supplier

-- let's focus on a few columns from the products table

SELECT   ProductID,
         ProductName,
         SupplierID
FROM     Products
ORDER BY ProductID

--and the companyName from the suppliers table

SELECT   SupplierID,
         CompanyName
FROM     Suppliers
ORDER BY SupplierID

--Now, we can read the company name of each supplier
--we used the SupplierID field in the Suppliers table to "lookup" the name of the Suppliers
--we can do that for one or two products, but what happens when we have a million products 

-- why not just add the CompanyName column to the SELECT clause?
-- let's just  put the CompanyName 

SELECT   ProductID,
         ProductName,
         SupplierID,
         CompanyName
FROM     Products
ORDER BY ProductID
-- we will get a syntax error 'invalid column name companyname' because CompanyName is not a field in the Products table

--let's add the Suppliers table to the FROM statement
--here, we will add the suppliers as a list item in the FROM statement

SELECT   ProductID,
         ProductName,
         SupplierID,
         CompanyName
FROM     Products,
         Suppliers
ORDER BY ProductID

-- that got rid of the syntax error on CompanyName, but now SupplierID is ambiguous? What does that mean?

-- if we look at the columns list for each table: there's a SupplierID in both the Products table and the Suppliers table
-- so, we need to be more specific - which one do we mean?

-- here's how
--let's qualify the supplierID with the table products

SELECT   ProductID,
         ProductName,
         Products.SupplierID,
         CompanyName
FROM     Products,
         Suppliers
ORDER BY ProductID

-- now we don't have any syntax errors...great!

-- but we have 2340 rows! --> 30 suppliers x 78 products as shown in this cross-join
-- where is that coming from? we don't have that many suppliers or products

-- let's calculate the number of suppliers:

SELECT COUNT(SupplierID) AS [Supplier Count]
FROM   Suppliers

-- 30 Suppliers

-- let's calculate the number of products:

SELECT COUNT(ProductID) AS [ProductCount]
FROM   Products

-- 78 products

SELECT 30 * 78

-- 2340 - --so if I take the number of products and multiply it by the number of suppliers 
--it comes out to exactly that the number of records

--let's run this again:

SELECT   ProductID,
         ProductName,
         Products.SupplierID,
         CompanyName
FROM     Products,
         Suppliers
ORDER BY ProductID

-- let's add the SupplierID from the Suppliers table to the SELECT statement:

SELECT   ProductID,
         ProductName,
         Products.SupplierID,
         Suppliers.SupplierID,
         CompanyName
FROM     Products,
         Suppliers
ORDER BY ProductID

--  why is chai being shown next to the wrong Suppliers?  It's being shown next to *every* supplier
-- all products are shown next to every supplier

-- the reason is we haven't stated how the products and suppliers should be related

-- we didn't use join--we  list the two tables in the FROM clause 
-- we haven't specified how the records from suppliers and products should be matched
-- So, the database engine returns all possible combinations of products and suppliers ----- which is called a CROSS JOIN
-- this is sometimes what we want, but not usually

-- how do we limit the results to the records where supplierID in the products table 
-- is aligned with the supplierID in the suppliers table

-- the WHERE clause:

SELECT   ProductID,
         ProductName,
         Products.SupplierID,
         Suppliers.SupplierID,
         CompanyName
FROM     Products, --the first table in our statement is going to be our left table
         Suppliers
WHERE    Products.SupplierID = Suppliers.SupplierID 
ORDER BY ProductID

-- this is how we can limit the results
-- this looks a lot better
-- chai has a SupplierID = 1, and it is shown next to the Supplier with SupplierID = 1
-- but the record count is 77? -- aren't there 78 products?

-- let's look at the table products again

SELECT   ProductID,
         ProductName,
         SupplierID
FROM     Products
ORDER BY ProductID

-- if you scroll down, you can see that Pencils has a NULL SupplierID 
-- so, if you look back at the combined query, -- note that product Pencils doesn't appear
-- because in this case, Products.SupplierID is NULL 
-- and  Products.SupplierID= Suppliers.SupplierID is False-- NULL is not equal to Suppliers.SupplierID 

--So, here is joining to tables using a constraint in the WHERE clause

--*******************************************************
SELECT   Products.ProductID,
         Products.ProductName,
         Products.SupplierID,
         Suppliers.SupplierID,
         CompanyName
FROM     Products,
         Suppliers
WHERE    Products.SupplierID = Suppliers.SupplierID 
ORDER BY ProductID
--*******************************************************

-- here we are joining two tables using a special condition between the PK of one table and the FK in another table
-- You choose all possible combinations of the records from two tables 
-- and then remove the ones that don't have equal PK--FK combinations. *NULL, in this case.

-- We can also use the JOIN...ON operator
-- we combine the tables in a specific way to create a particular set of records then show fields from the combined set of records. 
-- The JOIN.. ON operator is a binary operator between two tables,  with an ON clause to specify details that the operator will use.

--*******************************************************
SELECT   ProductID,
         ProductName,
         Suppliers.SupplierID,
         CompanyName
FROM     Products 
    JOIN     Suppliers ON Products.SupplierID = Suppliers.SupplierID
ORDER BY ProductID
--*******************************************************
-- these two methods will always return the same results (JOIN.. ON and the WHERE clause)

-- I would recommend that you learn both methods-- so you can read either way when you encounter it
-- also, sometimes one way is more precise than another in a specific context

-- the JOIN syntax signals your *intention* better than the WHERE clause and generally organizes your statement better 
-- it is *not* a list of tables (separated by commas), but an expression that states how to combine the tables

-- another recommendation:
-- whenever there is more than one table, fully **qualify** every field in every clause:

SELECT   Products.ProductID,
         Products.ProductName,
         Suppliers.CompanyName
FROM     Products 
    JOIN     Suppliers    ON Products.SupplierID = Suppliers.SupplierID
ORDER BY Products.ProductID

--OR We can use Aliases for our tables to make things simpler

SELECT   p.ProductID,
         p.ProductName,
         s.CompanyName
FROM     Products p 
    JOIN     Suppliers s  ON p.SupplierID = s.SupplierID
ORDER BY p.ProductID

--We can join two tables as long as they are connected
-- Since the products table is connected to the categories table, 
-- we can also look up the categories of each product by joint the tables Categories and Products

SELECT   Products.ProductName,
         Suppliers.CompanyName,
         Categories.CategoryName
FROM     Products  
    JOIN     Suppliers   ON Products.SupplierID = Suppliers.SupplierID
    JOIN     Categories  ON Products.CategoryID = Categories.CategoryID
ORDER BY Products.ProductID



--using Alias

SELECT   p.ProductName,
         s.CompanyName,
         c.CategoryName
FROM     Products p 
    JOIN     Suppliers s   ON p.SupplierID = s.SupplierID
    JOIN     Categories c  ON p.CategoryID = c.CategoryID
ORDER BY p.ProductID

-- this is a 3-table join

-- Anywhere there is a line between tables in your database, you can connect/join those tables. 


