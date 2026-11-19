--- SQL CASE Statement

/*
   Create a report showing total sales for each category:
	   - High: Sales over 50
	   - Medium: Sales between 20 and 50
	   - Low: Sales 20 or less
   The results are sorted from highest to lowest total sales.
*/

use SalesDB

SELECT
Category,
SUM(Sales) AS TotalSales
FROM(
	SELECT 
	OrderID,
	Sales,
	CASE 
		 WHEN Sales>50  THEN 'High'
		 WHEN Sales>20 AND Sales<=50 THEN 'Medium'
		 ELSE 'Low'
	END Category
	FROM Sales.Orders
)t
GROUP BY Category
ORDER BY TotalSales DESC

-- Retrive employee details with gender displayed as full text
SELECT
EmployeeID,
FirstName,
LastName,
Gender,
CASE
    WHEN Gender = 'F' THEN 'Female'
    WHEN Gender = 'M' THEN 'Male'
    ELSE 'Not Avaiable'
END GenderFullText
FROM Sales.Employees

/* 
   Retrieve customer details with abbreviated country codes 
*/

SELECT
    CustomerID,
    FirstName,
    LastName,
    Country,
    CASE 
        WHEN Country = 'Germany' THEN 'DE'
        WHEN Country = 'USA'     THEN 'US'
        ELSE 'n/a'
    END AS CountryAbbr
FROM Sales.Customers;
-- another syntax
SELECT
    CustomerID,
    FirstName,
    LastName,
    Country,
    CASE Country
        WHEN 'Germany' THEN 'DE'
        WHEN 'USA'     THEN 'US'
        ELSE 'n/a'
    END AS CountryAbbr
FROM Sales.Customers;

/*
   Calculate the average score of customers, treating NULL as 0,
   and provide CustomerID and LastName details.
*/

SELECT 
CustomerID,
score,
CASE
    WHEN score IS NOT NULL THEN score
    ELSE 0
END scoreNUllCheck,
AVG(Score) OVER() AvgCus,
AVG(
CASE
    WHEN score IS NOT NULL THEN score
    ELSE 0
END) OVER() avgCusCleaned
FROM Sales.Customers

/* 
   Count how many orders each customer made with sales greater than 30 
*/
SELECT
    OrderID,
    CustomerID,
    Sales,
    CASE
        WHEN Sales>30 THEN 1
        ELSE 0
    END Flag
FROM Sales.Orders
ORDER BY CustomerID

SELECT
    CustomerID,
    SUM(CASE
        WHEN Sales>30 THEN 1
        ELSE 0
    END) FREQ
FROM Sales.Orders
GROUP BY CustomerID

