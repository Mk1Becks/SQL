/*

*******************************************************************************
*******************************************************************************

SQL CHALLENGES 5

*******************************************************************************
*******************************************************************************

In the exercises below you will need to use the following clauses:
    - GROUP BY
    - HAVING
------------------------------------------------------------------------------------------------

*/

USE publications;

/*******************************************************************************
GROUP BY

https://www.w3schools.com/sql/sql_groupby.asp
*******************************************************************************/

-- 1. Find the total amount of authors for each state

SELECT 
	state, COUNT(*)
FROM 
	authors
GROUP BY 
	state;

/* 2. Find the total amount of authors by each state and order them in 
    descending order */

SELECT
	state, COUNT(*) AS anz_autoren
FROM
	authors
GROUP BY
	state 
ORDER BY
	# anz_autoren ASC, state DESC
	anz_autoren DESC, state
;

-- 3. What's the price of the most expensive title from each publisher?

SELECT
	title, price, pub_id
FROM
	titles
;

SELECT
	pub_id, MAX(price) AS max_price
FROM
	titles
GROUP BY
	pub_id
;

-- 4. Find out the top 3 stores with the most sales

SELECT
	stor_id AS filiale, # die Stores ausgeben
	SUM(qty) AS qty_pro_filiale # hier addiert man die qty (quantity)
FROM 
	sales
GROUP BY 
	# stor_id
	filiale	#...oder "stor_id", hier gruppiet man die Filiale   
ORDER BY 
	qty_pro_filiale DESC	# ...oder "SUM(qty) DESC", hier ordne absteigend die most_qty
LIMIT 3; # ...und wird auf 3 begrenzt

-- alterniv eine andere Frage: Find out the top 3 stores with the highest per order qty

SELECT 
    stor_id, MAX(qty) AS Verkaeufe
FROM
    sales
GROUP BY stor_id
ORDER BY Verkaeufe DESC
LIMIT 3;

/* 5. Find the average job level for each job_id from the employees table.
    Order the jobs in ascending order by its average job level. */

SELECT 
    job_id, ROUND(AVG(job_lvl), 2) AS av_lvl
FROM
    employee
GROUP BY job_id
ORDER BY av_lvl;

/* 6. For each type (business, psychology…), find out how many books each
    publisher has. */

SELECT
	pub_id, type, COUNT(*), COUNT(title)
FROM
	titles
GROUP BY
	pub_id, type
-- optional sortieren
ORDER BY
	pub_id, type
;

/* 7. Add the average price of each publisher - book-type combination from your
   previous query */
   
SELECT
	pub_id, type, COUNT(title) AS anz_buecher, ROUND(AVG(price), 2) AS avg_price
FROM
	titles
GROUP BY
	pub_id, type
-- optional sortieren
ORDER BY
	pub_id, type
;

/*******************************************************************************
HAVING

https://www.w3schools.com/sql/sql_having.asp
*******************************************************************************/

/* 8. From your previous query, keep only the combinations of publisher - book
   type with an average price higher than 12 */

SELECT
	pub_id, type, COUNT(title) AS anz_buecher, ROUND(AVG(price), 2) AS avg_price
FROM
	titles
GROUP BY
	pub_id, type
HAVING
	avg_price > 12
-- optional sortieren
ORDER BY
	pub_id, type
;
-- 

SELECT 
	type, pub_id, COUNT(title), AVG(price) AS AVGP
FROM 
	titles
GROUP BY 
	type, pub_id
having
	avgp > 12
ORDER BY 
	AVGP DESC;


/* 9. Order the results of your previous query by these two criteria:
      1. Count of books, descendingly
      2. Average price, descendingly */


SELECT
	pub_id, type, COUNT(title) AS anz_buecher, ROUND(AVG(price), 2) AS avg_price
FROM
	titles
GROUP BY
	pub_id, type
HAVING
	avg_price > 12
ORDER BY
	anz_buecher DESC, avg_price DESC
;

-- alternative Lösung

SELECT 
    pub_id,
    type,
    AVG(price) AS DurchschnittPreis,
    COUNT(*) AS Stueckzahl
FROM
    titles
GROUP BY 
	pub_id , type
HAVING 
	AVG(Price) > 12
ORDER BY 
	Stueckzahl DESC , DurchschnittPreis DESC;

/* 10. Some authors have a contract, while others don't - it's indicated in the
     "contract" column of the authors table.
     
     Select all the states and cities where there are 2 or more contracts 
     overall */

SELECT
	state, city, SUM(contract) AS anz_vertraege_pro_state_city
FROM
	authors
GROUP BY
	state, city
HAVING
	anz_vertraege_pro_state_city >= 2
;

/* 
The main difference between WHERE and HAVING is that:
    - the WHERE clause is used to specify a condition for filtering most records (Einträge/Zeilen)
    - the HAVING clause is used to specify a condition for filtering values from 
      an aggregate (such as MAX(), AVG(), COUNT() etc...)
 */

