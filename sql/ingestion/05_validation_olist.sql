-- ============================================================================
-- OLIST VALIDATION
-- ============================================================================
-- Objetivo:
-- Validar a carga inicial, checar duplicidades e verificar integridade
-- relacional entre as tabelas do dataset Olist.
-- ============================================================================


-- ============================================================================
-- 1. CONTAGEM DE REGISTROS
-- ============================================================================

SELECT 'olist.customers' AS tabela, COUNT(*) FROM olist.customers
UNION ALL
SELECT 'olist.geolocation', COUNT(*) FROM olist.geolocation
UNION ALL
SELECT 'olist.order_items', COUNT(*) FROM olist.order_items
UNION ALL
SELECT 'olist.order_payments', COUNT(*) FROM olist.order_payments
UNION ALL
SELECT 'olist.order_reviews', COUNT(*) FROM olist.order_reviews
UNION ALL
SELECT 'olist.orders', COUNT(*) FROM olist.orders
UNION ALL
SELECT 'olist.products', COUNT(*) FROM olist.products
UNION ALL
SELECT 'olist.sellers', COUNT(*) FROM olist.sellers
UNION ALL
SELECT 'olist.product_category_name_translation', COUNT(*) FROM olist.product_category_name_translation;

-- ============================================================================
-- 2. CHECAGEM DE DUPLICIDADES E VERIFICAÇÃO DE INTEGRIDADE RELACIONAL
-- ============================================================================

SELECT
    o.order_id,
    COUNT(oi.order_item_id) AS qtd_itens
FROM olist.orders o
LEFT JOIN olist.order_items oi
    ON o.order_id = oi.order_id
GROUP BY o.order_id
LIMIT 10;

SELECT
    oi.order_id,
    oi.product_id,
    p.product_category_name
FROM olist.order_items oi
LEFT JOIN olist.products p
    ON oi.product_id = p.product_id
LIMIT 10;

SELECT COUNT(*) AS total_orders
FROM olist.orders;

SELECT COUNT(*) AS total_linhas_join
FROM olist.orders o
JOIN olist.order_items oi
    ON o.order_id = oi.order_id;

SELECT
    oi.product_id,
    COUNT(*) AS qtd_itens
FROM olist.products p
JOIN olist.order_items oi
    ON p.product_id = oi.product_id
GROUP BY oi.product_id
LIMIT 10;

SELECT
    product_id,
    COUNT(*) AS qtd
FROM olist.products
GROUP BY product_id
HAVING COUNT(*) > 1;

SELECT
    customer_id,
    COUNT(*) AS qtd
FROM olist.customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

SELECT
    seller_id,
    COUNT(*) AS qtd
FROM olist.sellers
GROUP BY seller_id
HAVING COUNT(*) > 1;

SELECT
    order_id,
    COUNT(*) AS qtd
FROM olist.orders
GROUP BY order_id
HAVING COUNT(*) > 1;

SELECT COUNT(*) AS orders_sem_order_id
FROM olist.orders
WHERE order_id IS NULL;

SELECT COUNT(*) AS orders_sem_customer_id
FROM olist.orders
WHERE customer_id IS NULL;

SELECT COUNT(*) AS items_sem_order_id
FROM olist.order_items
WHERE order_id IS NULL;

SELECT COUNT(*) AS items_sem_product_id
FROM olist.order_items
WHERE product_id IS NULL;

SELECT COUNT(*) AS items_sem_seller_id
FROM olist.order_items
WHERE seller_id IS NULL;

SELECT COUNT(*) AS products_sem_product_id
FROM olist.products
WHERE product_id IS NULL;

SELECT COUNT(*) AS customers_sem_customer_id
FROM olist.customers
WHERE customer_id IS NULL;

SELECT COUNT(*) AS sellers_sem_seller_id
FROM olist.sellers
WHERE seller_id IS NULL;

SELECT COUNT(*) AS itens_sem_produto
FROM olist.order_items oi
LEFT JOIN olist.products p
    ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;

SELECT COUNT(*) AS itens_sem_pedido
FROM olist.order_items oi
LEFT JOIN olist.orders o
    ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;

SELECT COUNT(*) AS pedidos_sem_cliente
FROM olist.orders o
LEFT JOIN olist.customers c
    ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

SELECT COUNT(*) AS itens_sem_vendedor
FROM olist.order_items oi
LEFT JOIN olist.sellers s
    ON oi.seller_id = s.seller_id
WHERE s.seller_id IS NULL;

SELECT COUNT(*) AS pagamentos_sem_pedido
FROM olist.order_payments op
LEFT JOIN olist.orders o
    ON op.order_id = o.order_id
WHERE o.order_id IS NULL;

SELECT COUNT(*) AS reviews_sem_pedido
FROM olist.order_reviews r
LEFT JOIN olist.orders o
    ON r.order_id = o.order_id
WHERE o.order_id IS NULL;

-- Observação:
-- O dataset possui categorias sem tradução na tabela
-- product_category_name_translation. Isso é esperado.
SELECT COUNT(*) AS produtos_sem_traducao_categoria
FROM olist.products p
LEFT JOIN olist.product_category_name_translation t
    ON p.product_category_name = t.product_category_name
WHERE p.product_category_name IS NOT NULL
  AND t.product_category_name IS NULL;