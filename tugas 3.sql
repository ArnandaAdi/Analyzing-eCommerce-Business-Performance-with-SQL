--Reset Table to ensure the results do not increase or differ from the initial input--
drop table if exists total_revenue_year;
drop table if exists total_cancel_order_year;
drop table if exists top_product_revenue_year;
drop table if exists top_product_cancel_year;

--no1--
--Membuat tabel revenue pertahun--
create table total_revenue_year as
with revenue_order as(
	select
		order_id,
		sum(price+freight_value)as revenue
	from order_items oi
	group by 1
)
select 
	date_part('year',o.order_purchase_timestamp)as year,
	sum(po.revenue) as revenue
from orders o 
join revenue_order po
on o.order_id = po.order_id
where o.order_status = 'delivered'
group by 1
order by 1;

--no2--
--Membuat table cancel order pertahun--
create table total_cancel_order_year as
select
	date_part('year',o.order_purchase_timestamp)as year,
	count(order_id)as total_cancel
from orders o
where order_status = 'canceled'
group by 1
order by 1;

--no3--
--Membuat table kategori produk dengan pendapatan tertinggi untuk setiap tahun--
create table top_product_revenue_year as
with revenue_category_order as(
	select
		date_part('year',o.order_purchase_timestamp)as year,
		p.product_category_name,
		sum(oi.price+oi.freight_value)as revenue,
		row_number()over(
			partition by date_part('year',o.order_purchase_timestamp)
			order by sum(oi.price+oi.freight_value)desc
		)as rank
	from orders o
	join order_items oi
	on o.order_id = oi.order_id
	join product p
	on oi.product_id = p.product_id
	where order_status = 'delivered'
	group by 1,2
)
select year,
	   product_category_name,
	   revenue
from revenue_category_order
where rank = 1;
			
--no4--
--Membuat table kategori produk dengan cancel order terbanyak untuk setiap tahun--
create table top_product_cancel_year as
with canceled_category_order as(
	select
		date_part('year',o.order_purchase_timestamp)as year,
		p.product_category_name,
		count(*)as total_cancel,
		row_number()over(
			partition by date_part('year',o.order_purchase_timestamp)
			order by count(*) desc
		)as rank
	from orders o
	join order_items oi
	on o.order_id = oi.order_id
	join product p
	on oi.product_id = p.product_id
	where order_status = 'canceled'
	group by 1,2
)
select year,
	   product_category_name,
	   total_cancel
from canceled_category_order
where rank = 1;
			
--no5--
--Menggabungkan informasi dalam satu table--
select tpr.year,
	   tpr.product_category_name as top_product_revenue,
	   tpr.revenue as top_revenue,
	   try.revenue as total_revenue_year,
	   tpc.product_category_name as top_product_canceled,
	   tpc.total_cancel as top_num_cancel,
	   tcy.total_cancel as total_cancel_year
from top_product_revenue_year tpr
join total_revenue_year try
on tpr.year = try.year
join top_product_cancel_year tpc
on tpr.year = tpc.year
join total_cancel_order_year tcy
on  tpr.year = tcy.year;