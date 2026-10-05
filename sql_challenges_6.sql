/*

*******************************************************************************
*******************************************************************************

SQL CHALLENGES 6

*******************************************************************************
*******************************************************************************

HOW TO GET THE SCHEMA OF A DATABASE: 
* Windows/Linux: Ctrl + R
* MacOS: Cmd + R

In the exercises below you will need to use the clauses you used in the
previous SQL Challenges, plus the following clauses:
    - AS
	- LEFT JOIN
    - RIGHT JOIN
    - INNER JOIN
*/

USE publications; 
 
/*******************************************************************************
ALIAS (AS) for tables
*******************************************************************************/

/* 1. Select the table sales, assigning the alias "s" to it. 
   Select the column ord_num using the syntax "table_alias.column" */

SELECT s.ord_num
FROM sales AS s;

/*******************************************************************************
JOINS

We will only use LEFT, RIGHT, and INNER joins.
You do not need to worry about the other types for now

- https://www.w3schools.com/sql/sql_join.asp
- https://www.w3schools.com/sql/sql_join_left.asp
- https://www.w3schools.com/sql/sql_join_right.asp
- https://www.w3schools.com/sql/sql_join_inner.asp
*******************************************************************************/

-- 2. Select the title and publisher name of all books

SELECT 
    b.title, p.pub_name
FROM
    titles AS b
        LEFT JOIN
    publishers AS p ON b.pub_id = p.pub_id;
    
-- 4. Select the order number, quantity and book title for all sales.

SELECT 
    b.title, qty, o.ord_num
FROM
    sales AS o
        LEFT JOIN
    titles AS b ON b.title = b.title;
    
 SELECT 
    s.ord_num, s.qty, t.title
FROM
    sales AS s
        LEFT JOIN titles AS t
   -----------------------   ON s.title_id = t.title_id
   USING(title_ID)
ORDER BY qty DESC;
    
    
    

/* 5. Select the full name of all employees (LEFT JOIN aufgrund ALLE) and the name of the publisher they 
   work for */

SELECT 
    e.fname, e.lname, p.pub_name
FROM
    employee AS e
		LEFT JOIN
    publishers AS p
ON e.pub_id = p.pub_id;


12:36:29	"SELECT e.fname, e.lname, p.pub_name FROM employee AS e INNER JOIN publisher AS p     ON e.pub_id = p.pub_id LIMIT 0, 1000	
Error Code: 1146. Table 'music_beginner.employee' doesn't exist	0.000 sec"


--------------------------


-- 6. Select the full name and job description of all employees.

SELECT
		e.fname,
        e.lname,
        e.job_id
        j.job_desc        
FROM
	employee AS e
    LEFT JOIN jobs AS j 
    ON e.job_id = j.job_id;
    
    13:03:50	12:36:29 "SELECT e.fname, e.lname, p.pub_name FROM employee AS e INNER JOIN publisher AS p     ON e.pub_id = p.pub_id LIMIT 0, 1000  
    Error Code: 1146. Table 'music_beginner.employee' doesn't exist 0.000 sec"   --------------------------   -
    - 6. Select the full name and job description of all employees.  
    SELECT   e.fname,         e.lname,         j.job_desc         FROM  employee AS e     LEFT JOIN jobs AS j      ON e.job_id = j.job_id	Error Code: 1064. You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '
    12:36:29 "SELECT e.fname, e.lname, p.pub_name FROM employee AS e INNER JOIN publ' at line 1	0.000 sec;


SELECT
    e.fname,
    e.lname,
    j.job_desc
FROM employee AS e
LEFT JOIN jobs AS j
    ON e.job_id = j.job_id;



/* 7. Select the full name, job description and publisher name of all employees
   Hint: you will have to perform 2 joins in a single query to merge 3 tables 
         together. */

SELECT 
    e.fname, 
    e.lname, 
    j.job_desc, 
    p.pub_name
FROM
    employee AS e
        LEFT JOIN
    jobs AS j ON e.job_id = j.job_id
        LEFT JOIN
    publishers AS p ON e.pub_id = p.pub_id;
    
    
    SELECT 
    e.fname, 
    e.lname, 
    j.job_desc, 
    p.pub_name
FROM
    employee AS e
        LEFT JOIN
    jobs AS j USING(job_id)
        LEFT JOIN
    publishers AS p USING(pub_id);


/* 8. Select the full name, job description and publisher name of employees
   that work for Binnet & Hardley.
   Hint: you can add a WHERE clause after the joins */

SELECT 
    e.fname, 
    e.lname, 
    j.job_desc, 
    p.pub_name
FROM
    employee AS e
        LEFT JOIN
    jobs AS j ON e.job_id = j.job_id
        LEFT JOIN
    publishers AS p ON e.pub_id = p.pub_id
WHERE
	p.pub_name = "Binnet & Hardley";


/* 9. Select the name and PR Info (from the pub_info table) from all publishers
   based in Berkeley, California. */

SELECT
p.pub_name,
p.city,
p.state,
pi.pr_info
FROM
publishers AS p
LEFT JOIN
pub_info AS pi USING(pub_id)
WHERE
p.city = "Berkeley";



/* 10. Select all columns from the discounts table.
   Observe the columns it has and now some of them are filled with NULL values.
*/
SELECT * FROM discounts;


/* 11. Select all store names, their store id and the discounts they offer.

	   - When selecting the store id, select it two times: from the stores table
         and from the discounts table.
         
       - ALL stores should be displayed, even if they don't offer any discount 
         (i.e. have a NULL value on the discount column). */

SELECT		st.stor_name,
			st.stor_id,
			dis.discount,
			dis.stor_id
FROM		stores AS st
LEFT JOIN	discounts AS dis 
			USING(stor_id);



/* 12.Select all store names and the discounts they offer.

       - This time, we don't want to display stores that don't offer any 
         discount.
         
   Hint: change the join type! */

SELECT		st.stor_name,
			st.stor_id,
			dis.discount,
			dis.stor_id
FROM		stores AS st
INNER JOIN	discounts AS dis 
ON dis.stor_id = st.stor_id;



SELECT		st.stor_name,
			st.stor_id,
			dis.discount,
			dis.stor_id
FROM		discounts AS dis
LEFT JOIN	stores AS st 
ON dis.stor_id = st.stor_id;
