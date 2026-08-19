--Total number of rows imported
select count(*)
from orders;

--If order_id is Unique
select count(*)    
from orders
group by order_id 
having count(*)>1;

--NULL checks
SELECT
    COUNT(*) FILTER (WHERE order_id IS NULL) AS order_id_nulls,
    COUNT(*) FILTER (WHERE datetime IS NULL) AS datetime_nulls,
    COUNT(*) FILTER (WHERE is_weekend IS NULL) AS is_weekend_nulls,
    COUNT(*) FILTER (WHERE is_festive_season IS NULL) AS is_festive_season_nulls,
    COUNT(*) FILTER (WHERE app IS NULL) AS app_nulls,
    COUNT(*) FILTER (WHERE city IS NULL) AS city_nulls,
    COUNT(*) FILTER (WHERE city_tier IS NULL) AS city_tier_nulls,
    COUNT(*) FILTER (WHERE category IS NULL) AS category_nulls,
    COUNT(*) FILTER (WHERE items_ordered IS NULL) AS items_ordered_nulls,
    COUNT(*) FILTER (WHERE order_amount_rupees IS NULL) AS order_amount_rupees_nulls,
    COUNT(*) FILTER (WHERE discount_rupees IS NULL) AS discount_rupees_nulls,
    COUNT(*) FILTER (WHERE final_amount_rupees IS NULL) AS final_amount_rupees_nulls,
    COUNT(*) FILTER (WHERE delivery_fee_rupees IS NULL) AS delivery_fee_rupees_nulls,
    COUNT(*) FILTER (WHERE payment_mode IS NULL) AS payment_mode_nulls,
    COUNT(*) FILTER (WHERE delivery_slot IS NULL) AS delivery_slot_nulls,
    COUNT(*) FILTER (WHERE delivery_time_minutes IS NULL) AS delivery_time_minutes_nulls,
    COUNT(*) FILTER (WHERE dark_store_id IS NULL) AS dark_store_id_nulls,
    COUNT(*) FILTER (WHERE order_Status IS NULL) AS order_status_nulls,
    COUNT(*) FILTER (WHERE cancel_return_reason IS NULL) AS cancel_return_reason_nulls,
    COUNT(*) FILTER (WHERE cancel_return_reason = '') AS cancel_return_reason_blanks,                             --blank check
    COUNT(*) FILTER (WHERE customer_rating IS NULL) AS customer_rating_nulls,
    COUNT(*) FILTER (WHERE age_group IS NULL) AS age_group_nulls,
    COUNT(*) FILTER (WHERE gender IS NULL) AS gender_nulls,
    COUNT(*) FILTER (WHERE user_type IS NULL) AS user_type_nulls,
    COUNT(*) FILTER (WHERE customer_lifetime_orders IS NULL) AS customer_lifetime_orders_nulls,
    COUNT(*) FILTER (WHERE days_since_last_order IS NULL) AS days_since_last_order_nulls,
    COUNT(*) FILTER (WHERE promo_code_used IS NULL) AS promo_code_used_nulls,
    COUNT(*) FILTER (WHERE promo_code_used = '') AS promo_code_used_blanks,                                       --blank check
    COUNT(*) FILTER (WHERE estimated_delivery_distance_km IS NULL) AS estimated_delivery_distance_nulls
FROM orders;

--Range MIN-MAX checks
select
    MIN(datetime) AS earliest_date,
    MAX(datetime) AS latest_date,
    MIN(items_ordered) AS min_items_ordered,
    MAX(items_ordered) AS max_items_ordered,
    MIN(order_amount_rupees) AS min_order_amount,
    MAX(order_amount_rupees) AS max_order_amount,
    MIN(discount_rupees) AS min_discount,
    MAX(discount_rupees) AS max_discount,
    MIN(final_amount_rupees) AS min_final_amount,
    MAX(final_amount_rupees) AS max_final_amount,
    MIN(delivery_fee_rupees) AS min_delivery_fee,
    MAX(delivery_fee_rupees) AS max_delivery_fee,
    MIN(delivery_time_minutes) AS min_delivery_time,
    MAX(delivery_time_minutes) AS max_delivery_time,
    MIN(customer_rating) AS min_rating,
    MAX(customer_rating) AS max_rating,
    MIN(customer_lifetime_orders) AS min_customer_lifetime_orders,
    MAX(customer_lifetime_orders) AS max_customer_lifetime_orders,
    MIN(days_since_last_order) AS min_days_since_last_order,
    MAX(days_since_last_order) AS max_days_since_last_order,
    MIN(estimated_delivery_distance_km) AS min_estimated_delivery_distance,
    MAX(estimated_delivery_distance_km) AS max_estimated_delivery_distance
FROM orders;

--Logical formula check
SELECT COUNT(*) AS mismatches
FROM orders
WHERE ROUND(order_amount_rupees - discount_rupees, 2) != ROUND(final_amount_rupees, 2);

--New User validation 
SELECT COUNT(*) AS invalid_new_users
FROM orders
WHERE user_type = 'New User'
  AND customer_lifetime_orders != 0;

SELECT COUNT(*) AS invalid_new_users
FROM orders
WHERE user_type = 'New User'
  AND days_since_last_order IS NOT NULL;

-- Standardize empty strings as SQL NULL

UPDATE orders
SET cancel_return_reason = NULL
WHERE TRIM(cancel_return_reason) = ''; --Replacing the values that have only spaces or missing

UPDATE orders
SET promo_code_used = NULL
WHERE TRIM(promo_code_used) = '';
