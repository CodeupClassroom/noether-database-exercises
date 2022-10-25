-- BASIC STATEMENTS
USE fruits_db;


-- We can use the SELECT statement to ask for specific columns to be returned. 
-- Here we ask for all three columns available in the table.
SELECT id,
		name,
		quantity
FROM fruits;

-- Here we ask for only two columns
SELECT name,
		quantity
FROM fruits;

-- The special character * can be used as a wildcard that asks for everything
SELECT *
FROM fruits;

-- We can ask for a specific column to be returned more than once
SELECT *, quantity
FROM fruits;

-- The distinct keyword allows us to find only unique values within a specific column
SELECT DISTINCT quantity
FROM fruits;

-- Let's explore using a different database/table
USE employees;

-- Let's see what is in the titles table
SELECT *
FROM titles;

SELECT DISTINCT title
FROM titles;

-- This query will cause an error. The DISTINCT keyword produces a reduced set for the output
-- That reduced set cannot be paired up with the larger set produced by the *
SELECT *, 
	DISTINCT title
FROM titles;

-- We can use the WHERE clause to add a filter to our query
SELECT *
FROM titles
WHERE (title = 'Senior Engineer' OR title = 'Staff')
AND from_date BETWEEN '2001-01-01' AND '1995-01-01';

-- Notice that when we use a conditional statement in the SELECT portion of the query we get 
-- boolean output for the entire set. It does not act as a filter (like we see in a WHERE clause)
SELECT title, 
		title = 'Senior Engineer', 
		title
FROM titles;

-- SELECT statements can run specific calculations
SELECT 2+3;

-- You can alias the names of the columns returned in the output by using the keyword "AS"
SELECT title,
		title = 'Senior Engineer' AS 'FROM'
FROM titles;

-- Putting it all together
SELECT *, 
		title = 'Senior Engineer' AS 'IsSenior',
	   title = 'Staff' AS 'IsStaff'
FROM titles
WHERE emp_no < 10010
AND to_date = '9999-01-01';