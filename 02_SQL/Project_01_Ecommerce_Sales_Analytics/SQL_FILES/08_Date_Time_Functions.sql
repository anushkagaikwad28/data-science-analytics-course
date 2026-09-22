/*
====================================================
08 - DATE & TIME FUNCTIONS
====================================================

YEAR
MONTH
DAY
DAYNAME
MONTHNAME
QUARTER
DATEDIFF
DATE_ADD
DATE_SUB
DATE_FORMAT
====================================================
*/

-- 1. YEAR
SELECT
 orderDate,
 YEAR(orderDate) AS Order_Year
FROM orders;

-- 2. MONTH
SELECT
 orderDate,
 MONTH(orderDate) AS Order_Month
 FROM orders LIMIT 10;

-- 3. DAY
SELECT
 orderDate,
 DAY(orderDate) AS Order_Day
 FROM orders LIMIT 10;

-- 4. DAYNAME
SELECT
 orderDate,
 DAYNAME(orderDate) AS Order_DayName
 FROM orders LIMIT 10;

-- 5. MONTHNAME
SELECT
 orderDate,
 MONTHNAME(orderDate) AS Order_MonthName
 FROM orders LIMIT 10;

-- 6. QUARTER
SELECT
 orderID,
 QUARTER(orderDate) AS quarter_number
FROM orders LIMIT 10;

-- 7. DATEDIFF
SELECT 
orderID,
DATEDIFF(shippedDate,orderDate) AS Shipping_Days
FROM orders LIMIT 10;

-- 8. DATE_ADD
SELECT 
 orderID,
 orderDate,
 DATE_ADD(orderDate,INTERVAL 30 DAY) AS Date_After_30_Days
 FROM orders;

-- 9. DATE_SUB
SELECT 
 orderID,
 orderDate,
 DATE_SUB(orderDate,INTERVAL 30 DAY) AS Date_Before_30_Days
 FROM orders;

-- 10. DATE_FORMAT
SELECT 
 orderID,
 DATE_FORMAT(orderDate,'%Y-%m') AS order_Month
 FROM orders;
 
-- 11. Orders by year
SELECT 
 YEAR(orderDate) AS order_year,
 COUNT(*) AS total_Orders
 FROM orders
 GROUP BY Year(orderDate)
 ORDER BY order_year;

-- 12. Average shipping time
SELECT 
    orderID,
    AVG(DATEDIFF(shippedDate, orderDate)) AS Average_Shipping_Days
FROM orders 
WHERE shippedDate IS NOT NULL
GROUP BY orderID;

