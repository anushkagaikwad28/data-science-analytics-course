/*
====================================================
03 - SORTING, DISTINCT & LIMIT
====================================================
*/

-- 1. Sort products by price
SELECT productName , unitPrice 
FROM products 
ORDER BY unitPrice;

-- 2. Descending order
SELECT productName , unitPrice 
FROM products 
ORDER BY unitPrice DESC;


-- 3. Sort by multiple columns
SELECT *FROM customers
ORDER BY country ASC , companyName ASC;

-- 4. Top 10 expensive products
SELECT productName, unitPrice
FROM products
ORDER BY unitPrice DESC LIMIT 10;

-- 5. Five cheapest products
SELECT productName , unitPrice
FROM products 
ORDER BY unitPrice LIMIT 5;

-- 6. Top 10 customers alphabetically
SELECT customerID,companyName
FROM customers 
ORDER BY CustomerID LIMIT 10;

-- 7. Unique customer countries
SELECT DISTINCT country
FROM customers
ORDER BY country;

-- 8. Top 10 largest quantities ordered
SELECT *FROM order_details
ORDER BY quantity DESC LIMIT 10;

-- 9. Highest discounts
SELECT *FROM order_details
ORDER BY discount DESC LIMIT 10;

-- 10. OFFSET
SELECT productID,productName,unitPrice
FROM products 
ORDER BY productID,unitPrice DESC
LIMIT 10 OFFSET 10;