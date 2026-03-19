-- ============================================
-- Projeto: Olist Data Analysis
-- Sprint 3: Advanced Queries (CTE + Subqueries)
-- Autor: Felipe Mendes
-- Descrição:
-- Conjunto de queries analíticas utilizando
-- CTEs e Subqueries para geração de insights.
-- ============================================

-- ============================================
-- CTEs
-- ============================================

-- 1) Top 10 clientes por receita total
-- Objetivo: identificar os clientes com maior valor acumulado de compras

WITH spend_per_customer AS (
    SELECT
        o.customer_id,
        SUM(oi.price + oi.freight_value) AS total_spend
    FROM orders o
    JOIN order_items oi
        ON oi.order_id = o.order_id
    GROUP BY o.customer_id
)
SELECT
    c.customer_unique_id,
    spc.total_spend AS total_spend
FROM spend_per_customer spc
JOIN customers c
    ON c.customer_id = spc.customer_id
ORDER BY total_spend DESC
LIMIT 10;

-- 2) Produtos mais vendidos
-- Objetivo: identificar os produtos com maior quantidade vendida

WITH sales_per_product AS(
	SELECT
		oi.product_id,
		COUNT(*) AS total_product_sales		
	FROM order_items oi
	GROUP BY oi.product_id
)
SELECT
	p.product_id,
	p.product_category_name AS category,
	spp.total_product_sales
FROM products p
JOIN sales_per_product  spp
	ON spp.product_id = p.product_id 
ORDER BY spp.total_product_sales DESC;

-- 3) Receita mensal
-- Objetivo: identificar a receita mensal

WITH orders_month AS(
	SELECT
		o.order_id,
		DATE_TRUNC('month', o.order_approved_at) AS purchase_month
	FROM orders o
	WHERE o.order_approved_at IS NOT NULL
),
revenue AS (
	SELECT
		oi.order_id,
		SUM(oi.price + oi.freight_value) AS revenue_per_order
	FROM order_items oi
	GROUP BY oi.order_id 
)
SELECT
	om.purchase_month,
	sum(r.revenue_per_order) AS monthly_revenue
FROM orders_month om
JOIN revenue r
	ON r.order_id = om.order_id
GROUP BY om.purchase_month 
ORDER BY monthly_revenue DESC;

-- 4) Clientes recorrentes
-- Objetivo: identificar os clientes que realizaram mais de uma compra

WITH clients AS(
	SELECT
		c.customer_unique_id,
		c.customer_id
	FROM customers c 
),
valid_orders AS(
	SELECT
		o.customer_id
	FROM orders o
	WHERE o.order_approved_at IS NOT NULL
)
SELECT
	c.customer_unique_id,
	COUNT(*) AS total_orders_per_client
FROM clients c
JOIN valid_orders vo
	ON vo.customer_id = c.customer_id
GROUP BY c.customer_unique_id 
HAVING COUNT(*) > 1
ORDER BY total_orders_per_client DESC;

-- 5) Ticket médio por pedido
-- Objetivo: identificar o ticket médio por pedido

WITH total_per_order AS (
	SELECT
		order_id,
		SUM(oi.price + oi.freight_value) AS total_revenue
	FROM order_items oi 
	GROUP BY oi.order_id
),
valid_orders AS(
	SELECT
		o.order_id
	FROM orders o
	WHERE o.order_approved_at IS NOT NULL
)
SELECT 
	AVG(tpo.total_revenue)  AS average_ticket_per_order
FROM total_per_order tpo
JOIN valid_orders vo
	ON tpo.order_id = vo.order_id;

-- ============================================
-- Subqueries
-- ============================================

-- 6) Clientes com gastos acima da média
-- Objetivo: identificar os clientes que gastaram mais do que a média de gasto por cliente.

SELECT
	ct.customer_unique_id,
	ct.total_spend
FROM (
	SELECT
		c.customer_unique_id,
		SUM(oi.price + oi.freight_value) AS total_spend
	FROM customers c
	JOIN orders o
		ON o.customer_id = c.customer_id 
		JOIN order_items oi
			ON oi.order_id = o.order_id
	GROUP BY c.customer_unique_id
	) ct
WHERE ct.total_spend > (
	SELECT AVG(client_total) 
	FROM (
		SELECT 
			c.customer_unique_id,
			SUM(oi.price + oi.freight_value) AS client_total
		FROM customers c
		JOIN orders o
			ON o.customer_id = c.customer_id
		JOIN order_items oi
			ON oi.order_id = o.order_id
		GROUP BY c.customer_unique_id
) avg_base
)
ORDER BY ct.total_spend DESC;

-- 7) Produtos com preço acima da média por produto
-- Objetivo: identificar os produtos cujo preço médio vendido está acima da média dos preços médios por produto

SELECT
	ct.product_id,
	ct.product_value
FROM (
	SELECT
		p.product_id,
		AVG(oi.price) AS product_value
	FROM products p
	JOIN order_items oi
		ON oi.product_id = p.product_id 
	GROUP BY p.product_id
) ct
WHERE product_value > (
	SELECT AVG(sub.product_value) 
	FROM (
		SELECT 
			AVG(oi.price) AS product_value
		FROM order_items oi
		GROUP BY oi.product_id
) sub
)
ORDER BY ct.product_value DESC;

-- 8) Pedidos com valor acima da média
-- Objetivo: identificar os pedidos com valor total acima da média de valor dos pedidos

SELECT
	ct.order_id,
	ct.total_order_value 
FROM (
	SELECT
		oi.order_id,
		SUM(oi.price + oi.freight_value) AS total_order_value
	FROM order_items oi
	GROUP BY oi.order_id
) ct
WHERE ct.total_order_value > (
	SELECT AVG(sub.total_order_value) 
	FROM (
		SELECT 
			SUM(oi.price + oi.freight_value ) AS total_order_value
		FROM order_items oi
		GROUP BY oi.order_id
) sub
)
ORDER BY ct.total_order_value DESC;

-- 9) Clientes com pelo menos 1 pedido entregue
-- Objetivo: identificar os clientes que tiveram ao menos 1 pedido entregue

SELECT
	c.customer_unique_id
FROM customers c
WHERE EXISTS (
	SELECT 1
	FROM orders o
	WHERE o.customer_id = c.customer_id
	  AND o.order_status = 'delivered'
);

-- 10) Meses com receita acima da média mensal
-- Objetivo: identificar os meses com receita acima da média mensal

SELECT
	ct.month_with_sales,
	ct.total_revenue_per_month
FROM (
	SELECT
		DATE_TRUNC('month', o.order_approved_at) AS month_with_sales,
		SUM(oi.price + oi.freight_value) AS total_revenue_per_month
	FROM orders o
	JOIN order_items oi
		ON oi.order_id = o.order_id
	WHERE o.order_approved_at  IS NOT NULL
	GROUP BY DATE_TRUNC('month', o.order_approved_at)
) ct
WHERE ct.total_revenue_per_month >(
		SELECT
			AVG(sub.total_revenue_per_month)
		FROM (
			SELECT 
				DATE_TRUNC('month', o.order_approved_at) AS month_with_sales,
				SUM(oi.price + oi.freight_value) AS total_revenue_per_month
			FROM orders o
			JOIN order_items oi
				ON oi.order_id = o.order_id
			WHERE o.order_approved_at  IS NOT NULL
			GROUP BY DATE_TRUNC('month', o.order_approved_at)
			) sub
)
ORDER BY ct.total_revenue_per_month DESC;