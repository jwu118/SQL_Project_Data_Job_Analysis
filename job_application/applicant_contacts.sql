UPDATE job_applied
SET     contact = 'Jack'
WHERE job_id = 1;

UPDATE job_applied
SET contact = 'Bob'
WHERE job_id = 2;

UPDATE job_applied
SET     contact = 'Mary'
WHERE job_id = 3;

UPDATE job_applied
SET contact = 'Ann'
WHERE job_id = 4;

UPDATE job_applied
SET contact = 'Sammy'
WHERE job_id = 5;

SELECT *
FROM job_applied;