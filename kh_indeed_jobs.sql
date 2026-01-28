-- How many rows are in the data_analyst_jobs table?

SELECT COUNT(title) AS num_jobs
FROM data_analyst_jobs;

-- Write a query to look at just the first 10 rows. What company is associated with the job posting on the 10th row?

-- ExxonMobil is the company in the 10th row.

SELECT *
FROM data_analyst_jobs
LIMIT 10;

-- How many postings are in Tennessee? How many are there in either Tennessee or Kentucky?

SELECT COUNT(title) AS tennessee_jobs
FROM data_analyst_jobs
WHERE location = 'TN';

SELECT COUNT(title) AS tn_ky_jobs
FROM data_analyst_jobs
WHERE location = 'TN' OR location = 'KY';

-- How many postings in Tennessee have a star rating above 4?

SELECT COUNT(title) AS four_star_tn
FROM data_analyst_jobs
WHERE location = 'TN' AND star_rating > 4;

-- How many postings in the dataset have a review count between 500 and 1000?

SELECT COUNT(title) AS mid_review_count
FROM data_analyst_jobs
WHERE review_count > 500 AND review_count < 1000;

-- Show the average star rating for companies in each state. The output should show the state as state and the average rating for the state as avg_rating. Which state shows the highest average rating?

-- NE has the highest average rating

SELECT location, AVG(star_rating) AS avg_rating
FROM data_analyst_jobs
WHERE star_rating IS NOT NULL
GROUP BY location
ORDER BY AVG(star_rating) DESC;

-- Select unique job titles from the data_analyst_jobs table. How many are there?

SELECT DISTINCT title AS unique_titles
FROM data_analyst_jobs;

SELECT COUNT(DISTINCT title) AS num_unique_titles
FROM data_analyst_jobs;

-- How many unique job titles are there for California companies?

SELECT COUNT(DISTINCT title) AS ca_unique_titles
FROM data_analyst_jobs
WHERE location = 'CA';

-- Find the name of each company and its average star rating for all companies that have more than 5000 reviews across all locations. How many companies are there with more that 5000 reviews across all locations?

SELECT DISTINCT company, AVG(star_rating)
FROM data_analyst_jobs
WHERE review_count > 5000 AND company IS NOT NULL
GROUP BY DISTINCT company;

SELECT COUNT(DISTINCT company)
FROM data_analyst_jobs
WHERE review_count > 5000 AND company IS NOT NULL;

-- Add the code to order the query in #9 from highest to lowest average star rating. Which company with more than 5000 reviews across all locations in the dataset has the highest star rating? What is that rating?

-- American Express has the highest average rating, ~4.2 stars out of 5

SELECT DISTINCT company, AVG(star_rating)
FROM data_analyst_jobs
WHERE review_count > 5000 AND company IS NOT NULL
GROUP BY DISTINCT company
ORDER BY AVG(star_rating) DESC;

-- Find all the job titles that contain the word ‘Analyst’. How many different job titles are there?

SELECT title
FROM data_analyst_jobs
WHERE UPPER(title) LIKE '%ANALYST%';

SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs
WHERE UPPER(title) LIKE '%ANALYST%';

-- How many different job titles do not contain either the word ‘Analyst’ or the word ‘Analytics’? What word do these positions have in common?

-- Ther are 4 titles that do not contain 'Analyst' or 'Analytics'. Three of 4 contain the word 'Data', and the final one contains 'IT'.

SELECT DISTINCT title
FROM data_analyst_jobs
WHERE UPPER(title) NOT LIKE '%ANALYST%' AND UPPER(title) NOT LIKE '%ANALYTICS%';

SELECT COUNT(DISTINCT title)
FROM data_analyst_jobs
WHERE UPPER(title) NOT LIKE '%ANALYST%' AND UPPER(title) NOT LIKE '%ANALYTICS%';

-- BONUS: You want to understand which jobs requiring SQL are hard to fill. Find the number of jobs by industry (domain) that require SQL and have been posted longer than 3 weeks.
	-- Disregard any postings where the domain is NULL.
	-- Order your results so that the domain with the greatest number of hard to fill jobs is at the top.
	-- Which three industries are in the top 4 on this list? How many jobs have been listed for more than 3 weeks for each of the top 4?

-- Internet and Software, 42 unfilled positions
-- Health Care, 40 unfilled positions
-- Banks and Financial Services, 38 unfilled positions
-- Consulting and Business Services, 31 unfilled positions

SELECT DISTINCT domain, COUNT(DISTINCT title) AS num_unfilled_jobs
FROM data_analyst_jobs
WHERE days_since_posting > 21 AND UPPER(skill) LIKE '%SQL%' AND domain IS NOT NULL
GROUP BY domain
ORDER BY COUNT(DISTINCT title) DESC;