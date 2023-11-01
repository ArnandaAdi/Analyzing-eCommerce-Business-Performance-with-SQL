--no1--
--Menampilkan jumlah penggunaan tipe pembayaran secara all time diurutkan dari yang terfavorit--
select
	op.payment_type,
	count(*) as num_of_usage
from orders o
join order_payment op
on o.order_id = op.order_id
group by 1
order by 2 desc;

--no2--
--Menampilkan jumlah pengguanaan tipe pembayaran tiap tahun--
select 
	date_part('year',o.order_purchase_timestamp)as year,
	op.payment_type,
	count(*) as num_of_usage
from orders o
join order_payment op
on o.order_id = op.order_id
group by 1,2 
order by 1 asc, 3 desc;

--no3--
--Membuat table summary jumlah penggunaan tipe pembayaran tiap tahun--
with type_payment as(
	select 
		date_part('year',o.order_purchase_timestamp)as year,
		op.payment_type,
		count(*)as num_of_usage
	from orders o
	join order_payment op
	on o.order_id = op.order_id
	group by 1,2
)
select 
	payment_type,
	sum(case when year = '2016' then num_of_usage else 0 end) as year_2016,
	sum(case when year = '2017' then num_of_usage else 0 end) as year_2017,
	sum(case when year = '2018' then num_of_usage else 0 end) as year_2018
from type_payment
group by 1
order by 4 desc