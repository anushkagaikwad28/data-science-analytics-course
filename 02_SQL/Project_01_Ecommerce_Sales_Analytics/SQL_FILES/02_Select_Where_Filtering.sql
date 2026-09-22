/*
====================================================
02 - SELECT, WHERE & FILTERING
====================================================
*/

-- 1. Select all columns
SELECT *FROM customers;

-- 2. Select specific columns
SELECT customerID,companyName,country
FROM customers;

-- 3. DISTINCT
SELECT DISTINCT country
FROM customers;

-- 4. WHERE
SELECT *FROM customers
WHERE country='Germany';

-- 5. Greater than
SELECT productName,unitPrice 
FROM products 
WHERE unitPrice > 50;

-- 6. Less than
SELECT productName,unitPrice 
FROM products 
WHERE unitPrice < 20;

-- 7. Greater than or equal
SELECT productName,unitPrice 
FROM products 
WHERE unitPrice >= 50;

-- 8. Not equal
SELECT *FROM customers
WHERE country <>'USA';

-- 9. AND
SELECT *FROM products
WHERE unitPrice >20
AND categoryID=1;

-- 10. OR
SELECT *FROM customers
WHERE country='Germany'
OR country='France';

-- 11. NOT
SELECT *FROM customers
WHERE NOT country='Germany';

-- 12. IN
SELECT *FROM customers
WHERE country IN('Germany','France','UK');

-- 13. BETWEEN
SELECT productName,unitPrice
FROM products 
WHERE unitPrice BETWEEN 20 AND 50;

-- 14. LIKE - starts with
SELECT *FROM customers
WHERE companyName LIKE 'A%';

-- 15. LIKE - ends with
SELECT *FROM customers
WHERE companyName LIKE '%Ltd';

-- 16. LIKE - contains
SELECT *FROM products
WHERE productName LIKE '%ch%';

-- 17. IS NULL
SELECT *FROM employees
WHERE reportsTo IS NULL;

-- 18. IS NOT NULL
SELECT *FROM employees
WHERE reportsTo IS NOT NULL;

-- 19. Discontinued products
SELECT *FROM products 
WHERE discontinued=1;

-- 20. Orders after a specific date
SELECT *FROM orders
WHERE orderDate >'1997-01-01';