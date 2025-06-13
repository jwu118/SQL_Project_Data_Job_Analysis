/*
PROBLEM 1:

Find the count of the number of remote job postings per skill. Display the top 5 skills by their demand 
in remote jobs. Include skill ID, name, and count of postings requiring the skill.
*/

WITH remote_job_skills AS(
   SELECT
       skill_id,
       COUNT(*) AS skill_count
   FROM
       skills_job_dim AS skills_to_job
   INNER JOIN job_postings_fact ON job_postings_fact.job_id = skills_to_job.job_id
   WHERE
       job_work_from_home = TRUE AND
       job_postings_fact.job_title_short = 'Data Analyst'
   GROUP BY
       skill_id
)


SELECT
   skills.skill_id,
   skills AS skill_name,
   skill_count
FROM
   remote_job_skills
INNER JOIN skills_dim AS skills ON skills.skill_id = remote_job_skills.skill_id
ORDER BY
   skill_count DESC
LIMIT 5;



/*
PROBLEM 2:

Get the corresponding skill and skill type for each job posting from problem 1. Includes those without any skills, 
too. Look at the skills and the type for each job in the first quarter that has a salary > $70,000. 
*/

-- Jobs with skills
SELECT
    j.job_id,
    s.skill_id,
    s.skills,
    s.type
FROM
    job_postings_fact AS j
INNER JOIN skills_job_dim AS sj ON j.job_id = sj.job_id
INNER JOIN skills_dim AS s ON sj.skill_id = s.skill_id
WHERE
    j.salary_year_avg = 70000
    AND EXTRACT(MONTH FROM j.job_posted_date) IN (1, 2, 3)

UNION

-- Jobs without skills
SELECT
    j.job_id,
    NULL AS skill_id,
    NULL AS skills,
    NULL AS type
FROM
    job_postings_fact AS j
WHERE
    j.salary_year_avg = 70000
    AND EXTRACT(MONTH FROM j.job_posted_date) IN (1, 2, 3)
    AND j.job_id NOT IN (
        SELECT job_id FROM skills_job_dim
    );
