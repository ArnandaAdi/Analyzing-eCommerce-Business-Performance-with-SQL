--Create Table--
create table customer(
	customer_id varchar NOT NULL,
	customer_unique_id varchar NULL,
	customer_zip_code_prefix varchar NULL,
	customer_city varchar NULL, 
	customer_state varchar NULL,
	CONSTRAINT customer_pk primary key (customer_id)
);

create table geolocation_dirty(
	geolocation_zip_code_prefix varchar NULL,
	geolocation_lat float NULL,
	geolocation_lng float NULL,
	geolocation_city varchar NULL,
	geolocation_state varchar NULL
);

create table order_items(
	order_id varchar NULL,
	order_item_id int NULL,
	product_id varchar NULL,
	seller_id varchar NULL,
	shipping_limit_date timestamp NULL,
	price float NULL,
	freight_value float NULL
);

create table order_payment(
	order_id varchar NULL,
	payment_sequential int NULL,
	payment_type varchar NULL,
	payment_installments int NULL,
	payment_value float NULL
);

create table order_review(
	review_id varchar NULL,
	order_id varchar NULL,
	review_score int NULL,
	review_comment_title varchar NULL,
	review_comment_message varchar NULL,
	review_creation_date timestamp NULL,
	review_answer_timestamp timestamp NULL
);

create table orders(
	order_id varchar NOT NULL,
	customer_id varchar NULL,
	order_status varchar NULL,
	order_purchase_timestamp timestamp NULL,
	order_approved_at timestamp NULL,
	order_delivered_carrier_date timestamp NULL,
	order_delivered_customer_date timestamp NULL,
	order_estimated_delivery_date timestamp NULL,
	CONSTRAINT orders_pk primary key (order_id)
);

create table product(
	column1 int NULL,
	product_id varchar NOT NULL,
	product_category_name varchar NULL,
	product_name_lenght float NULL,
	product_description_lenght float NULL,
	product_photos_qty float NULL,
	product_weight_g float NULL, 
	product_length_cm float NULL,
	product_height_cm float NULL,
	product_width_cm float NULL,
	CONSTRAINT product_pk primary key (product_id)
);

create table seller(
	seller_id varchar NOT NULL,
	seller_zip_code_prefix varchar NULL,
	seller_city varchar NULL,
	seller_state varchar NULL,
	CONSTRAINT seller_pk primary key (seller_id)
);