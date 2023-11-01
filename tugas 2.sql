--no1--
--Rata-rata Monthly Active User (MAU) per tahun--
select 
	year,
	floor(avg(n_customer))as avg_monthly_active_user
from (
	select 
		date_part('year',o.order_purchase_timestamp)as year,
		date_part('month',o.order_purchase_timestamp)as month,
		count(distinct c.customer_unique_id)as n_customer
	from orders o
	join customer c
	on o.customer_id = c.customer_id
	group by 1,2
)monthly
group by 1
order by 1;

--no2--
--total customer baru per tahun--
select 
	date_part('year', first_date_order)as year,
	count(customer_unique_id)as new_customer
from(
	select 
		c.customer_unique_id,
		min(o.order_purchase_timestamp)as first_date_order
	from orders o
	join customer c 
	on o.customer_id = c.customer_id
	group by 1
) first_order
group by 1
order by 1;

--no3--
--jumlah customer yang melakukan repeat order per tahun--
select 
	year,
	count(distinct customer_unique_id) as repeat_customer
from(
	select 
		date_part('year',o.order_purchase_timestamp)as year,
		c.customer_unique_id,
		count(c.customer_unique_id)as n_customer,
		count(o.order_id)as n_order
	from orders o
	join customer c
	on o.customer_id = c.customer_id
	group by 1,2
	having count(order_id)>1
)repeat_order
group by 1
order by 1;

--no4--
--rata-rata frekuensi order untuk setiap tahun--
select
	year,
	round(avg(n_order), 2)as avg_num_order
from(
	select
	date_part('year', o.order_purchase_timestamp)as year,
	c.customer_unique_id,
	count(c.customer_unique_id)as n_customer,
	count(o.order_id)as n_order
	from orders o
	join customer c
	on o.customer_id =c.customer_id
	group by 1,2
)order_customer
group by 1 
order by 1;

--no5--
--Menggabungkan metrik yang telah berhasil ditampilkan menjadi satu tampilan tabel--
with table_mau as(
select 
	year,
	floor(avg(n_customer))as avg_monthly_active_user
from(
	select 
		date_part('year',o.order_purchase_timestamp)as year,
		date_part('month',o.order_purchase_timestamp)as month,
		count(distinct c.customer_unique_id)as n_customer
	from orders o
	join customer c
	on o.customer_id = c.customer_id
	group by 1,2
)monthly
group by 1
),
table_newcust as(
select 
	date_part('year', first_date_order)as year,
	count(customer_unique_id)as new_customer
from(
	select 
		c.customer_unique_id,
		min(o.order_purchase_timestamp)as first_date_order
	from orders o
	join customer c 
	on o.customer_id = c.customer_id
	group by 1
) first_order
group by 1
),
table_recust as(
select 
	year,
	count(distinct customer_unique_id) as repeat_customer
from(
	select 
		date_part('year',o.order_purchase_timestamp)as year,
		c.customer_unique_id,
		count(c.customer_unique_id)as n_customer,
		count(o.order_id)as n_order
	from orders o
	join customer c
	on o.customer_id = c.customer_id
	group by 1,2
	having count(order_id)>1
)repeat_order
group by 1
),
table_avgorder as(
select
	year,
	round(avg(n_order), 2)as avg_num_order
from(
	select
	date_part('year', o.order_purchase_timestamp)as year,
	c.customer_unique_id,
	count(c.customer_unique_id)as n_customer,
	count(o.order_id)as n_order
	from orders o
	join customer c
	on o.customer_id =c.customer_id
	group by 1,2
)order_customer
group by 1 
)
select
	tm.year,
	tm.avg_monthly_active_user,
	tn.new_customer,
	tr.repeat_customer,
	ta.avg_num_order
from table_mau tm
join table_newcust tn
on tm.year = tn.year
join table_recust tr
on tm.year = tr.year
join table_avgorder ta
on tm.year = ta.year
order by 1;


