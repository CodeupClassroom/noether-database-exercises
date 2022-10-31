USE darden_1028;

DROP TABLE IF EXISTS my_numbers;

CREATE TEMPORARY TABLE my_numbers(
	n INT UNSIGNED NOT NULL,
	name VARCHAR(10) NOT NULL
);

SELECT *
FROM my_numbers;

# Insert data into my_numbers
INSERT INTO my_numbers(n, name)
VALUES (1, 'a'), (2, 'b'), (3, 'c'), (4, 'd'), (5, 'e');

# Delete from my_numbers
DELETE FROM my_numbers WHERE n > 4;

# Transform our existing data
UPDATE my_numbers SET n = n + 1;

# Transform our existing data with a condition
UPDATE my_numbers SET n = n + 10
WHERE name = 'a';

SELECT *
FROM my_numbers;

# -----------------------------------------------

USE employees;

SELECT emp_no, dept_no, first_name, last_name, salary, title
FROM employees AS e
JOIN dept_emp AS de USING(emp_no)
JOIN salaries AS s USING(emp_no)
JOIN departments AS d USING(dept_no)
JOIN titles AS t using(emp_no)
WHERE de.to_date > NOW()
	AND s.to_date > NOW()
	AND t.to_date > NOW()
	AND dept_name = 'Customer Service';

DROP TABLE IF EXISTS darden_1028.salary_info;
	
CREATE TEMPORARY TABLE darden_1028.salary_info AS (

SELECT emp_no, dept_no, first_name, last_name, salary, title
FROM employees AS e
JOIN dept_emp AS de USING(emp_no)
JOIN salaries AS s USING(emp_no)
JOIN departments AS d USING(dept_no)
JOIN titles AS t using(emp_no)
WHERE de.to_date > NOW()
	AND s.to_date > NOW()
	AND t.to_date > NOW()
	AND dept_name = 'Customer Service'

);

SELECT *
FROM darden_1028.salary_info;

# What is the average salary for current employees in Customer Service
SELECT AVG(salary)
FROM darden_1028.salary_info;

# Add new columns to my temporary table
ALTER TABLE darden_1028.salary_info ADD avg_salary float;
ALTER TABLE darden_1028.salary_info ADD std_salary float;
ALTER TABLE darden_1028.salary_info ADD greater_than_avg INT;

SELECT *
FROM darden_1028.salary_info;

# Update the new columns with new info
UPDATE darden_1028.salary_info SET avg_salary = 67000;

SELECT *
FROM darden_1028.salary_info;

UPDATE darden_1028.salary_info SET std_salary = 16000;

UPDATE darden_1028.salary_info SET greater_than_avg = salary > avg_salary;

SELECT *
FROM darden_1028.salary_info;

-- Checking the output of a query that joins my temp table to a perm table
SELECT *
FROM darden_1028.salary_info AS si
JOIN employees AS e USING (emp_no);

-- Saving the results of the query above into a new temp table (salary_info_and_emp)

CREATE TEMPORARY TABLE darden_1028.salary_info_and_emp AS (
SELECT emp_no, 
		dept_no, 
		 si.first_name, 
		 si.last_name, 
		 salary, 
		 title, 
		 avg_salary, 
		 std_salary, 
		 greater_than_avg, 
		 birth_date, gender, 
		 hire_date
FROM darden_1028.salary_info AS si
JOIN employees AS e USING (emp_no)
);

-- Viewing the content of my new temp table
SELECT * 
FROM darden_1028.salary_info_and_emp;



