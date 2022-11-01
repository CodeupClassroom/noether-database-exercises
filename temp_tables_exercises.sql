
-- Using the example from the lesson, create a temporary table called employees_with_departments that contains first_name, last_name, and dept_name for employees currently with that department. Be absolutely sure to create this table on your own database. If you see "Access denied for user ...", it means that the query was attempting to write a new table to a database that you can only read.

USE employees;

DROP TEMPORARY TABLE IF EXISTS read_only_user.employees_with_departments;

CREATE TEMPORARY TABLE read_only_user.employees_with_departments AS (
	SELECT first_name, last_name, dept_name
	FROM employees
	JOIN dept_emp USING (emp_no)
	JOIN departments USING (dept_no)
);

SELECT *
FROM read_only_user.employees_with_departments
LIMIT 10;

-- Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns

DESCRIBE read_only_user.employees_with_departments;

ALTER TABLE read_only_user.employees_with_departments ADD full_column VARCHAR(31);

SELECT *
FROM read_only_user.employees_with_departments
LIMIT 10;

-- Update the table so that full name column contains the correct data

UPDATE read_only_user.employees_with_departments SET full_column = CONCAT(first_name, ' ', last_name);

SELECT *
FROM read_only_user.employees_with_departments
LIMIT 10;

-- Remove the first_name and last_name columns from the table.

ALTER TABLE read_only_user.employees_with_departments DROP COLUMN first_name;
ALTER TABLE read_only_user.employees_with_departments DROP COLUMN last_name;

SELECT *
FROM read_only_user.employees_with_departments
LIMIT 10;

-- What is another way you could have ended up with this same table?


-- Create a temporary table based on the payment table from the sakila database.

USE sakila;

DROP TEMPORARY TABLE IF EXISTS read_only_user.payments;

CREATE TEMPORARY TABLE read_only_user.payments AS (
	SELECT payment_id, customer_id, amount, payment_date
	FROM payment
);

SELECT *
FROM read_only_user.payments
LIMIT 10;

-- Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.

SELECT payment_id, amount * 100
FROM read_only_user.payments;

ALTER TABLE read_only_user.payments ADD pennies INT(5) NOT NULL;

SELECT payment_id, amount * 100
FROM read_only_user.payments;

UPDATE read_only_user.payments SET pennies = amount * 100;

SELECT *
FROM read_only_user.payments;

ALTER TABLE read_only_user.payments DROP COLUMN amount;

SELECT *
FROM read_only_user.payments;

SELECT CAST(amount * 100 AS UNSIGNED) AS cents
FROM read_only_user.payments;


















# Find out how the current average pay in each department compares to the overall current pay for everyone at the company. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department right now to work for? The worst?

# -- Returns the historic z-scores for each salary
-- Notice that there are 2 separate scalar subqueries involved
SELECT salary,
    (salary - (SELECT AVG(salary) FROM salaries))
    /
    (SELECT stddev(salary) FROM salaries) AS zscore
FROM salaries;


USE employees;

#Aggregate information
CREATE TEMPORARY TABLE read_only_user.overall_agg AS (
	SELECT AVG(salary) AS avg_salary, STD(salary) AS std_salary
	FROM employees.salaries
	WHERE to_date > NOW()
);

#Check
SELECT *
FROM read_only_user.overall_agg;


#Average salary by department
CREATE TEMPORARY TABLE read_only_user.metrics AS (
	SELECT dept_name, AVG(salary) AS dept_average
	FROM employees.salaries
	JOIN employees.dept_emp USING (emp_no)
	JOIN employees.departments USING (dept_no)
	WHERE employees.dept_emp.to_date > NOW()
	AND employees.salaries.to_date > NOW()
	GROUP BY dept_name
);

#Check
SELECT *
FROM read_only_user.metrics;


#Create columns for table
ALTER TABLE read_only_user.metrics ADD overall_avg FLOAT(10, 2);
ALTER TABLE read_only_user.metrics ADD overall_std FLOAT(10, 2);
ALTER TABLE read_only_user.metrics ADD dept_zscore FLOAT(10, 2);


#Check
SELECT *
FROM read_only_user.metrics;

#Update the table with the average
UPDATE read_only_user.metrics SET overall_avg = (SELECT avg_salary FROM read_only_user.overall_agg);

#Check
SELECT *
FROM read_only_user.metrics;


#Update with standard deviation
UPDATE read_only_user.metrics SET overall_std = (SELECT std_salary FROM read_only_user.overall_agg);


#Check
SELECT *
FROM read_only_user.metrics;


#Update with calculated zscore
UPDATE read_only_user.metrics SET dept_zscore = (dept_average - overall_avg) / overall_std;


#Check and order
SELECT *
FROM read_only_user.metrics
ORDER BY dept_zscore DESC;