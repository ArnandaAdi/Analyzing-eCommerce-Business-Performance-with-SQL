--Import CSV--
copy customer(
	customer_id,
	customer_unique_id,
	customer_zip_code_prefix,
	customer_city, 
	customer_state
)
FROM 'C:\customers_dataset.csv'
DELIMITER ','
CSV HEADER;

copy geolocation_dirty(
	geolocation_zip_code_prefix,
	geolocation_lat,
	geolocation_lng,
	geolocation_city,
	geolocation_state
)
FROM 'C:\geolocation_dataset.csv'
DELIMITER ','
CSV HEADER;

copy order_items(
	order_id,
	order_item_id,
	product_id,
	seller_id,
	shipping_limit_date,
	price,
	freight_value
)
FROM 'C:\order_items_dataset.csv'
DELIMITER ','
CSV HEADER;

copy order_payment(
	order_id,
	payment_sequential,
	payment_type,
	payment_installments,
	payment_value
)
FROM 'C:\order_payments_dataset.csv'
DELIMITER ','
CSV HEADER;

copy order_review(
	review_id,
	order_id,
	review_score,
	review_comment_title,
	review_comment_message,
	review_creation_date,
	review_answer_timestamp
)
FROM 'C:\order_reviews_dataset.csv'
DELIMITER ','
CSV HEADER;

copy orders(
	order_id,
	customer_id,
	order_status,
	order_purchase_timestamp,
	order_approved_at,
	order_delivered_carrier_date,
	order_delivered_customer_date,
	order_estimated_delivery_date
)
FROM 'C:\orders_dataset.csv'
DELIMITER ','
CSV HEADER;

copy product(
	column1,
	product_id,
	product_category_name,
	product_name_lenght,
	product_description_lenght,
	product_photos_qty,
	product_weight_g, 
	product_length_cm,
	product_height_cm,
	product_width_cm
)
FROM 'C:\product_dataset.csv'
DELIMITER ','
CSV HEADER;

ALTER TABLE product DROP COLUMN column1;

copy seller(
	seller_id,
	seller_zip_code_prefix,
	seller_city,
	seller_state
)
FROM 'C:\sellers_dataset.csv'
DELIMITER ','
CSV HEADER;