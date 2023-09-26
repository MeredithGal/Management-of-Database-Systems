-- Tabitha Hagen
-- Week 7 Assignment 7      Complex Query Assignment (Project) 


------------------------------------------------------------------------------------------------------------
-- Data Model: The table diagram below describes the Zion Bookstore database, which tracks books, customers, and sales. You can find the tables below in the Northwind database:
   -- Author (ID, FirstName, LastName, BirthDate)
   -- BookAuthor(AuthorID, BookID): Primary key consists of both Foreign keys
   -- Book (ID, Title, Publisher, Category, Price)
   -- Sale (ID, BookID, CustomerID, UnitPrice, Quantity, Date)
   -- Customer (ID, FirstName, LastName, Address, City, State, Zip)

-- Task: The Zion Bookstore wants to know which books a single author wrote generated the most sales to customers from Colorado or Oklahoma in February 2020. The information required to answer this question is spread across several tables, requiring a complex query to answer the question.

-- Tips: 
   -- Grouping by state and book - The result table must show the total sales per book and form.
   -- Filtering states and dates - The result table should only show results from Colorado and Oklahoma. Only purchases made during February 2020 should be considered. All the filtering criteria must be specified in the query's WHERE clause.
   -- Books with a single author - The result table should contain only one author. A row in BookAuthor assigns one author to one book. Ex: A row with AuthorID = 5 and BookID = 103 means the author 5 wrote book 103. Books with multiple authors have multiple rows, so a subquery that examines the number of rows in BookAuthor for a given book ID can limit the results to single-author books.

------------------------------------------------------------------------------------------------------------
USE Northwind                 -- Define which database to use
------------------------------------------------------------------------------------------------------------

-- Let's look at the Author table (ID 1-8, FirstName, LastName, BirthDate)
 --SELECT * FROM [Author]              -- Need Author_ID  
-------------------------------------- Results in table with 8 rows, 5 columns

--Let's look at the BookAuthor table (AuthorID 1-8, BookID 100-105)
 --SELECT * FROM [BookAuthor]         -- Need Author_ID, Book_ID  
-------------------------------------- Results in table with 8 rows and 2 columns

--Let's look at the Book table (ID 100-05, Title, Publisher, Category, Price)
 --SELECT * FROM [Book]               -- Need Book_ID, Title, Category, Price  
-------------------------------------- Results in table with 6 rows and 5 columns

--Let's look at the Sale table (ID 1-19, CustomerID 1-7, BookID 100-105, UnitPrice, Quantity, Date)
 --SELECT * FROM [Sale]                -- Need Sale_ID, Customer_ID, Book_ID, Max(Quantity), Customer_ID  
-------------------------------------- Results in table with 19 rows and 6 columns

--Let's look at the Customer table (ID 1-8, FirstName, LastName, Address, City, State, Zip)
 --SELECT * FROM [Customer]            -- Need Customer_ID, State = Colorado/Oklahoma  
-------------------------------------- Results in table with 8 rows and 7 columns

------------------------------------------------------------------------------------------------------------
-- Task: The Zion Bookstore wants to know which books a single author wrote generated the most sales to customers from Colorado or Oklahoma in February 2020. The information required to answer this question is spread across several tables, requiring a complex query to answer the question.
------------------------------------------------------------------------------------------------------------

------------------ Book Title with Correct Author Count -------------------
--SELECT Book.Title AS [Book Title], Count(BookAuthor.AuthorID) AS [Author Count]
--FROM BookAuthor INNER JOIN Book ON BookAuthor.BookID = Book.ID
--GROUP BY Book.Title Having COUNT(BookAuthor.AuthorID) = 1
--ORDER BY Book.Title DESC
-------------------------------------- Results in table with 4 rows and 2 columns

SELECT  TOP 2                                                    -- There were two results given and I am unsure why
   Book.Title AS [Book Title],                                   -- List the Book Title Column
   Author.FirstName AS [Author's First Name],                    -- List the Author's First Name  Column
   Author.LastName AS [Author's Last Name],                      -- List the Author's Last Name Column
   SUM(Sale.Quantity) * Sale.UnitPrice AS [Total Sales Revenue]  -- List the Total Revenue (as opposed to Total Sales of Books) 
FROM BookAuthor                                                  -- From the BookAuthor table   
   INNER JOIN Book ON BookAuthor.BookID = Book.ID                -- Join BookAuthor and Book tables
   INNER JOIN Sale ON  BookAuthor.BookID = Sale.BookID           -- Join BookAuthor and Sale tables
   INNER JOIN Author ON BookAuthor.AuthorID = Author.ID          -- Join BookAuthor and Author tables
   INNER JOIN Customer ON BookAuthor.AuthorID = Customer.ID      -- Join BookAuthor and Customer tables

WHERE  BookAuthor.BookID IN                                      -- Where the BookID is in
   --(SELECT Book.Title, Count(BookAuthor.AuthorID) FROM BookAuthor INNER JOIN Book ON BookAuthor.BookID = Book.ID GROUP BY Book.Title Having COUNT(BookAuthor.AuthorID) = 1 )
   (SELECT BookAuthor.BookID FROM BookAuthor GROUP BY BookID HAVING Count(*) = 1)   -- a table with books ahving 1 author
   AND Year(Sale.Date) = 2020                                    -- a table where sales occurred only in 2020
   AND Month(Sale.Date) = 2                                      -- a table where sales occurred only in February 
   AND (Customer.[State] IN ('CO', 'OK'))                        -- a table where sales occurred only in Colorado or Oklahoma

GROUP BY Book.Title,Author.LastName, Author.FirstName, Sale.UnitPrice -- Organize table
ORDER BY [Total Sales Revenue] DESC, Book.Title DESC             -- Sort by Total Sales Revenue, and then Book Title


-------------------------------------- Results in table with 2 rows and 4 columns (Book Title, Author's FirstName, Author's Last Name, Total Sale Revenue)

-- Provide one paragraph explaining the final answer based on your analysis and lessons learned from working on this problem --
-- The problem required nesting of queries.  My final answer gave 2 results and I was unable to give a top author without using the TOP function in the initial select statement.  I struggled to only include authors with 1 author, but could have easily given a chart with all Author Revenue values, in a sorted view.  I am certain there is a certain way that the nested subqueries should have been in a where statement but feel compelled to write programming in loops to count and solve issues where a calculated "Total" could loop through the table only keeping the highest value.  I believe that a method in the class that could have prevented some of this frustration would be if we students were given probems to debug or find the flaws in.  Or maybe, presented with a subquery in one fashion, rewrite in a certain prescribed way so that we caould examine the different ways of viewing it.  I feel as though I need a way of seeing values line by line as the code is executing such as I would see in Jupyter Notebook.  I need to examine what changes as each layer of the subquery is complete.