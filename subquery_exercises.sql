# Find all the current employees with the same hire date as employee 101010 using a sub-query.
SELECT *
FROM employees
JOIN dept_emp USING (emp_no)
WHERE hie_date =   (
					SELECT hire_date
						FROM employees
						WHERE emp_no = 101010
						)
AND to_date > CURDATE();

SELECT first_name, last_name
FROM employees
WHERE emp_no IN (
				SELECT emp_no
					FROM dept_emp
					WHERE to_date > CURDATE()
					)
AND hire_date IN (
				 SELECT hire_date
				 	FROM employees
				 	WHERE emp_no = 101010
				 	);					


# Find all the titles ever held by all current employees with the first name Aamod.
SELECT employees.first_name, titles.title
FROM employees
JOIN titles ON employees.emp_no = titles.emp_no
WHERE first_name = "Aamod"
GROUP BY titles.title;


SELECT title, first_name
FROM (
	  SELECT first_name, employees.emp_no
	   FROM employees
	   JOIN dept_emp AS de ON de.emp_no = employees.emp_no
	   WHERE first_name = "Aamod"
	   AND de.to_date > CURDATE()
	   ) AS e
JOIN titles AS t ON t.emp_no = e.emp_no;	   



# How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.
SELECT *
FROM employees
WHERE emp_no IN (
				SELECT emp_no
				   FROM dept_emp
				   WHERE to_date < CURDATE()
				   );



# Find all the current department managers that are female. List their names in a comment in your code.
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM employees
JOIN dept_manager USING (emp_no)
WHERE gender = "F"
AND dept_manager.emp_no IN (
							SELECT emp_no
								 FROM dept_manager
								 WHERE to_date > CURDATE()
								 );

SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM employees
WHERE emp_no IN (
				SELECT emp_no
					FROM dept_manager
					WHERE to_date > CURDATE()
					)
AND gender = "F";					

# Find all the employees who currently have a higher salary than the companies overall, historical average salary.
SELECT emp_no
FROM salaries
WHERE salary > (
				SELECT AVG(salary)
				   FROM salaries
				   )
AND to_date > CURDATE();

				   
SELECT emp_no, CONCAT(first_name, ' ', last_name) AS full_name
FROM employees
JOIN salaries USING (emp_no)
WHERE salary > (
				SELECT AVG(salary)
					FROM salaries
					)
AND to_date > CURDATE()					
GROUP BY emp_no, full_name;


# How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?

SELECT COUNT(*) AS num_of_emps, (COUNT(*) / (
											 SELECT COUNT(`to_date`)
												     FROM salaries
												     WHERE to_date > CURDATE()) * 100) AS percent_of_emps
												     
FROM salaries
WHERE salary >= (SELECT (MAX(salary) - STD(salary))
				FROM salaries
					WHERE to_date > CURDATE()
				)
AND salaries.to_date > CURDATE();	 					 												     

