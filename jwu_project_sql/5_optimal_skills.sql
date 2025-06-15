/*
What are most optimal skills to learn (aka it's in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on remote with specidied salaries
- Targets skills that offer job security (high demand) and financial benefits (high salaries),
offering strategic insights for career development in data analysis
*/


WITH skills_demand AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM 
        job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id 
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id 
    WHERE
        job_title_short = 'Data Analyst' 
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    GROUP BY
        skills_dim.skill_id
), average_salary AS (
    SELECT 
        skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM 
        job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id 
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id 
    WHERE
        job_title_short = 'Data Analyst' 
        AND salary_year_avg IS NOT NULL
    GROUP BY
        skills_job_dim.skill_id
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM
    skills_demand
INNER JOIN average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE 
    demand_count > 10
ORDER BY
    demand_count DESC,
    avg_salary DESC
LIMIT 25;


/*
RESULTS:

"skill_id","skills","demand_count","avg_salary"
0,"sql","398","96435"
181,"excel","256","86419"
1,"python","236","101512"
182,"tableau","230","97978"
5,"r","148","98708"
183,"power bi","110","92324"
7,"sas","63","93707"
186,"sas","63","93707"
196,"powerpoint","58","88316"
185,"looker","49","103855"
188,"word","48","82941"
80,"snowflake","37","111578"
79,"oracle","37","100964"
61,"sql server","35","96191"
74,"azure","34","105400"
76,"aws","32","106440"
192,"sheets","32","84130"
215,"flow","28","98020"
8,"go","27","97267"
22,"vba","24","93845"
199,"spss","24","85293"
97,"hadoop","22","110888"
233,"jira","20","107931"
9,"javascript","20","91805"
195,"sharepoint","18","89027"
*/