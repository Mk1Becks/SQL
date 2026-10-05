/******************************************************************************
*******************************************************************************

SQL CHALLENGES 9

*******************************************************************************
******************************************************************************/


USE publications;


-- 1. Add a column showing how many characters are in each author's last name

SELECT 
    au_lname, LENGTH(au_lname) AS name_length
FROM
    authors;

-- 2. What is the first name of each author in uppercase?

SELECT 
    au_fname, UPPER(au_fname) AS lower_name
FROM
    authors;

-- 3. Combine first and last names of authors into a single column.
SELECT 
    au_fname,
    au_lname,
    CONCAT(au_fname, ' ', au_lname) AS full_name
FROM
    authors;

-- 4. Show the current date in a column called 'today'.

SELECT CURRENT_DATE() AS today;

-- 5. Calculate the difference in days between a book's publication date and today's date.


SELECT title, pubdate, DATEDIFF(CURRENT_DATE(), pubdate) AS Diffdays
FROM titles;


#<<< ALTERNATIVE aber genauer >>>>

SELECT 
    title,
    pubdate,
    TIMESTAMPDIFF(YEAR, pubdate, CURRENT_DATE()) AS Jahre,
    DATEDIFF(
        CURRENT_DATE(),
        DATE_ADD(
            pubdate,
            INTERVAL TIMESTAMPDIFF(YEAR, pubdate, CURRENT_DATE()) YEAR
        )
    ) AS Tage
FROM titles;


-- 6. How many years has it been since each title was published?
    
    SELECT 
    title,
    pubdate,
    TIMESTAMPDIFF(YEAR, pubdate, CURRENT_DATE()) AS Diffyears
FROM titles;


#<<<<<<<< erst jahre.... dann mit Komma <<<<<


SELECT 
    title,
    pubdate,
    ROUND(DATEDIFF(CURRENT_DATE(), pubdate) / 365.25, 2) AS Jahre
FROM titles;

### <<<<< ZULETZT WIE OBEN Jahre mit tage genau >>>>>>>>
    
    SELECT 
    title,
    pubdate,
    TIMESTAMPDIFF(YEAR, pubdate, CURRENT_DATE()) AS Jahre,
    DATEDIFF(
        CURRENT_DATE(),
        DATE_ADD(
            pubdate,
            INTERVAL TIMESTAMPDIFF(YEAR, pubdate, CURRENT_DATE()) YEAR
        )
    ) AS Tage
FROM titles;
    
-- 7. Find the publication year and month of each title in 'YYYY-MM' format.   

SELECT 
    title,
    DATE_FORMAT(pubdate, '%Y-%m') AS PubYM
FROM titles;

-- 8. Concatenate the publisher's name and city into a single column. Separate them with a comma.

SELECT 
    CONCAT(pub_name, ' - ', City) AS Publisher
FROM
    publishers;

-- 9. What is the longest title of a book?

SELECT 
    title, LENGTH(title) AS Longesttitle
FROM
    titles
ORDER BY Longesttitle DESC
LIMIT 1;

SELECT 
    title, LENGTH(title) AS Longtitle
FROM
    titles
WHERE
    LENGTH(title) = (SELECT 
            MAX(LENGTH(title))
        FROM
            titles);

-- 10. Display the publication date of each title in 'Day-Month-Year' format. For example, '12-June-1991'.

SELECT 
    title, DATE_FORMAT(pubdate, '%d-%M-%Y') AS PubYM
FROM
    titles;
        
-- 11. List authors whose last name starts with 'C' and show the first 5 characters of their address.

SELECT 
    au_fname, au_lname, SUBSTRING(address, 1, 5) AS Address1_5
FROM
    authors
WHERE
    au_lname LIKE 'C%';

-- 12. Return the difference in days between the current date and the publication date of titles where the difference is greater than 1000 days.

SELECT 
    title, DATEDIFF(CURRENT_DATE(), pubdate) AS days_diff
FROM
    titles
HAVING days_diff > 1000;

-- 13. Find the titles where the length of the title name is greater than the average length of all titles.

SELECT 
    title
FROM
    titles
WHERE
    LENGTH(title) > (SELECT 
            AVG(LENGTH(title))
        FROM
            titles);

-- 14. Get the authors whose first name length is equal to their last name length.
    
 SELECT 
    au_fname,
    au_lname,
    LENGTH(au_fname) AS VN,
    LENGTH(au_lname) AS NN
FROM
    authors
WHERE
    LENGTH(au_fname) = LENGTH(au_lname);
    

-- 15. Find the longest city name among the authors' addresses.

SELECT 
    city, LENGTH(city)
FROM
    authors
WHERE
    LENGTH(city) = (SELECT 
            MAX(LENGTH(city))
        FROM
            authors);

-- 16. Display titles and their publication dates formatted as 'Day of the Week, Month Day, Year'. For example, 'Wednesday, June 12, 1991'.
  

SELECT title, DATE_FORMAT(pubdate, '%W.%M %d, %Y') AS Pub_Date
FROM
    titles;
    
-- 17. Calculate the difference in days between the first and last publication date for each author.


SELECT 
    a.au_fname,
    a.au_lname,
    DATEDIFF(MAX(t.pubdate), MIN(t.pubdate)) AS publication_difference_days
FROM
    authors AS a
        INNER JOIN
    titleauthor AS ta ON a.au_id = ta.au_id
        INNER JOIN
    titles AS t ON ta.title_id = t.title_id
GROUP BY a.au_id , a.au_fname , a.au_lname;

SELECT 
    a.au_id,
    a.au_fname,
    a.au_lname,
    MIN(t.pubdate) AS erste_veroeffentlichung,
    MAX(t.pubdate) AS letzte_veroeffentlichung,
    DATEDIFF(MAX(t.pubdate), MIN(t.pubdate)) AS differenz_tage
FROM
    authors AS a
        INNER JOIN
    titleauthor AS ta ON a.au_id = ta.au_id
        INNER JOIN
    titles AS t ON ta.title_id = t.title_id
GROUP BY a.au_id , a.au_fname , a.au_lname
ORDER BY differenz_tage DESC;

SELECT ta.au_id,
				DATEDIFF(MAX(t.pubdate), MIN(t.pubdate)) AS difference_date_pub
	FROM titles AS t
    LEFT JOIN titleauthor AS ta
    USING (title_id)
    GROUP BY ta.au_id;





SELECT DATEDIFF(MAX(pubdate), MIN(pubdate)) AS DiffDays
FROM titles;





