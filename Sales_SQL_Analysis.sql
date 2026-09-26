
use sales_sql_db;

# 1. Display all customers.
select*from customers;

# 2. Display only customer name, city and segment
select customer_name,city,segment
from customers;

# 3. Find all products with unit_price greater than 500
SELECT *
FROM products
WHERE unit_price > 500;

# 4. Find products priced between 100 and 500.
SELECT *
FROM products
WHERE unit_price between 100 and 500;

# 5. Find customers from Hyderabad.
select*from customers
where city="Hyderabad";

# 6. Find customers belonging to the Corporate segment.
SELECT *
FROM customers
WHERE segment = 'Corporate';

# 7. List all distinct payment methods
select distinct payment_method from orders;

# 8. List all distinct order statuses.
select distinct status from orders;

# 9. Find orders placed during 2025
select*from orders
where order_Date >= '2025-01-01'
and order_date < '2026-01-01';

# 10. Sort products from highest to lowest unit_price.
select*from products
order by unit_price desc;

# 11. Display the 10 cheapest products
select*from products
order by unit_price asc
limit 10;

# 12. Find products whose name contains 'Mouse'
select*from products
where product_name like '%Mouse%';

# 13. Find customers whose name ends with '5'
select*from customers
where customer_name like '%5';

# 14. Count the total number of customers.
select count(*) as total_customers from customers;

# 15. Count the total number of products
select count(*) as total_products from products;

# 16. Find the minimum, maximum and average product price
select 
min(unit_price) as minimum_price,
max(unit_price) as maximum_price,
avg(unit_price) as average_price
from products;

# 17. Find the total quantity sold
select sum(quantity) as Total_quantity_sold
from order_details;

# 18. Calculate total gross sales before discount.
select sum(quantity*unit_price) as gross_sales
from order_details;

# 19. Find the number of orders per status
select status,count(*) as total_orders
from orders
group by status;

# 20. Find the number of customers per segment
select segment,count(*) as customer_per_segment
from customers
group by segment;

# 21. Find the average product price by category_id
select category_id,avg(unit_price) as avg_product_price
from products
group by category_id;

# 22. Find categories having more than 5 products
select category_id, count(*) as total_products
from products
group by category_id
having count(*)>5;

# 23. Find payment methods with more than 100 orders
select payment_method,count(*) as total_orders
from orders
group by payment_method
having count(*)>100;

# 24. Find the total quantity sold for each product
select product_id, sum(quantity) as total_quantity
from order_details
group by product_id;

# 25. Find the total revenue for each product using order_details
select product_id, sum(quantity*unit_price) as total_revenue
from order_details
group by product_id;

# Level 2 — Joins & Business Analysis

# 26. Join products with categories and display product and category names
select p.product_name,c.category_name
from products p
join categories c
on  p.category_id=c.category_id;

# 27. Join products with suppliers and display supplier names
select p.product_name,s.supplier_name
from products p
join suppliers s
on p.supplier_id=s.supplier_id;

# 28. Join stores with regions
select s.store_name,r.region_name
from stores s
join regions r 
on s.region_id=r.region_id;

# 29. Join employees with regions
select e.employee_name,r.region_name
from employees e
join regions r on
e.region_id=r.region_id;

# 30. Join orders with customers
select o.order_id,o.order_date,c.customer_name,c.city,c.segment
from customers c
join orders o
on c.customer_id=o.customer_id;

# 31. Join orders with stores and regions
select o.order_id,o.order_date,s.store_name,r.region_name
from orders o 
join stores s
on o.store_id=s.store_id
join regions r
on s.region_id=r.region_id;

# 32. Join order_details with products
select od.order_id,od.product_id,od.quantity,od.unit_price,p.product_name
from order_details od
join products p
on p.product_id=od.product_id;

# REVENUE ANALYSIS

# 33. Calculate revenue by category Concept: Multiple joins + aggregation

select c.category_name, sum(od.quantity*od.unit_price) as Total_revenue
from order_details od
join products p
on od.product_id=p.product_id
join categories c
on p.category_id=c.category_id
group by c.category_id, c.category_name
order by Total_revenue desc;

# 34. Calculate revenue by region
select r.region_name, sum(od.quantity*od.unit_price) as total_revenue
from orders o
join order_details od
on o.order_id=od.order_id
join stores s 
on o.store_id=s.store_id
join regions r
on r.region_id=s.region_id
group by r.region_id, r.region_name
order by total_revenue desc;

# 35. Calculate revenue by store
select s.store_name, sum(od.quantity*od.unit_price) as total_revenue
from orders o
join order_details od
on o.order_id=od.order_id
join stores s
on o.store_id=s.store_id
group by s.store_id,s.store_name
order by total_revenue desc;

# 36. Calculate revenue by Employees Concept: Join + aggregation
select e.employee_name, sum(od.quantity*od.unit_price) as total_revenue
from orders o
join order_details od
on o.order_id=od.order_id
join employees e
on o.employee_id=e.employee_id
group by e.employee_id,e.employee_name
order by total_revenue desc;

# 37. Find the top 10 customers by revenue
select c.customer_id,c.customer_name, sum(od.quantity*od.unit_price) as total_revenue
from orders o
join order_details od
on o.order_id=od.order_id
join customers c
on o.customer_id=c.customer_id
group by c.customer_id,c.customer_name
order by total_revenue desc
limit 10;

# 38. Find the top 10 products by revenue
select p.product_id,p.product_name, sum(od.quantity*od.unit_price) as total_revenue
from products p
join order_details od
on p.product_id=od.product_id
group by p.product_id,p.product_name
order by total_revenue desc
limit 10;

# 39. Find the top 5 stores by revenue
select s.store_id,s.store_name, sum(od.quantity*od.unit_price) as total_revenue
from stores s
join orders o
on o.store_id=s.store_id
JOIN order_details od
ON o.order_id = od.order_id
group by s.store_id,s.store_name
order by total_revenue desc
limit 5;

# 40. Find the top 5 sales employees by revenue
select  e.employee_id,
    e.employee_name, sum(od.quantity*od.unit_price) as total_revenue
from orders o
join order_details od
on o.order_id=od.order_id
join employees e
on o.employee_id=e.employee_id
group by e.employee_id,e.employee_name
order by total_revenue desc
limit 5;

# Customer & Product Analysis

# 41. Find customers who have placed at least one order
select distinct c.customer_id,c.customer_name
from customers c
join orders o
on c.customer_id=o.customer_id;

# 42. Find customers who have never placed an order
select distinct c.customer_id,c.customer_name
from customers c
left join orders o
on c.customer_id=o.customer_id
where o.customer_id is null;

# 43. Find products that have never been ordered
select distinct p.product_id,p.product_name
from products p
left join order_details od
on p.product_id=od.product_id
where od.product_id is null;

# 44. Find suppliers whose products generated more than 100,000 in revenue
select s.supplier_id,s.supplier_name, sum(od.quantity*od.unit_price) as total_revenue
from suppliers s
join products p
on s.supplier_id=p.supplier_id
join order_details od
on od.product_id=p.product_id
group by s.supplier_id,s.supplier_name
having total_revenue > 100000
order by total_revenue desc;

# 45. Find the number of orders handled by each employee  Why LEFT JOIN?
# It also displays employees who handled zero orders.

select e.employee_id,e.employee_name, count(o.order_id) as total_orders_handled
from employees e
left join orders o
on e.employee_id=o.employee_id
group by e.employee_id,e.employee_name
order by total_orders_handled;

# 46. Find average order value by store
SELECT s.store_id,s.store_name, AVG(order_totals.order_value) AS average_order_value
FROM stores s
JOIN (
    SELECT
        o.order_id,
        o.store_id,
        SUM(od.quantity * od.unit_price) AS order_value
    FROM orders o
    JOIN order_details od
        ON o.order_id = od.order_id
    GROUP BY o.order_id, o.store_id
) AS order_totals
    ON s.store_id = order_totals.store_id
GROUP BY s.store_id, s.store_name
ORDER BY average_order_value DESC;

# 48. Compare completed vs cancelled order counts
select status, count(*) as order_counts
from orders 
where status in ('COMPLETED','RETURNED')
GROUP BY STATUS;

# 49. Calculate revenue by payment method
select o.payment_method, sum(od.quantity*od.unit_price) as total_revenue
from orders o
join order_details od
on o.order_id=od.order_id
group by o.payment_method
order by total_revenue desc;

# 50. Find the best-selling product in each category
WITH product_sales AS (
    SELECT
        p.category_id,
        p.product_id,
        p.product_name,
        SUM(od.quantity) AS total_quantity_sold
    FROM products p
    JOIN order_details od
        ON p.product_id = od.product_id
    GROUP BY
        p.category_id,
        p.product_id,
        p.product_name
),
ranked_products AS (
    SELECT
        category_id,
        product_id,
        product_name,
        total_quantity_sold,
        RANK() OVER (
            PARTITION BY category_id
            ORDER BY total_quantity_sold DESC
        ) AS product_rank
    FROM product_sales
)
SELECT
    rp.category_id,
    c.category_name,
    rp.product_id,
    rp.product_name,
    rp.total_quantity_sold
FROM ranked_products rp
JOIN categories c
    ON rp.category_id = c.category_id
WHERE rp.product_rank = 1
ORDER BY rp.category_id;

# Level 3 — Subqueries & CTEs

# 51. Find products priced above the overall average product price
select p.product_id,p.product_name,p.unit_price
from products p
where unit_price > (
select avg(unit_price) from products )
order by unit_price desc;

# 52. Find customers whose total revenue is above average customer revenue 
# Concept: CTE + subquery + aggregation
with customer_revenue as
(
select c.customer_id,c.customer_name, sum(od.quantity*od.unit_price) as total_revenue
from customers c
join orders o
on c.customer_id=o.customer_id
join order_details od
on o.order_id=od.order_id
group by c.customer_id,c.customer_name

)
select customer_id,customer_name,total_revenue
from customer_revenue
where total_revenue > ( 
select avg(total_revenue) from customer_revenue
)
order by total_revenue desc;

# 53. Find employees whose revenue is above average employee revenue
# Concept: CTE + subquery
with employee_revenue as 
( 
select e.employee_id,e.employee_name, sum(od.quantity*od.unit_price) as total_revenue
from employees e
join orders o
on e.employee_id=o.employee_id
join order_details od
on o.order_id=od.order_id
group by e.employee_id,e.employee_name

)
select employee_id,employee_name,total_revenue
from employee_revenue
where total_revenue > (
select avg(total_revenue) from employee_revenue )
order by total_revenue desc;

# 54. Find stores whose revenue is above average store revenue
with store_revenue as 
( 
select s.store_id,s.store_name, sum(od.quantity*od.unit_price) as total_revenue
from stores s
join orders o
on s.store_id=o.store_id
join order_details od
on o.order_id=od.order_id
group by s.store_id,s.store_name
)
select store_id,store_name,total_revenue
from store_revenue
where total_revenue > (
select avg(total_revenue) from store_revenue )
order by total_revenue desc;

# 55. Find the second-highest priced product Concept: Nested Sub-Query
select product_id,product_name,unit_price
from products
where unit_price = (
select max(unit_price) from products
where unit_price < (
select max(unit_price) from products ));

# 56. Find the third-highest revenue-generating customer
with customer_revenue as
(
select c.customer_id,c.customer_name, sum(od.quantity*od.unit_price) as total_revenue
from customers c
join orders o
on c.customer_id=o.customer_id
join order_details od
on o.order_id=od.order_id
group by c.customer_id,c.customer_name 
),
ranked_customers as (
select customer_id,customer_name,total_revenue,
dense_rank() over(order by total_revenue desc) as revenue_rank from customer_revenue 
)
select customer_id,customer_name,total_revenue
from ranked_customers
where revenue_rank=3;

# 57. Find the category with the highest average product price
select c.category_id,c.category_name, avg(p.unit_price) as avg_product_price
from categories c
join products p
on c.category_id=p.category_id
group by c.category_id,c.category_name
order by avg_product_price desc
limit 1;

# 58. Find products whose unit_price is greater than their category average
select p.product_id,p.product_name,p.category_id, p.unit_price
from products p
where unit_price >
(
select avg(p2.unit_price)
from products p2
where p2.category_id=p.category_id )
order by p.category_id,p.unit_price desc;

# 59. Find customers who ordered every month in 2025
select c.customer_id,c.customer_name
from customers c
join orders o
on c.customer_id=o.customer_id
where order_date >='2025-01-01' 
and order_date < '2026-01-01'
group by c.customer_id,c.customer_name
having count(distinct month(o.order_date))=12;

# 60. Find customers with more than 3 completed orders.
select c.customer_id,c.customer_name,
count(o.order_id) as completed_orders
from customers c
join orders o on
c.customer_id=o.customer_id
where o.status='Completed'
group by c.customer_id,c.customer_name
having count(o.order_id)>3
order by completed_orders desc;

# 61. Find products purchased by more than 50 distinct customers
# Concept: Multiple joins + COUNT(DISTINCT)
select p.product_id,p.product_name, count(distinct o.customer_id) as distinct_customers
from products p
join order_details od
on p.product_id=od.product_id
join orders o on
o.order_id=od.order_id
group by p.product_id,p.product_name
having count(distinct o.customer_id)>50
order by distinct_customers desc;

# CTE PRACTICE

-- 62. Calculate monthly revenue
WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(o.order_date, '%Y-%m') AS month,
        SUM(od.quantity * od.unit_price) AS revenue
    FROM orders o
    JOIN order_details od
        ON o.order_id = od.order_id
    GROUP BY month
)
SELECT *
FROM monthly_revenue
ORDER BY month;


-- 63. Monthly revenue and MoM change
WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(o.order_date, '%Y-%m') AS month,
        SUM(od.quantity * od.unit_price) AS revenue
    FROM orders o
    JOIN order_details od
        ON o.order_id = od.order_id
    GROUP BY month
)
SELECT
    month,
    revenue,
    revenue - LAG(revenue) OVER (ORDER BY month) AS mom_change
FROM monthly_revenue
ORDER BY month; 


-- 64. Top 3 products by category
WITH product_sales AS (
    SELECT
        p.category_id,
        p.product_id,
        p.product_name,
        SUM(od.quantity * od.unit_price) AS revenue
    FROM products p
    JOIN order_details od
        ON p.product_id = od.product_id
    GROUP BY p.category_id, p.product_id, p.product_name
)
SELECT *
FROM (
    SELECT *,
           RANK() OVER (
               PARTITION BY category_id
               ORDER BY revenue DESC
           ) AS rnk
    FROM product_sales
) x
WHERE rnk <= 3;


-- 65. Top 5 customers by region
WITH customer_sales AS (
    SELECT
        s.region_id,
        o.customer_id,
        SUM(od.quantity * od.unit_price) AS revenue
    FROM orders o
    JOIN order_details od
        ON o.order_id = od.order_id
    JOIN stores s
        ON o.store_id = s.store_id
    GROUP BY s.region_id, o.customer_id
)
SELECT *
FROM (
    SELECT *,
           RANK() OVER (
               PARTITION BY region_id
               ORDER BY revenue DESC
           ) AS rnk
    FROM customer_sales
) x
WHERE rnk <= 5;

-- 66. Customer lifetime revenue
WITH customer_revenue AS (
    SELECT
        o.customer_id,
        SUM(od.quantity * od.unit_price) AS lifetime_revenue
    FROM orders o
    JOIN order_details od
        ON o.order_id = od.order_id
    GROUP BY o.customer_id
)
SELECT *
FROM customer_revenue
ORDER BY lifetime_revenue DESC;


-- 67. Revenue, Cost and Profit
WITH x AS (
    SELECT
        SUM(od.quantity * od.unit_price) AS revenue,
        SUM(od.quantity * p.unit_cost) AS cost
    FROM order_details od
    JOIN products p
        ON od.product_id = p.product_id
)
SELECT
    revenue,
    cost,
    revenue - cost AS profit
FROM x;


-- 68. Stores with below-average profit margin
WITH s AS (
    SELECT
        o.store_id,
        SUM(od.quantity * (od.unit_price - p.unit_cost))
        / SUM(od.quantity * od.unit_price) * 100 AS margin
    FROM orders o
    JOIN order_details od ON o.order_id = od.order_id
    JOIN products p ON od.product_id = p.product_id
    GROUP BY o.store_id
)
SELECT *
FROM s
WHERE margin < (SELECT AVG(margin) FROM s);


-- 69. Identify repeat customers
WITH customer_orders AS (
    SELECT
        customer_id,
        COUNT(DISTINCT order_id) AS order_count
    FROM orders
    GROUP BY customer_id
)
SELECT *
FROM customer_orders
WHERE order_count > 1;


-- 70. Category contribution to total revenue
WITH category_revenue AS (
    SELECT
        p.category_id,
        SUM(od.quantity * od.unit_price) AS revenue
    FROM products p
    JOIN order_details od
        ON p.product_id = od.product_id
    GROUP BY p.category_id
)
SELECT
    category_id,
    revenue,
    ROUND(
        revenue / SUM(revenue) OVER () * 100, 2
    ) AS contribution_pct
FROM category_revenue
ORDER BY revenue DESC;

-- =====================================================
-- LEVEL 4: WINDOW FUNCTIONS — QUESTIONS + SQL
-- =====================================================

-- 71. Rank products by revenue
SELECT product_id,
       SUM(quantity * unit_price) AS revenue,
       RANK() OVER(ORDER BY SUM(quantity * unit_price) DESC) AS rnk
FROM order_details
GROUP BY product_id;


-- 72. Rank products by revenue within each category
SELECT 
    p.product_id,
    p.category_id,
    SUM(od.quantity * od.unit_price) AS revenue,
    RANK() OVER(
        PARTITION BY p.category_id
        ORDER BY SUM(od.quantity * od.unit_price) DESC
    ) AS rnk
FROM products p
JOIN order_details od
    ON p.product_id = od.product_id
GROUP BY p.product_id, p.category_id;


-- 73. Rank employees by revenue within each region
SELECT 
    o.employee_id,
    s.region_id,
    SUM(od.quantity * od.unit_price) AS revenue,
    RANK() OVER(
        PARTITION BY s.region_id
        ORDER BY SUM(od.quantity * od.unit_price) DESC
    ) AS rnk
FROM orders o
JOIN order_details od
    ON o.order_id = od.order_id
JOIN stores s
    ON o.store_id = s.store_id
GROUP BY o.employee_id, s.region_id;


-- 74. Top 3 customers in each segment
SELECT *
FROM (
    SELECT c.customer_id, c.segment,
           SUM(od.quantity * od.unit_price) AS revenue,
           DENSE_RANK() OVER(
               PARTITION BY c.segment
               ORDER BY SUM(od.quantity * od.unit_price) DESC
           ) AS rnk
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    JOIN order_details od ON o.order_id = od.order_id
    GROUP BY c.customer_id, c.segment
) x
WHERE rnk <= 3;


-- 75. First order of every customer
SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER(
               PARTITION BY customer_id
               ORDER BY order_date
           ) AS rn
    FROM orders
) x
WHERE rn = 1;


-- 76. Latest order of every customer
SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER(
               PARTITION BY customer_id
               ORDER BY order_date DESC
           ) AS rn
    FROM orders
) x
WHERE rn = 1;


-- 77. Monthly revenue vs previous month
WITH m AS (
    SELECT DATE_FORMAT(o.order_date,'%Y-%m') AS month,
           SUM(od.quantity * od.unit_price) AS revenue
    FROM orders o
    JOIN order_details od ON o.order_id = od.order_id
    GROUP BY month
)
SELECT month, revenue,
       LAG(revenue) OVER(ORDER BY month) AS previous_revenue
FROM m;


-- 78. Next order date for each customer
SELECT customer_id,
       order_date,
       LEAD(order_date) OVER(
           PARTITION BY customer_id
           ORDER BY order_date
       ) AS next_order
FROM orders;


-- 79. Running monthly revenue
WITH m AS (
    SELECT DATE_FORMAT(o.order_date,'%Y-%m') AS month,
           SUM(od.quantity * od.unit_price) AS revenue
    FROM orders o
    JOIN order_details od ON o.order_id = od.order_id
    GROUP BY month
)
SELECT month, revenue,
       SUM(revenue) OVER(ORDER BY month) AS running_revenue
FROM m;


-- 80. Running revenue by region
WITH r AS (
    SELECT s.region_id,
           DATE_FORMAT(o.order_date,'%Y-%m') AS month,
           SUM(od.quantity * od.unit_price) AS revenue
    FROM orders o
    JOIN stores s ON o.store_id = s.store_id
    JOIN order_details od ON o.order_id = od.order_id
    GROUP BY s.region_id, month
)
SELECT region_id, month, revenue,
       SUM(revenue) OVER(
           PARTITION BY region_id ORDER BY month
       ) AS running_revenue
FROM r;


-- 81. 3-month moving average
WITH m AS (
    SELECT DATE_FORMAT(o.order_date,'%Y-%m') AS month,
           SUM(od.quantity * od.unit_price) AS revenue
    FROM orders o
    JOIN order_details od ON o.order_id = od.order_id
    GROUP BY month
)
SELECT month, revenue,
       AVG(revenue) OVER(
           ORDER BY month ROWS 2 PRECEDING
       ) AS moving_avg
FROM m;


-- 82. Product % of category revenue
WITH p AS (
    SELECT pr.product_id,
           pr.category_id,
           SUM(od.quantity * od.unit_price) AS revenue
    FROM products pr
    JOIN order_details od ON pr.product_id = od.product_id
    GROUP BY pr.product_id, pr.category_id
)
SELECT product_id, category_id, revenue,
       ROUND(
           revenue * 100 /
           SUM(revenue) OVER(PARTITION BY category_id), 2
       ) AS category_pct
FROM p;


-- 83. Region % of total revenue
WITH r AS (
    SELECT s.region_id,
           SUM(od.quantity * od.unit_price) AS revenue
    FROM orders o
    JOIN stores s ON o.store_id = s.store_id
    JOIN order_details od ON o.order_id = od.order_id
    GROUP BY s.region_id
)
SELECT region_id, revenue,
       ROUND(revenue * 100 / SUM(revenue) OVER(), 2) AS total_pct
FROM r;


-- 84. Highest-revenue product in every category
WITH p AS (
    SELECT pr.product_id, pr.category_id,
           SUM(od.quantity * od.unit_price) AS revenue
    FROM products pr
    JOIN order_details od ON pr.product_id = od.product_id
    GROUP BY pr.product_id, pr.category_id
)
SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER(
               PARTITION BY category_id
               ORDER BY revenue DESC
           ) AS rn
    FROM p
) x
WHERE rn = 1;


-- 85. Second-highest employee in every region
WITH e AS (
    SELECT o.employee_id, s.region_id,
           SUM(od.quantity * od.unit_price) AS revenue
    FROM orders o
    JOIN stores s ON o.store_id = s.store_id
    JOIN order_details od ON o.order_id = od.order_id
    GROUP BY o.employee_id, s.region_id
)
SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER(
               PARTITION BY region_id
               ORDER BY revenue DESC
           ) AS rn
    FROM e
) x
WHERE rn = 2;


-- 86. Employee revenue vs regional average
WITH e AS (
    SELECT o.employee_id, s.region_id,
           SUM(od.quantity * od.unit_price) AS revenue
    FROM orders o
    JOIN stores s ON o.store_id = s.store_id
    JOIN order_details od ON o.order_id = od.order_id
    GROUP BY o.employee_id, s.region_id
)
SELECT employee_id, region_id, revenue,
       ROUND(
           revenue - AVG(revenue) OVER(
               PARTITION BY region_id
           ), 2
       ) AS difference
FROM e;


-- 87. Current order greater than previous order
WITH o AS (
    SELECT orders.order_id,
           orders.customer_id,
           orders.order_date,
           SUM(od.quantity * od.unit_price) AS order_value
    FROM orders
    JOIN order_details od ON orders.order_id = od.order_id
    GROUP BY orders.order_id,
             orders.customer_id,
             orders.order_date
)
SELECT *
FROM (
    SELECT *,
           LAG(order_value) OVER(
               PARTITION BY customer_id
               ORDER BY order_date
           ) AS previous_value
    FROM o
) x
WHERE order_value > previous_value;


-- 88. Cumulative customer revenue
WITH o AS (
    SELECT orders.order_id,
           orders.customer_id,
           orders.order_date,
           SUM(od.quantity * od.unit_price) AS order_value
    FROM orders
    JOIN order_details od ON orders.order_id = od.order_id
    GROUP BY orders.order_id,
             orders.customer_id,
             orders.order_date
)
SELECT customer_id, order_date, order_value,
       SUM(order_value) OVER(
           PARTITION BY customer_id
           ORDER BY order_date
       ) AS cumulative_revenue
FROM o;


-- 89. Monthly order growth %
WITH m AS (
    SELECT DATE_FORMAT(order_date,'%Y-%m') AS month,
           COUNT(*) AS orders
    FROM orders
    GROUP BY month
)
SELECT month, orders,
       ROUND(
           (orders - LAG(orders) OVER(ORDER BY month))
           * 100.0 /
           LAG(orders) OVER(ORDER BY month), 2
       ) AS growth_pct
FROM m;


-- 90. Month with largest revenue increase
WITH m AS (
    SELECT DATE_FORMAT(o.order_date,'%Y-%m') AS month,
           SUM(od.quantity * od.unit_price) AS revenue
    FROM orders o
    JOIN order_details od ON o.order_id = od.order_id
    GROUP BY month
)
SELECT month,
       revenue - LAG(revenue) OVER(ORDER BY month) AS increase
FROM m
ORDER BY increase DESC
LIMIT 1;

# Level 5 — Interview / Case Study SQL

-- 91. Find total revenue by region
SELECT s.region_id,
       SUM(od.quantity * od.unit_price) AS revenue
FROM orders o
JOIN stores s ON o.store_id = s.store_id
JOIN order_details od ON o.order_id = od.order_id
GROUP BY s.region_id;


-- 92. Find the highest-revenue product
SELECT p.product_id,
       SUM(od.quantity * od.unit_price) AS revenue
FROM products p
JOIN order_details od ON p.product_id = od.product_id
GROUP BY p.product_id
ORDER BY revenue DESC
LIMIT 1;


-- 93. Find the highest-revenue customer
SELECT o.customer_id,
       SUM(od.quantity * od.unit_price) AS revenue
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY o.customer_id
ORDER BY revenue DESC
LIMIT 1;


-- 94. Find the highest-revenue employee
SELECT o.employee_id,
       SUM(od.quantity * od.unit_price) AS revenue
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY o.employee_id
ORDER BY revenue DESC
LIMIT 1;


-- 95. Find the highest-revenue store
SELECT o.store_id,
       SUM(od.quantity * od.unit_price) AS revenue
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY o.store_id
ORDER BY revenue DESC
LIMIT 1;


-- 96. Find average order value
SELECT AVG(order_value) AS avg_order_value
FROM (
    SELECT o.order_id,
           SUM(od.quantity * od.unit_price) AS order_value
    FROM orders o
    JOIN order_details od ON o.order_id = od.order_id
    GROUP BY o.order_id
) x;


-- 97. Find customers with more than 5 orders
SELECT customer_id,
       COUNT(*) AS orders
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 5;


-- 98. Find products sold more than 100 units
SELECT product_id,
       SUM(quantity) AS units
FROM order_details
GROUP BY product_id
HAVING SUM(quantity) > 100;


-- 99. Find monthly revenue
SELECT DATE_FORMAT(o.order_date,'%Y-%m') AS month,
       SUM(od.quantity * od.unit_price) AS revenue
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY month
ORDER BY month;


-- 100. Find monthly orders
SELECT DATE_FORMAT(order_date,'%Y-%m') AS month,
       COUNT(*) AS orders
FROM orders
GROUP BY month
ORDER BY month;


-- 101. Find monthly customers
SELECT DATE_FORMAT(order_date,'%Y-%m') AS month,
       COUNT(DISTINCT customer_id) AS customers
FROM orders
GROUP BY month
ORDER BY month;


-- 102. Find monthly AOV
SELECT DATE_FORMAT(o.order_date,'%Y-%m') AS month,
       SUM(od.quantity * od.unit_price) / COUNT(DISTINCT o.order_id) AS AOV
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY month;


-- 103. Find revenue by category
SELECT p.category_id,
       SUM(od.quantity * od.unit_price) AS revenue
FROM products p
JOIN order_details od ON p.product_id = od.product_id
GROUP BY p.category_id;


-- 104. Find revenue by employee
SELECT o.employee_id,
       SUM(od.quantity * od.unit_price) AS revenue
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY o.employee_id;


-- 105. Find revenue by store
SELECT o.store_id,
       SUM(od.quantity * od.unit_price) AS revenue
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY o.store_id;


-- 106. Find customers with revenue above 10,000
SELECT o.customer_id,
       SUM(od.quantity * od.unit_price) AS revenue
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY o.customer_id
HAVING revenue > 10000;


-- 107. Find products with revenue above average
WITH p AS (
    SELECT product_id,
           SUM(quantity * unit_price) AS revenue
    FROM order_details
    GROUP BY product_id
)
SELECT *
FROM p
WHERE revenue > (SELECT AVG(revenue) FROM p);


-- 108. Find top 5 products
SELECT product_id,
       SUM(quantity * unit_price) AS revenue
FROM order_details
GROUP BY product_id
ORDER BY revenue DESC
LIMIT 5;


-- 109. Find top 5 customers
SELECT customer_id,
       SUM(od.quantity * od.unit_price) AS revenue
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY customer_id
ORDER BY revenue DESC
LIMIT 5;


-- 110. Find top 5 employees
SELECT employee_id,
       SUM(od.quantity * od.unit_price) AS revenue
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY employee_id
ORDER BY revenue DESC
LIMIT 5;


-- 111. Find largest regional contributors to monthly decline
WITH r AS (
    SELECT DATE_FORMAT(o.order_date,'%Y-%m') AS month,
           s.region_id,
           SUM(od.quantity * od.unit_price) AS revenue
    FROM orders o
    JOIN stores s ON o.store_id = s.store_id
    JOIN order_details od ON o.order_id = od.order_id
    GROUP BY month, s.region_id
)
SELECT region_id, month, revenue,
       revenue - LAG(revenue) OVER(
           PARTITION BY region_id ORDER BY month
       ) AS change
FROM r;


-- 112. Customers whose order frequency is increasing
SELECT customer_id,
       YEAR(order_date) AS year,
       COUNT(*) AS orders
FROM orders
GROUP BY customer_id, YEAR(order_date)
ORDER BY customer_id, year;


-- 113. Top 20% customers and revenue share
WITH c AS (
    SELECT customer_id,
           SUM(od.quantity * od.unit_price) AS revenue
    FROM orders o
    JOIN order_details od ON o.order_id = od.order_id
    GROUP BY customer_id
),
r AS (
    SELECT *,
           NTILE(5) OVER(ORDER BY revenue DESC) AS bucket
    FROM c
)
SELECT *
FROM r
WHERE bucket = 1;


-- 114. Pareto analysis of products
WITH p AS (
    SELECT product_id,
           SUM(quantity * unit_price) AS revenue
    FROM order_details
    GROUP BY product_id
)
SELECT *,
       SUM(revenue) OVER(
           ORDER BY revenue DESC
       ) AS cumulative_revenue
FROM p;


-- 115. Products with high revenue but low margin
SELECT product_id,
       SUM(quantity * unit_price) AS revenue
FROM order_details
GROUP BY product_id
ORDER BY revenue DESC;


-- 116. Products with high margin but low volume
SELECT product_id,
       SUM(quantity) AS volume
FROM order_details
GROUP BY product_id
ORDER BY volume;


-- 117. Stores with above-average revenue
SELECT store_id,
       SUM(od.quantity * od.unit_price) AS revenue
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY store_id
HAVING revenue > (
    SELECT AVG(x.revenue)
    FROM (
        SELECT store_id,
               SUM(od.quantity * od.unit_price) AS revenue
        FROM orders o
        JOIN order_details od ON o.order_id = od.order_id
        GROUP BY store_id
    ) x
);


-- 118. Employee revenue and average order value
SELECT o.employee_id,
       SUM(od.quantity * od.unit_price) AS revenue,
       SUM(od.quantity * od.unit_price) /
       COUNT(DISTINCT o.order_id) AS AOV
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY o.employee_id;


-- 119. First and latest purchase date
SELECT customer_id,
       MIN(order_date) AS first_purchase,
       MAX(order_date) AS latest_purchase
FROM orders
GROUP BY customer_id;


-- 120. Customer lifetime value
SELECT customer_id,
       SUM(od.quantity * od.unit_price) AS lifetime_value
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY customer_id;


-- 121. Monthly active customers
SELECT DATE_FORMAT(order_date,'%Y-%m') AS month,
       COUNT(DISTINCT customer_id) AS active_customers
FROM orders
GROUP BY month;


-- 122. Customer retention by signup month
SELECT DATE_FORMAT(c.signup_date,'%Y-%m') AS signup_month,
       COUNT(DISTINCT c.customer_id) AS customers
FROM customers c
GROUP BY signup_month;


-- 123. Repeat-purchase rate
SELECT
    COUNT(DISTINCT CASE WHEN orders > 1 THEN customer_id END)
    * 100.0 / COUNT(DISTINCT customer_id) AS repeat_rate
FROM (
    SELECT customer_id,
           COUNT(*) AS orders
    FROM orders
    GROUP BY customer_id
) x;


-- 124. Customers purchased in January but not February
SELECT DISTINCT customer_id
FROM orders
WHERE MONTH(order_date) = 1
AND customer_id NOT IN (
    SELECT customer_id
    FROM orders
    WHERE MONTH(order_date) = 2
);


-- 125. Customers purchased in both January and February
SELECT customer_id
FROM orders
WHERE MONTH(order_date) IN (1,2)
GROUP BY customer_id
HAVING COUNT(DISTINCT MONTH(order_date)) = 2;


-- 126. Customers purchased in every quarter of 2025
SELECT customer_id
FROM orders
WHERE YEAR(order_date) = 2025
GROUP BY customer_id
HAVING COUNT(DISTINCT QUARTER(order_date)) = 4;


-- 127. Longest gap between orders
WITH x AS (
    SELECT customer_id,
           order_date,
           LEAD(order_date) OVER(
               PARTITION BY customer_id
               ORDER BY order_date
           ) AS next_order
    FROM orders
)
SELECT customer_id,
       MAX(DATEDIFF(next_order, order_date)) AS longest_gap
FROM x
GROUP BY customer_id;


-- 128. Fastest-growing category YoY
WITH c AS (
    SELECT p.category_id,
           YEAR(o.order_date) AS year,
           SUM(od.quantity * od.unit_price) AS revenue
    FROM orders o
    JOIN order_details od ON o.order_id = od.order_id
    JOIN products p ON od.product_id = p.product_id
    GROUP BY p.category_id, YEAR(o.order_date)
)
SELECT category_id,
       year,
       revenue,
       LAG(revenue) OVER(
           PARTITION BY category_id ORDER BY year
       ) AS previous_revenue
FROM c;


-- 129. Best and worst month by revenue
SELECT DATE_FORMAT(o.order_date,'%Y-%m') AS month,
       SUM(od.quantity * od.unit_price) AS revenue
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY month
ORDER BY revenue DESC;


-- 130. Executive monthly sales report
SELECT DATE_FORMAT(o.order_date,'%Y-%m') AS month,
       SUM(od.quantity * od.unit_price) AS revenue,
       COUNT(DISTINCT o.order_id) AS orders,
       COUNT(DISTINCT o.customer_id) AS customers,
       SUM(od.quantity * od.unit_price) /
       COUNT(DISTINCT o.order_id) AS AOV
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
GROUP BY month
ORDER BY month;









