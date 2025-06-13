/*
Determine the size category(‘Small’, ‘Medium’, or ‘Large’) for each company by first identifying the 
number of job postings they have. Use a subquery to calculate the total job postings per company. A 
company is considered ‘Small’ if it has less than 10 job postings, ‘Medium’ if the number of job postings 
is between 10 and 50, and ‘Large’ if it has more than 50 job postings. Implement a subquery to aggregate 
job counts per company before classifying them based on size. 
*/


-- Step 1: Aggregate job postings per company
WITH total_job_postings AS (
   SELECT
       company_id,
       COUNT(*) AS num_of_jobs
   FROM
       job_postings_fact
   GROUP BY
       company_id
)


-- Step 2: Classify companies and join with company names
SELECT
   c.name AS company_name,
   t.num_of_jobs,
   CASE
       WHEN t.num_of_jobs < 10 THEN 'Small'
       WHEN t.num_of_jobs BETWEEN 10 AND 50 THEN 'Medium'
       ELSE 'Large'
   END AS company_size
FROM
   total_job_postings t
JOIN
   company_dim c ON t.company_id = c.company_id
ORDER BY
   t.num_of_jobs DESC;
