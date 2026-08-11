use udise_school_db;
show tables;
select * from school_infrastructure;
select * from social_category_enrollment;
select * from school_statistics;

-- INTERMEDIATE QUESTIONS -----------------
-- 1. Highest percentage of single teacher schools
SELECT state,
ROUND((`Schools with Single Teachers`/
`Total number of Schools`)*100,2) AS Percentage
FROM school_statistics
ORDER BY Percentage DESC;

-- 2. Lowest internet facility percentage
SELECT
state,
ROUND((internet_facility/total_schools)*100,2) AS Internet_Percentage
FROM school_infrastructure
ORDER BY Internet_Percentage;

-- 3. States above national average OBC enrolment
SELECT *
FROM social_category_enrollment
WHERE OBC>(
SELECT AVG(OBC)
FROM social_category_enrollment
);

-- 4. Girls toilet maintenance gap
SELECT
state,
girls_toilet,
functional_girls_toilet,
(girls_toilet-functional_girls_toilet) AS Gap
FROM school_infrastructure
ORDER BY Gap DESC;

-- 5. PTR Band using CASE
SELECT
state,
`Pupil Teacher Ratio`,
CASE
WHEN `Pupil Teacher Ratio`<20 THEN 'Excellent'
WHEN `Pupil Teacher Ratio` BETWEEN 20 AND 30 THEN 'Average'
ELSE 'Poor'
END AS PTR_Band
FROM school_statistics;

-- 6. Count states in each PTR Band
SELECT
CASE
WHEN `Pupil Teacher Ratio`<20 THEN 'Excellent'
WHEN `Pupil Teacher Ratio` BETWEEN 20 AND 30 THEN 'Average'
ELSE 'Poor'
END AS PTR_Band,
COUNT(*) AS Total
FROM school_statistics
GROUP BY PTR_Band;

-- 7. Highest non-functional computer facility
SELECT
state,
(computer_facility-functional_computer_facility) AS Gap
FROM school_infrastructure
ORDER BY Gap DESC;

-- 8. SC enrolment above 20%
SELECT
s.state,
e.SC,
s.`Pupil Teacher Ratio`
FROM school_statistics s
JOIN social_category_enrollment e
ON s.state=e.`State/UT`
WHERE e.SC>20;

-- 9. States with more than 90% electricity and drinking water
SELECT state
FROM school_infrastructure
WHERE
(functional_electricity/total_schools)>=0.90
AND
(functional_drinking_water/total_schools)>=0.90;

-- 10. Rank states by average enrolments
SELECT
state,
`Average Enrolments Per School`,
RANK() OVER(
ORDER BY `Average Enrolments Per School` DESC
) AS Ranking
FROM school_statistics;

-- --------------END -----------------------------