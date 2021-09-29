-- 1. Rank films by length (filter out the rows that have nulls or 0s in length column). 
-- 		In your output, only select the columns title, length, and the rank.
select
rank() over(order by length desc) as 'rank'
,title
,length 
from sakila.film
where length <> null or rental_duration not in ("",0);

-- 2. Rank films by length within the rating category (filter out the rows that have nulls or 0s in length column). 
-- 		In your output, only select the columns title, length, rating and the rank.
select
rank() over(partition by rating order by length desc) as 'rank'
,rating 
,title
,length 
from sakila.film
where length <> null or rental_duration not in ("",0);

-- 3. How many films are there for each of the categories in the category table. Use appropriate join to write this query
select * from sakila.category;
select * from sakila.film_category;
select name
,count(*) as filmCount
from sakila.film_category f 
inner join sakila.category c on f.category_id=c.category_id
group by name
order by filmCount desc;

-- 4. Which actor has appeared in the most films?
select * from sakila.actor;
select * from sakila.film_actor;

select a.first_name 
,a.last_name
,count(*) as filmCount
from sakila.actor a
inner join sakila.film_actor f on a.actor_id=f.actor_id
group by a.first_name 
,a.last_name
order by filmCount desc;

-- 5. Most active customer (the customer that has rented the most number of films)
select a.first_name 
,a.last_name
,count(*) as filmCount
from sakila.customer a
inner join sakila.rental f on a.customer_id=f.customer_id
group by a.first_name 
,a.last_name
order by filmCount desc;

-- 6. Bonus: Which is the most rented film? The answer is Bucket Brotherhood This query might require using more than one join statement. 
-- 		Give it a try. We will talk about queries with multiple join statements later in the lessons.
select f.title
,count(r.rental_id) timesRented
from sakila.film f
inner join sakila.inventory i on f.film_id=i.film_id
inner join sakila.rental r on i.inventory_id=r.inventory_id
group by f.title
order by timesRented desc
limit 1;