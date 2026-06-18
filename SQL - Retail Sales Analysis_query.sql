drop database sql_proj2
use sql_project;
create table Retail_Sales
             (
                 transactions_id int primary key,
                 sale_date date,
                 sale_time time,
                 customer_id int,
                 gender varchar(15),
                 age int,
                 category varchar(15),
                 quantity int,
                 price_per_unit	float,
                 cogs float, 
                 total_sale float
              );   
select 
     count(*)
from Retail_Sales;

select * from Retail_sales
limit 10;

-- data cleaning

select * Retail_Sales
where transactions_id is null or sale_date is null or gender is null or age is null or category is null
or quantity is null or price_per_unit is null or cogs is null or total_Sale is null 


delete from Retail_Sales
where transactions_id is null or sale_date is null or gender is null or age is null or category is null
or quantity is null or price_per_unit is null or cogs is null or total_Sale is null 


-- Data Exploration
-- how many sales we have 
select count(*) as total_sale from Retail_Sales

-- how many unique customer we have 
select count(distinct customer_id) as total_sale from Retail_Sales

select distinct category  from Retail_Sales

-- data analaysis
-- qns  and answers 
 
 
-- 1) Write a SQL query to retrieve all columns for sales made on '2022-11-05

select * 
from retail_sales
where sale_date='2022-11-05'


-- 2) Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 2 in the month of Nov-2022:

 select *
 from retail_sales
 where category="clothing"
 and quantity>2 
 and sale_date between'2022-11-01' and '2022-11-30'
 
 
-- 3) Write a SQL query to calculate the total sales (total_sale) for each category.:

select category,
sum(total_sale) as total_Sales,
count(*)as total_orders
from Retail_Sales
group by category
 

-- 4) Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:

select round(avg(age),2) as avg_age
from Retail_Sales
where category='beauty'


 -- 5) Write a SQL query to find all transactions where the total_sale is greater than 1000.:

select transactions_id
from Retail_Sales
where total_sale > 1000


 -- 6) Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
 
 select gender,category,count(transactions_id) as tot_no_of_trans
 from retail_sales
 group by gender,category
 order by gender,category


 -- 7) Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
 
 
 use sql_project
with monthly_sales as (select extract(year from sale_date)as year,
extract(month from sale_date)as month,
avg(total_sale)as avg_sales
from retail_sales
group by extract(year from sale_date),extract(month from sale_date))
select * from(select *,
dense_rank() over(partition by year order by avg_sales desc) as rank_num
from monthly_sales) as tab
where rank_num=1
 with monthly_sales as (select
 extract(year from sale_date)as year,
 extract(month from sale_date)as month,
 avg(total_sale)as avg_sales
 from retail_sales
 group by extract(year from sale_date),extract(month from sale_date))
 
 select * from (select *,dense_rank() over (partition by year order by avg_sales desc)as rank_num
 from monthly_sales)as tab1
 where rank_num=1

 
 

 
 -- 8) Write a SQL query to find the top 5 customers based on the highest total sales
 
 select customer_id,max(total_sale) as high from retail_sales
 group by customer_id
 order by high desc limit 5
 
 
 -- 9) Write a SQL query to find the number of unique customers who purchased items from each category.:
 
select category,count(distinct customer_id) as uniquee
 from retail_sales
 group by category
 
 
 -- 10) Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17): *\

select 
case 
when extract(hour from sale_time) < 12 then'Morning'
when extract(hour from sale_time) between 12 and 17  then'Afternoon'
else 'Evening'
end as shift,
count(*)as number_of_orders
from retail_sales
group by
case when extract(hour from sale_time) < 12 then'Morning'
when extract(hour from sale_time) between 12 and 17  then'Afternoon'
else 'Evening'
end



--over--

           
