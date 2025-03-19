CREATE DATABASE company_db;

USE company_db;

CREATE TABLE departments (
    dept_id INT AUTO_INCREMENT PRIMARY KEY,
    dept_name VARCHAR(100) NOT NULL
);

CREATE TABLE employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    salary DECIMAL(10,2) NOT NULL,
    dept_id INT,
    join_date DATE NOT NULL,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id) ON DELETE CASCADE
);

INSERT INTO departments (dept_name)
VALUES 
    ('HR'),
    ('Finance'),
    ('IT'),
    ('Marketing'),
    ('Operations');

INSERT INTO employees (first_name, last_name, email, salary, dept_id, join_date)
VALUES 
('Suresh', 'Reddy', 'suresh.reddy@example.com', 52000.00, 1, '2022-02-10'),     
('Vijay', 'Prathap', 'vijay.prathap@example.com', 61000.00, 2, '2021-07-12'),  
('Ravi', 'Kumar', 'ravi.kumar@example.com', 78000.00, 3, '2023-04-05'),    
('Meera', 'Krishnan', 'meera.krishnan@example.com', 56000.00, 4, '2020-08-18'),        
('Vignesh', 'Karthick', 'vignesh.karthick@example.com', 69000.00, 5, '2019-11-22'),    
('Shyam', 'Prasanth', 'shyam.prasanth@example.com', 73000.00, 3, '2022-05-30'),        
('Karthik', 'Shetty', 'karthik.shetty@example.com', 59000.00, 1, '2021-12-09');

-- Retrieve all employees' details.
SELECT * FROM employees; 

-- Retrieve all employees in the IT department.
SELECT * FROM employees WHERE dept_id=
(SELECT dept_id FROM departments WHERE dept_name='IT');

-- Retrieve employees who earn more than 80,000.
SELECT first_name, last_name, email, salary FROM employees WHERE salary>80000;

-- Increase the salary of employees in Finance by 10%.
UPDATE employees SET salary=salary*1.10 WHERE dept_id=
(SELECT dept_id FROM departments WHERE dept_name='Finance');

-- Change the department of an employee whose email is 
-- 'suresh.reddy@example.com' to IT.
UPDATE employees SET dept_id=(
SELECT dept_id FROM departments WHERE dept_name='IT')
WHERE email='suresh.reddy@example.com';

-- Delete an employee who joined before 2021.
DELETE FROM employees WHERE join_date < '2021-01-01';

-- Delete a department that has no employees.
DELETE FROM departments
WHERE dept_id NOT IN
(SELECT DISTINCT dept_id FROM employees WHERE dept_id IS NOT NULL);

-- Find employees who earn more than the average salary of all employees.
SELECT first_name, last_name,salary FROM employees 
WHERE salary>(SELECT AVG(salary) FROM employees);

-- Find employees who work in the same department as ‘ravi kumar’.
SELECT first_name,last_name,dept_id FROM employees
WHERE dept_id=(SELECT dept_id FROM employees WHERE first_name='ravi' AND last_name='kumar');

-- Retrieve the department with the highest number of employees.
SELECT dept_name,dept_id FROM departments WHERE 
dept_id=(
SELECT dept_id FROM employees GROUP BY dept_id
ORDER BY COUNT(*) DESC LIMIT 1);


