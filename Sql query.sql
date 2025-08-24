--SQL sales retail analysis p1##
-- Create table--
create table sales
(
transactions_id	int primary key,
sale_date Date,
sale_time Time,
customer_id int,
gender varchar(100),
age int,
category varchar(100),
quantiy int,
price_per_unit float,
cogs float,
total_sale float
);
--Inserted values through click on options--
select * from sales;
select count (*) from sales;
--Dating cleaning--
select *from sales where transactions_id is null
or
sale_date is null
or 
sale_time is null
or
customer_id is null
or 
gender is null
or 
age is  null
or 
category is null
or 
quantiy is null
or
price_per_unit is null
or 
cogs is null
or 
total_sale is null;

--delete null values from the table--

delete from sales where 
transactions_id is null
or
sale_date is null
or 
sale_time is null
or
customer_id is null
or 
gender is null
or 
age is  null
or 
category is null
or 
quantiy is null
or
price_per_unit is null
or 
cogs is null
or 
total_sale is null;
select count (*) from sales;

--Data exploration--
--1)How many records we have--
select count(*) from sales;
--2)How many unique customers we have--
select count( Distinct customer_id) from sales;
--3)Total number of category--
select count(Distinct category) from sales;
select distinct category from sales;
--Data analysis,key problems and solutions

--1.Write a SQL query to retrieve all columns for sales made on '2022-11-05:
select * from sales where sale_date='2022-11-05';

--2.Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
select * from sales where
category='clothing' 
and 
To_char(sale_date,'YYYY-MM')='2022-11'
and
quantiy >=4
select * from sales;
--3.Calculate the total sales for each category
select category,sum(total_sale) as net_sale from sales group by category;
--4.find the average age of customers who purchased items from the 'Beauty' category--
select round(avg(age),2) as avg_age from sales where category='Beauty';
--5.find all transactions where the total_sale is greater than 1000--
select *from sales;
select * from sales where total_sale >1000 ;
--6.find the total number of transactions (transaction_id) made by each gender in each category
SELECT 
    category,
    gender,
    COUNT(*) as total_trans
FROM sales
GROUP 
    BY 
    category,
    gender
ORDER BY total_trans;

--7.calculate the average sale for each month. Find out best selling month in each year--
SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    round(AVG(total_sale)) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM sales

GROUP BY 1, 2
) as t1
WHERE rank = 1

--8.find the top 5 customers based on the highest total sales--
select*from sales;
SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5
--9.find the number of unique customers who purchased items from each category--
select customer_id ,
count(distinct customer_id) as unique_cs_id 
from sales
group by 1
--10.SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)--
WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift




