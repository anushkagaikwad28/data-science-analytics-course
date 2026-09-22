/*
====================================================
09 - CONDITIONAL & NULL FUNCTIONS
====================================================
*/

-- 1. CASE
SELECT
    productName,
    unitPrice,
    CASE
        WHEN unitPrice < 20 THEN 'Low'
        WHEN unitPrice < 50 THEN 'Medium'
        ELSE 'High'
    END AS price_category
FROM products;

-- 2. IF
SELECT
    productName,
    IF(discontinued = 1, 'Discontinued', 'Active') AS status
FROM products;

-- 3. IFNULL
SELECT
    employeeID,
    firstName,
    IFNULL(reportsTo, 0) AS manager_id
FROM employees;

-- 4. COALESCE
SELECT
    employeeID,
    firstName,
    COALESCE(reportsTo, 0) AS manager_id
FROM employees;

-- 5. NULLIF
SELECT NULLIF(10, 10) AS result;

-- 6. Shipping status
SELECT
    orderID,
    CASE
        WHEN shippedDate IS NULL THEN 'Not Shipped'
        ELSE 'Shipped'
    END AS shipping_status
FROM orders;

-- 7. Shipping performance
SELECT
    orderID,
    DATEDIFF(shippedDate, orderDate) AS shipping_days,
    CASE
        WHEN shippedDate IS NULL THEN 'Not Shipped'
        WHEN DATEDIFF(shippedDate, orderDate) <= 3 THEN 'Fast'
        WHEN DATEDIFF(shippedDate, orderDate) <= 7 THEN 'Normal'
        ELSE 'Delayed'
    END AS shipping_category
FROM orders;