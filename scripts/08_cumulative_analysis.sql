/*
===================
Cumulative Analysis
====================
The why:
    - To calculate running totals or moving averages for key metrics.
    - To trace performance over time.
    - Useful for growth analysis or identifying long-term trends.

What was used? SQL Functions Used:
    - Window Functions: SUM() OVER(), AVG() OVER()
=================================================================
*/

-- Calculate the total sales per month 
-- and the running total of sales over time 
SELECT
	total_sales,
	order_date,
	SUM(total_sales) OVER (ORDER BY order_date) AS running_total_sales,
	AVG(avg_price) OVER (ORDER BY order_date) AS moving_average_price
FROM
(
    SELECT 
        DATETRUNC(year, order_date) AS order_date,
        SUM(sales_amount) AS total_sales,
        AVG(price) AS avg_price
    FROM gold.fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY DATETRUNC(year, order_date)
) t
