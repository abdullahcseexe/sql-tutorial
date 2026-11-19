-- Date & Time
---------------------------------Part Extraction---------------------------------------
use SalesDB

SELECT
OrderID,
CreationTime,
'2026-11-05' HardCoded,
GETDATE() Today
FROM Sales.Orders

-- Get year,month,day
SELECT
OrderID,
CreationTime,
YEAR(CreationTime) year,
MONTH(CreationTime) month,
DAY(CreationTIme) day
FROM Sales.Orders

-- Get year,month,day,quarter, week using DATEPART (stores int)
SELECT
OrderID,
CreationTime,
DATEPART(year,CreationTime) year,
DATEPART(month,CreationTime) month,
DATEPART(day,CreationTime) day,
DATEPART(quarter,CreationTime) quarter,
DATEPART(week, CreationTime) week
FROM Sales.Orders

-- Get month name and week day name using DATENAME (stores string)
SELECT
OrderID,
CreationTime,
DATENAME(month,CreationTime) month_name,
DATENAME(weekday, CreationTime) weekday_name
FROM Sales.Orders

-- DATETRUNC examples - gives datetime
-- resets to 0
-- 1-No need of seconds
-- 2-no need of minutes
-- 3-no need of hours
-- resets to 1
-- 4-no need of day 
-- 5-no need of month
SELECT
OrderID,
CreationTime,
DATETRUNC(minute,CreationTime) one,
DATETRUNC(hour,CreationTime) two,
DATETRUNC(day,CreationTime) three,
DATETRUNC(month,CreationTime) four,
DATETRUNC(year,CreationTime) five
FROM Sales.Orders


-- Use case (counting number of orders in each month)
SELECT
DATETRUNC(month, CreationTime) CreationMonth,
COUNT(OrderID)
FROM Sales.Orders
GROUP BY DATETRUNC(month, CreationTime)

-- can be done similarly for year (DATETRUNC or normal YEAR func also works)
-- End of month(EOMONTH)
SELECT
EOMONTH(CreationTime) EndOf_Month
FROM Sales.Orders

-- show all orders placed in month of febrauary
SELECT
*
FROM Sales.Orders
WHERE MONTH(CreationTime) = 2

-------------------------------Formatting and Casting--------------------------
-- FORMAT() - Returns a string only
SELECT
OrderID,
CreationTime,
FORMAT(CreationTIme, 'dd-MM-yyyy') IndianFormat, 
FORMAT(CreationTime, 'dd') dd,
FORMAT(CreationTime, 'ddd') ddd,
FORMAT(CreationTime, 'dddd') dddd,
FORMAT(CreationTime, 'MM') MM,
FORMAT(CreationTime, 'MMM') MMM,
FORMAT(CreationTime, 'MMMM') MMMM
FROM Sales.Orders

/* 
   Display CreationTime using a custom format:
   Example: Day Wed Jan Q1 2025 12:34:56 PM
*/

SELECT
OrderID,
CreationTime,
 'Day ' + FORMAT(CreationTime, 'ddd') + ' '
+ FORMAT(CreationTime, 'MMM') + ' Q' +
DATENAME(quarter,CreationTIme) +
FORMAT(CreationTime, 'yyyy') + ' ' + FORMAT(CreationTime,'hh:mm:ss tt') CustomFormat
FROM Sales.Orders


SELECT
FORMAT(OrderDate,'MMM yy') OrderDate,
COUNT(*) SalesPer_Month
FROM Sales.Orders
GROUP BY FORMAT(OrderDate,'MMM yy')

---------------CONVERT----------------- any to any with format
SELECT
'123' String,
CONVERT(INT,'123') [String to Interger]

--- Convert datetime to date
SELECT
CreationTime,
CONVERT(DATE, CreationTime, 32) [Only Date],
CONVERT(VARCHAR, CreationTime, 32) [US FORMAT], --Refer to pdf page 51
CONVERT(VARCHAR, CreationTime, 34) [Euro FORMAT]
FROM Sales.Orders


------- CAST(This AS TYPE) any to any
-- one data type to another (no format can be specified)

SELECT
CAST('123' AS INT) AS [String to Int],
CAST(123 AS VARCHAR) AS [Int to String],
CAST(CreationTime AS DATE) [Datetime to Date]
FROM Sales.Orders
 


 ------------------------ Date Calculations ---------------------------
 -- DATEADD(part,interval,date)
SELECT
OrderDate,
DATEADD(year,2,OrderDate) [Two Years Later],
DATEADD(month,2,OrderDate) [Two Months Later],
DATEADD(day,-5,OrderDate) [5 days behind]
FROM Sales.Orders


-- DATEDIFF(year, startdate, enddate)
-- Calculate age of employees
SELECT
EmployeeID,
BirthDate,
DATEDIFF(year,BirthDate,GETDATE()) Age
FROM Sales.Employees

-- Average Shipping duration in days for each month
SELECT 
MONTH(OrderDate) OrderMonth,
AVG(DATEDIFF(day,OrderDate,ShipDate)) AvgShip
FROM Sales.Orders
GROUP BY MONTH(OrderDate) 

-- Time Gap Analysis
-- Find the number of days between each order and the previous order
SELECT 
OrderID,
OrderDate CurrentOrder,
LAG(OrderDate) OVER (ORDER BY OrderDate) PreviousDate, --Imp LAG() Function
DATEDIFF(day,LAG(OrderDate) OVER (ORDER BY OrderDate),OrderDate) [Difference between current and previous order]
FROM Sales.Orders

-- ISDATE()
SELECT
BirthDate,
ISDATE(FORMAT(BirthDate,'yyyy-MM-dd'))
FROM Sales.Employees
