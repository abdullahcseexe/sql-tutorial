SELECT *
FROM customers

INSERT INTO customers(id,first_name,country,score)
VALUES
(6,'Abdul','Australia',930),
(7,'Debanik',NULL,700),
(8,'Khalid','Australia',NULL),
(9,'David',NULL,NULL)

-- Copy data from customers to persons
-- First select then insert into the destination table
INSERT INTO persons(id,person_name,birth_date,phone)
SELECT 
id,
first_name,
NULL,
'Unknown'
FROM customers

SELECT * FROM persons

-- Update (use where when using udpate orelse every row would be affected)
-- Change score of customer 7 score to 0

UPDATE customers
SET score=0
WHERE id=7

SELECT * 
FROM customers

-- change country of customer 7 to Brazil
UPDATE customers
SET country='Brazil'
WHERE id = 7

-- Update all customers who have NULL by setting it to 0
UPDATE customers
SET score=0
WHERE score IS NULL

-- Update all customers with country as NULL into Finland
UPDATE customers
SET country='Finland'
WHERE country IS NULL

--- Deleting row
-- Delete all customers with id greater than 6
DELETE FROM customers
WHERE id>6

-- delete all data from persons table
DELETE FROM persons

SELECT * FROM persons