-- Dataset Profile

-- Total number of orders - 1,00000
select count(order_id) as total_orders
from orders;

-- Total Revenue - 2,22,33645.67
select sum(final_amount_rupees) as total_revenue
from orders
where order_status = 'Delivered';

-- Number of distinct cities - 8
select count(distinct city) as number_of_cities
from orders;

-- City Names
select distinct city 
from orders;

/* Bangaluru
 * Mumbai
 * Kolkata
 * Delhi
 * Chennai
 * Pune
 * Ahmedabad
 * Hyderabad
 */

-- Number of dark stores - 499
select count(distinct dark_store_id) as number_of_darkstores
from orders;

-- Category names
select distinct category 
from orders;

/*Groceries & Staples
  Electronics
  Dairy & Eggs
  Fruits & Vegetables
  Household
  Beauty & Skincare
  Snacks & Beverages
  Personal Care
  Baby Products
  Medicines
*/

--User types
select distinct user_type
from orders;

/* Returning User
 * Premium User
 * New User
 */

-- Order Status
select distinct order_Status 
from orders;

/* Delivered
 * Returned
 * Cancelled
 */
--                                                                                Order Status Distribution
/*
 * Delivered	90,544
   Returned		1,908
   Cancelled	7,548
 */

select order_Status, count(order_id) as total_orders, (count(order_id)*100)/sum(count(order_id)) over() as percentage
from orders 
group by order_Status;


--                                                                             User Type/Customer Distribution
-- Revenue by user types

/*Returning User	98,80879.51
  Premium User		24,69585.59
  New User			98,83180.57
*/

select user_Type, sum(final_amount_rupees) as revenue
from orders 
where order_status = 'Delivered'
group by user_type;

-- Number of orders by User types

/*Returning User	44,416
  Premium User	    11,114
  New User	        44,470
*/

select user_type, count(order_id) as total_orders
from orders 
group by user_type;

-- AOV by user types
/*New User			245.25
  Premium User		246.20
  Returning User	245.71
*/
select user_Type, round(sum(final_amount_rupees)/count(order_id),2) as AOV
from orders 
where order_status = 'Delivered'
group by user_type;

-- Average lifetime orders by user types
/*
 * Returning User	21.95
   Premium User		114.95
   New User			0
 */
select user_type, round(avg(customer_lifetime_orders),2) as avg_lifetime_orders
from orders
group by user_type;

-- Average days since last order by user types
/*Returning User	30.64
  Premium User		7.56
  New User			null
*/
select user_type, round(avg(days_since_last_order ),2) as avg_days_since_last_order
from orders
group by user_type;

--                                                                                Revenue Distribution
-- Minimum Order Value - 69.3 rupees
select min(final_amount_rupees) as minimum_order_value
from orders;

-- Maximum Order Value - 5000 rupees
select max(final_amount_rupees) as maximum_order_value
from orders;

-- Average Order Value - 245.56 rupees
select round(sum(final_amount_rupees) / count(order_id),2) as AOV
from orders
where order_status = 'Delivered';

--                                                                                Category Distribution
-- Revenue by categories
/*Groceries & Staples	22,05546.47		245.74
  Dairy & Eggs			22,14706.79		243.70
  Electronics			23,43202.37		244.02
  Fruits & Vegetables	22,39501.70		257.78
  Household				22,09862.65		244.91
  Beauty & Skincare		22,00822.62		244.44
  Snacks & Beverages	22,24408.60		242.79
  Personal Care			22,15946.56		243.57
  Baby Products			21,75805.81		243.62
  Medicines				22,03842.10		244.98
*/
select category, sum(final_amount_rupees) as revenue, round(sum(final_amount_rupees) / count(order_id),2) as AOV
from orders 
where order_status = 'Delivered'
group by category;

-- Number of orders(all statuses) by categories
/*Groceries & Staples	9,997
 Electronics			10,036
 Dairy & Eggs			10,048
 Fruits & Vegetables	10,064
 Household				10,074
 Beauty & Skincare		10,004
 Snacks & Beverages		9,982
 Personal Care			10,003
 Baby Products			9,822
 Medicines				9,970
*/
select category, count(order_id) as total_orders
from orders
group by category;

--																				   City Distribution
-- Revenue by Cities
/*Bengaluru		28,07498.05		245.74
  Mumbai		27,61410.90		246.90
  Kolkata		27,55256.90		244.33
  Delhi			28,11024.37		246.95
  Chennai		27,00104.30		247.15
  Pune			27,85385.69		244.02
  Hyderabad		28,07404.65		244.98
  Ahmedabad		28,05560.81		244.33
*/
select city, sum(final_amount_rupees) as revenue, round(sum(final_amount_rupees) / count(order_id),2) as AOV
from orders
where order_status = 'Delivered'
group by city;

-- Number of orders(all statuses) by Cities
/*Bengaluru		12,555
  Mumbai		12,485
  Kolkata		12,497
  Delhi			12,522
  Chennai		12,268
  Pune			12,607
  Ahmedabad		12,562
  Hyderabad		12,504
*/
select city, count(order_id) as total_orders
from orders
group by city;

--																				Dark Store Exploration
-- Revenue by darkstore
select dark_store_id, sum(final_amount_rupees) as revenue
from orders
where order_status = 'Delivered'
group by dark_store_id 
order by revenue desc;

-- Number of orders(all statuses) by darkstore
select dark_store_id, count(order_id) as total_orders, count(order_id) filter(where order_status = 'Cancelled' or order_status  = 'Returned') as cancel_return_count, 
	round((count(order_id)filter(where order_status = 'Cancelled' or order_status  = 'Returned') * 100):: numeric / count(order_id),2) as cancellation_return_rate
from orders
group by dark_store_id 
order by cancellation_return_rate desc;

--																				Delivery Exploration
-- Average Delivery Time of Delivered orders- 40.24
select round(avg(delivery_time_minutes),2) 
from orders
where order_status = 'Delivered';

-- Delivery time by city
select city, round(avg(delivery_time_minutes),2) as avg_delivery_time
from orders
where order_status = 'Delivered'
group by city;

-- Delivery time by Dark store
select dark_store_id, round(avg(delivery_time_minutes),2) as avg_delivery_time
from orders
where order_status = 'Delivered'
group by dark_store_id
order by avg_delivery_time asc;

-- Delivery time by Delivery slot
select delivery_slot, round(avg(delivery_time_minutes),2) as avg_delivery_time
from orders
where order_status = 'Delivered'
group by delivery_slot
order by avg_delivery_time asc;

-- Average Distance by Delivery Time bracket
select 
	case 
		when delivery_time_minutes <= 20 then '0-20 minutes'
		when delivery_time_minutes <= 60 then '21-60 minutes'
		when delivery_time_minutes <=100 then '61-100 minutes'
	else '100+ minutes'
	end as deliverytime_bucket,
	count(order_id) as total_order,
	round(avg(estimated_delivery_distance_km),2) as avg_distance
from orders
where delivery_time_minutes is not null and order_status = 'Delivered'
group by deliverytime_bucket
order by min(delivery_time_minutes);

--																				Discount Exploration
-- Number of orders with discount - 53,241
select count(order_id) as total_orders
from orders
where discount_rupees > 0 and discount_rupees is not null;

-- Average discount - 42.66
select round(avg(discount_rupees),2) as avg_discount
from orders
where discount_rupees > 0;

-- Discount by category - 
select category, round(avg(discount_rupees),2) as avg_discount
from orders 
where discount_rupees > 0
group by category;

--AOV with discount - 225.93
select round(sum(final_amount_rupees) / count(order_id),2) as AOV
from orders 
where discount_rupees > 0;

--AOV without discount - 268.61
select round(sum(final_amount_rupees) / count(order_id),2) as AOV
from orders 
where discount_rupees = 0;

--																				 Time Exploration
-- Peak order hours
select 
	case 
		when extract(hour from datetime) between 0 and 5 then 'Between 12 am to 5:59 am'
		when extract(hour from datetime) between 6 and 11 then 'Between 6 am to 11:59 am'
		when extract(hour from datetime) between 12 and 17 then 'Between 12 pm to 5:59 pm'
		when extract(hour from datetime) between 18 and 23 then 'Between 6 pm to 11:59 pm'
	end as time_bucket,
	count(order_id) as total_orders
from orders
group by time_bucket
order by min(extract(hour from datetime));
	

-- Weekday vs Weekend

select 
	case
		when is_weekend = 0 then 'Weekday'
		else 'Weekend'
	end as day_type,
count(order_id) as total_orders	
from orders
group by day_type;

-- Order Month pattern
select extract (month from datetime) as month_number, to_char(datetime,'Month') as month_name, count(order_id) as total_orders
from orders
group by month_number, month_name
order by month_number;

--																		Customer Rating Exploration
-- Average Rating - 3.98 - It is calculated using rated orders only, missing ratings are excluded
select round(avg(customer_rating),2) as avg_customer_rating
from orders;

-- Average Rating by City
select city, round(avg(customer_rating),2) as avg_customer_rating
from orders
group by city;

-- Average Rating by Usertype
select user_type, round(avg(customer_rating),2) as avg_customer_rating
from orders
group by user_type;

--																		Payment Method Distribution		
select payment_mode, count(order_id) AS total_orders, round(sum(final_amount_rupees),2) as revenue
from orders
where order_status = 'Delivered'
group by payment_mode
order by total_orders desc;



