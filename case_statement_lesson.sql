
#### if and case statement lesson

-- lets use the chipotle database
show databases;

use chipotle;

show tables;

select * from orders;


-- lets look at all the chicken orders
select distinct item_name from orders 
where item_name like '%chicken%';



### if function

/*

if(condition, value if true, value if false)

*/

-- if statements are generally best for T/F  

select item_name, if(item_name = 'Chicken Bowl', 'yes', 'no') as is_chicken_bowl
from orders;

select distinct item_name, if(item_name like '%Chicken%', 'yes', 'no') as has_chicken
from orders
order by item_name;

select distinct item_name, if(item_name like '%Chicken%', 'True', 'False') as has_chicken
from orders
order by item_name;

select distinct item_name, if(item_name like '%Chicken%', True, False) as has_chicken
from orders
order by item_name;

-- we dont have to explictly write out if when T/F
select distinct item_name, item_name like '%Chicken%' as has_chicken
from orders
order by item_name;

-- subquery to count chicken items
select sum(has_chicken) as total_chicken_items
from 
	(select distinct item_name, item_name like '%Chicken%' as has_chicken
	from orders
	order by item_name) as a
;


### case statement - option 1

/* 

case column
	when condition_a then value_a
	when condition_b then value_b
	else value_c
end as new_column_name 
	
*/

-- the conditions are checking one column
-- the conditions are checking for equality
-- can check more than T/F

select distinct item_name from orders;

-- lets find the bowls
select distinct item_name,
	case item_name
			when 'Chicken Bowl' then 'yes_chicken'
			when 'Steak Bowl' then 'yes_steak'
			when '%bowl%' then 'yes_other' -- ONLY checking for equality, will not find anything
			else 'other'
	end 'is_bowl'
from orders; 

select distinct item_name,
	case item_name
			when 'Chicken Bowl' then 'yes_chicken'
			when 'Steak Bowl' then 'yes_steak'
			else concat('this_is_not_a_bowl_',replace(lower(item_name), ' ', '_'))
	end 'is_bowl'
from orders; 


### case statement - option 2

/* 

case 
	when column_a condition_a then value_a
	when column_b condition_b then value_b
	else value_c
end as new_column_name 

*/

-- more flexibility 
-- multiple columns check
-- can utilize different operators
-- generally preferred

select * from orders;

-- lets find bowls again
select distinct order_id, item_name,
	case
		when item_name like '%bowl%' then 'is_bowl'
		when order_id = 1 then 'first_order'
		when item_name = 'Izze' then 'found_izze'
-- 		when order_id = 1 then 'first_order'
		else 'not_a_bowl'
	end as 'where_are_the_bowls'
from orders;


-- lets group our quantities
select quantity, count(*)
from orders
group by quantity
order by quantity;

select * from orders;

-- the categories for how many times a person ordered a specific item in an order
select distinct quantity,
		case 
			when quantity >= 5 then 'big_orders'
			when quantity >= 2 then 'middle_size_orders'
-- 			 when quantity = 1 then 'single_orders'
			else 'single_orders'
		end as 'order_size'
from orders
order by quantity;


select order_size_by_item, count(*) as count_of_size
from 
	(select quantity,
		case 
			when quantity >= 5 then 'big_orders'
			when quantity >= 2 then 'middle_size_orders'
			else 'single_orders'
		end as 'order_size_by_item'
	from orders) as o
group by order_size_by_item
;


### pivot table

select * from orders;

-- lets find all the chicken orders
select distinct item_name from orders where item_name like '%chicken%';

-- look at chicken orders and quantity
select quantity, item_name 
from orders 
where item_name like '%chicken%';

-- building all the columns 
select quantity, item_name,
	case when item_name = 'Chicken Bowl' then item_name end as 'Chicken Bowl',
	case when item_name = 'Chicken Crispy Tacos' then item_name end as 'Chicken Crispy Tacos',
	case when item_name = 'Chicken Soft Tacos' then item_name end as 'Chicken Soft Tacos',
	case when item_name = 'Chicken Burrito' then item_name end as 'Chicken Burrito',
	case when item_name = 'Chicken Salad Bowl' then item_name end as 'Chicken Salad Bowl',
	case when item_name = 'Chicken Salad' then item_name end as 'Chicken Salad'
from orders 
where item_name like '%chicken%';

-- adding groupby and count
select quantity,
	count(case when item_name = 'Chicken Bowl' then item_name end) as 'Chicken Bowl',
	count(case when item_name = 'Chicken Crispy Tacos' then item_name end) as 'Chicken Crispy Tacos',
	count(case when item_name = 'Chicken Soft Tacos' then item_name end) as 'Chicken Soft Tacos',
	count(case when item_name = 'Chicken Burrito' then item_name end) as 'Chicken Burrito',
	count(case when item_name = 'Chicken Salad Bowl' then item_name end) as 'Chicken Salad Bowl',
	count(case when item_name = 'Chicken Salad' then item_name end) as 'Chicken Salad'
from orders 
where item_name like '%chicken%'
group by quantity
order by quantity
;

-- the total counts for chicken 
select item_name, count(*)
from orders
where item_name like '%Chicken%'
group by item_name

