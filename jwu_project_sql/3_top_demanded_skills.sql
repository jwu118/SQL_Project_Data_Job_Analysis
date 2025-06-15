/*
Question: What are the most in-demand skill for data analysts?
- Join job postings to innder join table similar to query 2
- Identify the top 5 in-demand skills for data analyst.
- Focus on all job postings.
- Retrives the top 2 skills with the highest demand in the job market,
providing insights into the most valuable skills for job seekers.
*/


--filters top 5 skills for data analyst jobs that are remote AND in-person
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM 
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id 
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id 
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;


--filters top 5 skills for data analyst jobs that are remote
SELECT 
    skills,
    COUNT(skills_job_dim.job_id) AS demand_count
FROM 
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id 
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id 
WHERE
    job_title_short = 'Data Analyst' AND
    job_work_from_home = TRUE
GROUP BY
    skills
ORDER BY
    demand_count DESC
LIMIT 5;