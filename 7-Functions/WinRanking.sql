  /* ==============================================================================
   SQL Window Ranking Functions
-------------------------------------------------------------------------------
   These functions allow you to rank and order rows within a result set 
   without the need for complex joins or subqueries. They enable you to assign 
   unique or non-unique rankings, group rows into buckets, and analyze data 
   distributions on ordered data.

   Table of Contents:
     1. ROW_NUMBER
     2. RANK
     3. DENSE_RANK
     4. NTILE
     5. CUME_DIST
=================================================================================
*/

/* ============================================================
   SQL WINDOW RANKING | ROW_NUMBER, RANK, DENSE_RANK
   ============================================================ */

/* 
   Rank Orders Based on Sales from Highest to Lowest
*/

--- integer based

-- in ranking, order by is very much necessary
--ROW_NUMBER() gives every row a unique number (1, 2, 3, 4), 
--while RANK() gives tied rows the same number and skips the next number (1, 2, 2, 4).
-- RANK can also skip ranks while ROW_NUMBER never skip ranks
SELECT 
OrderID,
CustomerID,
Sales,
ROW_NUMBER() OVER(ORDER BY Sales DESC) [Rank]
FROM Sales.Orders

SELECT 
OrderID,
CustomerID,
Sales,
RANK() OVER(ORDER BY Sales DESC) [Rank]
FROM Sales.Orders

-- DENSE_RANK() handles ties like RANK() but it doesnt skip any ranking unlike RANK()

SELECT 
OrderID,
CustomerID,
Sales,
ROW_NUMBER() OVER(ORDER BY Sales DESC) [Rank-ROW],
RANK() OVER(ORDER BY Sales DESC) [Rank-RANK],
DENSE_RANK() OVER(ORDER BY Sales DESC) [Rank-DENSE]
FROM Sales.Orders

/* 
   Use Case | Top-N Analysis: Find the Highest Sale for Each Product
*/
SELECT *
FROM(
SELECT 
    OrderID,
    CustomerID,
    ProductID,
    Sales,
    ROW_NUMBER() OVER(PARTITION BY ProductID ORDER BY Sales DESC) [RankProduct]
FROM Sales.Orders) AS Total
WHERE RankProduct = 1

/* 
   Use Case | Bottom-N Analysis: Find the Lowest 2 Customers Based on Their Total Sales
*/

SELECT*
FROM(
SELECT 
    CustomerID,
    SUM(Sales) TotalSales,
    ROW_NUMBER() OVER(ORDER BY SUM(Sales)) CUSTOrank
FROM Sales.Orders
GROUP BY CustomerID
) AS CustomerRanking
WHERE CUSTOrank <=2

/* 
   Use Case | Assign Unique IDs to the Rows of the 'Order Archive'
*/

SELECT
    ROW_NUMBER() OVER(ORDER BY CreationTime,OrderID) UniqueID,
    *
FROM Sales.OrdersArchive

/* 
   Use Case | Identify Duplicates:
   Identify Duplicate Rows in 'Order Archive' and return a clean result without any duplicates
*/
SELECT *
FROM(
SELECT
    *,
    ROW_NUMBER() OVER(PARTITION BY OrderID ORDER BY CreationTime DESC) RankingDupli
FROM Sales.OrdersArchive ) 
AS Tempo
WHERE RankingDupli = 1


/* ============================================================
   SQL WINDOW RANKING | NTILE
   ============================================================ */


   /*
NTILE(N) Distribution Formula:
- Base Bucket Size  = FLOOR(Total_Rows / N)
- Extra-Row Buckets = Total_Rows % N  (First R buckets get Base Size + 1)

Example: 10 rows with NTILE(3) -> 10 / 3 = 3 remainder 1
- Bucket 1: 4 rows
- Bucket 2: 3 rows
- Bucket 3: 3 rows
*/


/* 
   Divide Orders into Groups Based on Sales
*/
SELECT 
    OrderID,
    Sales,
    NTILE(1) OVER (ORDER BY Sales) AS OneBucket,
    NTILE(2) OVER (ORDER BY Sales) AS TwoBuckets,
    NTILE(3) OVER (ORDER BY Sales) AS ThreeBuckets,
    NTILE(4) OVER (ORDER BY Sales) AS FourBuckets,
    NTILE(2) OVER (PARTITION BY ProductID ORDER BY Sales) AS TwoBucketByProducts
FROM Sales.Orders;

/* 
   Segment all Orders into 3 Categories: High, Medium, and Low Sales.
*/
SELECT
    OrderID,
    Sales,
    Buckets,
    CASE 
        WHEN Buckets = 1 THEN 'High'
        WHEN Buckets = 2 THEN 'Medium'
        WHEN Buckets = 3 THEN 'Low'
    END AS SalesSegmentations
FROM (
    SELECT
        OrderID,
        Sales,
        NTILE(3) OVER (ORDER BY Sales DESC) AS Buckets
    FROM Sales.Orders
) AS SalesBuckets;

-- percentage based

/*
  SIMPLE POSITION FORMULAS:
  - CUME_DIST()    = Row_Position / Total_Rows             (Uses LAST position if tied)
  -> Does NOT start at 0 (starts at 1/Total_Rows, ends at 1)

  - PERCENT_RANK() = (Row_Position - 1) / (Total_Rows - 1) (Uses FIRST position if tied)
  -> STARTS at 0 (first row is always 0, ends at 1)
*/

SELECT 
    Product,
    Price,
    DistRank,
    CONCAT(DistRank * 100, '%') AS DistRankPerc
FROM (
    SELECT
        Product,
        Price,
        CUME_DIST() OVER (ORDER BY Price DESC) AS DistRank
    FROM Sales.Products
) AS PriceDistribution
WHERE DistRank <= 0.4;