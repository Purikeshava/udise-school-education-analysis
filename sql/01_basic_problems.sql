use udise_school_db;
show tables;
select * from school_infrastructure;
select * from social_category_enrollment;
select * from school_statistics;

-- BASIC QUESTIONS ---------------
-- 1. Top 10 states by total number of schools
SELECT state,`Total number of Schools` from udise_stateschool_statistics
order by `Total number of Schools` desc
limit 10;

-- 2. States with Pupil-Teacher Ratio (PTR) worse than 30
SELECT state, `Pupil Teacher Ratio`
FROM school_statistics
WHERE `Pupil Teacher Ratio` > 30;

-- 3. States with at least one zero-enrolment school
SELECT COUNT(*) AS states_with_zero_enrolment_schools
FROM school_statistics
WHERE `Schools with Zero Enrolments` > 0;

-- 4. Top 5 states with internet facility
SELECT state, internet_facility
FROM school_infrastructure
ORDER BY internet_facility DESC
LIMIT 5;

-- 5. Social category enrolment share of Andhra Pradesh
SELECT *
FROM social_category_enrollment
WHERE `State/UT`='Andhra Pradesh';

-- 6. National Average PTR
SELECT ROUND(AVG(`Pupil Teacher Ratio`),2) AS National_PTR
FROM school_statistics;

-- 7. Average enrolments per school
SELECT state,
`Average Enrolments Per School`
FROM school_statistics
ORDER BY state;

-- 8. Total number of States/UTs
SELECT COUNT(*) AS Total_States
FROM school_statistics;

-- 9. States with less than 1000 schools
SELECT state,
`Total number of Schools`
FROM school_statistics
WHERE `Total number of Schools`<1000
ORDER BY `Total number of Schools`;

-- 10. Top 5 states by enrolments
SELECT state,
Enrolments
FROM school_statistics
ORDER BY Enrolments DESC
LIMIT 5;

-- ---------------END --------------------------------------------------


