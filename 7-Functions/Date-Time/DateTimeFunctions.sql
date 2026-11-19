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
-- FORMAT() - Returns a string
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
COUNT(*)
FROM Sales.Orders
GROUP BY FORMAT(OrderDate,'MMM yy')