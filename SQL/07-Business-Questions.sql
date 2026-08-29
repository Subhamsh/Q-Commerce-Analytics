--																					Revenue & Category Performance

-- 1. Which product categories generate the highest order volume?

select 
	category,
	count(*) as total_orders
from orders
where order_status = 'Delivered'
group by category
order by total_orders desc;

-- Ans: Fruits & Vegetables generated the highest delivered-order volume with no large difference across categories.

-- 2. Which product categories contribute the most revenue?

select 
	category,
	sum(final_amount_rupees ) as revenue
from orders
where order_status = 'Delivered'
group by category
order by revenue desc;

-- Ans: Electronics generated the highest revenue and there isn't a large difference between categories.

-- 3. Which product categories have the highest Average Order Value (AOV)?

select 
	category,
	round(
			sum(final_amount_rupees) / count(*)
	,2) as aov
from orders
where order_status = 'Delivered'
group by category 
order by aov desc;

-- Ans: Electronics generated the highest Average Order Value and there isn't a large difference between categories

-- 4. Which categories depend most on discounts?

select 
	category,
	count(*) filter (where discount_rupees > 0) as discounted_orders,
	round(
		count(*) filter (where discount_rupees > 0) * 100.0 / count(*)
	,2) as discount_utilization_rate
from orders
where order_status = 'Delivered'
group by category
order by discount_utilization_rate desc;

-- Ans: Beauty & Skincare has the highest percentage of delivered orders receiving discounts.

-- 5. Do discounted orders have a different AOV from non-discounted orders?

select 
	case when discount_rupees > 0 then 'discounted'
		else 'not discounted'
	end as sale_type,
	round(
			sum(final_amount_rupees) / count(*)
	,2) as aov
from orders
where order_status = 'Delivered'
group by sale_type;

-- Ans: Discounted orders have lower AOV than non-discounted ones by 42.65 rupees.

-- 6. How can Average Order Value (AOV) be improved?

-- Ans: The lower AOV observed among discounted orders suggests that the discount strategy should be reviewed and optimized. The business could test discount thresholds or targeted promotions rather than broadly reducing discounts.

--																						Dark Store Performance

-- 7. Which dark stores have the highest cancellation rates with at least average order volume?

with dark_store_cancellation_rate_analysis as
(
	select 
		dark_store_id,
		count(*) as total_orders,
		round(count(*) filter(where order_status = 'Cancelled') * 100.0 / count(*),2) as cancellation_rate
	from orders
	group by dark_store_id
),
avg_total_orders as 
(
	select round(count(*)::numeric / count(distinct dark_store_id)) as avg_order
	from orders
)
select 
	dark_store_id,
	total_orders,
	cancellation_rate 
from dark_store_cancellation_rate_analysis cross join avg_total_orders
where total_orders >= (select * from avg_total_orders)
order by cancellation_rate desc;

-- Ans: Among dark stores with at least average order volume, DS0158 has the highest cancellation rate.

-- 8. Which dark stores lead or lag on revenue, AOV, cancellation rate, and delivery time?

with dark_store_analysis as 
(
	select 
		dark_store_id,
		count(*) filter (where order_status = 'Delivered') as total_orders,
		sum(final_amount_rupees) filter (where order_status = 'Delivered') as revenue,
		round(
				sum(final_amount_rupees)
				filter (
					where order_status = 'Delivered') / 
					nullif(count(*) 
					filter (
						where order_status = 'Delivered')
					,0)
			,2) as aov,
		round(count(*) filter(where order_status = 'Cancelled') * 100.0 / count(*),2) as cancellation_rate,
		round(avg(delivery_time_minutes)filter (where order_status = 'Delivered'),2) as avg_delivery_time
	from orders
	group by dark_store_id
),
ranked_dark_stores as
(
	select 
		*,
		rank() over (order by revenue desc nulls last) as revenue_rank,
		rank() over (order by aov desc nulls last) as aov_rank,
		rank() over (order by cancellation_rate asc) as cancellation_performance_rank,
		rank() over (order by avg_delivery_time asc) as delivery_time_performance_rank
	from dark_store_analysis	
)
select *
from ranked_dark_stores
order by revenue_rank;


/*Ans: Highest Revenue : DS0119 
 * 	   Lowest Revenue : DS0451
 * 	   Highest AOV : DS0229
 * 	   Lowest AOV : DS0493
 * 	   Highest Cancellation Rate: DS0056
 * 	   Lowest Cancellation Rate: DS0393
 * 	   Highest Average Delivery Time:DS0157
 * 	   Lowest Average Delivery Time: DS0479
 */
	

-- 9. Which dark stores have high revenue but also high cancellation/return rates?

-- Dark stores were classified as high revenue or high cancellation/return rate when their metric was above the 75th percentile across all dark stores
with dark_store_analysis as
(
	with dark_store_kpi as
	(
		select 
			dark_store_id,
			sum(final_amount_rupees) filter (where order_status = 'Delivered') as revenue,
			round(count(*) filter(where order_status in ('Cancelled','Returned')) * 100.0 / count(*),2) as cancellation_return_rate
		from orders	
		group by dark_store_id
	),
	percentile_75 as 
	(
    	select
        PERCENTILE_CONT(0.75)
            within group (order by revenue) as high_rev,
        PERCENTILE_CONT(0.75)
            within group (order by cancellation_return_rate) as high_failure_rate
    from dark_store_kpi
	)
select 
	*,
	case when revenue > (select high_rev from percentile_75) then 'High'
	else 'Low'
	end as revenue_type,
	case when cancellation_return_rate > (select high_failure_rate from percentile_75) then 'High'
	else 'Low'
	end as failure_rate_type
from dark_store_kpi
)
select * from dark_Store_analysis
where revenue_type = 'High' and failure_rate_type = 'High';

-- There are 10 Dark Stores which have high revenue and high cancellation/return rate.

-- 10. Which cities experience the most failed orders?

select 
	city,
	count(*) as failed_orders
from orders
where order_status in ('Cancelled','Returned')
group by city
order by failed_orders desc;

-- Chennai has the highest number of failed orders, where failed orders are defined as cancelled or returned orders.

-- 11. Which cities have the highest cancellation and return rates?

select 
	city,
	round(count(*) filter(where order_status in ('Cancelled','Returned')) * 100.0 / count(*),2) as failure_rate
from orders
group by city
order by failure_rate desc;

-- Chennai has the highest cancellation and return rates.

-- 12. How does customer spending vary across locations?

select 
	city,
	round(
			sum(final_amount_rupees) / count(*)
		,2) as aov,
	sum(final_amount_rupees) as revenue,
	count(*) as total_orders
from orders
where order_status = 'Delivered'
group by city
order by aov desc;

-- Hyderabad has the highest Average Order Value, Delhi has the highest revenue and Ahmedabad has made the highest number of delivered orders. There aren't large differences in AOV across cities.

-- 13. What is the relationship between estimated delivery distance and actual delivery time?

select 
	count(*) as number_of_records_in_each_bucket,
	case 
		when estimated_delivery_distance_km < 1 then '<1 km'
		when estimated_delivery_distance_km < 2 then '1-<2 km'
		when estimated_delivery_distance_km < 3 then '2-<3 km'
	else '3+ km'
	end as distance_bucket,
	round(
		avg(delivery_time_minutes)
	,2) as avg_delivery_time
from orders
where 
	estimated_delivery_distance_km is not null 
	and delivery_time_minutes is not null
group by distance_bucket
order by min(estimated_delivery_distance_km);

-- Average delivery time shows a weak positive association with estimated delivery distance. Orders with distances of 3+ km have the highest average delivery time.

-- 14. Which cities and delivery slots have the longest average delivery times?

select 
	city,
	delivery_slot,
	round(
		avg(delivery_time_minutes)
	,2) as avg_delivery_time
from orders
group by 
	city,
	delivery_slot
order by avg_delivery_time desc
limit 10;

-- The 60+ minute delivery slot has the longest average delivery time across all cities, with Chennai recording the highest average at 72.80 minutes

--																						Customer Segments

-- 15. How does AOV differ across New, Returning, and Premium Users?

with avg_aov as 
(
	select
		user_type, 
		round(
				sum(final_amount_rupees) / count(*)
			,2) as aov
	from orders
	where order_status = 'Delivered' 
	group by user_type
) 
select * from avg_aov
order by aov desc;

-- Premium Users have the highest AOV at ₹246.20, followed by Returning Users at ₹245.71 and New Users at ₹245.25. But the differences are very small.

-- 16. Which customer segment contributes the most revenue?

select 
	user_type,
	sum(final_amount_rupees) as revenue
from orders 
where order_status = 'Delivered'
group by user_type
order by revenue desc;

-- New Users contribute the highest delivered revenue, but their revenue is nearly identical to Returning Users. This is consistent with the two groups having nearly identical order volumes and AOVs.

-- 17. On average, how much historical order activity is recorded for Returning vs Premium Users?

select 
	user_type,
	round(
		avg(customer_lifetime_orders)
	,2) as historical_orders
from orders
group by user_type
having user_type != 'New User'           -- New User was excluded from the group as they don't have any number of lifetime orders.
order by historical_orders desc;

-- Premium Users have substantially higher recorded historical order activity than Returning Users, with an average of 114.95 lifetime orders compared with 21.95 for Returning Users.

--																						Customer Experience

-- 18. How does average customer rating vary across cities and customer segments?

select 
	city,
	user_type,
	round(
		avg(customer_rating)
	,2) as avg_rating	
from orders
group by 
	city,
	user_type
order by avg_rating desc;

-- Average customer ratings vary only slightly across cities and user segments, generally remaining close to 4.0, There isn't a large rating difference between segments.






