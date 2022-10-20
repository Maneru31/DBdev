use sakila;
select c.email, r.return_date
from customer c
inner join rental r
on c.customer_id = r.customer_id
where date(r.rental_date)='2005-06-14'
order by return_date desc;