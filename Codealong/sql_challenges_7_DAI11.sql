/*

*******************************************************************************
*******************************************************************************

SQL CHALLENGES 7

*******************************************************************************
*******************************************************************************


In the exercises below you will need to use the clauses you used in the
previous SQL Challenges, plus the following clauses:
    - CASE
*/

/*******************************************************************************
CASE

https://www.w3schools.com/sql/sql_case.asp
*******************************************************************************/

/* 1. Select everything from the sales table and create a new column called 
   "sales_category" with case conditions to categorise qty:
   
		1. qty >= 50 high sales
		2. 20 <= qty < 50 medium sales
		3. qty < 20 low sales
*/

SELECT 
	*,
    CASE
	   WHEN qty >= 50 THEN "high sales"
	   WHEN qty >= 20 THEN "medium sales"
	   ELSE "low sales"
    END AS sales_category 
FROM sales;

SELECT
	*,
    CASE
			-- 1. qty >= 50 high sales
        WHEN qty >= 50 THEN "high sales"
			-- 2. 20 <= qty < 50 medium sales
		WHEN (qty >= 20 AND qty < 50) THEN "medium sales"
			-- 3. qty < 20 low sales
        WHEN qty < 20 THEN "low sales"
    END AS sales_category
FROM
	sales
ORDER BY qty DESC;


/* 2. Given your three sales categories (high, medium, and low), 
   calculate the total number of books sold in each category. 
*/

SELECT
	SUM(qty) AS total_book_sales,
    CASE
			-- 1. qty >= 50 high sales
        WHEN qty >= 50 THEN "high sales"
			-- 2. 20 <= qty < 50 medium sales
		WHEN (qty >= 20 AND qty < 50) THEN "medium sales"
			-- 3. qty < 20 low sales
        WHEN qty < 20 THEN "low sales"
    END AS sales_category,
    COUNT(ord_num) AS num_of_orders
FROM
	sales
GROUP BY 
	sales_category
    ;

-- alternative


SELECT
	SUM(qty) AS 'books_sold', # hier wird die Summe von qty gemacht
	CASE
		WHEN qty >= 50 THEN 'high' # hier werden alle werte größer und gleich 50 definiert.
		WHEN qty >= 20 THEN 'medium' # hier werden alle werte größer und gleich 20 definiert.
		ELSE 'low' # hier wird alle werte kleiner als 20  definiert.
    END AS 'sales_category' # Ende der case mit der Spalte-Name sales_categorie 
FROM sales
GROUP BY sales_category; 	#hier wird sales categorie gruppiert. Damit alle Werte, die größer gleich 50 sind, addiert werden (category = high),
							#genauso für 20 sales (categorry = medium) und für kleiner als 20 sales (categorry = low)

/* 3. Adding to your answer from the previous questions: output only those 
   sales categories that have a SUM(qty) greater than 100, and order them in 
   descending order */

SELECT
	SUM(qty) AS total_book_sales,
    CASE
        WHEN qty >= 50 THEN "high sales"
		WHEN (qty >= 20 AND qty < 50) THEN "medium sales"
        WHEN qty < 20 THEN "low sales"
    END AS sales_category
FROM
	sales
GROUP BY 
	sales_category
HAVING total_book_sales > 100
ORDER BY total_book_sales DESC;

/* 4. Find out the average book price, per publisher, for the following book 
    types and price categories:
		book types: business, traditional cook and psychology
		price categories: <= 5 super low, <= 10 low, <= 15 medium, > 15 high
        
    - When displaying the average prices, use ROUND() to hide decimals. */


SELECT
    pub_name, 
    pub_id,
    type,
    CASE
		--  <= 5 super low
        WHEN price <= 5 THEN "super low"
        --  <= 10 low
        WHEN price <= 10 THEN "low"
        --  <= 15 medium
        WHEN price <= 15 THEN "medium"
        --  > 15 high
        WHEN price > 15 THEN "high"
    END AS price_category,
    ROUND(AVG(price), 2)
FROM
	titles
		JOIN
	publishers USING (pub_id)
WHERE 
    type IN ("business", "trad_cook", "psychology")
GROUP BY	
	pub_id, type,  price_category
ORDER BY pub_id, type, price_category
;


-- alternative für eine andere Interpretation der Aufgabenstellung

SELECT DISTINCT
    pub_id, 
    type,
    ROUND(AVG(price), 2) AS avarages_price,
    CASE
		WHEN AVG(price) <= 5 THEN 'super low'
		WHEN AVG(price) <= 10 THEN 'low'
        WHEN AVG(price) <= 15 THEN 'medium'
        WHEN AVG(price) > 15 THEN 'high'
	END AS price_category
FROM
    titles
WHERE
    type IN ('business' , 'trad_cook', 'psychology')
GROUP BY pub_id , type
ORDER BY pub_id , type;

