/*
Identify the top 5 skills that are most frequently mentioned in job postings. Use a subquery to find the 
skill IDs with the highest counts in the skills_job_dim table and then join this result with the skills_dim 
table to get the skill names.
*/


WITH top_skills AS (
   SELECT
       skill_id,
       COUNT(*) AS count
   FROM
       skills_job_dim
   GROUP BY
       skill_id
   ORDER BY
       count DESC
)


SELECT
   skills_dim.skills AS skill_name,
   top_skills.skill_id
FROM
   skills_dim
LEFT JOIN top_skills ON top_skills.skill_id = skills_dim.skill_id
ORDER BY
   skill_id
LIMIT 5;
