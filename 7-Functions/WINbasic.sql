
/* 
   Calculate the Total Sales Across All Orders 
*/
SELECT
    SUM(Sales) AS Total_Sales
FROM Sales.Orders;

/* 
   Calculate the Total Sales for Each Product 
*/
SELECT 
    ProductID,
    SUM(Sales) AS Total_Sales
FROM Sales.Orders
GROUP BY ProductID; 

---OVER()

/* 
   Find the total sales across all orders,
   additionally providing details such as OrderID and OrderDate 
*/
SELECT 
    ProductID,
    OrderID,
    OrderDate,
    SUM(Sales) OVER() Total_Sales
FROM Sales.Orders

/* ==============================================================================
   SQL WINDOW FUNCTIONS | PARTITION CLAUSE
===============================================================================*/
-- PARTITION()
/* 
   Find the total sales across all orders and for each product,
   additionally providing details such as OrderID and OrderDate 
*/
SELECT
    OrderID,
    OrderDate,
    ProductID,
    Sales,
    SUM(Sales) OVER () AS Total_Sales,
    SUM(Sales) OVER (PARTITION BY ProductID) AS Sales_By_Product
FROM Sales.Orders;

 /* 
   Find the total sales across all orders, for each product,
   and for each combination of product and order status,
   additionally providing details such as OrderID and OrderDate 
*/

SELECT
    OrderID,
    OrderDate,
    ProductID,
    Sales,
    OrderStatus,
    SUM(Sales) OVER () AS Total_Sales,
    SUM(Sales) OVER (PARTITION BY ProductID) AS Sales_By_Product,
    SUM(Sales) OVER (PARTITION BY ProductID,OrderStatus) COMBO
FROM Sales.Orders;

SELECT * FROM Sales.Orders;

-- RANK() [have to use OVER() with arguement in it]
/* 
   Rank each order by Sales from highest to lowest */

SELECT 
    OrderID,
    OrderDate,
    Sales,
    RANK() OVER(ORDER BY Sales DESC) RankSales
FROM Sales.Orders

/* 
====================================================================================
WINDOW FRAME CLAUSE: ROWS BETWEEN [Start_Boundary] AND [End_Boundary]
====================================================================================
Example used below: ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING

[START BOUNDARY] (Lower Value) Options:
  - CURRENT ROW        : Start at the current row
  - N PRECEDING        : Start N rows before the current row
  - UNBOUNDED PRECEDING: Start from the very first row of the partition

[END BOUNDARY] (Higher Value) Options:
  - CURRENT ROW        : End at the current row
  - N FOLLOWING        : End N rows after the current row
  - UNBOUNDED FOLLOWING: End at the very last row of the partition
====================================================================================
*/

-- Should always be used with ORDER BY

/*  
   Calculate Total Sales by Order Status for current and next two orders 
*/
SELECT
    OrderID,
    OrderDate,
    ProductID,
    OrderStatus,
    Sales,
    SUM(Sales) OVER (
        PARTITION BY OrderStatus 
        ORDER BY OrderDate 
        ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING
    ) AS Total_Sales
FROM Sales.Orders;

/* 
   Calculate Total Sales by Order Status for current and previous two orders 
*/

SELECT
    OrderID,
    OrderDate,
    ProductID,
    OrderStatus,
    Sales,
    SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate 
    ROWS BETWEEN  2 PRECEDING AND CURRENT ROW 
    ) TotalSales
FROM Sales.Orders;

/* 
   Calculate Total Sales by Order Status from previous two orders only 
*/ -- shortcut but only works for preceding

SELECT
    OrderID,
    OrderDate,
    ProductID,
    OrderStatus,
    Sales,
    SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY OrderDate 
    ROWS 2 PRECEDING) TotalSales
FROM Sales.Orders;


/* 
   Calculate cumulative Total Sales by Order Status up to the current order 
*/
SELECT
    OrderID,
    OrderDate,
    ProductID,
    OrderStatus,
    Sales,
    SUM(Sales) OVER (
        PARTITION BY OrderStatus 
        ORDER BY OrderDate 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    ) AS Total_Sales
FROM Sales.Orders;