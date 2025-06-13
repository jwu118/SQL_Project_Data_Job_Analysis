/*
Categorize the salaries from each job posting. To see if it fits in your desired salary range. 
Put salary into different buckets
Define what’s a high, standard, or low salary with our own conditions.
Why? It is easy to determine which job postings are worth looking at based on salary. Bucketing is common practice in data analysis when viewing categories.
Only data analyst roles.
Order from highest to lowest
*/


SELECT
   job_id,
   job_title_short,
   salary_year_avg,
   CASE
       WHEN salary_year_avg <= 60000 THEN 'low'
       WHEN salary_year_avg > 60000 THEN 'standard'
       ELSE 'high'
   END AS salary_condition
FROM
   job_postings_fact
WHERE
   job_title_short = 'Data Analyst'
ORDER BY
   salary_year_avg;
