/*
Write a query to find companies (include company name) that have posted jobs offering health insurance, 
where these postings were made in the second quarter of 2023. Use date extraction to filter by quarter.
*/


SELECT
   company_dim.name AS company_name,
   job_postings_fact.job_health_insurance AS company_insurance,
   job_posted_date
FROM
   job_postings_fact
LEFT JOIN company_dim
   ON job_postings_fact.company_id = company_dim.company_id
WHERE
   job_postings_fact.job_health_insurance = 'TRUE'
   AND EXTRACT(QUARTER FROM job_postings_fact.job_posted_date) = 2
   AND EXTRACT(YEAR FROM job_postings_fact.job_posted_date) = 2023;
