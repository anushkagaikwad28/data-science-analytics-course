/*
====================================================
07 - NUMERIC FUNCTIONS
====================================================

ROUND
CEIL / CEILING
FLOOR
ABS
MOD
POWER
SQRT
TRUNCATE
====================================================
*/

-- 1. ROUND
SELECT 
 productName,unitPrice,
 ROUND(unitPrice,1) AS Rounded_Price
FROM products;

-- 2. CEILING
SELECT
 productName,unitPrice,
 CEILING(unitPrice) AS Ceiling_Price
FROM products;

-- 3. FLOOR
SELECT
 productName,unitPrice,
 FLOOR(unitPrice) AS Floor_Price
FROM products;

-- 4. ABS
SELECT
 ABS(-100) AS Absolute_Value;

-- 5. MOD
SELECT
MOD(quantity,2) AS Remainder
FROM order_details;

-- 6. POWER
SELECT
POWER(2,3) AS Result;

-- 7. SQRT
SELECT SQRT(100) AS Result;

-- 8. TRUNCATE
SELECT
 productName,
 TRUNCATE(unitPrice,1) AS truncated_Price
FROM products;

-- 9. Revenue rounded to 2 decimals
SELECT 
 o.productID,p.productName,
 SUM(o.unitPrice*o.quantity*(1-o.discount)) AS  Revenue,
 ROUND(SUM(o.unitPrice*o.quantity*(1-o.discount))) AS Rounded_Revenue
 FROM order_details o
 JOIN products p
 ON o.productID=p.productID
 GROUP BY o.productID,p.productName
 ORDER BY o.productID;
 