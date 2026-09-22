use ecommerce_analytics;
/*
====================================================
15 - ADVANCED SQL ANALYSIS
====================================================

JOIN
GROUP BY
SUBQUERY
WINDOW FUNCTIONS
CASE
DATE FUNCTIONS
====================================================
*/


-- ==================================================
-- 1. TOP 5 CUSTOMERS BY REVENUE
-- ==================================================

SELECT 
 c.customerID,
 c.companyName AS customerName,
 SUM(od.unitPrice*od.quantity*(1-od.discount)) AS Revenue
FROM customers c
JOIN orders o
ON c.customerID=o.customerID
JOIN order_details od
ON o.orderID=od.orderID
GROUP BY c.customerID,c.companyName
ORDER BY Revenue DESC
LIMIT 5;



-- ==================================================
-- 2. RANK EMPLOYEES BY REVENUE
-- ==================================================
SELECT
 e.employeeID,
 CONCAT(e.firstName," ",e.lastName) AS EmployeeName,
 SUM(od.unitPrice*od.quantity*(1-od.discount))AS Employee_Revenue,
 RANK() OVER
 ( 
 ORDER BY SUM(od.unitPrice*od.quantity*(1-od.discount)) DESC)
 AS Revenue_Rank
 FROM employees e
 JOIN orders o
 ON e.employeeID=o.employeeID
 JOIN order_details od 
 ON o.orderID=od.orderID
 
 GROUP BY e.employeeID,EmployeeName;

-- ==================================================
-- 3. TOP PRODUCT WITHIN EVERY CATEGORY
-- ==================================================
SELECT *FROM
( SELECT
 p.productID,
 p.productName,
 p.categoryID,
 SUM(od.unitPrice*od.quantity*(1-od.discount)) AS Revenue,
row_number() OVER
 ( PARTITION BY p.categoryID
  ORDER BY 
  SUM(od.unitPrice*od.quantity*(1-od.discount)) DESC)
  AS Category_Rank 
  FROM products p
  JOIN order_details od
  ON p.productID=od.productID
  
  GROUP BY
   p.productID,
   p.productName,
   p.categoryID
   ) AS Ranked_Products
   
WHERE Category_Rank=1;
   


-- ==================================================
-- 4. MONTHLY REVENUE
-- ==================================================

SELECT 
 YEAR(o.orderDate) AS order_year,
 MONTH(o.orderDate) AS order_MONTH,
 SUM(od.unitPrice*od.quantity*(1-od.discount)) AS REVENU
FROM orders o
JOIN order_details od
ON o.orderID=od.orderID

GROUP BY 
YEAR(o.orderDate),
MONTH(o.orderDate)
ORDER BY 
 order_year,
 order_month;



-- ==================================================
-- 5. CUSTOMERS ABOVE AVERAGE REVENUE
-- ==================================================
SELECT
 c.customerID ,
 c.companyName AS customerName,
 SUM(od.unitPrice*od.quantity*(1-od.discount)) AS REVENU
 FROM customers c
 JOIN orders o
 ON c.customerID=o.customerID
 JOIN order_details od
 ON o.orderID=od.orderID
 GROUP BY c.customerID,c.companyName
 HAVING SUM(od.unitPrice*od.quantity*(1-od.discount)) > 
 (
  SELECT 
  AVG(customer_revenue) AS Average_Revenue
  FROM 
  (
   SELECT o1.customerID,
   SUM(od1.unitPrice*od1.quantity*(1-od1.discount)) AS customer_revenue
   FROM orders o1
   JOIN order_details od1
   ON o1.orderID=od1.orderID
   GROUP BY o1.customerID
   ) as Revenue_Table
 )ORDER BY REVENUE desc;


-- ==================================================
-- 6. EMPLOYEE YEARLY PERFORMANCE
-- ==================================================

SELECT 
 e.employeeID,
 CONCAT(e.firstName,' ',e.lastName) AS EmployeeName,
 YEAR(o.orderDate) AS order_year,
 SUM(od.unitPrice*od.quantity*(1-od.discount)) AS Revenue,
 RANK() 
 OVER(
  PARTITION BY YEAR(o.orderDate)
  ORDER BY  SUM(od.unitPrice*od.quantity*(1-od.discount)) DESC 
  ) AS Ranked_Year
  FROM employees e
  JOIN orders o
  ON e.employeeID=o.employeeID
  JOIN order_details od
  ON o.orderID=od.orderID
  GROUP BY  e.employeeID,EmployeeName, YEAR(o.orderDate);


-- ==================================================
-- 8. SHIPPING PERFORMANCE
-- ==================================================

SELECT 
o.orderID,
s.companyName AS ShipperName,
DATEDIFF(o.shippedDate,o.orderDate) AS Shipped_Days,
CASE
 WHEN o.shippedDate IS NULL THEN 'NOT Shipped'
 WHEN DATEDIFF(o.shippedDate,o.orderDate) <=3 THEN 'FAST'
 WHEN DATEDIFF(o.shippedDate,o.orderDate) <=7 THEN 'NORMAL'
 ELSE 'Delayed'
END AS shipping_status
FROM orders o
JOIN shippers s
ON o.shipvia=s.shipperID;