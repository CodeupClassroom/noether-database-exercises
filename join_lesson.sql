-- Show me the options of various schema I can go to
SHOW DATABASES;
-- take me to that specific schema
USE join_example_db;
-- Whats in here?
SHOW TABLES;
-- whats in these tables specifically
SELECT * FROM roles;
-- fields present: id, name
SELECT * FROM users;
-- fields present: id, name, email, role_id

-- Our first join: the inner join

-- SELECT everything
SELECT * 
-- From the users table
FROM users
-- join the roles table in
JOIN roles 
-- specify how the match between users and roles looks like:
ON users.role_id = roles.id;

-- Select specific fields in the context of a join?
-- tell sql what you want to grab, with dot notation
-- format of field calls: table.field
SELECT users.email, roles.name
FROM users
JOIN roles
ON users.role_id = roles.id;

-- if we alias tables, we can reference them even in the first line
-- faketablename.field, faketablename2.field2
SELECT pizza.email, hamsandwich.name
-- note the alias of the table here
FROM users AS pizza
-- and here
JOIN roles AS hamsandwich
-- note that the aliased table names are being used for the key pairing
ON pizza.role_id = hamsandwich.id;

-- we can alias things without as! as was a lie! i'm sorry! this isnt my fault!
SELECT pizza.email, hamsandwich.name
FROM users pizza
JOIN roles hamsandwich
ON pizza.role_id = hamsandwich.id;

-- this is the wrong join!!!!
-- we want to link up users role id to the roles id field!
-- id in users is also an integer and sql understands that enough
-- to actually perform that join because it doesnt know better
-- BUT we as the human operator understand that the association
-- between the mapping of these two tables is only valuable
-- in the sense that we can link up the natural language version of the 
-- role inside of the roles table, with the role_id encoding present
-- inside the users table
-- wrong, nope, dont do: SELECT * FROM roles
-- wrong, nope, dont do: JOIN users USING(id);

-- left and right?
-- Take everything
SELECT * 
-- from users (to start)
FROM users
-- Join roles (with left)
LEFT JOIN roles
-- what pairing?
ON users.role_id = roles.id;

-- takeaways here: everything from users is present, 
-- two rows of info that have users information, but nothing from roles
-- the cells from roles are filled with null values

-- take that flip it and reverse it
-- left and right?
-- Take everything
SELECT * 
-- from users (to start)
FROM roles
-- Join roles (with left)
LEFT JOIN users
-- what pairing?
ON users.role_id = roles.id;

-- as a right join?
SELECT * 
-- from users (to start)
-- ***
-- This first table we select from is always the left table!!
-- ***
FROM roles
-- Join roles (with left)
RIGHT JOIN users
-- what pairing?
ON users.role_id = roles.id;

-- brief review:
-- inner joins: only instances were we have a match on both sides
-- inside of our key pairing
-- consequence: we can lose information from both tables if there is
-- not a match on either side
-- left/right joins:
-- left: give me all information present in the left table, and any 
-- matches from the right table
-- consequence: we will maintain every row present in the left table,
-- but we may not see everything in the right table, and furthermore
-- if we have info in the left table with no match, we will see nulls
-- filled into the cells instead of data

-- switch to a new schema: world
USE world;
-- tables in here? yall got any tables?
SHOW tables;
-- city
-- fields present: ID, Name, CountryCode, District, Population
-- CountryCode is a three letter character string
SELECT * FROM city LIMIT 5;

-- country
-- looks like country.Code is a foreign key math with city.CountryCode
SELECT * FROM country LIMIT 5;

-- countrylanguage
-- CountryCode, language, isOfficial, Percentage
SELECT * FROM countrylanguage LIMIT 5;

-- lets link these together!
-- lets use an inner join, and take every field
SELECT *
FROM city
-- USING is congruent to "ON table.field1 = table2.field1"
-- USING is shorthand that will allow us to make a key-pair link
-- in the specific situation where both fields have the exact same name
LEFT JOIN countrylanguage USING(CountryCode)
LEFT JOIN country ON country.Code = countrylanguage.CountryCode;

SELECT *
FROM city
-- USING is congruent to "ON table.field1 = table2.field1"
-- USING is shorthand that will allow us to make a key-pair link
-- in the specific situation where both fields have the exact same name
LEFT JOIN countrylanguage ON city.CountryCode = countrylanguage.CountryCode
LEFT JOIN country ON country.Code = countrylanguage.CountryCode;

SELECT *
FROM city
-- USING is congruent to "ON table.field1 = table2.field1"
-- USING is shorthand that will allow us to make a key-pair link
-- in the specific situation where both fields have the exact same name
LEFT JOIN countrylanguage ON city.CountryCode = countrylanguage.CountryCode
LEFT JOIN country ON country.Code = countrylanguage.CountryCode
WHERE Language = 'Arabic';

