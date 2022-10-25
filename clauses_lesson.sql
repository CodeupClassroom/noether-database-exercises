
use employees;

SELECT * 
FROM employees
WHERE hire_date >= '1990-01-01';

# TO FIND THOSE HIRED IN THE 1990'S

select * 
from employees 
where hire_date LIKE '199%';

# TO FIND THOSE HIRED IN THE MONTH OF OCTOBER

SELECT * 
FROM employees
WHERE hire_date LIKE '%-10-%';

# FIND THOSE WHOSE FIRST NAME STARTS WITTH S

SELECT * 
FROM employees 
WHERE first_name LIKE 'S%';

# FIND THOSE WHOSE FIRST NAME STARTS WITH S AND ENDS WITH S

SELECT * 
FROM employees 
WHERE first_name LIKE 'S%s';

SELECT * 
FROM employees 
WHERE first_name LIKE 'S%' AND last_name LIKE 'S%';

# TO FIND THOSE WHOSE FIRST NAME STARTS WITH S OR LAST NAME STARTS WITH S

SELECT * 
FROM employees 
WHERE first_name LIKE 'S%' OR last_name LIKE 'S%';


# TO FIND THOSE NOT HIRED IN THE MONTH OF OCTOBER

SELECT * 
FROM employees
WHERE hire_date NOT LIKE '%-10-%';

# TO FIND THOSE HIRED BETWEEN 1990 AND 1999

SELECT * 
FROM employees 
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31';


# FIND ALL THOSE WHOSE LAST NAME IS EITHER FOOTE OR SIDOU

SELECT *
FROM employees 
WHERE last_name = 'Foote' OR last_name = 'Sidou';

SELECT *
FROM employees
WHERE last_name IN ('Foote', 'Sidou');

# ANY RECORDS WHERE HIRE_DATE IS NULL?

SELECT *
FROM employees
WHERE hire_date IS NULL;

# ANY RECORDS WHERE HIRE_DATE IS not NULL?

SELECT *
FROM employees
WHERE hire_date IS NOT NULL;

# FIND EMPLOYEES WHO WERE HIRED IN THE 90'S AND FIRST NAME STARTS WITH S OR LAST NAME STARTS WITH S

SELECT *
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31' 
	AND (first_name LIKE 'S%' OR last_name LIKE 'S%');
	
	

# EMPLOYEES HIRED IN THE 90'S, ORDER BY HIRE_DATE ASCENDING

SELECT * 
FROM employees 
WHERE hire_date BETWEEN '1990-01-01' and '1999-12-31'
ORDER BY hire_date asc;

SELECT * 
FROM employees 
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
ORDER BY hire_date DESC;


SELECT *
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
ORDER BY hire_date DESC, gender ASC;

# ALL MALES FIRST BY HIRE_DATE AND THEN ALL THE FEMALES BY HIRE DATE
SELECT *
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
ORDER BY gender ASC, hire_date DESC;


# ADDING LIMITS TO OUTPUT

#find the oldest employee hired in 1990

SELECT *
FROM employees
WHERE hire_date LIKE '1990%'
ORDER BY birth_date ASC, first_name ASC
LIMIT 5;

SELECT *
FROM employees
WHERE hire_date LIKE '1990%'
ORDER BY birth_date ASC, first_name ASC
LIMIT 5 OFFSET 3;

