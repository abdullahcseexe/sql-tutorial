use MyDatabase

-- Retrieve All Customer Data
SELECT * 
FROM customers

-- Retrieve All Order Data
SELECT *
FROM orders

-- Retrieve Customers name,country and score
SELECT 
	first_name,
	country,
	score
FROM customers

-- Retrieve customers with score != 0 (Where clause)
SELECT
*
FROM customers
WHERE score!=0

-- Retrieve All customers and sort the results by highest score
SELECT *
FROM customers
ORDER BY score DESC --Lowest score ust change DESC to ASC

-- Retrieve customers, sort by country and then by high score
SELECT *
FROM customers
ORDER BY 
country ASC,
score DESC

-- find total score of each country (Group By)
SELECT
country,
sum(score) AS total_sum
FROM customers
GROUP BY country

--find total score and total num of customers in each country
SELECT 
country,
sum(score) AS total,
count(id) AS customer_freq
FROM customers
GROUP BY country

/* Find the average score for each country
considering only customers with a score not equal to 0
and return only those countries with an average score greater than 430
*/
SELECT
country,
AVG(score) as avg
FROM customers
WHERE score!=0
GROUP BY country
HAVING AVG(score)>430

-- Return Unique List of All Countries
SELECT DISTINCT
country
FROM customers

-- Retrieve only 3 customers
SELECT TOP 3
*
FROM customers

-- Retrieve the Top 3 Customers with the Highest Scores
SELECT TOP 3
*
FROM customers
ORDER BY score DESC

-- Retrieve the Lowest 2 Customers based on the Score
SELECT TOP 2
*
FROM customers
ORDER BY score ASC

-- Get two most recent orders
SELECT TOP 2
*
FROM orders
ORDER BY order_date DESC

/*
the way

SELECT TOP 2 
    Col1, 
    SUM(Col2) AS TotalSum
FROM Table
WHERE Col1 = 10
GROUP BY Col1
HAVING SUM(Col2) > 30
ORDER BY SUM(Col2) DESC;

*/