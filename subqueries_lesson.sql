USE farmers_market;

-- Lets Review our Tables:
-- TABLE: booth
SELECT *
FROM booth;
-- Contains booth_number, booth_price_level, booth_description, booth_type
-- How could we use it? Lets us know the features of each of the 12 booths in the farmer's market

-- TABLE: customer
SELECT *
FROM customer;
-- Contains customer_id, customer_first_name, customer_last_name, customer_zip
-- How could we use it? Lets us know the names and zip codes of each of the 26 customers in the farmer's market

-- TABLE: customer_purchases
SELECT *
FROM customer_purchases;
-- Contains product_id, vendor_id, market_date, customer_id, quantity, cost_to_customer_per_qty, transaction_time
-- How could we use it? Lets us know details of each purchase made by a customer in the farmers' market

-- TABLE: product_category
SELECT *
FROM product_category;
-- Contains product_category_id, product_category_name
-- How could we use it? Lets us know the name and id number of 7 product categories in the farmers' market

-- TABLE: vendor
SELECT *
FROM vendor;
-- Contains vendor_id, vendor_name, vendor_type, vendor_owner_first_name, vendor_owner_last_name
-- How could we use it? Let's us know the details of each of the 9 vendors in the farmers' market

-- TABLE: vendor_booth_assignments
SELECT *
FROM vendor_booth_assignments;
-- Contains vendor_id, booth_number, market_date
-- How could we use it? Lets us know which booths were assigned to which vendor each day

-- TABLE: vendor_inventory
SELECT *
FROM vendor_inventory;
-- Contains market_date, quantity, vendor_id, product_id, original_price
-- How could we use it? Its not 100% clear, but this may contain info on how much of each product each vendor had at the start or end of a given day

-- TABLE: zip_data
SELECT *
FROM zip_data;
-- Contains zip_code_5, median_household_income, percent_high_income, percent_under_18, percent_over_65
-- people_per_sq_mile, latitude, longitude
-- How could we use it? This gives is socio-economic information about the zip codes related to customers


-- Q1: What is the average minimum temperature across all Saturdays?

SELECT AVG(market_min_temp)
FROM market_date_info
WHERE market_day = 'Saturday';

-- Q2: Generate a report that only returns market_date_info where the market_min_temp was lower than the average 
-- market_min_temp

SELECT *
FROM market_date_info
WHERE market_min_temp < AVG(market_min_temp);
