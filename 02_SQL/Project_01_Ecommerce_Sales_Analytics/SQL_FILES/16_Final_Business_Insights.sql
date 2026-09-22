use ecommerce_analytics;
/*
====================================================
17 - FINAL BUSINESS INSIGHTS
====================================================
NORTHWIND SALES & BUSINESS ANALYTICS
====================================================
*/


/*
----------------------------------------------------
1. What is the total revenue?
----------------------------------------------------
*/

SELECT 
SUM(unitPrice*quantity*(1-discount)) AS Total_Revenue
FROM order_details;


/*
----------------------------------------------------
2. What are the top 10 products by revenue?
----------------------------------------------------
*/
SELECT 
p.productID,
p.productName,
SUM(od.unitPrice*od.quantity*(1-discount)) AS product_revenue
FROM products p
JOIN order_details od
ON p.productID=od.productID
GROUP BY 
p.productID,p.productName
ORDER BY product_revenue DESC 
LIMIT 10; 


/*
----------------------------------------------------
3. Which categories generate the most revenue?
----------------------------------------------------
*/
SELECT 
c.categoryID,
c.categoryName,
ROUND(SUM(od.unitPrice*od.quantity*(1-discount)),3)AS category_revenue
FROM categories c
JOIN products p 
ON c.categoryID=p.categoryID
JOIN order_details od
ON p.productID=od.productID

GROUP BY c.categoryID,c.categoryName
ORDER BY category_revenue DESC;

/*
----------------------------------------------------
4. Who are the top 10 customers?
----------------------------------------------------
*/
SELECT 
c.customerID,
c.companyName AS customerName,
ROUND(SUM(od.unitPrice*od.quantity*(1-discount)),3) AS customer_revenue
FROM customers c
JOIN orders o
ON c.customerID=o.customerID
JOIN order_details od 
ON o.orderID=od.orderID
GROUP BY c.customerID,customerName
ORDER BY customer_revenue DESC
LIMIT 10;


/*
----------------------------------------------------
5. Which employees generate the most revenue?
----------------------------------------------------
*/
SELECT 
e.employeeID,
CONCAT(e.firstName,' ',e.lastName) AS EmployeeName,
ROUND(SUM(od.unitPrice*od.quantity*(1-discount)),3) AS employee_revenue
FROM employees e
JOIN orders o
ON e.employeeID=o.employeeID
JOIN order_details od
ON o.orderID=od.orderID
GROUP BY 
e.employeeID,EmployeeName
ORDER BY employee_revenue DESC
LIMIT 1;


/*
----------------------------------------------------
6. What is the yearly revenue trend?
----------------------------------------------------
*/
SELECT 
YEAR(o.orderDate) AS yearly,
ROUND(SUM(od.unitPrice*od.quantity*(1-discount)),3) AS Yearly_Revenue
FROM orders o
JOIN order_details od 
ON o.orderID=od.orderID
GROUP BY YEAR(o.orderDate)
ORDER BY Yearly_Revenue;


/*
----------------------------------------------------
7. What is the monthly revenue trend?
----------------------------------------------------
*/
SELECT 
YEAR(o.orderDate) AS yearly,
MONTH(o.orderDate) AS monthly,
ROUND(SUM(od.unitPrice*od.quantity*(1-discount)),3) AS Monthly_Revenue
FROM orders o
JOIN order_details od 
ON o.orderID=od.orderID
GROUP BY YEAR(o.orderDate),MONTH(o.orderDate)
ORDER BY YEAR(o.orderDate),MONTH(o.orderDate);

/*
----------------------------------------------------
8. Which products perform above their category average?
----------------------------------------------------
*/
SELECT 
p.productId,
p.productName,
p.categoryID,
p.unitPrice
FROM products p
WHERE p.unitPrice >
(
SELECT 
AVG(p1.unitPrice)
FROM products p1
WHERE p1.categoryID=p.categoryID
)
ORDER BY 
p.categoryID,
p.unitPrice;



/*
----------------------------------------------------
9. What are the top 3 products in each category?
----------------------------------------------------
*/
SELECT *FROM
(
 SELECT 
  p.productID,
  p.productName,
  p.categoryID,
  c.categoryName,
  ROUND(SUM(od.unitPrice*od.quantity*(1-od.discount)),2) AS Revenue,
  ROW_NUMBER() 
  OVER(PARTITION BY p.categoryID 
		ORDER BY SUM(od.unitPrice*od.quantity*(1-od.discount)) DESC) AS category_Rank
        FROM products p
	JOIN categories c 
    ON p.categoryID=c.categoryID
    JOIN order_Details od
    ON p.productID=od.productID
    
    GROUP BY p.productID,p.productName,p.categoryID,c.categoryName
    ) AS ranked_products
    WHERE category_Rank<=3
    ORDER BY categoryID,category_Rank;



/*
----------------------------------------------------
10. Which customers have never placed an order?
----------------------------------------------------
*/
SELECT 
c.customerID,
c.companyName AS customerName
FROM customers c 
LEFT JOIN orders o
ON c.customerID=o.customerID 
WHERE o.orderID IS NULL;



/*
----------------------------------------------------
11. Which customers generate above-average revenue?
----------------------------------------------------
*/
SELECT 
c.customerID,
c.companyName AS customerName,
ROUND(SUM(od.unitPrice*od.quantity*(1-od.discount)),2) AS Revenue
FROM customers c 
JOIN orders o
ON c.customerID=o.customerID
JOIN order_details od
ON o.orderID=od.orderID
GROUP BY c.customerID,c.companyName
HAVING
SUM(od.unitPrice*od.quantity*(1-od.discount))>
(
 SELECT AVG(customer_revenue)
 FROM
 (
  SELECT o2.customerID,
  SUM(od.unitPrice*od.quantity*(1-od.discount)) AS customer_revenue
  FROM orders o2
  JOIN order_details od2
  ON o2.orderID=od2.orderID
  GROUP BY o2.customerID 
 ) average_customer_revenue
)ORDER BY Revenue DESC;

/*
----------------------------------------------------
12. What is the year-over-year revenue growth?
----------------------------------------------------
*/
SELECT 
order_year,
Revenue,
Previous_Year_Revenue,
ROUND((Revenue-Previous_Year_Revenue)/Previous_Year_Revenue*100,2) AS Year_Over_Year_Growth_Percentage
FROM
(
 SELECT 
 YEAR(o.orderDate) AS order_year,
 ROUND(SUM(od.unitPrice*od.quantity*(1-od.discount)),2) AS Revenue,
 LAG(SUM(od.unitPrice*od.quantity*(1-od.discount)))
 OVER(
 ORDER BY YEAR(o.orderDate) 
 )AS Previous_year_revenue
 FROM orders o
 JOIN order_details od 
 ON o.orderID=od.orderID
 GROUP BY YEAR(o.orderDate)
) yearly_revenue
WHERE Previous_Year_Revenue IS NOT NULL
ORDER BY order_year;






/*
----------------------------------------------------
13. Which shipper has the best average delivery time?
----------------------------------------------------
*/
SELECT
s.shipperID,
s.companyName AS shipper,
ROUND(AVG( DATEDIFF( o.shippedDate, o.orderDate)),2) AS average_delivery_days
FROM shippers s
JOIN orders o
 ON s.shipperID = o.shipVia
WHERE o.shippedDate IS NOT NULL
GROUP BY
s.shipperID, s.companyName
ORDER BY
average_delivery_days ASC
LIMIT 1;



/*
----------------------------------------------------
14. Which products have never been ordered?
----------------------------------------------------
*/
SELECT
p.productID, p.productName
FROM products p
LEFT JOIN order_details od ON 
p.productID = od.productID
WHERE od.productID IS NULL;
/*
----------------------------------------------------
15. Which customers place the most orders?
----------------------------------------------------
*/
SELECT
c.customerID, c.companyName AS customerName,
COUNT(o.orderID) AS order_count
FROM customers c
JOIN orders o 
ON c.customerID = o.customerID
GROUP BY c.customerID,c.companyName
ORDER BY order_count DESC
LIMIT 10;

/*
----------------------------------------------------
16. What is the average order value?
----------------------------------------------------
*/
SELECT
ROUND( AVG(order_revenue), 2) AS average_order_value
FROM (
SELECT
o.orderID,
SUM(
od.unitPrice * od.quantity * (1 - od.discount)) AS order_revenue
FROM orders o
JOIN order_details od ON o.orderID = od.orderID
GROUP BY o.orderID
) AS order_sales;
