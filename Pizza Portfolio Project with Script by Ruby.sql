---Problem statement
--KPI requirement:
we need to analyze key indicators for our pizza sales data to gain insights into our business performance. specifically, we want to calculate the following metrics:

--Calculate total revenue

select SUM(TOTAL_PRICE) AS TOTAL_REVENUE
from pizza_sales

-- Calculate average order value

select (sum(total_price) / count(distinct order_id)) AS 'Avg_order_value'
from pizza_sales

-- Calculate total pizzas sold
Select sum(quantity) as total_pizza_sold
from pizza_sales

-- Calculate total orders
Select count(distinct order_id) as total_orders
from pizza_sales

-- Look at average pizzas per order
select cast(cast(sum(quantity) as decimal(10,2))/ cast(count(distinct order_id) as decimal(10,2)) as decimal (10,2))
as Avg_pizzas_per_order
from pizza_sales

--Chart requirements:
we would like to visualize various aspects of our pizza sales data to gain insights and understand key trends. we have identified the following requirements for creating charts:

select *
from pizza_sales

--Daily trend for total orders

select DATENAME(DW, order_date) as order_day, count(distinct order_id) as total_orders
from pizza_sales
Group by DATENAME(DW, order_date)

--Monthly trend for orders
Select datename(month, order_date) as month_name, count(distinct order_id)
as Total_orders
from pizza_sales
Group by datename(month, order_date)

-- Percentage of sales by pizza category
select *
from pizza_sales

Select pizza_category, sum(total_price)*100 / (select sum(total_price) from pizza_sales) as PCT
from pizza_sales as total_sales
group by pizza_category
-- show total_sale and PCT
Select pizza_category, sum(total_price) as Toal_sales, sum(total_price)*100 / (select sum(total_price) from pizza_sales) as PCT
from pizza_sales as total_sales
group by pizza_category

-- See only january (or first month)
select pizza_category, sum(total_price) as Total_sales, sum(total_price) * 100 / 
 (select sum(total_price) from pizza_sales WHERE MONTH(order_date) = 1) as PCT
 from pizza_sales
 WHERE MONTH(order_date) = 1
 group by pizza_category


-- Percentage of sales by pizza size
select *
from pizza_sales

Select pizza_size, sum(total_price) as Total_sales, sum(total_price) * 100 / 
 (select sum(total_price) from pizza_sales) as PCT
 from pizza_sales
 where datepart(quarter, order_date)=1
 group by pizza_size
 order by PCT DESC

-- Top 5 best seller by revenue, total quantity and total orders
select *
from pizza_sales

select top 5 pizza_name, sum(total_price) as total_revenue
from pizza_sales
group by pizza_name
order by total_revenue desc

-- Bottom 5 pizza
select top 5 pizza_name, sum(total_price) as total_revenue
from pizza_sales
group by pizza_name
order by total_revenue asc

--Total number of top 5 best seller pizza were sold
select top 5 pizza_name, sum(quantity) as total_quantity
from pizza_sales
group by pizza_name
order by total_quantity Desc



