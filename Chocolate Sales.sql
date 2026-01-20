-- 1.	 Total Sales by Country

SELECT 
    country, SUM(amount) AS total_sales
FROM
    sales
GROUP BY country;

-- 2.	 Top 5 Products by Revenue:

SELECT 
    product, SUM(amount) AS total_sales
FROM
    sales
GROUP BY product
ORDER BY total_sales DESC
LIMIT 5;
SELECT 
    *
FROM
    sales;
 
 -- 3.   Monthly Sales Trend
 
SELECT 
    DATE_FORMAT(order_date, '%y-%m') AS month,
    SUM(amount) AS monthly_sale
FROM
    sales
GROUP BY month
ORDER BY month;
 
 
 -- 4. Top 5 Sales Representatives
 
SELECT 
    salesman, SUM(amount) AS total_sales
FROM
    sales
GROUP BY salesman
ORDER BY total_sales DESC
LIMIT 5;
 
 -- 5. Average Sale Amount per Country
SELECT 
    country, AVG(amount) AS avg_amt
FROM
    sales
GROUP BY country
ORDER BY avg_amt DESC;
 
 
 -- 6.	Revenue per Box Shipped 
 
SELECT 
    product, SUM(amount) / SUM(boxes_shipped) AS revenue_per_box
FROM
    sales
GROUP BY product;
 
 -- 7.	Rank Products by Sales (Window Function)
 select product, sum(amount) as product_sales,
Rank () over (order by sum(amount) desc) as rnk
from sales
group by product;

-- 8.	Sales Above Overall Average

select * from sales
where amount>(select avg(amount) as avg_amt from sales);

-- 9.	Country-wise Top Product

select country, product, total_sales from (select country, product, sum(amount) as total_sales,
rank () Over (partition by country order by sum(amount)desc) as rnk
from sales
group by country, product)t 
where rnk =1;

-- 10.	Sales Categorization (CASE Statement)

SELECT 
    amount,
    CASE
        WHEN amount < 3000 THEN 'Low'
        WHEN amount BETWEEN 3000 AND 7000 THEN 'Medium'
        ELSE 'High'
    END AS sales_category
FROM
    sales
