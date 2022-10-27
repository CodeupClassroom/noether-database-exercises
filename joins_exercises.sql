-- JOINS EXERCISES

-- 1. Use the employees database
USE employees;

-- 2. Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.

SELECT *
FROM employees
LIMIT 5;
-- employees contains emp_no, birth_date, first_name, last_name, gender, hire_date

SELECT *
FROM dept_manager;
-- dept_manager contains emp_no, dept_no, from_date, to_date

SELECT *
FROM departments;

SELECT *
FROM employees AS e
JOIN dept_manager AS dm ON e.emp_no = dm.emp_no AND to_date > CURDATE()
LIMIT 50;

SELECT *
FROM employees AS e
JOIN dept_manager AS dm ON e.emp_no = dm.emp_no
WHERE to_date > CURDATE()
LIMIT 50;

-- Adding to my supertable
SELECT *
FROM employees AS e
JOIN dept_manager AS dm ON e.emp_no = dm.emp_no AND to_date > CURDATE()
JOIN departments AS d USING(dept_no)
LIMIT 50;

SELECT *
FROM employees AS e
JOIN dept_manager AS dm ON e.emp_no = dm.emp_no AND to_date > CURDATE()
JOIN departments AS d ON dm.dept_no = d.dept_no
LIMIT 50;

-- Limiting my output by a specific SELECT 
SELECT d.dept_name,
		  CONCAT(e.first_name, ' ', e.last_name) AS current_department_manager
FROM employees AS e
JOIN dept_manager AS dm ON e.emp_no = dm.emp_no AND to_date > CURDATE()
JOIN departments AS d USING(dept_no)
ORDER BY dept_name;

-- 3. Find the name of all departments currently managed by women.
SELECT *
FROM employees AS e
JOIN dept_manager AS dm ON e.emp_no = dm.emp_no
	AND to_date > CURDATE()
	AND gender = 'F'
JOIN departments AS d USING(dept_no);

SELECT *
FROM employees AS e
JOIN dept_manager AS dm ON e.emp_no = dm.emp_no
JOIN departments AS d USING(dept_no)
WHERE to_date > CURDATE()
	AND gender = 'F';
	
SELECT d.dept_name,
		CONCAT(e.first_name, ' ', e.last_name) AS 'current_department_manager',
		 gender
FROM employees AS e
JOIN dept_manager AS dm ON e.emp_no = dm.emp_no
JOIN departments AS d USING(dept_no)
WHERE to_date > CURDATE()
	AND gender = 'F';
	
-- 4. Find the current titles of employees currently working in the Customer Service department.
SELECT *
FROM dept_emp;

SELECT *
FROM titles;

SELECT *
FROM departments;

SELECT *
FROM dept_emp AS de
JOIN titles AS t ON de.emp_no = t.emp_no
			AND t.to_date > CURDATE()
			AND de.to_date > CURDATE()
JOIN departments AS d ON d.dept_no = de.dept_no
		AND dept_name = 'Customer Service';
		
SELECT COUNT(*)
FROM dept_emp AS de
JOIN titles AS t ON de.emp_no = t.emp_no
			AND t.to_date > CURDATE()
			AND de.to_date > CURDATE()
JOIN departments AS d ON d.dept_no = de.dept_no
		AND dept_name = 'Customer Service';
		
SELECT title, COUNT(*)
FROM dept_emp AS de
JOIN titles AS t ON de.emp_no = t.emp_no
			AND t.to_date > CURDATE()
			AND de.to_date > CURDATE()
JOIN departments AS d ON d.dept_no = de.dept_no
		AND dept_name = 'Customer Service'
GROUP BY title;
-- 5. Find the current salary of all current managers.
SELECT *
FROM salaries;

SELECT *
FROM employees as e
JOIN salaries AS s ON e.emp_no = s.emp_no
	AND s.to_date > CURDATE()
JOIN dept_manager AS dm ON e.emp_no = dm.emp_no
	AND dm.to_date > CURDATE()
JOIN departments AS d USING(dept_no);

SELECT d.dept_name,
		CONCAT(e.first_name, ' ', e.last_name) AS current_department_manager,
		s.salary
FROM employees as e
JOIN salaries AS s ON e.emp_no = s.emp_no
	AND s.to_date > CURDATE()
JOIN dept_manager AS dm ON e.emp_no = dm.emp_no
	AND dm.to_date > CURDATE()
JOIN departments AS d USING(dept_no)
ORDER BY dept_name;

-- 6. Find the number of current employees in each department.
SELECT *
FROM dept_emp AS de
JOIN departments AS d ON de.dept_no = d.dept_no
	AND de.to_date > CURDATE();
	
SELECT COUNT(*)
FROM dept_emp AS de
JOIN departments AS d ON de.dept_no = d.dept_no
	AND de.to_date > CURDATE();	
	
SELECT d.dept_no,
		d.dept_name,
		COUNT(*)
FROM dept_emp AS de
JOIN departments AS d ON de.dept_no = d.dept_no
	AND de.to_date > CURDATE()
GROUP BY dept_no, dept_name;

-- 7. Which department has the highest average salary? Hint: Use current not historic information.
SELECT
	d.dept_name,
	ROUND(AVG(salary), 2) AS average_salary
FROM dept_emp AS de
JOIN salaries AS s ON de.emp_no = s.emp_no
	AND de.to_date > CURDATE()
	AND s.to_date > CURDATE()
JOIN departments AS d ON de.dept_no = d.dept_no
GROUP BY d.dept_name
ORDER BY average_salary DESC
LIMIT 1;

-- 8. Who is the highest paid employee in the Marketing department?
SELECT e.first_name,
			 e.last_name,
			 s.salary,
			 d.dept_name
FROM employees AS e
JOIN dept_emp AS de ON e. emp_no = de.emp_no
	AND de.to_date > CURDATE()
JOIN salaries AS s ON e.emp_no = s.emp_no
	AND s.to_date > CURDATE()
JOIN departments AS d ON de.dept_no = d.dept_no
	AND d.dept_name = 'Marketing'
ORDER BY s.salary DESC
LIMIT 1;

SELECT e.first_name,
			 e.last_name,
			 s.salary AS 'Salary',
			 d.dept_name AS 'Department Name'
FROM salaries AS s
JOIN 
	employees AS e ON e.emp_no = s.emp_no
JOIN 
	dept_emp AS de ON de.emp_no = e.emp_no
JOIN 
	departments AS d ON d.dept_no = de.dept_no
WHERE s.to_date LIKE '9999%' AND d.dept_name = 'Marketing' AND de.to_date LIKE '9999%' AND d.dept_name = 'Marketing'
ORDER BY 
	s.salary DESC
LIMIT 1;
-- 9. Which current department manager has the highest salary?
SELECT e.first_name,
			e.last_name,
			s.salary,
			d.dept_name
FROM employees AS e
JOIN dept_manager AS dm ON e.emp_no = dm.emp_no
	AND dm.to_date > CURDATE()
JOIN salaries AS s ON e.emp_no = s.emp_no
	AND s.to_date > CURDATE()
JOIN departments AS d USING(dept_no)
ORDER BY s.salary DESC
LIMIT 1;
-- 10. Determine the average salary for each department. Use all salary information and round your results.
SELECT d.dept_name,
		ROUND(AVG(s.salary), 0) AS avg_dept_salary
FROM departments d
JOIN dept_emp de ON d.dept_no = de.dept_no
JOIN salaries s ON de.emp_no = s.emp_no
GROUP BY d.dept_name
ORDER BY avg_dept_salary DESC;
