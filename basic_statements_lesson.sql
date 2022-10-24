-- BASIC STATEMENTS
USE fruits_db;

SELECT id,
		name,
		quantity
FROM fruits;

SELECT name,
		quantity
FROM fruits;

SELECT *
FROM fruits;

SELECT *, quantity
FROM fruits;

SELECT *
FROM fruits;

SELECT DISTINCT quantity
FROM fruits;

USE employees;

SELECT *
FROM titles;

SELECT DISTINCT title
FROM titles;

SELECT *, 
	DISTINCT title
FROM titles;

SELECT *
FROM titles
WHERE (title = 'Senior Engineer' OR title = 'Staff')
AND from_date BETWEEN '2001-01-01' AND '1995-01-01';

SELECT title, 
		title = 'Senior Engineer', 
		title
FROM titles;

SELECT 2+3;

SELECT title,
		title = 'Senior Engineer' AS 'FROM'
FROM titles;

SELECT *, 
		title = 'Senior Engineer' AS 'IsSenior',
	   title = 'Staff' AS 'IsStaff'
FROM titles
WHERE emp_no < 10010
AND to_date = '9999-01-01';