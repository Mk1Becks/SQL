/*

*******************************************************************************
*******************************************************************************

SQL CHALLENGES 8

*******************************************************************************
*******************************************************************************


In the exercises below you will need to use the clauses you used in the
previous SQL Challenges, plus the following clauses:
    - Subqueries

*/

USE publications;

/*******************************************************************************
Subqueries

https://dev.mysql.com/doc/refman/8.4/en/subqueries.html
*******************************************************************************/


-- 1. Find the name of the publisher with the highest advance.

SELECT
	p.pub_name
FROM
	publishers p
WHERE
	p.pub_id = (SELECT
					pub_id
				FROM
					titles
				ORDER BY advance DESC
				LIMIT 1)
;

# maximale advance finden
SELECT
	title, advance, pub_id
FROM
	titles
ORDER BY advance DESC
LIMIT 1
;

SELECT
	pub_id
FROM
	titles
ORDER BY advance DESC
LIMIT 1;

-- 2. List the titles of books published by publishers based in 'Boston'.

SELECT t.title
FROM 
	titles t
WHERE t.pub_id IN 
				(SELECT p.pub_id
				FROM publishers p
				WHERE p.city = 'Boston');
                
                
SELECT pub_id
FROM publishers  
WHERE city = 'Boston';

-- lösung mit einem Join statt subquery

SELECT 
    p.city AS stadt, p.pub_name AS Name, t.title AS Titel
FROM
    publishers AS p
        LEFT JOIN
    titles AS t ON p.pub_id = t.pub_id
WHERE
    p.city = 'Boston';

-- 3. Find the authors who have written more than one book.

SELECT 
    a.au_fname, 
    a.au_lname, 
    a.au_id, 
    -- optional die Anzahl Bücher anzeigen
    (SELECT 
		COUNT(t1.title_id)
	FROM
		titleauthor AS t1
	WHERE t1.au_id = a.au_id
	) AS anz_buecher
FROM
    authors AS a
WHERE
    a.au_id IN (SELECT 
					t2.au_id
				FROM
					titleauthor AS t2
				GROUP BY t2.au_id
				HAVING COUNT(t2.title_id) > 1);
                
SELECT 
	t.au_id
FROM
	titleauthor AS t
GROUP BY t.au_id
HAVING COUNT(t.title_id) > 1;

                
SELECT 
	COUNT(t.title_id)
FROM
	titleauthor AS t
WHERE t.au_id = "213-46-8915";





-- 4. List all authors and the number of books they have written.

SELECT 
	a.au_fname, 
	a.au_lname,
	(SELECT 
		COUNT(t.title_id) 
    FROM 
		titleauthor AS t 
    WHERE 
		a.au_id = t.au_id
	) AS total_books
FROM 
	authors AS a
ORDER BY 
	total_books DESC;


-- 5. Find the titles with a price higher than the average price.

SELECT 
	title AS titel,
    price AS preis,
    (SELECT 
		 ROUND(AVG(price),2) 
     FROM 
		 titles
	) AS durchschnitt
FROM 
	titles
WHERE 
	price > (SELECT AVG(price) FROM titles)
ORDER BY price DESC;

SELECT AVG(price) 
FROM titles;


SELECT 
	title AS titel,
    price AS preis
FROM 
	titles;
    
    
    
    
-- 6. Find the name of the publisher who has published the most books.

SELECT
	p.pub_name
FROM
	publishers p
WHERE
	# filtern anhand der pub_id
	p.pub_id = (SELECT
					t.pub_id
				FROM
					titles t
				GROUP BY t.pub_id
				ORDER BY COUNT(t.title_id) DESC
				LIMIT 1)
;

SELECT
	pub_id, COUNT(title_id)
FROM
	titles t
GROUP BY
	pub_id
ORDER BY
	COUNT(title_id) DESC
LIMIT 1;

-- 7. List the titles that have never been sold.

SELECT
	title
FROM 
	titles
WHERE 
	title_id NOT IN (
					SELECT DISTINCT 
						title_id
					FROM sales
					)
;

SELECT DISTINCT
	title_id
FROM sales;

-- alternative Lösung mit JOINs

SELECT
	t.title
FROM
	titles t
		LEFT JOIN
	sales s USING(title_id)
WHERE
	s.ord_num IS NULL
;

-- 8. List all titles along with their publisher's name.

SELECT
	t.title,
    t.pub_id,
    (
	SELECT
		p.pub_name
	FROM
		publishers p
	WHERE p.pub_id = t.pub_id
	) AS publisher_name
FROM
	titles t
ORDER BY t.title
;

SELECT
		p.pub_name
	FROM
		publishers p
	WHERE p.pub_id = '1389';

-- 9. List the employees who have the same job as 'Helen Bennett'.

SELECT 
	fname, 
    lname
FROM 
	employee
WHERE 
	job_id = (
			SELECT 
				job_id 
			FROM employee 
			WHERE 
				fname="HELEN" 
					AND 
				lname= "Bennett"
            );


SELECT 
	job_id 
FROM employee 
WHERE 
	fname="HELEN" 
		AND 
	lname= "Bennett"
;







