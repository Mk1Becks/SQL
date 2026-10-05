/******************************************************************************
*******************************************************************************

SQL CHALLENGES 9

*******************************************************************************
******************************************************************************/


USE publications;


-- 1. Add a column showing how many characters are in each author's last name

SELECT
	au_lname, LENGTH (au_lname) as Legnth_name
FROM
	authors
ORDER BY Legnth_name  desc;

-- 2. What is the first name of each author in uppercase?

SELECT
    UPPER(au_fname) AS first_name_uppercase
FROM 
	authors
;

-- 3. Combine first and last names of authors into a single column.

SELECT 
	CONCAT(au_fname, " ", au_lname) AS full_name
FROM 
	authors;

-- mit extras
SELECT 
	CONCAT(au_fname, " ", au_lname, " - Tel: ", phone) AS full_name
FROM 
	authors;

-- 4. Show the current date in a column called 'today'.

SELECT NOW() AS now_time, CURRENT_DATE() AS today;

-- 5. Calculate the difference in days between a book's publication date and today's date.

SELECT 
    title,
    pubdate,
    DATEDIFF(CURRENT_DATE(), pubdate) 
		AS zuletzt_veroeffentlicht_in_Tage
FROM
    titles;

-- 6. How many years has it been since each title was published?

SELECT 
	pubdate, title, 
    TIMESTAMPDIFF(YEAR, pubdate, CURRENT_DATE()) 
		AS years_since_publication,
    TIMESTAMPDIFF(DAY, pubdate, CURRENT_DATE()) 
		AS days_since_publication
FROM
	titles
ORDER BY days_since_publication DESC
;
    
-- alternative mit ein wenig Mathematik
SELECT
	pubdate AS publication_date, # optional
	CURRENT_DATE() AS today, #optional
    DATEDIFF(CURRENT_DATE(), pubdate) AS difference_days, #optional
    DATEDIFF(CURRENT_DATE(), pubdate) / 365.00 AS years_since_publication
FROM 
	titles;
    
    
-- 7. Find the publication year and month of each title in 'YYYY-MM' format.   
# Beispiel 2026-09

SELECT title,
       DATE_FORMAT(pubdate, "%Y-%m") AS pub_YYYY_MM
FROM titles;



SELECT  
	CURRENT_DATE() AS current_date_,
	DATE_FORMAT(CURRENT_DATE(), "%Y-%m x %H:%i") AS current_date_with_time_visible;

-- 8. Concatenate the publisher's name and city into a single column. Separate them with a comma.

SELECT 
	pub_id,
	CONCAT(pub_name, ', ', city) AS info
FROM publishers;

-- 9. What is the longest title of a book?

SELECT 
    title, LENGTH(title) AS laenge
FROM
    titles
WHERE
    LENGTH(title) = (SELECT 
						MAX(LENGTH(title))
					FROM
						titles);


-- mit Limit, aber nicht flexibel in Anzahl an Ergebnissen
SELECT    
	title, LENGTH(title) AS laenge
FROM
    titles
ORDER BY laenge DESC
LIMIT 2
;


-- 10. Display the publication date of each title in 'Day-Month-Year' format. For example, '12-June-1991'.
    
SELECT 
	title_id, title,
	DATE_FORMAT(pubdate, "%d-%M-%Y") 
		AS formatted_date
FROM titles;
    
-- 11. List authors whose last name starts with 'C' and show the first 5 characters of their address.
    
SELECT
	au_lname, 
    address,
	SUBSTRING(address,1,5) AS short_address
FROM
	authors
WHERE 
	au_lname LIKE 'c%';

-- 12. Return the difference in days between the current date and the publication date of titles where the difference is greater than 1000 days.

SELECT 
	title, 
    DATEDIFF(current_date(), pubdate) AS days_diff
FROM 
	titles
HAVING 
	days_diff > 1000;

SELECT 
	title, 
    DATEDIFF(current_date(), pubdate) AS days_diff
FROM 
	titles
WHERE 
	DATEDIFF(CURRENT_DATE(), pubdate) > 1000;

-- 13. Find the titles where the length of the title name is greater than the average length of all titles.

SELECT
	title,
    LENGTH(title) AS title_length,
	(
	SELECT
		AVG(LENGTH(title))
	FROM
		titles
	) AS avg_title_length
FROM
	titles
WHERE
	LENGTH(title) > (
					SELECT
						AVG(LENGTH(title))
					FROM
						titles
					)
ORDER BY title_length DESC
;

-- 14. Get the authors whose first name length is equal to their last name length.

SELECT 
	au_id, 
	au_lname, 
	LENGTH(au_lname), 
	au_fname,
	LENGTH(au_fname)
FROM 
	authors
WHERE 
	LENGTH(au_lname) = LENGTH(au_fname)
ORDER BY
	LENGTH(au_fname);

-- 15. Find the longest city name among the authors' addresses.

SELECT 
	au_lname, au_fname, 
    city, 
    LENGTH(city)
FROM authors
WHERE LENGTH(city) = (  SELECT 
							MAX(LENGTH(city)) 
						FROM 
							authors
						);

SELECT DISTINCT
	city, 
    LENGTH(city)
FROM authors
WHERE LENGTH(city) = (  SELECT 
							MAX(LENGTH(city)) 
						FROM 
							authors
						);

SELECT
	MAX(LENGTH(city)) AS longest_city_name
FROM
	authors
;

-- 16. Display titles and their publication dates formatted as 'Day of the Week, Month Day, Year'. For example, 'Wednesday, June 12, 1991'.

SELECT title,
       DATE_FORMAT(pubdate, '%W, %M %e, %Y') AS pub_datum
FROM titles;

-- 17. Calculate the difference in days between the first and last publication date for each author.

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
GROUP BY a.au_id
ORDER BY differenz_tage DESC;


SELECT 
	ta.au_id,
	DATEDIFF(MAX(t.pubdate), MIN(t.pubdate)) AS difference_date_pub
FROM 
	titles AS t
		LEFT JOIN 
	titleauthor AS ta USING (title_id)
GROUP BY ta.au_id
ORDER BY difference_date_pub DESC;








