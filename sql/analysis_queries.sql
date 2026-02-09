--Business KPIs

--Total sales
SELECT ROUND(SUM(sales),2) AS total_sales FROM superstore_orders;

--Average Order Value
SELECT ROUND(AVG(sales),2) AS average_order_value from superstore_orders;

--Minimum and Maximum Sales
SELECT ROUND(MIN(sales), 2) AS min_sales, ROUND(MAX(sales),2) AS max_sales FROM superstore_orders;


--Time-based analysis

--Yearly sales trend
SELECT strftime('%Y', order_date) AS year,
ROUND(SUM(sales), 2) AS total_sales;
FROM superstore_orders GROUP BY year ORDER BY year;

--Monthly sales
SELECT strftime('%m', order_date) as month, ROUND(SUM(sales), 2) AS total_sales 
FROM superstore_orders GROUP BY month ORDER BY month;


--Regional and Location Analysis

-- Sales by Region
SELECT region, ROUND(SUM(sales), 2) AS total_sales
FROM superstore_orders GROUP BY region ORDER BY total_sales DESC;

--Sales by States(Top 10)
SELECT state, ROUND(SUM(sales), 2) AS total_sales
FROM superstore_orders GROUP BY state ORDER BY total_sales DESC LIMIT 10;

--Sales by City(top 10)
SELECT city, ROUND(SUM(sales), 2) AS total_sales
FROM superstore_orders GROUP BY city ORDER BY total_sales DESC LIMIT 10;


--Category and Product Performance

--Sales by Category
SELECT category, ROUND(SUM(sales), 2) AS total_sales
FROM superstore_orders GROUP BY category ORDER BY total_sales DESC;

--Sales by Sub-category
SELECT sub_category, ROUND(SUM(sales), 2) AS total_sales
FROM superstore_orders GROUP BY sub_category ORDER BY total_sales DESC;


--Customer and segment analysis

--Sales by segment
SELECT segment, ROUND(SUM(sales), 2) AS total_sales
FROM superstore_orders GROUP BY segment ORDER BY total_sales DESC;

--Top 10 customers
SELECT customer_id, customer_name, ROUND(SUM(sales), 2) AS total_sales
FROM superstore_orders GROUP BY customer_id, customer_name ORDER BY total_sales DESC LIMIT 10;

--Customer order frequency
SELECT customer_id, customer_name, COUNT(order_id) AS total_orders
FROM superstore_orders GROUP BY customer_id, customer_name ORDER BY total_orders DESC LIMIT 10;


--Outlier and High-Value Order Analysis
SELECT order_id, customer_name, ROUND(sales, 2) AS sales
FROM superstore_orders ORDER BY sales DESC LIMIT 10;

--High-value orders
SELECT * FROM superstore_orders WHERE ROUND(sales, 2) > 3 * (SELECT ROUND(AVG(sales), 2) FROM superstore_orders);

--Region-wise category performance
SELECT region, category, ROUND(SUM(sales), 2) AS total_sales
FROM superstore_orders GROUP BY region, category ORDER BY region, total_sales DESC;

--Best Category per Region
SELECT region, category, total_sales FROM (SELECT region, category, ROUND(SUM(sales), 2) AS total_sales, RANK() OVER(PARTITION BY region ORDER BY SUM(sales) DESC) AS rnk FROM superstore_orders GROUP BY region, category) WHERE rnk = 1;


--Quality Check

--Check missing postal codes    
SELECT COUNT(*) AS mising_postal_code FROM superstore_orders WHERE postal_code IS NULL;

--Check duplicate orders
SELECT order_id, COUNT(*) FROM superstore_orders GROUP BY order_id HAVING COUNT(*)>1;
