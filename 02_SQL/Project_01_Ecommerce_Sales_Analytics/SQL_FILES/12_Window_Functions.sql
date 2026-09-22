USE ecommerce_analytics;
/*
====================================================
13 - WINDOW FUNCTIONS
====================================================
====================================================
*/


/*
====================================================
1. ROW_NUMBER()
====================================================

Assigns a unique sequential number to every row.

ORDER BY decides the numbering sequence.
====================================================
*/

SELECT 
 productID,
 productName,
 unitPrice,
 ROW_NUMBER() OVER(
  ORDER BY unitPrice DESC 
 ) AS row_num
FROM products;
/*
====================================================
2. RANK()
====================================================
====================================================
*/

SELECT 
 productID,
 productName,
 unitPrice,
 RANK() OVER(
 ORDER BY unitPrice DESC )AS price_rank
 FROM products;


/*
====================================================
3. DENSE_RANK()
====================================================

Same rank for tied values,
but ranking numbers are NOT skipped.
====================================================
*/

SELECT 
productID,
productName,
unitPrice,
DENSE_RANK() OVER(
 ORDER BY unitPrice DESC
) AS price_rank
FROM products;


/*
====================================================
4. NTILE()
====================================================
====================================================
*/

SELECT
    productID,
    productName,
    unitPrice,
    NTILE(4) OVER (
        ORDER BY unitPrice
    ) AS price_quartile
FROM products;


/*
====================================================
5. PARTITION BY
====================================================
Rank products separately within each category.
====================================================
*/
SELECT
    productID,
    productName,
    categoryID,
    unitPrice,
    RANK() OVER (
        PARTITION BY categoryID
        ORDER BY unitPrice DESC
    ) AS category_rank
FROM products;


/*
====================================================
6. SUM() OVER()
====================================================
Calculates a running total.
====================================================
*/
SELECT   
o.orderDate,
od.orderID,
od.unitPrice*od.quantity*(1-od.discount) AS Revenue,
SUM(od.unitPrice*od.quantity*(1-od.discount))
OVER(
ORDER BY o.orderDate,od.orderID
)AS running_revenue
FROM orders o
JOIN order_details od
ON o.orderID=od.orderID;


/*
====================================================
7. AVG() OVER()
====================================================

Calculates the average across all rows
while keeping every individual row.
====================================================
*/
SELECT 
 o.orderDate,
 od.orderID,
 od.unitPrice*od.quantity*(1-od.discount) AS REVENUE,
 AVG(od.unitPrice)
 OVER 
() AS overall_average
FROM orders o
JOIN order_details od
ON o.orderID=od.orderID;

/*
====================================================
8. LAG()
====================================================
====================================================
*/
SELECT 
 YEAR(o.orderDate) AS order_year,
 SUM(od.unitPrice*od.quantity*(1-discount)) AS Revenue,
 LAG(
  SUM(od.unitPrice*od.quantity*(1-discount))
  )OVER(ORDER BY YEAR(o.orderDate)
 ) AS previous_year_revenue
 FROM orders o
 JOIN order_details od
  ON o.orderID=od.orderID 
  GROUP BY YEAR(o.orderDate);

/*
====================================================
9. LEAD()
====================================================
====================================================
*/
SELECT 
 YEAR(o.orderDate) AS order_year,
 SUM(od.unitPrice*od.quantity*(1-discount)) AS Revenue,
 LEAD(
  SUM(od.unitPrice*od.quantity*(1-discount))
  )OVER(ORDER BY YEAR(o.orderDate)
 ) AS NEXT_year_revenue
 FROM orders o
 JOIN order_details od
  ON o.orderID=od.orderID 
  GROUP BY YEAR(o.orderDate);

/*
====================================================
11. FIRST_VALUE()
====================================================
Find the highest-revenue customer.
====================================================
*/
SELECT 
 c.customerID,
 c.companyName AS customerName,
 SUM(od.unitPrice*od.quantity*(1-discount)) AS REVENUE ,
 FIRST_VALUE(c.companyName)OVER(
 PARTITION BY c.customerID
 ORDER BY SUM(od.unitPrice*od.quantity*(1-discount)) DESC
 ) AS highest_revenue_customer
 FROM customers c
 JOIN orders o
 ON c.customerID=o.customerID
 JOIN order_details od
 ON  o.orderID=od.orderID
 GROUP BY 
  c.customerID,c.companyName;


/*
====================================================
12. LAST_VALUE()
====================================================
Returns the last value in the window.
Find the lowest-priced product.
====================================================
*/

SELECT 
 productID,
 productName,
 unitPrice,
 LAST_VALUE(productName)OVER
 (
  ORDER BY unitPrice 
  ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING 
) AS highest_Price_Product
FROM products;


/*
====================================================
13. COUNT() OVER()
====================================================
PARTITION BY customerID means:

Count orders separately for each customer.
====================================================
*/
SELECT 
 customerID,
 orderID,
 COUNT(*) OVER
 ( PARTITION BY customerID) AS customer_order_count
 FROM orders;


/*
====================================================
14. SUM() OVER(PARTITION BY)
====================================================
Total revenue generated by each employee.
====================================================
*/
SELECT
o.employeeID,
o.orderID,
od.unitPrice*od.quantity*(1-od.discount) AS Revenue,
SUM(od.unitPrice*od.quantity*(1-od.discount)) OVER 
(PARTITION BY o.employeeID)AS employee_Revenue
FROM orders o
JOIN order_details od
ON o.orderID=od.orderID;


/*
====================================================
15. AVG() OVER(PARTITION BY)
====================================================
Average product price within each category.
====================================================
*/

SELECT
 productID,
 productName,
 categoryID,
 unitPrice,
 AVG(unitPrice)OVER
 ( PARTITION BY categoryID) AS category_average
 FROM products;


/*
====================================================
16. MIN() OVER()
====================================================
====================================================
*/

SELECT
 productID,
 productName,
 unitPrice,
 MIN(unitPrice)OVER() AS min_price
 FROM products;


/*
====================================================
17. MAX() OVER()
====================================================

Finds the maximum value while keeping
every individual row.
====================================================
*/
SELECT 
 productID,
 productName,
 unitPrice,
 MAX(unitPrice) OVER() AS max_price
 FROM products;


/*
====================================================
18. MIN/MAX WITH PARTITION
====================================================

Find minimum and maximum price
inside every category.
====================================================
*/
SELECT 
productID,
productName,
categoryID,
unitPrice,
MIN(unitPrice)OVER
(PARTITION BY categoryID) AS min_category_price,
MAX(unitPrice)over
(PARTITION BY categoryID) AS max_category_price
FROM products;


/*
====================================================
19. ROW_NUMBER() WITH PARTITION
====================================================

Assigns a unique number to products
inside each category.

====================================================
*/

SELECT 
 productID,
 productName,
 categoryID,
 unitPrice,
 ROW_NUMBER()OVER 
 ( PARTITION BY categoryID 
 ORDER BY unitPrice DESC) AS product_number
 FROM products;


/*
====================================================
20. TOP 3 PRODUCTS IN EACH CATEGORY
====================================================
====================================================
*/

SELECT 
 productID,
 productName,
 unitPrice,
 productRank
 FROM(
  SELECT 
   productID,
   productName,
   unitPrice,
   DENSE_RANK() OVER
   ( PARTITION BY categoryID
    ORDER BY unitPrice DESC) AS productRank
 
    FROM products
     )AS ranked_products
    WHERE productRank <=3;
   

SELECT 
 c.customerID,
 c.companyName AS customerName,
 SUM(od.unitPrice*od.quantity*(1-discount)) AS REVENUE ,
 FIRST_VALUE(c.companyName)OVER(
 PARTITION BY c.customerID
 ORDER BY SUM(od.unitPrice*od.quantity*(1-discount)) DESC
 ) AS highest_revenue_customer
 FROM customers c
 JOIN orders o
 ON c.customerID=o.customerID
 JOIN order_details od
 ON  o.orderID=od.orderID
 GROUP BY 
  c.customerID,c.companyName;
