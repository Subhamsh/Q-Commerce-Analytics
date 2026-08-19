-- public.orders definition

-- Drop table

-- DROP TABLE public.orders;

CREATE TABLE public.orders (
	order_id varchar(20) NULL,
	datetime timestamp NULL,
	is_weekend int4 NULL,
	is_festive_season int4 NULL,
	app varchar(50) NULL,
	city varchar(50) NULL,
	city_tier varchar(50) NULL,
	category varchar(50) NULL,
	items_ordered int4 NULL,
	order_amount_rupees numeric(10, 2) NULL,
	discount_rupees numeric(10, 2) NULL,
	final_amount_rupees numeric(10, 2) NULL,
	delivery_fee_rupees numeric(10, 2) NULL,
	payment_mode varchar(50) NULL,
	delivery_slot varchar(50) NULL,
	delivery_time_minutes numeric(8, 2) NULL,
	dark_store_id varchar(50) NULL,
	order_status varchar(50) NULL,
	cancel_return_reason text NULL,
	customer_rating numeric(2, 1) NULL,
	age_group varchar(50) NULL,
	gender varchar(50) NULL,
	user_type varchar(50) NULL,
	customer_lifetime_orders int4 NULL,
	days_since_last_order int4 NULL,
	promo_code_used varchar(50) NULL,
	estimated_delivery_distance_km numeric(8, 2) NULL
);