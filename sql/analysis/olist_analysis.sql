--1)Métricas de volume

--Total pedidos
select
	count(*) as total_orders 
from orders;

--Clientes total
select distinct
	count(*) as total_customers 
from customers;

--Vendedores totais
select 
	count (*) as total_sellers 
from sellers;

--Produtos totais
select 
	count (*) as total_products 
from products;

--Total de itens por pedido
select 
	count (*) as total_order_items 
from order_items;

--2)Métricas financeiras

--Faturamento total
select 
	sum(payment_value) as faturamento_total 
from order_payments;

--Faturamento por pedido
select 
	order_id,
	sum(payment_value) as faturamento_por_pedido 
from order_payments 
group by order_id 
order by faturamento_por_pedido desc;

--Ticket médio
select 
	(sum(payment_value)/count(*)) as average_ticket
from order_payments;

--Faturamento por categoria
select
	products.product_category_name as category_name,
	sum(payment_value) as faturamento_total
from products
left join order_items
	on order_items.product_id = products.product_id 
	left join order_payments
		on order_payments.order_id = order_items.order_id 
group by category_name
order by faturamento_total desc;

--Faturamento por vendedor/loja
select
	sellers.seller_id,
	seller_city,
	seller_state,
	sum(payment_value) as faturamento_total
from sellers
left join order_items
	on order_items.seller_id = sellers.seller_id  
	left join order_payments
		on order_payments.order_id = order_items.order_id 
group by sellers.seller_id
order by faturamento_total desc;


--Tempo médio de entrega
select
	avg(order_delivered_customer_date-order_delivered_carrier_date) as average_time_delivery
from orders;

--Pedidos entregues vs cancelados
select
	order_status,
	count(order_status) total
from orders
where order_status in('canceled', 'delivered')	
group by order_status;

--Pedidos atrasados
select
	count(*) orders_delayed
from orders
where order_delivered_customer_date > order_estimated_delivery_date;

--Média de avaliação de pedidos
select
	avg(review_score) as average_review_score
from order_reviews;

--Vendas por estado
select
	seller_state,
	count(orders.order_id) as total_sales
from sellers
left join order_items
	on order_items.seller_id = sellers.seller_id  
	left join orders
		on order_items.order_id = orders.order_id 
group by seller_state
order by total_sales desc;

--Vendas por categoria
select
	products.product_category_name as category_name,
	count(orders.order_id) as total_sales
from products
left join order_items
	on order_items.product_id = products.product_id 
	left join orders
		on order_items.order_id = orders.order_id 
group by category_name
order by total_sales desc;

--Vendas por mês
select 
	extract(month from order_approved_at) as purchase_month,
	count(*) total_sales_per_month
from orders
where order_approved_at is not null
group by purchase_month
order by total_sales_per_month desc;

--Vendas por vendedor/loja
select
	sellers.seller_id,
	seller_city,
	seller_state,
	count(*) as total_sales_per_seller
from sellers
left join order_items
	on order_items.seller_id = sellers.seller_id  
	left join orders
		on order_items.order_id = orders.order_id 
group by sellers.seller_id
order by total_sales_per_seller desc;

--Vendas por cliente
select distinct 
	customer_unique_id as clients,
	count(customer_id) as total_sales_per_client
from customers
group by clients 
order by total_sales_per_client desc;

--LTV, categoria mais comprada pelo cliente, total de compras dessa categoria
with base as(
select
	customers.customer_unique_id as client,
	orders.order_id,
	order_items.order_item_id,
	products.product_category_name as category,
	order_items.price as price,
	order_items.freight_value as freight_value
from customers
left join orders
	on orders.customer_id = customers.customer_id 
	left join order_items
		on order_items.order_id = orders.order_id 
		left join products
			on order_items.product_id = products.product_id 
),

ltv as (
	select
		client,
		sum(price + freight_value) as ltv
	from base 
	group by client
),

client_category as (
	select
		client,
		category,
		count(distinct order_id) as purchases,
		sum(price + freight_value) as category_spent
	from base
	group by client, category
),

ranking as (
	select
		client,
		category,
		purchases,
		category_spent,
		row_number() over(
			partition by client
			order by purchases desc, category_spent desc
		) as rn
	from client_category 
)

select
	ltv.client,
    ltv.ltv,
    ranking.category,
    ranking.purchases,
    ranking.category_spent
from ltv
join ranking
	on ranking.client = ltv.client
where rn = 1
order by ranking.purchases desc, ranking.category_spent desc, ltv.ltv desc;
