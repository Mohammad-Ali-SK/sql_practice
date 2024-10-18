create table orders(
ord_id serial primary key,
ord_date date not null,
price numeric not null,
customer_id integer not null,
foreign key (customer_id) references
customer(customer_id)
)

select * from orders
select * from customer


insert into orders
values
(2344,'2022-10-22',1200,1),
(2234,'2022-10-23',2000,1),
(5727,'2023-12-2',600,2),
(7727,'2023-05-7',8900,2),
(5027,'2023-07-6',6004,3);

-- JOIN --------------------------------------------\
-- INNER JOIN
-- LEFT JOIN
-- RIGHT JOIN
-- CROSS JOIN




select c.first_name, sum(o.price) from customer as c
inner join orders as o
on c.customer_id = o.customer_id
group by first_name


select * from customer as c
left join orders as o
on c.customer_id = o.customer_id




