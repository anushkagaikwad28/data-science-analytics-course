/*
====================================================
01 - DATABASE EXPLORATION
====================================================
*/

-- 1. Display all databases
SHOW DATABASES;

-- 2. Select your database
USE ecommerce_analytics;

-- 3. Display all tables
SHOW TABLES;

-- 4. Inspect table structures
DESCRIBE customers;
DESCRIBE orders;
DESCRIBE order_details;
DESCRIBE products;
DESCRIBE categories;
DESCRIBE employees;
DESCRIBE shippers;
DESCRIBE territories;
DESCRIBE regions;
DESCRIBE employee_territories;

-- 5. Preview data
SELECT * FROM customers LIMIT 10;
SELECT * FROM orders LIMIT 10;
SELECT * FROM order_details LIMIT 10;
SELECT * FROM products LIMIT 10;

-- 6. Count records
SELECT 'customers' AS table_name, COUNT(*) AS total_records FROM customers
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_details', COUNT(*) FROM order_details
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'categories', COUNT(*) FROM categories
UNION ALL
SELECT 'employees', COUNT(*) FROM employees
UNION ALL
SELECT 'shippers', COUNT(*) FROM shippers
UNION ALL
SELECT 'regions', COUNT(*) FROM regions
UNION ALL
SELECT 'territories', COUNT(*) FROM territories;

-- 7. Find unique countries
SELECT DISTINCT country
FROM customers;

-- 8. Find date range of orders
SELECT
 MIN(orderDate) AS First_Order,
 MAX(orderDate) AS Last_Order
FROM orders;