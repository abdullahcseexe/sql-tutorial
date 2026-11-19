--Created a database,Created a table,Inserted values,Deletion of Row,Accessing Elements


Create database employee_details

use employee_details


CREATE TABLE Employees (
EmployeeID INT PRIMARY KEY,
FirstName VARCHAR(50),
LastName VARCHAR(50),
Department VARCHAR(50)
);

INSERT INTO Employees(EmployeeID,FirstName,LastName,Department)
VALUES
(01,'Abdul','Adil','Data Engineer'),
(02,'Khalid','Hossain','Software Tester'),
(03,'Jenny','Fernandes','Sales Executive')

--DELETE FROM Employees
--WHERE EmployeeID=1

SELECT * 
FROM Employees