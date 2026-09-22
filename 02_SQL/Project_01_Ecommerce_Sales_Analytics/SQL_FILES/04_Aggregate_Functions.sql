/*
====================================================
04 - AGGREGATE FUNCTIONS
====================================================

COUNT()
SUM()
AVG()
MIN()
MAX()
====================================================
*/

-- 1. COUNT
SELECT COUNT(*) AS Total_Orders
FROM orders;

-- 2. COUNT specific column
SELECT COUNT(customerID) AS orders_with_customers
FROM orders;

-- 3. COUNT DISTINCT
SELECT COUNT(DISTINCT customerID) AS unique_customers
FROM orders;

-- 4. SUM
SELECT SUM(quantity) AS total_quantity 
FROM order_details;

-- 5. AVG
SELECT AVG(unitPrice) AS Average_Product_Price
FROM products;

-- 6. MIN
SELECT MIN(unitPrice) AS Minimum_Price 
FROM products;

-- 7. MAX
SELECT MAX(unitPrice) AS Maxmimum_Price 
FROM products;

-- 8. Total gross sales
SELECT SUM(unitPrice * quantity) AS GROSS_SALES
FROM order_details;
   
-- 9. Total discount amount
SELECT SUM(unitPrice*quantity*discount) AS total_Discount
FROM order_details;
   
-- 10. Net revenue
SELECT SUM(unitPrice*quantity*(1-discount)) AS Net_Revenue
FROM order_details;

-- 11. Average order quantity
SELECT AVG(quantity) AS Average_Quantity 
FROM order_details;

-- 12. Average discount
SELECT AVG(discount) AS Average_Discount
FROM order_details;