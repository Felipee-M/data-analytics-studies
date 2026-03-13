CREATE SCHEMA IF NOT EXISTS olist;

DROP TABLE IF EXISTS olist.customers;

CREATE TABLE olist.customers (
    customer_id TEXT,
    customer_unique_id TEXT,
    customer_zip_code_prefix INT,
    customer_city TEXT,
    customer_state TEXT
);

COPY olist.customers
FROM '/caminho/para/olist_customers_dataset.csv'
DELIMITER ','
CSV HEADER
ENCODING 'UTF8';

DROP TABLE IF EXISTS olist.geolocation;

CREATE TABLE olist.geolocation (
    geolocation_zip_code_prefix INT,
    geolocation_lat NUMERIC,
    geolocation_lng NUMERIC,
    geolocation_city TEXT,
    geolocation_state TEXT
);

COPY olist.geolocation
FROM '/caminho/para/olist_geolocation_dataset.csv'
DELIMITER ','
CSV HEADER
ENCODING 'UTF8';

DROP TABLE IF EXISTS olist.orders;

CREATE TABLE olist.orders (
    order_id TEXT,
    customer_id TEXT,
    order_status TEXT,
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP
);

COPY olist.orders
FROM '/caminho/para/olist_orders_dataset.csv'
DELIMITER ','
CSV HEADER
ENCODING 'UTF8';

DROP TABLE IF EXISTS olist.order_items;

CREATE TABLE olist.order_items (
    order_id TEXT,
    order_item_id INT,
    product_id TEXT,
    seller_id TEXT,
    shipping_limit_date TIMESTAMP,
    price NUMERIC(10,2),
    freight_value NUMERIC(10,2)
);

COPY olist.order_items
FROM '/caminho/para/olist_order_items_dataset.csv'
DELIMITER ','
CSV HEADER
ENCODING 'UTF8';

DROP TABLE IF EXISTS olist.order_payments;

CREATE TABLE olist.order_payments (
    order_id TEXT,
    payment_sequential INT,
    payment_type TEXT,
    payment_installments INT,
    payment_value NUMERIC(10,2)
);

COPY olist.order_payments
FROM '/caminho/para/olist_order_payments_dataset.csv'
DELIMITER ','
CSV HEADER
ENCODING 'UTF8';

DROP TABLE IF EXISTS olist.order_reviews;

CREATE TABLE olist.order_reviews (
    review_id TEXT,
    order_id TEXT,
    review_score INT,
    review_comment_title TEXT,
    review_comment_message TEXT,
    review_creation_date TIMESTAMP,
    review_answer_timestamp TIMESTAMP
);

COPY olist.order_reviews
FROM '/caminho/para/olist_order_reviews_dataset.csv'
DELIMITER ','
CSV HEADER
ENCODING 'UTF8';

DROP TABLE IF EXISTS olist.products;

CREATE TABLE olist.products (
    product_id TEXT,
    product_category_name TEXT,
    product_name_lenght INT,
    product_description_lenght INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT
);

COPY olist.products
FROM '/caminho/para/olist_products_dataset.csv'
DELIMITER ','
CSV HEADER
ENCODING 'UTF8';

DROP TABLE IF EXISTS olist.sellers;

CREATE TABLE olist.sellers (
    seller_id TEXT,
    seller_zip_code_prefix INT,
    seller_city TEXT,
    seller_state TEXT
);

COPY olist.sellers
FROM '/caminho/para/olist_sellers_dataset.csv'
DELIMITER ','
CSV HEADER
ENCODING 'UTF8';

DROP TABLE IF EXISTS olist.product_category_name_translation;

CREATE TABLE olist.product_category_name_translation (
    product_category_name TEXT,
    product_category_name_english TEXT
);

COPY olist.product_category_name_translation
FROM '/caminho/para/product_category_name_translation.csv'
DELIMITER ','
CSV HEADER
ENCODING 'UTF8';


