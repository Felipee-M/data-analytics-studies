ALTER TABLE orders 
ADD CONSTRAINT fk_orders_customer
FOREIGN KEY (customer_id)
REFERENCES customers (customer_id);

ALTER TABLE order_items  
ADD CONSTRAINT fk_order_items_order
FOREIGN KEY (order_id)
REFERENCES orders (order_id);

ALTER TABLE order_payments   
ADD CONSTRAINT fk_order_payments_order
FOREIGN KEY (order_id)
REFERENCES orders (order_id);

ALTER TABLE order_reviews  
ADD CONSTRAINT fk_order_reviews_order
FOREIGN KEY (order_id)
REFERENCES orders (order_id);

ALTER TABLE order_items    
ADD CONSTRAINT fk_order_items_product
FOREIGN KEY (product_id)
REFERENCES products  (product_id);

ALTER TABLE order_items    
ADD CONSTRAINT fk_order_items_seller
FOREIGN KEY (seller_id)
REFERENCES sellers (seller_id);

--Mostra os nomes das FK registradas, quais o nome da tabela e da coluna de origem e em quais elas estão como estrangeiras.
SELECT
    tc.constraint_name,
    tc.table_name,
    kcu.column_name,
    ccu.table_name AS foreign_table_name,
    ccu.column_name AS foreign_column_name
FROM information_schema.table_constraints AS tc
JOIN information_schema.key_column_usage AS kcu
    ON tc.constraint_name = kcu.constraint_name
JOIN information_schema.constraint_column_usage AS ccu
    ON ccu.constraint_name = tc.constraint_name
WHERE tc.constraint_type = 'FOREIGN KEY'
ORDER BY tc.table_name, tc.constraint_name;