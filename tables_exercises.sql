-- TABLES EXERCISES

-- Use the employees database. Write the SQL code necessary to do this. 
USE employees;

-- List all the tables in the database. Write the SQL code necessary to accomplish this.
SHOW TABLES;

-- Explore the employees table. What different data types are present on this table?
DESCRIBE employees;
-- int, date, varchar(14), varchar(16), enum('M','F'), date

-- Which table(s) do you think contain a numeric type column? (Write this question and your answer in a comment)
-- I think all tables will contain a numeric type column

-- Which table(s) do you think contain a string type column? (Write this question and your answer in a comment)
-- I think all tables except salaries will contain a string type column

-- Which table(s) do you think contain a date type column? (Write this question and your answer in a comment)
-- I think dept_manager, employees, salaries, and titles will have date type columns

-- What is the relationship between the employees and the departments tables? (Write this question and your answer in a comment)
-- There is no direct apparent relationship between the employees and the departments table
-- There is a joiner table (dept_emp) that can connect an employee to their relevant department name

-- Show the SQL that created the dept_manager table. Write the SQL it takes to show this as your exercise solution.
SHOW CREATE TABLE dept_manager;

/*
CREATE TABLE `dept_manager` (
  `emp_no` int NOT NULL,
  `dept_no` char(4) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  PRIMARY KEY (`emp_no`,`dept_no`),
  KEY `dept_no` (`dept_no`),
  CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=latin1
*/
