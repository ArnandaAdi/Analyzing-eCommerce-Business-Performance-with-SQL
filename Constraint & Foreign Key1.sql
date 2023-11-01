-- =============== Constraint & Foreign Key =============== 


--  product -> order_items

ALTER TABLE order_items 
ADD CONSTRAINT order_items_fk_product 
FOREIGN KEY (product_id) REFERENCES product(product_id) 
ON DELETE CASCADE ON UPDATE CASCADE;

-- seller -> order_items

ALTER TABLE order_items 
ADD CONSTRAINT order_items_fk_seller 
FOREIGN KEY (seller_id) REFERENCES seller(seller_id) 
ON DELETE CASCADE ON UPDATE CASCADE;

-- orders -> order_items

ALTER TABLE order_items 
ADD CONSTRAINT order_items_fk_order 
FOREIGN KEY (order_id) REFERENCES orders(order_id) 
ON DELETE CASCADE ON UPDATE CASCADE;

--  orders -> order_payment

ALTER TABLE order_payment 
ADD CONSTRAINT order_payments_fk 
FOREIGN KEY (order_id) REFERENCES orders(order_id) 
ON DELETE CASCADE ON UPDATE CASCADE;

-- orders -> order_review

ALTER TABLE order_review 
ADD CONSTRAINT order_review_fk 
FOREIGN KEY (order_id) REFERENCES orders(order_id) 
ON DELETE CASCADE ON UPDATE CASCADE;

-- customer -> orders

ALTER TABLE orders 
ADD CONSTRAINT orders_fk 
FOREIGN KEY (customer_id) REFERENCES customer(customer_id) 
ON DELETE CASCADE ON UPDATE CASCADE;

-- geolocation -> customers

ALTER TABLE customer 
ADD CONSTRAINT customer_fk 
FOREIGN KEY (customer_zip_code_prefix) REFERENCES geolocation(geolocation_zip_code_prefix) 
ON DELETE CASCADE ON UPDATE CASCADE;

-- geolocation -> sellers

ALTER TABLE seller 
ADD CONSTRAINT seller_fk 
FOREIGN KEY (seller_zip_code_prefix) REFERENCES geolocation(geolocation_zip_code_prefix) 
ON DELETE CASCADE ON UPDATE CASCADE;