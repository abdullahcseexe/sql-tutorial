-- Comparison Operators
-- Select all customers from Germany
SELECT * 
FROM customers
WHERE country='Germany'

-- Select all customers not from Germany
SELECT * 
FROM customers
WHERE country!='Germany'

-- Retrieve all customers with score greater than 500
SELECT * 
FROM customers
WHERE score>500

-- Retrieve all customers with score of 500 or more
SELECT * 
FROM customers
WHERE score>=500

-- Retrieve all customers with score less than 500
SELECT * 
FROM customers
WHERE score<500

-- Retrieve all customers with score of 500 or less
SELECT * 
FROM customers
WHERE score<=500

-- Logical operators (AND,OR,etc)
-- Retrieve all customers who from USA and score greather than 500
SELECT *
FROM customers
WHERE country='USA' AND score>500

-- Retrieve all customers who from USA or score greather than 500
SELECT *
FROM customers
WHERE country='USA' OR score>500

-- Retrieve all customers with a score not less than 500 (NOT)
SELECT *
FROM customers
WHERE NOT score <500

-- Range operator (BETWEEN) (includes both lower and upper boundary)
/* Retrieve all customers whose score falls
in the range between 100 and 500 */
SELECT *
FROM customers
WHERE score BETWEEN 100 AND 500

/* Retrieve all customers from
either Germany or USA. */

-- We can use OR also

--Membership operator (IN and NOT IN)
SELECT *
FROM customers
WHERE country IN ('Germany','USA')

/* Retrieve all customers from
neither Germany nor USA. */

SELECT *
FROM customers
WHERE country NOT IN ('Germany','USA')

-- Search Operator (LIKE)
-- Find all customers whose first name starts with 'M'
SELECT *
FROM customers
WHERE first_name LIKE 'M%'

-- Find all customers whose first name end with 'n'
SELECT *
FROM customers
WHERE first_name LIKE '%n'

-- Find all customers whose first name contains 'r'
SELECT *
FROM customers
WHERE first_name LIKE '%r%'

-- Find all customers whose first name contains 'r' in 3rd place
SELECT *
FROM customers
WHERE first_name LIKE '__r%'