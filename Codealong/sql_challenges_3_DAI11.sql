/*
*******************************************************************************
*******************************************************************************

SQL CHALLENGES 3

*******************************************************************************
*******************************************************************************

In the exercises below you will need to use the following clauses/operators:
	- ORDER BY
	- LIMIT
    - MIN(), MAX()
    - COUNT(), AVG(), SUM()

In SQL we can have many databases, they will show up in the schemas list
We must first define which database we will be working with.
*/

USE publications;

/******************************************************************************
ORDER BY
******************************************************************************/
-- https://www.w3schools.com/sql/sql_orderby.asp

/* 1. Select the title and ytd_sales from the table titles. Order them by the
year to date sales. */

SELECT 
    title, ytd_sales
FROM
    titles
WHERE
	ytd_sales >= 0
ORDER BY ytd_sales ASC;

-- Musterlösung
SELECT 
	title, ytd_sales 
FROM 
	titles 
ORDER BY 
	ytd_sales;

-- 2. Repeat the same query, but this time sort the titles in descending order

SELECT
	title, ytd_sales
FROM 
	titles
ORDER BY 
	ytd_sales DESC
;

/******************************************************************************
LIMIT

https://www.w3schools.com/mysql/mysql_limit.asp
******************************************************************************/

-- 3. Select the top 5 titles with the most ytd_sales from the table titles

SELECT 
    title, ytd_sales
FROM
    titles
ORDER BY ytd_sales DESC
LIMIT 5;

/******************************************************************************
MIN and MAX

https://www.w3schools.com/sql/sql_min_max.asp
******************************************************************************/

-- 4. What's the maximum amount of books ever sold in a single order?

SELECT 
	qty AS books_per_order
FROM 
	sales
ORDER BY
	qty DESC
LIMIT
	1
;
-- Alternative

SELECT 
	MAX(qty) AS maximum_books_sold
FROM
	sales
;
-- 5. What's the price of the cheapest book?

SELECT 
	MIN(price)
FROM 
	titles;

/******************************************************************************
COUNT, AVG, and SUM

https://www.w3schools.com/sql/sql_count_avg_sum.asp

******************************************************************************/

 -- 6. How many rows are there in the table authors?

SELECT 
	COUNT(au_lname)
FROM 
	authors;
    
SELECT
	COUNT(*)
FROM
	authors;

 -- 7. What's the total amount of year-to-date sales?

# Mit "SUM(ytd_sales)"addiert man Alle Werte der ytd_sales_column
SELECT
	SUM(ytd_sales)
-- ytd_sales befindet sich in titles-Tabelle
FROM 
	titles;

 -- 8. What's the average price of books?

SELECT 
	AVG(price) AS average_price
FROM 
	titles;

/* 9. In a single query, select the count, average and sum of quantity in the
table sales */

SELECT 
    COUNT(*), AVG(qty), SUM(qty)
FROM
    sales;

/*
In the exercises below you will need to use the following clauses/operators:
	- SELECT FROM
    - AS
	- DISTINCT
	- WHERE
	- AND / OR / NOT
	- ORDER BY
	- LIMIT
    - MIN(), MAX()
    - COUNT(), AVG(), SUM()

*/

-- 10. From how many different states are our authors?

SELECT 
	COUNT(DISTINCT State)
FROM 
	authors;
    
-- extras
SELECT 
	COUNT(DISTINCT State)
FROM 
	authors;
    
-- andere Lösung

SELECT 
    COUNT(*) AS zeilen_autoren,
    COUNT(state) AS autoren_mit_state,
    COUNT(DISTINCT state) AS verschiedene_states
FROM
    authors;

-- 11. How many publishers are based in the USA?

SELECT 
    COUNT(pub_name)
FROM
    publishers
WHERE
    country = 'USA';

-- 12. What's the average quantity of titles sold per sale by store 7131?

SELECT 
	AVG(qty) AS average_order_size
FROM 
	sales
WHERE 
	stor_id = "7131";

-- 13. When was the employee with the highest level hired?

SELECT 
	emp_id, fname, lname, hire_date, job_lvl
FROM 
	employee
ORDER BY job_lvl DESC 
LIMIT 1;

-- 14. What's the average price of psychology books?

SELECT
	# Man möchte den Mittelwert der Preise, also...
	AVG(price)
FROM 
	# price befindet sich in titles, also...
	titles
# Nur die Bücher von Psychologie werden betrachtet, in dem type gleich "psychology" setzt
WHERE 
	type = "psychology";


-- 15. Which category of books has had more year-to-date sales, "business" or
-- "popular_comp"? You can write two queries to answer this question.

-- Ich musste hier einmal eine Query machen um zu sehen welche types existieren. Gibt es eine einfachere Lösung? 
SELECT 
	DISTINCT type
FROM 
	titles
ORDER BY type;

-- business -> '30788'
SELECT 
	SUM(ytd_sales)
FROM 
	titles
WHERE 
	type = "business";

-- popular_comp -> '12875'
SELECT 
	SUM(ytd_sales)
FROM 
	titles
WHERE 
	type = "popular_comp";

-- 16. What's the title and the price of the most expensive book?

SELECT
	title AS teuerstes_buch, price
FROM
	titles
ORDER BY price DESC
LIMIT 1
;


-- 17. What's the price of the most expensive psychology book?

SELECT 
    MAX(price)
FROM
    titles
WHERE
    type = 'psychology';

-- alternative lösung

SELECT
	title AS teuerstes_psych_buch, price
FROM
	titles
WHERE
	type = "psychology"
ORDER BY price DESC
LIMIT 1
;

-- 18. How many authors live in either San Jose or Salt Lake City

SELECT 
	-- au_id, city
	COUNT(au_id)
FROM 
	authors
WHERE 
	city = 'San Jose' OR city = 'Salt Lake City';






