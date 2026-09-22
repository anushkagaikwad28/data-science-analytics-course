use ecommerce_analytics;
/*
====================================================
16 - VIEWS
====================================================
*/

-- 1. Product revenue view

CREATE VIEW product_revenue AS
SELECT 
 p.productID,
 p.productName,
 SUM(od.unitPrice*od.quantity*(1-discount)) AS Product_Revenue
 FROM products p
 JOIN order_details od
 ON p.productID=od.productID
  GROUP BY 
  p.productID ,
  p.productName ;
  

-- 2. Use the view
SELECT *FROM product_revenue
ORDER BY Product_Revenue DESC;


-- 3. Top products
SELECT *FROM product_revenue
ORDER BY Product_Revenue DESC
LIMIT 10;


-- 4. Category performance view

CREATE VIEW category_revenue AS 
SELECT 
c.categoryID,
c.categoryName,
SUM(od.unitPrice*od.quantity*(1-discount)) AS Revenue 
FROM categories c
JOIN products p
ON c.categoryID=p.categoryID 
JOIN order_details od 
ON p.productID=od.productID
GROUP BY 
c.categoryID,c.categoryName;



-- 5. Query view
SELECT *
FROM category_revenue
ORDER BY revenue DESC;