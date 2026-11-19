-- COUNT()
SELECT 
*
FROM Sales.Orders


/* 
   Calculate the Total Sales Across All Orders 
*/

SELECT 
COUNT(Sales) TotalSales
FROM Sales.Orders

/* 
   Find the Total Number of Orders and the Total Number of Orders for Each Customer
*/
SELECT 
OrderID,
OrderDate,
CustomerID,
COUNT(OrderID) OVER() [Total Orders],
COUNT(OrderID) OVER(PARTITION BY CustomerID) [OrdersByCustomers]
FROM Sales.Orders


/* 
   - Find the Total Number of Customers
   - Find the Total Number of Scores for Customers
   - Find the Total Number of Countries
*/

SELECT 
*,
COUNT(*) OVER() [Total Customers],
COUNT(Score) OVER() [Total No. of Scores],
COUNT(Country) OVER() [Total No. Of Countries]
FROM Sales.Customers


/* 
   Check whether the table 'OrdersArchive' contains any duplicate rows
*/
SELECT 
    * 
FROM (
    SELECT 
        *,
        COUNT(*) OVER(PARTITION BY OrderID) AS CheckDuplicates
    FROM Sales.OrdersArchive
) t
WHERE CheckDuplicates > 1

SELECT *
FROM Sales.OrdersArchive

-- SUM()
/* 
   - Find the Total Sales Across All Orders 
   - Find the Total Sales for Each Product
*/

SELECT
ProductID,
Sales,
SUM(Sales) OVER() TotalSales,
SUM(Sales) OVER(PARTITION BY ProductID) TotalSalesByProduct
FROM Sales.Orders

/* 
   Find the Percentage Contribution of Each Product's Sales to the Total Sales
*/

SELECT
    OrderID,
    ProductID,
    Sales,
    SUM(Sales) OVER () AS TotalSales,
    ROUND(CAST(Sales AS FLOAT) / SUM(Sales) OVER () * 100, 2) AS PercentageOfTotal
FROM Sales.Orders


/*
   Find the Average Scores of Customers
*/

SELECT 
*,
AVG(COALESCE(Score,0)) OVER() AVERAGE
FROM Sales.Customers

/* 
   Find all orders where Sales exceed the average Sales across all orders
*/
SELECT
    *
FROM (
    SELECT
        OrderID,
        ProductID,
        Sales,
        AVG(Sales) OVER () AS Avg_Sales
    FROM Sales.Orders
) t 
WHERE Sales > Avg_Sales

/* ============================================================
   SQL WINDOW AGGREGATION | AVG
   ============================================================ */

/* TASK 6:
   - Find the Average Sales Across All Orders 
   - Find the Average Sales for Each Product
*/
SELECT
    OrderID,
    OrderDate,
    Sales,
    ProductID,
    AVG(Sales) OVER () AS AvgSales,
    AVG(Sales) OVER (PARTITION BY ProductID) AS AvgSalesByProduct
FROM Sales.Orders

/* TASK 7:
   Find the Average Scores of Customers
*/
SELECT
    CustomerID,
    LastName,
    Score,
    COALESCE(Score, 0) AS CustomerScore,
    AVG(Score) OVER () AS AvgScore,
    AVG(COALESCE(Score, 0)) OVER () AS AvgScoreWithoutNull
FROM Sales.Customers

/* TASK 8:
   Find all orders where Sales exceed the average Sales across all orders
*/
SELECT
    *
FROM (
    SELECT
        OrderID,
        ProductID,
        Sales,
        AVG(Sales) OVER () AS Avg_Sales
    FROM Sales.Orders
) t 
WHERE Sales > Avg_Sales

/* ============================================================
   SQL WINDOW AGGREGATION | MAX / MIN
   ============================================================ */

/* TASK 9:
   Find the Highest and Lowest Sales across all orders
*/
SELECT 
    MIN(Sales) AS MinSales, 
    MAX(Sales) AS MaxSales 
FROM Sales.Orders

/* 
   Find the Lowest Sales across all orders and by Product
*/

SELECT 
    OrderID,
    ProductID,
    OrderDate,
    Sales,
    MIN(Sales) OVER () AS LowestSales,
    MIN(Sales) OVER (PARTITION BY ProductID) AS LowestSalesByProduct
FROM Sales.Orders

/* 
   Show the employees who have the highest salaries
*/

SELECT *
FROM (
	SELECT *,
		   MAX(Salary) OVER() HighestSalary
	FROM Sales.Employees
) t
WHERE Salary = HighestSalary

/* TASK 12:
   Find the deviation of each Sale from the minimum and maximum Sales
*/
SELECT
    OrderID,
    OrderDate,
    ProductID,
    Sales,
    MAX(Sales) OVER () AS HighestSales,
    MIN(Sales) OVER () AS LowestSales,
    Sales - MIN(Sales) OVER () AS DeviationFromMin,
    MAX(Sales) OVER () - Sales AS DeviationFromMax
FROM Sales.Orders

/* ============================================================
   Use Case | ROLLING SUM & AVERAGE
   ============================================================ */

/* TASK 13:
   Calculate the moving average of Sales for each Product over time
*/
SELECT
    OrderID,
    ProductID,
    OrderDate,
    Sales,
    AVG(Sales) OVER (PARTITION BY ProductID) AS AvgByProduct,
    AVG(Sales) OVER (PARTITION BY ProductID ORDER BY OrderDate) AS MovingAvg
FROM Sales.Orders

/* TASK 14:
   Calculate the moving average of Sales for each Product over time,
   including only the next order
*/
SELECT
    OrderID,
    ProductID,
    OrderDate,
    Sales,
    AVG(Sales) OVER (PARTITION BY ProductID ORDER BY OrderDate ROWS BETWEEN CURRENT ROW AND 1 FOLLOWING) AS RollingAvg
FROM Sales.Orders