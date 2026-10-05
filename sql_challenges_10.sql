/******************************************************************************
*******************************************************************************

SQL CHALLENGES 10

*******************************************************************************
******************************************************************************/


USE publications;


-- 1. What's the difference between highest and lowest price of titles
  
  SELECT MAX(price) - MIN(price) AS Diff_Price
FROM titles;
  
-- 2. Find titles where the total number of books sold is an even number.
SELECT t.title, SUM(s.qty) as total_books
FROM Titles t
LEFT JOIN sales s USING(title_id)
GROUP BY t.title_id, t.title
HAVING total_books % 2 =0
ORDER BY total_books DESC;

SELECT *
FROM titles
WHERE ytd_sales % 2 = 0;

-- 3. Calculate the total revenue by multiplying the quantity sold by the price for each title.

SELECT 
    t.title_id,
    ROUND(t.price, 2),
    ROUND(t.price * SUM(s.qty), 2) AS total_revenue
FROM
    titles AS t
        LEFT JOIN
    sales AS s USING (title_id)
GROUP BY t.title_id , t.price
ORDER BY total_revenue DESC;

-- 4. Cheryl Carson and Charlene Locksley got married, what is their collective revenue?




    
-- 5. Calculate the total number of books published by the publishers '0736' and '0877':
SELECT 
(SELECT COUNT(*) FROM titles WHERE pub_id = "0736")
	+
(SELECT COUNT(*) FROM titles WHERE pub_id = "0877")
AS total_books_published;

SELECT COUNT(*) AS total_books
FROM titles
WHERE pub_id IN ('0736', '0877');




SELECT pub_id, COUNT(*) AS total_books
FROM titles
WHERE pub_id IN ('0736' , '0877')
GROUP BY pub_id;
-- 6. Find all of the books that are more than 10% above the average price of a book in the dataset

SELECT 
    *
FROM
    titles
WHERE
    price > (SELECT 
            AVG(price)
        FROM
            titles) * 1.10;
            
            

SELECT 
    title,
    ROUND(price, 2),
    (SELECT 
            ROUND(AVG(price), 2)
        FROM
            titles) AS avg_price
FROM
    titles
WHERE
    price > (SELECT 
            AVG(price) * 1.10
        FROM
            titles);




















