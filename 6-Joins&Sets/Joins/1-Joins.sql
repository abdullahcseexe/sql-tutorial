-- Columnwise combining table is done by sql joins
-- JOINS BASIC
/*
SELECT *
FROM A
INNER JOIN B
ON A.key = B.key
*/

-- No Join
/* Retrieve all data from customers and orders as separate results */
SELECT *
FROM customers

DELETE FROM customers
WHERE id=6

SELECT *
FROM orders

-- Inner join (only matching data from both tables, basically intersection) 
/* Get all customers along with their orders, 
   but only for customers who have placed an order */

SELECT 
	c.id,
	c.first_name,
	o.customer_id,
	o.order_date,
	o.sales
FROM customers AS c
INNER JOIN orders AS o
ON c.id=o.customer_id

-- LEFT JOIN (include everything on left)
/* Get all customers along with their orders, 
   including those without orders */
SELECT *
FROM customers AS c
LEFT JOIN orders AS o
ON c.id=o.customer_id

-- RIGHT JOIN (include everything on right)
/* Get all customers along with their orders, 
   including orders without matching customers */
SELECT *
FROM customers AS c
RIGHT JOIN orders AS o
ON c.id=o.customer_id

-- Alternative to RIGHT JOIN using LEFT JOIN (Just switch tables) 
/* Get all customers along with their orders, 
   including orders without matching customers */
SELECT *
FROM orders AS o
LEFT JOIN customers AS c
ON c.id=o.customer_id

-- FULL JOIN
/* Get all customers and all orders, even if there’s no match */
SELECT *
FROM orders AS o
FULL JOIN customers AS c
ON c.id=o.customer_id

-- JOINS ADVANCED

-- LEFT ANTI JOIN
/* Get all customers who haven't placed any order */
SELECT *
FROM customers AS c
LEFT JOIN orders AS o
ON c.id=o.customer_id
WHERE o.customer_id IS NULL

-- RIGHT ANTI JOIN
/* Get all orders without matching customers (get the orders whose customer data is unavailable)*/
-- Get the order whose id is not there in customers
SELECT *
FROM customers AS c
RIGHT JOIN orders AS o
ON c.id=o.customer_id
WHERE c.id IS NULL

-- Alternative to RIGHT ANTI JOIN using LEFT JOIN
/* Get all orders without matching customers */

SELECT *
FROM orders AS o
LEFT JOIN customers AS c
ON c.id=o.customer_id
WHERE c.id IS NULL


-- FULL ANTI JOIN
/* Find customers without orders and orders without customers */
SELECT *
FROM customers AS c
FULL JOIN orders AS o
ON c.id=o.customer_id
WHERE c.id IS NULL OR o.customer_id IS NULL

-- Alternative to INNER JOIN using LEFT JOIN
/* Get all customers along with their orders, 
   but only for customers who have placed an order */
SELECT *
FROM customers AS c
LEFT JOIN orders AS o
ON c.id=o.customer_id
WHERE  c.id IS NOT NULL AND o.customer_id IS NOT NULL

/* A CROSS JOIN produces a Cartesian product.
It matches every row from the first table
with every row from the second table.
No 'ON' clause is used. */

/* Generate all possible combinations of customers and orders */
SELECT *
FROM customers AS c
CROSS JOIN orders AS o

