use ecommerce_analytics;
/*
====================================================
14 - SET OPERATORS
====================================================

UNION
UNION ALL
INTERSECT / EXCEPT
====================================================
*/

-- 1. UNION
SELECT country 
FROM customers 
UNION 
SELECT country
FROM employees;


-- 2. UNION ALL
SELECT country
FROM customers
UNION ALL
SELECT country
FROM customers;

-- 3. UNION with labels
SELECT
    companyName,
    'Customer' AS type
FROM customers

UNION

SELECT
    companyName,
    'Shipper' AS type
FROM shippers;