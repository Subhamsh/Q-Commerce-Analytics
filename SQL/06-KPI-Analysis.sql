--																					KPI Analysis
-- Total Orders- All orders including all order statuses

-- Delivered Orders- Number of orders that are Delivered

-- Cancelled Orders- Number of orders that are Cancelled

-- Returned Orders- Number of orders that are Returned

-- Revenue- Final amount from delivered orders

-- AOV- Delivered Revenue / Delivered Orders

-- Delivery Rate- Delivered Orders / Total Orders

-- Cancellation Rate- Cancelled Orders / Total Orders

-- Return Rate- Returned Orders / Total Orders

-- Cancellation + Return Rate- (Cancelled Orders+ Returned Orders) / Total Orders

-- Average Delivery Time - AVG(delivery_time_minutes) for delivered orders

-- Average Customer Rating- Average rating among rated orders

-- Discount Utilization Rate- Percentage of orders in a group that received a discount

--																				KPI Analysis Query

with kpi_analysis as 
(
	select 
		count(*) as total_orders,
		sum(final_amount_rupees) filter(where order_status = 'Delivered') as revenue,
		round(
			sum(final_amount_rupees) 
			filter(
				where order_status = 'Delivered') / 
			count(*) 
			filter(
				where order_status = 'Delivered')
		,2) as AOV,
		count(*) filter(where order_status = 'Delivered') as delivered_orders,
		round(
			count(*)
			filter(
				where order_status = 'Delivered'
				)*100.0/(nullif(count(*),0))::numeric
		,2) as delivery_rate,
		count(*) filter(where order_status = 'Cancelled') as cancelled_orders,
		round(
			count(*)
			filter(
				where order_status = 'Cancelled'
				)*100.0/(nullif(count(*),0))::numeric
		,2) as cancellation_rate,
		count(*) filter(where order_status = 'Returned') as returned_orders,
		round(
			count(*)
			filter(
				where order_status = 'Returned'
				)*100.0/(nullif(count(*),0))::numeric
		,2) as return_rate,
		round(
			count(*)
			filter(
				where order_status in ('Cancelled','Returned')
				)*100.0/(nullif(count(*),0))::numeric
		,2) as cancellation_return_rate,
		round(
			avg(delivery_time_minutes) filter(where order_status = 'Delivered')
		,2)	as average_delivery_time,
		round(
			avg(customer_rating)
		,2) as average_customer_rating,
		round(
			count(*) 
			filter (
				where discount_rupees > 0
				)*100.0 /(nullif(count(*),0)) :: numeric
		,2) as discount_utilization_rate
		from orders
)
select *
from kpi_analysis;
--																				City Kpi Analysis Query
with city_kpi_analysis as 
(
	select 
		city,
		count(*) as total_orders,
		sum(final_amount_rupees) filter(where order_status = 'Delivered') as revenue,
		round(
			sum(final_amount_rupees) 
			filter(
				where order_status = 'Delivered') / 
			count(*) 
			filter(
				where order_status = 'Delivered')
		,2) as AOV,
		count(*) filter(where order_status = 'Delivered') as delivered_orders,
		round(
			count(*)
			filter(
				where order_status = 'Delivered'
				)*100.0/(nullif(count(*),0))::numeric
		,2) as delivery_rate,
		count(*) filter(where order_status = 'Cancelled') as cancelled_orders,
		round(
			count(*)
			filter(
				where order_status = 'Cancelled'
				)*100.0/(nullif(count(*),0))::numeric
		,2) as cancellation_rate,
		count(*) filter(where order_status = 'Returned') as returned_orders,
		round(
			count(*)
			filter(
				where order_status = 'Returned'
				)*100.0/(nullif(count(*),0))::numeric
		,2) as return_rate,
		round(
			count(*)
			filter(
				where order_status in ('Cancelled','Returned')
				)*100.0/(nullif(count(*),0))::numeric
		,2) as cancellation_return_rate,
		round(
			avg(delivery_time_minutes) filter(where order_status = 'Delivered')
		,2)	as average_delivery_time,
		round(
			avg(customer_rating)
		,2) as average_customer_rating,
		round(
			count(*) 
			filter (
				where discount_rupees > 0
				)*100.0 /(nullif(count(*),0)) :: numeric
		,2) as discount_utilization_rate
		from orders
		group by city
)
select *
from city_kpi_analysis
order by revenue desc;
--																			Dark Store KPI Analysis Query
with dark_store_kpi_analysis as 
(
	select 
		dark_store_id,
		count(*) as total_orders,
		sum(final_amount_rupees) filter(where order_status = 'Delivered') as revenue,
		round(
			sum(final_amount_rupees) 
			filter(
				where order_status = 'Delivered') / 
			count(*) 
			filter(
				where order_status = 'Delivered')
		,2) as AOV,
		count(*) filter(where order_status = 'Delivered') as delivered_orders,
		round(
			count(*)
			filter(
				where order_status = 'Delivered'
				)*100.0/(nullif(count(*),0))::numeric
		,2) as delivery_rate,
		count(*) filter(where order_status = 'Cancelled') as cancelled_orders,
		round(
			count(*)
			filter(
				where order_status = 'Cancelled'
				)*100.0/(nullif(count(*),0))::numeric
		,2) as cancellation_rate,
		count(*) filter(where order_status = 'Returned') as returned_orders,
		round(
			count(*)
			filter(
				where order_status = 'Returned'
				)*100.0/(nullif(count(*),0))::numeric
		,2) as return_rate,
		round(
			count(*)
			filter(
				where order_status in ('Cancelled','Returned')
				)*100.0/(nullif(count(*),0))::numeric
		,2) as cancellation_return_rate,
		round(
			avg(delivery_time_minutes) filter(where order_status = 'Delivered')
		,2)	as average_delivery_time,
		round(
			avg(customer_rating)
		,2) as average_customer_rating,
		round(
			count(*) 
			filter (
				where discount_rupees > 0
				)*100.0 /(nullif(count(*),0)) :: numeric
		,2) as discount_utilization_rate
		from orders
		group by dark_store_id
)
select *
from dark_store_kpi_analysis
order by cancellation_return_rate desc;
--																			Category KPI Analysis Query
with category_kpi_analysis as 
(
	select 
		category,
		count(*) as total_orders,
		sum(final_amount_rupees) filter(where order_status = 'Delivered') as revenue,
		round(
			sum(final_amount_rupees) 
			filter(
				where order_status = 'Delivered') / 
			count(*) 
			filter(
				where order_status = 'Delivered')
		,2) as AOV,
		count(*) filter(where order_status = 'Delivered') as delivered_orders,
		round(
			count(*)
			filter(
				where order_status = 'Delivered'
				)*100.0/(nullif(count(*),0))::numeric
		,2) as delivery_rate,
		count(*) filter(where order_status = 'Cancelled') as cancelled_orders,
		round(
			count(*)
			filter(
				where order_Status = 'Cancelled'
				)*100.0/(nullif(count(*),0))::numeric
		,2) as cancellation_rate,
		count(*) filter(where order_status = 'Returned') as returned_orders,
		round(
			count(*)
			filter(
				where order_status = 'Returned'
				)*100.0/(nullif(count(*),0))::numeric
		,2) as return_rate,
		round(
			count(*)
			filter(
				where order_status in ('Cancelled','Returned')
				)*100.0/(nullif(count(*),0))::numeric
		,2) as cancellation_return_rate,
		round(
			avg(delivery_time_minutes) filter(where order_status = 'Delivered')
		,2)	as average_delivery_time,
		round(
			avg(customer_rating)
		,2) as average_customer_rating,
		round(
			count(*) 
			filter (
				where discount_rupees > 0
				)*100.0 /(nullif(count(*),0)) :: numeric
		,2) as discount_utilization_rate
		from orders
		group by category
)
select *
from category_kpi_analysis
order by revenue desc;
--																			User Type KPI Analysis Query
with user_type_kpi_analysis as 
(
	select 
		user_type,
		count(*) as total_orders,
		sum(final_amount_rupees) filter(where order_status = 'Delivered') as revenue,
		round(
			sum(final_amount_rupees) 
			filter(
				where order_status = 'Delivered') / 
			count(*) 
			filter(
				where order_status = 'Delivered')
		,2) as AOV,
		count(*) filter(where order_status = 'Delivered') as delivered_orders,
		round(
			count(*)
			filter(
				where order_status = 'Delivered'
				)*100.0/(nullif(count(*),0))::numeric
		,2) as delivery_rate,
		count(*) filter(where order_status = 'Cancelled') as cancelled_orders,
		round(
			count(*)
			filter(
				where order_status = 'Cancelled'
				)*100.0/(nullif(count(*),0))::numeric
		,2) as cancellation_rate,
		count(*) filter(where order_status = 'Returned') as returned_orders,
		round(
			count(*)
			filter(
				where order_status = 'Returned'
				)*100.0/(nullif(count(*),0))::numeric
		,2) as return_rate,
		round(
			count(*)
			filter(
				where order_status in ('Cancelled','Returned')
				)*100.0/(nullif(count(*),0))::numeric
		,2) as cancellation_return_rate,
		round(
			avg(delivery_time_minutes) filter(where order_status = 'Delivered')
		,2)	as average_delivery_time,
		round(
			avg(customer_rating)
		,2) as average_customer_rating,
		round(
			count(*) 
			filter (
				where discount_rupees > 0
				)*100.0 /(nullif(count(*),0)) :: numeric
		,2) as discount_utilization_rate
		from orders
		group by user_type
)
select *
from user_type_kpi_analysis
order by revenue desc;


	