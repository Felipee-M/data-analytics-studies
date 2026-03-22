-- ============================================
-- Projeto: Olist Data Analysis
-- Sprint 4: Advanced Queries (Window Functions)
-- Autor: Felipe Mendes
-- Descrição:
-- Conjunto de queries analíticas utilizando
-- Windows Function para geração de insights.
-- ============================================

-- 1) Ranking de vendas
-- Objetivo: Ranquear os produtos com base em volume vendido e receita gerada.

WITH total_revenue AS(
SELECT
	SUM(price) AS total_products_revenue
FROM order_items
),
product_sales_metrics AS(
	SELECT
		oi.product_id,
		COUNT(*) AS total_items_sold,
		SUM(oi.price) AS total_revenue_per_product,
		(SUM(oi.price) / tr.total_products_revenue)*100 AS percent_revenue_share		
	FROM order_items oi
	CROSS JOIN total_revenue tr
	GROUP BY oi.product_id, tr.total_products_revenue 
)
SELECT 
	RANK() OVER(
		ORDER BY psm.total_revenue_per_product DESC, psm.total_items_sold DESC
		) AS ranking_per_product,
	psm.product_id,
	psm.total_revenue_per_product,
	psm.total_items_sold,
	psm.percent_revenue_share,
	SUM(psm.percent_revenue_share ) OVER(
								ORDER BY psm.total_revenue_per_product DESC, psm.total_items_sold DESC
							) AS percent_cumulative_revenue_share
FROM product_sales_metrics AS psm;

-- 2) Ranking de clientes
-- Objetivo: Ranquear os clientes, vou utilizar as métricas de volume e receita dos clientes
-- para ranquear os clientes.

WITH total_revenue AS(
SELECT
	SUM(price + freight_value) AS grand_total_revenue
FROM order_items
),
customer_sales_metrics AS(
	SELECT
		c.customer_unique_id,
		COUNT(*) AS total_items_bought,
		SUM(oi.price + oi.freight_value) AS total_spent,
		(SUM(oi.price + oi.freight_value) / tr.grand_total_revenue)*100 AS percent_spend_per_client		
	FROM customers c
	JOIN orders o
		ON o.customer_id = c.customer_id 
		JOIN order_items oi
			ON oi.order_id = o.order_id 
			CROSS JOIN total_revenue tr
	GROUP BY c.customer_unique_id , tr.grand_total_revenue 
)
SELECT 
	RANK() OVER(
		ORDER BY csm.total_spent DESC, csm.total_items_bought DESC
		) AS ranking_per_client,
	csm.customer_unique_id,
	csm.total_items_bought,
	csm.total_spent,
	csm.percent_spend_per_client,
	SUM(csm.percent_spend_per_client ) OVER(
								ORDER BY csm.total_spent DESC, csm.total_items_bought DESC
							) AS percent_cumulative_spend_per_client
FROM customer_sales_metrics AS csm;

-- 3) MoM
-- Objetivo: Detalhar a evolução mensal com métricas de volume de pedidos e faturamento,
-- destacando a variação absoluta mês a mês.

WITH monthly_metrics AS (
    SELECT
        DATE_TRUNC('month', o.order_approved_at) AS month_with_sales,
        COUNT(DISTINCT o.order_id) AS total_orders_per_month,
        SUM(oi.price + oi.freight_value) AS total_revenue_per_month
    FROM orders o
    JOIN order_items oi
        ON oi.order_id = o.order_id
    WHERE o.order_approved_at IS NOT NULL
    GROUP BY DATE_TRUNC('month', o.order_approved_at)
)
SELECT
    mm.month_with_sales,
    mm.total_orders_per_month,
    mm.total_orders_per_month
        - LAG(mm.total_orders_per_month, 1) OVER (ORDER BY mm.month_with_sales) AS quantity_growth_per_month,
    mm.total_revenue_per_month,
    mm.total_revenue_per_month
        - LAG(mm.total_revenue_per_month, 1) OVER (ORDER BY mm.month_with_sales) AS revenue_growth_per_month
FROM monthly_metrics mm
ORDER BY mm.month_with_sales;

-- 4) Pedidos anteriores de cliente
-- Objetivo: Trazer histórico de pedidos dos clientes.

SELECT
	c.customer_unique_id,
	o.order_id,
	COUNT(*) OVER (PARTITION BY c.customer_unique_id) AS total_orders_per_client,
	ROW_NUMBER() OVER (PARTITION BY c.customer_unique_id ORDER BY o.order_purchase_timestamp) AS orders_sequence_per_client,
	o.order_status,
	FIRST_VALUE(o.order_purchase_timestamp) OVER(PARTITION BY c.customer_unique_id ORDER BY o.order_purchase_timestamp) AS oldest_buy,
	CASE 
		WHEN o.order_approved_at IS NULL THEN o.order_purchase_timestamp
		WHEN o.order_delivered_carrier_date IS NULL THEN o.order_approved_at 
		WHEN o.order_delivered_customer_date IS NULL THEN o.order_delivered_carrier_date 
		ELSE o.order_delivered_customer_date 
	END AS latest_order_status_date,
	t.review_score
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id 
	LEFT JOIN order_reviews t
		ON t.order_id = o.order_id 
ORDER BY oldest_buy, c.customer_unique_id, orders_sequence_per_client
