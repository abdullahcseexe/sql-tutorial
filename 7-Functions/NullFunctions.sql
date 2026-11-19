------ISNULL(check_expression, replacement_value)
---------COALESCE(expression_1, expression_2, ..., expression_N)
---------Think of COALESCE as a priority list. If expression_1 fails, it falls back to expression_2. If that also fails, it falls back to expression_3, and so on.

/* TASK 1: 
   Find the average scores of the customers.
   Uses COALESCE to replace NULL Score with 0.
*/
SELECT
    CustomerID,
    Score,
    COALESCE(Score, 0) AS Score2,
    AVG(Score) OVER () AS  AvgScores,
    AVG(COALESCE(Score, 0)) OVER () AS AvgScores2
FROM Sales.Customers;

/* TASK 2: 
   Display the full name of customers in a single field by merging their
   first and last names, and add 10 bonus points to each customer's score.
*/
SELECT
   CustomerID,
   FirstName,
   lastName,
   FirstName + ' ' + COALESCE(LastName, '') [Full Name],
   Score,
   COALESCE(Score,0) + 10 [Bonus Score]
FROM Sales.Customers;

-- Imp: NULL=NULL is Unknown so if in sql table it comes, it will exclude
-- so convert it to "" and ""="" results true so its included
/*
SELECT
    a.year,
    a.type,
    a.orders,
    b.sales
FROM Table1 a
JOIN Table2 b
    ON a.year = b.year
    AND a.type = b.type



SELECT
    a.year,
    a.type,
    a.orders,
    b.sales
FROM Table1 a
JOIN Table2 b
    ON a.year = b.year
    AND ISNULL(a.type, '') = ISNULL(b.type, '')
*/

--Sort the customers from lowest to highest scores, with NULL values appearing last.

SELECT
   CustomerID,
   Score,
   CASE WHEN score IS NULL THEN 1 ELSE 0 END Flag
FROM Sales.Customers
ORDER BY CASE WHEN score IS NULL THEN 1 ELSE 0 END, Score

-- NULLIF(val1,val2) -- if val1==val2 then null else val1
-- NULLIF(price,-1) -- price cannot be -ve so thats why we check and if price also -1 we change it to NULL
-- NULLIF(originalPrice,discount) 
-- preventing error of dviding by zero

/* 
   Find the sales price for each order by dividing sales by quantity.
   Uses NULLIF to avoid division by zero.
*/

SELECT
OrderID,
Sales,
Quantity,
Sales/NULLIF(Quantity,0) [(SalesPrice) Sales By Quantity]
FROM Sales.Orders

-- IS NULL and IS NOT NULL
/* 
   Identify the customers who have no scores 
*/

SELECT
   CustomerID,
   Score
FROM Sales.Customers
WHERE Score IS NULL

/* 
   Identify the customers who have scores 
*/

SELECT
    CustomerID,
    Score
FROM Sales.Customers
WHERE Score IS NOT NULL


/* 
   List all details for customers who have not placed any orders 
*/

SELECT
    c.CustomerID,
    c.FirstName
FROM Sales.Customers c
LEFT JOIN Sales.Orders o
ON c.CustomerID = o.CustomerID
WHERE o.OrderID IS NULL


/* T
   Demonstrate differences between NULL, empty strings, and blank spaces 
*/
WITH Orders AS (
    SELECT 1 AS Id, 'A' AS Category UNION
    SELECT 2, NULL UNION
    SELECT 3, '' UNION
    SELECT 4, '  '
)
SELECT 
    *,
    DATALENGTH(Category) AS LenCategory,
    TRIM(Category) AS Policy1,
    NULLIF(TRIM(Category), '') AS Policy2,
    COALESCE(NULLIF(TRIM(Category), ''), 'unknown') AS Policy3
FROM Orders;