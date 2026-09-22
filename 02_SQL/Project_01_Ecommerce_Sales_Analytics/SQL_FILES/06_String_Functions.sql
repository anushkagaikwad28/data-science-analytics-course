/*
====================================================
06 - STRING FUNCTIONS
====================================================

CONCAT
UPPER
LOWER
LENGTH
TRIM
SUBSTRING
LEFT
RIGHT
REPLACE
LOCATE
====================================================
*/

-- 1. CONCAT
SELECT
 CONCAT(firstName," ",lastName) AS Employee_Name
 FROM employees;

-- 2. UPPER
SELECT
 UPPER(CONCAT(firstName," ",lastName)) AS Employee_Name
 FROM employees;

-- 3. LOWER
SELECT
 LOWER(CONCAT(firstName," ",lastName)) AS Employee_Name
 FROM employees;
 
-- 4. LENGTH
SELECT
 LENGTH(CONCAT(firstName," ",lastName)) AS Employee_Name
 FROM employees;
 
-- 5. TRIM
SELECT 
  companyName,
  TRIM(companyName) as Cleaned_Name
FROM customers;

-- 6. LEFT
SELECT
 country,
 LEFT(country,4) AS First_4_Characters
 FROM customers;

-- 7. RIGHT
SELECT
 country,
 RIGHT(country,4) AS LAST_4_Characters
 FROM customers;

-- 8. SUBSTRING
SELECT
companyName,
SUBSTRING(companyName,1,5) AS Extracted_Substring
FROM customers;

-- 9. REPLACE
SELECT 
 companyName,
 REPLACE(companyName,' ','-') AS Modified_Name
 FROM customers;

-- 10. LOCATE
SELECT 
 companyName,
 LOCATE('a',companyName) AS Pos_Of_A
 FROM customers;

-- 11. Create employee full name
SELECT
 employeeID,
 CONCAT(firstName,' ',lastName) AS Full_Name
 FROM employees;