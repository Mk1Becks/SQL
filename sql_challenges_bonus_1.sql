/*

*******************************************************************************
*******************************************************************************

SQL CHALLENGES bonus 1

*******************************************************************************
*******************************************************************************

In the exercises below you might need to use the any of the clauses learend so 
far.

*/

USE publications;

/* 1. Select the top 5 orders with most quantity sold between 1993-03-11 and
    1994-09-13 from the table sales */

SELECT 
    ord_date, stor_id, COUNT(*) AS MAXBUY
FROM
    sales
WHERE
    ord_date BETWEEN '1993-03-11' AND '1994-09-13'
GROUP BY ytd
ORDER BY MAXBUY DESC;


SELECT 
    ord_num,ytd, stor_id, ord_date
FROM
    sales
WHERE
    ord_date BETWEEN '1993-03-11' AND '1994-09-13'
GROUP BY ytd DESC
LIMIT  5;


/* 2. How many authors have an "i" in their first name, are from Utah,
   Maryland, or Kansas? */

SELECT 
    au_fname, state, COUNT(*) AS author_count
FROM
    authors
WHERE
    au_fname LIKE '%i%'
        AND state IN ('UT' , 'MD', 'KS')
GROUP BY state;

/* 3. In California, how many authors are there in cities that contain an "o"
   in the name?
   - Show only results for cities with more than 1 author.
   - Sort the cities ascendingly by author count.
*/

SELECT
    city,
    COUNT(*) AS author_count
FROM authors
WHERE
    state = 'CA'
    AND city LIKE '%o%'
GROUP BY
    city
HAVING
    COUNT(*) > 1
ORDER BY
    author_count ASC;
