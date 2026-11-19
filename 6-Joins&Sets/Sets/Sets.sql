-- Combining Table Row-wise (using Sets)

use SalesDB

SELECT 
*
FROM Sales.Customers;

SELECT
*
FROM Sales.Employees;

/* 
   Combine the data from Employees and Customers into one table using UNION 
*/
-- UNION gives everything but no duplicates
SELECT 
FirstName,
LastName
FROM Sales.Customers
UNION
SELECT
FirstName,
LastName
FROM Sales.Employees;

/* 
   Combine the data from Employees and Customers include duplicates
*/
-- UNION ALL gives everything including duplicates 

SELECT 
FirstName,
LastName
FROM Sales.Customers
UNION ALL
SELECT
FirstName,
LastName
FROM Sales.Employees;

/* 
   Find employees who are NOT customers using EXCEPT 
*/

SELECT 
FirstName,
LastName
FROM Sales.Employees
EXCEPT
SELECT
FirstName,
LastName
FROM Sales.Customers;

/* 
   Find employees who are also customers 
*/
-- Intersect

SELECT 
FirstName,
LastName 
FROM Sales.Employees
INTERSECT
SELECT
FirstName,
LastName
FROM Sales.Customers;


/* 
   Combine order data from Orders and OrdersArchive into one report without duplicates 
*/

SELECT 'Orders' AS SourceTable,
    [OrderID]
    ,[ProductID]
    ,[CustomerID]
    ,[SalesPersonID]
    ,[OrderDate]
    ,[ShipDate]
    ,[OrderStatus]
    ,[ShipAddress]
    ,[BillAddress]
    ,[Quantity]
    ,[Sales]
    ,[CreationTime]   
FROM Sales.Orders
UNION
SELECT 'OrdersArchive' AS SourceTable,
    [OrderID]
    ,[ProductID]
    ,[CustomerID]
    ,[SalesPersonID]
    ,[OrderDate]
    ,[ShipDate]
    ,[OrderStatus]
    ,[ShipAddress]
    ,[BillAddress]
    ,[Quantity]
    ,[Sales]
    ,[CreationTime]
FROM Sales.OrdersArchive
ORDER BY OrderID;