use pizza_sales;

#select everything from pizza_sales table
select * from pizza_sales;

#selecting sum of total_prices 
SELECT SUM(total_price) as Total_Revenue FROM pizza_sales;

#selecting average revenue for each order
SELECT SUM(total_price)/count(distinct(order_id)) as Average_Revenue FROM pizza_sales;

#selecting sum of quantity 
SELECT SUM(quantity) as Total_pizzas_sold FROM pizza_sales;

#counting number of orders
SELECT count(distinct(order_id)) as Total_orders  FROM pizza_sales;

#finding average order quantity per order
SELECT cast(SUM(quantity) as decimal(10,2)) / cast(count(distinct(order_id)) as decimal(10,2)) as Average_order_quantity FROM pizza_sales;

#finding the number of orders on each day for entire dataset
SELECT DAYNAME(STR_TO_DATE(order_date, '%d-%m-%Y')) AS order_day, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DAYNAME(STR_TO_DATE(order_date, '%d-%m-%Y'))
ORDER BY FIELD(order_day, 'Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday');

#finding the number of orders on each month for entire dataset
SELECT monthname(STR_TO_DATE(order_date, '%d-%m-%Y')) AS month_name, COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY monthname(STR_TO_DATE(order_date, '%d-%m-%Y'))
order by total_orders desc;

#finding total_sales per pizza_type based on pizza category for entire dataset
select pizza_category, sum(total_price) * 100 / (Select sum(total_price) from pizza_sales) as total_sales_per_type
from pizza_sales
group by pizza_category;

#finding total_sales per pizza_type based on pizza category for jan month only
select pizza_category, sum(total_price) * 100 / 
(Select sum(total_price) from pizza_sales where month(STR_TO_DATE(order_date, '%d-%m-%Y')) = 1  #adding filter -- optional
) as total_sales_per_type
from pizza_sales
where month(STR_TO_DATE(order_date, '%d-%m-%Y')) = 1  #adding filter -- optional#
group by pizza_category;

#finding total_sales per pizza_type based on pizza size for entire dataset
select pizza_size, cast(sum(total_price) * 100 / (Select sum(total_price) from pizza_sales) as decimal(10,2)) as total_sales_per_size
from pizza_sales
group by pizza_size;

#finding total_sales per pizza_type based on pizza size for jan month only
select pizza_size, cast(sum(total_price) * 100 / 
(Select sum(total_price) from pizza_sales where quarter(STR_TO_DATE(order_date, '%d-%m-%Y')) = 1) as decimal(10,2)) as total_sales_per_size
from pizza_sales
where quarter(STR_TO_DATE(order_date, '%d-%m-%Y')) = 1
group by pizza_size;

#top 5 pizzas by revenue
select pizza_name, sum(total_price) as total_revenue_per_pizza_type
from pizza_sales
group by pizza_name
order by sum(total_price) desc
limit 5;

#bottom 5 pizzas by revenue
select pizza_name, sum(total_price) as total_revenue_per_pizza_type
from pizza_sales
group by pizza_name
order by sum(total_price) asc
limit 5;

#top 5 pizzas by quantity
select pizza_name, sum(quantity) as total_quantity_per_pizza_type
from pizza_sales
group by pizza_name
order by sum(quantity) desc
limit 5;

#bottom 5 pizzas by quantity
select pizza_name, sum(quantity) as total_quantity_per_pizza_type
from pizza_sales
group by pizza_name
order by sum(quantity) asc
limit 5;

#top 5 pizzas by order
select pizza_name, count(distinct(order_id)) as total_orders_per_pizza_type
from pizza_sales
group by pizza_name
order by count(distinct(order_id)) desc
limit 5;

#bottom 5 pizzas by order
select pizza_name, count(distinct(order_id)) as total_orders_per_pizza_type
from pizza_sales
group by pizza_name
order by count(distinct(order_id))asc
limit 5;