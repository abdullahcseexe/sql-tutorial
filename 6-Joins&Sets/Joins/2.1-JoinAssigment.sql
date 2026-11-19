/* ============================================================================== 
   MULTIPLE TABLE JOINS (4 Tables)
=============================================================================== */

/* Task: Using SalesDB, Retrieve a list of all orders, along with the related customer, product, 
   and employee details. For each order, display:
   - Order ID
   - Customer's name
   - Product name
   - Sales amount
   - Product price
   - Salesperson's name */

use SalesDB

SELECT 
	o.OrderID,
	c.FirstName AS CustomerFirstName,
	c.LastName AS CustomerLastName,
	p.Product,
	o.Sales,
	p.Price,
	o.Sales,
	e.FirstName AS SalesPersonFirstName,
	e.LastName AS SalesPersonLastName
FROM Sales.Orders AS o
LEFT JOIN Sales.Customers as c ON o.CustomerID=c.CustomerID
LEFT JOIN Sales.Products as p ON o.ProductID=p.ProductID
LEFT JOIN Sales.Employees as e ON o.SalesPersonID=e.EmployeeID