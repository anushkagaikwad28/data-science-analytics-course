/*
====================================================
05 - GROUP BY & HAVING
====================================================
*/

-- 1. Orders by customer
SELECT 
 customerID,
 COUNT(*) AS Total_Order
 FROM orders
 GROUP BY customerID ;

-- 2. Orders by employee
SELECT
  employeeID,
  COUNT(*) AS Total_Orders
  FROM orders
  GROUP BY employeeID
  ORDER BY employeeID;

-- 3. Customers by country
SELECT 
  country,
  COUNT(*) AS Total_Customer
  FROM customers
  GROUP BY country
  ORDER BY country;

-- 4. Products by category
 SELECT
  categoryID,
  COUNT(*) AS product_count
  FROM products
  GROUP BY categoryID;

-- 5. Average product price by category
SELECT 
 categoryID,
 AVG(unitPrice) AS Average_Price
 FROM products
 GROUP BY categoryID;

-- 6. Revenue by product
SELECT 
 o.productID,p.productName,
 SUM(o.unitPrice*o.quantity*(1-o.discount)) AS  Revenue
 FROM order_details o
 JOIN products p
 ON o.productID=p.productID
 GROUP BY o.productID,p.productName
 ORDER BY o.productID;

-- 7. Revenue by year
SELECT
 YEAR(o1.orderDate) AS order_year,
 SUM(o2.unitPrice*o2.quantity*(1-o2.discount)) AS Revenue
 FROM orders o1
 JOIN order_details o2
 ON o1.orderID=o2.orderID
 GROUP BY order_year;

-- 8. Customers with more than 10 orders
SELECT 
 customerID,
 count(*) AS total_orders
 FROM orders
 GROUP BY customerID
 HAVING total_orders > 10;

-- 9. Products generating more than 10000 revenue
SELECT 
 o.productID,p.productName,
 SUM(o.unitPrice*o.quantity*(1-o.discount)) AS  Revenue
 FROM order_details o
 JOIN products p
 ON o.productID=p.productID
 GROUP BY o.productID,p.productName
 HAVING Revenue >10000
 ORDER BY o.productID;

-- 10. Countries with more than 5 customers
SELECT 
country,
COUNT(*) AS total_customers
FROM customers
GROUP BY country
HAVING total_customers >5;