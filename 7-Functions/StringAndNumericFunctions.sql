-- String ---

-- CONCAT() - String Concatenation
-- Concatenate first name and country into one column

SELECT
first_name,
country,
CONCAT(first_name,'-',country) AS Info
FROM customers

-- LOWER() & UPPER() - Case Transformation
-- Convert the first name to lowercase

SELECT 
first_name,
LOWER(first_name) as lowerd_firstname
FROM customers

-- Convert the first name to uppercase
SELECT 
first_name,
UPPER(first_name) AS upperd_firstname
FROM customers

-- TRIM() - Remove White Spaces
-- Find customers whose first name contains leading or trailing spaces
SELECT 
*,
LEN(first_name) AS LengthName
FROM customers
WHERE first_name != TRIM(first_name)

-- REPLACE
SELECT
first_name,
country,
CONCAT(first_name,'.,;',country) AS Info,
REPLACE(CONCAT(first_name,'.,;',country), '.,;','-') AS InfoUpdated
FROM customers

-- LEN
SELECT 
    first_name, 
    LEN(first_name) AS name_length
FROM customers

-- LEFT and RIGHT
-- Retrieve the first two characters of each first name 
-- Retrieve the first two characters of each first name	
SELECT 
    first_name,
    RIGHT(TRIM(first_name), 2) AS last_2,
    LEFT(TRIM(first_name), 2) AS first_2
FROM customers

-- SUBSTRING(val,start,length)
-- extracts part of string
SELECT 
    first_name,
    SUBSTRING(TRIM(first_name), 2, 2) AS extracted
FROM customers

--- Numeric-----

/* ============================================================================== 
   ROUND() - Rounding Numbers
=============================================================================== */

-- Demonstrate rounding a number to different decimal places
SELECT 
    3.516 AS original_number,
    ROUND(3.516, 2) AS round_2,
    ROUND(3.516, 1) AS round_1,
    ROUND(3.516, 0) AS round_0

/* ============================================================================== 
   ABS() - Absolute Value
=============================================================================== */

-- Demonstrate absolute value function
SELECT 
    -10 AS original_number,
    ABS(-10) AS absolute_value_negative,
    ABS(10) AS absolute_value_positive