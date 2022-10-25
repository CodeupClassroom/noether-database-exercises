select concat('Hello ', 'World');

use albums_db;

select * from albums limit 50;

SELECT artist AS pop_name, `name` AS album_name,  concat(artist, '-', `name`) AS artist_album
FROM albums
WHERE artist = 'Michael Jackson';

SELECT SUBSTR('ADAM KRULL', 6, 10) AS your_instructor;

SELECT artist, 
	CONCAT(SUBSTR(artist, 1, 5), SUBSTR(`name`, 1, 5)) AS artist_album_id
FROM albums;

select concat(substr('Maggie', 1, 1), substr('Giust', 1, 1)) AS initials;

use zillow;

select distinct substr(regionidzip, 1,2) AS zip_first2digits from properties_2016 limit 100;

select * from properties_2016 WHERE substr(regionidzip, 1,2) = 39;


use albums_db;
SELECT artist, 
	LOWER(CONCAT(SUBSTR(artist, 1, 5), SUBSTR(`name`, 1, 5))) AS artist_album_id
FROM albums;


SELECT UPPER('maggie');

USE saas_llc;

select * from customer_details limit 100;

select distinct upper(state) as state from customer_details;


select replace('Margaret', 'rgaret', 'ggie');

select *, concat('0', zip) AS zip, lower(street_name) AS street, replace(state, 'A', 'assachusetts') AS full_state
from customer_details;

select now();

select curdate();

use zillow;

select * from properties_2016 limit 100;

select year(curdate()) - yearbuilt AS age
from properties_2016 
where yearbuilt is not null
order by age
limit 100;

use employees;

select birth_date, datediff(now(), birth_date)/365 AS age from employees;


select concat('my daughter is ', unix_timestamp() - unix_timestamp('2004-06-01'), ' seconds old');


use zillow;

select min(calculatedfinishedsquarefeet) AS min_sqft, 
		max(calculatedfinishedsquarefeet) AS max_sqft, 
		round(avg(calculatedfinishedsquarefeet), 2) AS avg_sqft, 
		round(std(calculatedfinishedsquarefeet), 2) AS stdev_sqft
from properties_2016 
limit 50;

USE saas_llc;

select cast(concat('0', zip) AS char) AS zip
from customer_details;

select cast(0123 as unsigned);
