create database pizza_store; -- create database as pizza store

use pizza_store; -- use the database

##ORDERS
create table orders(
order_id int primary key,
date DATE,
time TIME
);


## pizza_types
create table pizza_types(
pizza_type_id varchar(100) primary key,
name varchar(255),
category varchar(100),
ingredients text
);


## pizzas
create table pizza(
pizza_id varchar(20) primary key,
pizza_type_id varchar(100),
size varchar(50),
price decimal(10,2),
foreign key (pizza_type_id) references pizza_types(pizza_type_id)
on delete cascade
on update cascade
);

## order_details
create table order_details(
order_details_id int primary key,
order_id int,
pizza_id varchar(20),
quantity int,
foreign key (pizza_id) references pizza(pizza_id)
on delete cascade
on update cascade,

foreign key (order_id) references orders(order_id)
on delete cascade
on update cascade
);
select * from order_details; 
select * from orders;  
select * from pizza; 
select * from pizza_types; 
DESC orders;
DESC pizza;
DESC order_details;
DESC pizza_types;

-- 1. Retrieve the total number of orders placed.

select 
count(order_id) as `Total Order`
from orders;

-- 2. Calculate the total revenue generated from pizza sales.
select sum(od.quantity * p.price) as `Total Revenue`
from order_details as od
join pizza as p
ON od.pizza_id = p.pizza_id;


-- 3. Identify the highest-priced pizza.
SELECT pizza_id, price
FROM pizza
WHERE price = (SELECT MAX(price) FROM pizza);


-- 4. Identify the most common pizza size ordered.
SELECT p.size, SUM(od.quantity) AS total_quantity
FROM order_details od
JOIN pizza p ON od.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY total_quantity DESC ;


-- 5. List the top 5 most ordered pizza types along with their quantities.

SELECT pt.name, SUM(od.quantity) AS total_quantity
FROM order_details od
JOIN pizza p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY total_quantity DESC
LIMIT 5;

-- 6. Find the total quantity of each pizza category ordered.

SELECT pt.category, SUM(od.quantity) AS total_quantity
FROM order_details od
JOIN pizza p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
ORDER BY total_quantity DESC;

-- 7. Determine the distribution of orders by hour of the day.

select hour(time) as order_hour,count(order_id) as total_order
from orders 
group by order_hour
order by order_hour;


-- 8. Find the category-wise distribution of pizzas (count of pizza types per category).
select category, count(pizza_type_id) as pizza_count
from pizza_types
group by category; 


-- 9. Group the orders by date and calculate the average number of pizzas ordered per day.

SELECT AVG(daily_total) AS avg_pizzas_per_day
FROM (
  SELECT o.date, SUM(od.quantity) AS daily_total
  FROM orders o
  JOIN order_details od ON o.order_id = od.order_id
  GROUP BY o.date
) as t;


-- 10. Determine the top 3 most ordered pizza types based on revenue
SELECT pt.name,
SUM(od.quantity * p.price) AS revenue
FROM order_details od
JOIN pizza p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.name
ORDER BY revenue DESC limit 3;

-- 11. Calculate the percentage contribution of each pizza type to total revenue.
SELECT pt.pizza_type_id, pt.name, 
SUM(p.price * od.quantity) AS each_pizza_revenue,
ROUND((SUM(p.price * od.quantity) / (SELECT SUM(p2.price * od2.quantity)
FROM order_details od2
JOIN pizza p2 
ON p2.pizza_id = od2.pizza_id)) * 100, 2) AS revenue_percentage
FROM order_details AS od
JOIN pizza AS p 
ON p.pizza_id = od.pizza_id   
JOIN pizza_types AS pt
ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.pizza_type_id,
pt.name ORDER BY each_pizza_revenue DESC;


-- 12. Analyze the cumulative revenue generated over time.

WITH cte_1 AS (
SELECT o.date, SUM(p.price * od.quantity) AS daily_total_revenue
FROM orders AS o
JOIN order_details AS od
ON od.order_id = o.order_id
JOIN pizza AS p
ON od.pizza_id = p.pizza_id   
GROUP BY o.date
)
SELECT date,daily_total_revenue, 
SUM(daily_total_revenue) OVER (ORDER BY date) AS cumulative_revenue
FROM cte_1 ORDER BY date;

-- 13. Determine the top 3 most ordered pizza types based on revenue for each pizza

SELECT pt.pizza_type_id, pt.name, 
ROUND(SUM(p.price * od.quantity), 2) AS total_revenue
FROM pizza_types AS pt
JOIN pizza AS p 
ON p.pizza_type_id = pt.pizza_type_id
JOIN order_details AS od
ON p.pizza_id = od.pizza_id
GROUP BY pt.pizza_type_id, pt.name
ORDER BY total_revenue DESC
LIMIT 3;


-- 14. Find orders where multiple pizzas were ordered but all pizzas are from the same category.

SELECT od.order_id,MAX(pt.category) AS category
FROM order_details AS od
JOIN pizza AS p
ON p.pizza_id = od.pizza_id
JOIN pizza_types AS pt
ON p.pizza_type_id = pt.pizza_type_id
GROUP BY od.order_id
HAVING SUM(od.quantity) > 1 AND COUNT(DISTINCT pt.category) = 1;

select * from pizza;
select * from orders;
select * from order_details;
select * from pizza_types;



-- 15. Find the ingredient that contributes the most to revenue.

select pt.ingredients, 
round(sum(p.price*od.quantity),2) as total_revenue
from pizza_types as pt
join pizza as p  on pt.pizza_type_id = p.pizza_type_id
join order_details as od on p.pizza_id = od.pizza_id
group by pt.ingredients
order by total_revenue desc
limit 1;

