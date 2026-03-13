-- Seleciona todos os registros da tabela superstore.
select * from superstore;

--Seleciona todas as datas distintas de pedidos da tabela superstore e ordena de forma crescente (padrão)
select distinct  order_date from superstore order by order_date;

--Seleciona todas as datas de pedidos e todas as vendas da tabela superstore, agrupa pela data do pedido e ordena pelo total de vendas de forma decrescente.
select order_date, sum(sales) from superstore group by order_date order by sum(sales) desc;

--Seleciona a soma de todas as vendas da tabela superstore.
select sum(sales)  from superstore;

-- Seleciona estado e soma todas as vendas da tabela superstore, renomeando visualmente a coluna de vendas como "todas as vendas por estado" e agrupando por estado.
select state, SUM(sales) as total_sales_per_state from superstore group by state;

-- Seleciona categoria e soma todas as vendas da tabela superstore, renomeando visualmente a coluna de vendas como "todas as vendas por categoria" e agrupando por categoria.
select category, SUM(sales) as total_sales_per_category from superstore group by category;

--Seleciona a média do total de pedidos renomeando visualmente a coluna como "ticket médio", o total dos pedidos vai ser calculado por uma CTE, a qual vem como tabela de referência, 
--na CTE é selecionado o id do pedido e o total de vendas, renomeando como "total de pedidos" da tabela superstore e agrupando por id do pedido, 
--assim termina a CTE que recebeu o alias de t.
select avg(order_total) as average_ticket from (select order_id, sum(sales)as order_total from superstore group by order_id) t;

--Seleciona a quantidade de id de pedidos sem repetições, que tem na tabela superstore.
select count(distinct order_id) as total_orders from superstore;

--Seleciona país e soma todas as vendas da tabela superstore, renomeando visualmente a coluna de vendas como "todas as vendas por país" e agrupando por país.
select country, SUM(sales) as total_sales_per_country from superstore group by country;

--Seleciona nome dos clientes e a soma de todas as vendas da tabela superstore, renomeando visualmente a coluna de vendas como "ltv(life time value)",
--agrupando por nome dos clientes e ordenando por total de vendas de forma decrescente.
select customer_name, SUM(sales) as ltv from superstore group by customer_name order by sum(sales) DESC;

--Seleciona a soma do lucro total da tabela superstore.
select sum(profit) as total_profit from superstore;

--Seleciona o nome do produto e a divisão da soma de todas as vendas por a soma de todos os produtos vendidos da tabela superstore, 
--renomeando visualmente a coluna da divisão como "unit_price" e ordenando pela coluna unit_price de forma crescente.
select product_name, (sum(sales)/sum(quantity)) as unit_price from superstore group by product_name order by unit_price;