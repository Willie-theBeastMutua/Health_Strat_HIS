CREATE DATABASE skadden;
USE skadden;
CREATE TABLE employee(
	emp_id INT PRIMARY KEY,
    first_name VARCHAR(30),
    last_name VARCHAR(30),
    birth_date DATE,
    sex VARCHAR (1),
    salary INT,
    super_id INT,
    branch_id INT    
);
CREATE TABLE branch(
	branch_id INT PRIMARY KEY,
    branch_name VARCHAR(30),
    mgr_id INT,
    mgr_start_date DATE,
    FOREIGN KEY (mgr_id) REFERENCES employee(emp_id) ON DELETE SET NULL
);
-- ALTER employee table to include foreign keys after creating branch TABLE
ALTER TABLE employee
ADD FOREIGN KEY (super_id) REFERENCES employee(emp_id)
ON DELETE SET NULL;
ALTER TABLE employee
ADD FOREIGN KEY (branch_id) REFERENCES branch(branch_id)
ON DELETE SET NULL;
CREATE TABLE client(
	client_id INT PRIMARY KEY,
    client_name VARCHAR(30),
    branch_id INT,
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id)
);
CREATE TABLE works_with(
	emp_id INT,
	client_id INT,
    total_sales INT,
    PRIMARY KEY (emp_id, client_id),
    FOREIGN KEY (emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
	FOREIGN KEY (client_id) REFERENCES client(client_id) ON DELETE CASCADE
);
CREATE TABLE branch_supplier(
	branch_id INT,
    supplier_name VARCHAR (30),
    supply_type VARCHAR (30),
    PRIMARY KEY (branch_id, supplier_name),
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);

-- Populate TABLE employee and branch (watch for foreign key errors)
INSERT INTO employee VALUES (100, 'David', 'Wallace', '1967-11-17', 'M', 25000, NULL, NULL);
INSERT INTO branch VALUES (1, 'corporate', 100, '2006-02-09');
UPDATE employee
SET branch_id = 1
WHERE emp_id = 100;
INSERT INTO employee VALUES (101, 'Jan', 'Levinson', '1961-05-11', 'F', 110000, 100, 1);
INSERT INTO employee VALUES (102, 'Michael', 'Scott', '1964-03-15', 'M', 75000, 100, NULL);
INSERT INTO branch VALUES (2, 'scranton', 102, '1992-04-06');
UPDATE employee
SET branch_id = 2
WHERE emp_id = 102;
INSERT INTO employee VALUES (103, 'Angela', 'Martin', '1971-06-25', 'F', 63000, 102, 2);
INSERT INTO employee VALUES (104, 'Kelly', 'Kapoor', '1980-02-05', 'F', 55000, 102, 2);
INSERT INTO employee VALUES (105, 'Stanley', 'Hudson', '1958-02-19', 'M', 69000, 102, 2);
INSERT INTO employee VALUES (106, 'Josh', 'Porter', '1969-09-05', 'M', 78000, 100, Null);
INSERT INTO branch VALUES (3, 'STamford', 106, '1998-02-13');
UPDATE employee
SET branch_id = 3
WHERE emp_id = 106;
INSERT INTO employee VALUES (107, 'Andy', 'Bernard', '1973-07-22', 'M', 65000, 106, 3);
INSERT INTO employee VALUES (108, 'Jim', 'Halpert', '1978-10-01', 'M', 71000, 106, 3);

-- Populate Client TABLE

INSERT INTO client VALUES (400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES (401, 'Lackwana County', 2);
INSERT INTO client VALUES (402, 'FedEX', 2);
INSERT INTO client VALUES (403, 'John DAly Law, LLC', 2);
INSERT INTO client VALUES (404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES (405, 'Times Newspaper', 2);
INSERT INTO client VALUES (406, 'FedEX', 2);

-- Populate Works With TABLE
INSERT INTO works_with VALUES (105, 400, 55000);
INSERT INTO works_with VALUES (102, 401, 267000);
INSERT INTO works_with VALUES (108, 402, 22500);
INSERT INTO works_with VALUES (107, 403, 5000);
INSERT INTO works_with VALUES (108, 403, 12000);
INSERT INTO works_with VALUES (105, 404, 33000);
INSERT INTO works_with VALUES (107, 405, 26000);
INSERT INTO works_with VALUES (102, 406, 15000);
INSERT INTO works_with VALUES (105, 406, 130000);

-- Populate branch_supplier TABLE

INSERT INTO branch_supplier VALUES (2, 'Hammer MIll', 'Paper');
INSERT INTO branch_supplier VALUES (2, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES (3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES (2, 'J.T Forms & Labels', 'Custom forms');
INSERT INTO branch_supplier VALUES (3, 'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES (3, 'Hammer MIll', 'Paper');
INSERT INTO branch_supplier VALUES (3, 'Stamford Labels', 'Custom Forms');


-- Basic Queries
-- Find all employees
SELECT * FROM employee;
-- Find all clients
SELECT * FROM client;
-- Find all employees ordered by salary
SELECT * FROM employee
ORDER BY salary DESC;
-- Find all employees ordered by sex then name
SELECT * FROM employee
ORDER BY sex, first_name;
-- Find the first 5 employees in the table
SELECT * FROM employee
LIMIT 5;
-- Find the first and last names of all employees
SELECT employee.first_name, employee.last_name
FROM employee;
-- Find the forename and surnames names of all employees
SELECT employee.first_name AS forename, employee.last_name AS surname
FROM employee;
-- Find out all the different genders
SELECT DISTINCT sex
FROM employee;
-- Find all male employees
SELECT * FROM employee
WHERE sex = 'M';
-- Find all female employees at branch 2
SELECT * FROM employee
WHERE sex = 'F' AND branch_id = 2;
-- Find all employees born between 1970 and 1975
SELECT * FROM employee
WHERE birth_date BETWEEN '1970-01-01' AND '1975-01-01';
-- Find all employees named Jim, Michael, Johnny or David
SELECT *
FROM employee
WHERE first_name IN ('Jim', 'Michael', 'Johnny', 'David');


-- FUNCTIONS

-- Find the number of employees
SELECT COUNT(emp_id)
FROM employee;

-- Find out how many males and females there are
SELECT COUNT(sex), sex
From employee
GROUP BY sex;
-- Find the total sales of each salesman
SELECT SUM(total_sales), emp_id
FROM works_with
GROUP BY emp_id;

-- WILDCARDS

-- % = any # characters, _ = one character
-- Find any client's who are an LLC
SELECT *
FROM client
WHERE client_name LIKE '%LLC';

-- Find any employee born on the 10th day of the month
SELECT *
FROM employee
WHERE birth_date LIKE '_____10%';

-- UNION
-- Find a list of employee and branch names
SELECT employee.first_name AS Employee_Branch_Names
FROM employee
UNION
SELECT branch.branch_name
FROM branch;

-- Find a list of all clients & branch suppliers' names
SELECT client.client_name AS Non_Employee_Entities, client.branch_id AS Branch_ID
FROM client
UNION
SELECT branch_supplier.supplier_name, branch_supplier.branch_id
FROM branch_supplier;

-- JOINS
-- Add the extra branch
INSERT INTO branch VALUES(4, "Buffalo", NULL, NULL);

SELECT employee.emp_id, employee.first_name, branch.branch_name
FROM employee
JOIN branch    -- LEFT JOIN, RIGHT JOIN
ON employee.emp_id = branch.mgr_id;

-- NESTED QUERIES
-- Find names of all employees who have sold over 50,000
SELECT employee.first_name, employee.last_name
FROM employee
WHERE employee.emp_id IN (SELECT works_with.emp_id
                          FROM works_with
                          WHERE works_with.total_sales > 50000);

-- Find all clients who are handles by the branch that Michael Scott manages
-- Assume you know Michael's ID
SELECT client.client_id, client.client_name
FROM client
WHERE client.branch_id = (SELECT branch.branch_id
                          FROM branch
                          WHERE branch.mgr_id = 102);

 -- Find all clients who are handles by the branch that Michael Scott manages
 -- Assume you DONT'T know Michael's ID
 SELECT client.client_id, client.client_name
 FROM client
 WHERE client.branch_id = (SELECT branch.branch_id
                           FROM branch
                           WHERE branch.mgr_id = (SELECT employee.emp_id
                                                  FROM employee
                                                  WHERE employee.first_name = 'Michael' AND employee.last_name ='Scott'
                                                  LIMIT 1));
-- Find the names of all clients who have spent more than 100,000 dollars
SELECT client.client_name 
FROM client 
WHERE client_id IN (
	SELECT client_id 
	FROM (
		SELECT SUM(works_with.total_sales) AS totals, works_with.client_id
        FROM works_with
        GROUP BY client_id) AS Total_client_sales
	WHERE totals > 100000
	);