use udise_school_db;
show tables;
select * from school_infrastructure;
select * from social_category_enrollment;
select * from school_statistics;

-- ADVANCED QUESTIONS -------------
-- 1. Composite Infrastructure Score (CTE)
WITH Infrastructure AS
(
SELECT state,
 (library+playground+internet_facility+electricity+drinking_water)/5 AS Score
FROM school_infrastructure)
SELECT *
FROM Infrastructure
ORDER BY Score DESC;

-- 2. Rank states by school count
SELECT state,
`Total number of Schools`,
RANK() OVER(ORDER BY `Total number of Schools` DESC) Rank_No
FROM school_statistics;

-- 3. Estimated ST enrolment
SELECT
s.state,
ROUND((e.ST/100)*s.Enrolments) AS Estimated_ST
FROM school_statistics s
JOIN social_category_enrollment e
ON s.state=e.`State/UT`;

-- 4. Ramp accessibility quartiles
SELECT
state,
ramp_for_cwsn,
NTILE(4) OVER(ORDER BY ramp_for_cwsn DESC) Quartile
FROM school_infrastructure;

-- 5. Difference with next smaller state
SELECT
state,
`Total number of Schools`,
LAG(`Total number of Schools`)
OVER(ORDER BY `Total number of Schools` DESC) Previous_State,
`Total number of Schools`-
LAG(`Total number of Schools`)
OVER(ORDER BY `Total number of Schools` DESC) Difference
FROM school_statistics;

-- 6. Muslim enrolment vs internet facility
SELECT
s.state,
e.Muslim,
i.internet_facility
FROM school_statistics s
JOIN social_category_enrollment e
ON s.state=e.`State/UT`
JOIN school_infrastructure i
ON s.state=i.state;

-- 7. Worst five states for computer facility gap
SELECT
state,
(computer_facility-functional_computer_facility) AS Gap,
RANK() OVER(ORDER BY (computer_facility-functional_computer_facility) DESC) Ranking
FROM school_infrastructure
LIMIT 5;

-- 8. PTR vs National Average
SELECT
state,
`Pupil Teacher Ratio`,
AVG(`Pupil Teacher Ratio`) OVER() AS National_PTR
FROM school_statistics;

-- 9. Opportunity Score using all three tables
SELECT
s.state,
(i.internet_facility+
i.functional_electricity+
i.functional_drinking_water+
e.General+
e.OBC+
e.SC+
e.ST+
e.Muslim) AS Opportunity_Score
FROM school_statistics s
JOIN school_infrastructure i
ON s.state=i.state
JOIN social_category_enrollment e
ON s.state=e.`State/UT`
ORDER BY Opportunity_Score DESC;

-- 10. Percentile rank by internet facility
SELECT state,internet_facility,
PERCENT_RANK() OVER(ORDER BY internet_facility) AS Percentile_Rank
FROM school_infrastructure;

-- END -----------------------------------------------------------
