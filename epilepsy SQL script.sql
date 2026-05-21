Create database epilepsy_project;
use epilepsy_project;
USE epilepsy_project;

CREATE TABLE epilepsy_trials (
    nct_number VARCHAR(20) PRIMARY KEY,
    study_title TEXT,
    study_status VARCHAR(100),
    conditions TEXT,
    interventions TEXT,
    sponsor VARCHAR(200),
    age VARCHAR(100),
    phases VARCHAR(50),
    enrollment INT,
    start_date VARCHAR(20),
    country VARCHAR(100),
    start_year INT,
    sponsor_type VARCHAR(50),
    trial_status_clean VARCHAR(50)
);
USE epilepsy_project;

SELECT COUNT(*) 
FROM epilepsy_trials 
WHERE start_year < 2000 OR start_year > 2025;

-- Fix them by setting to NULL
UPDATE epilepsy_trials 
SET start_year = NULL 
WHERE start_year < 2000 OR start_year > 2025;

SELECT nct_number, study_title, start_date, start_year 
FROM epilepsy_trials 
WHERE start_year < 2000
LIMIT 10;
SELECT nct_number, study_title, start_date, start_year 
FROM epilepsy_trials 
WHERE start_year > 2025
LIMIT 10;
SELECT COUNT(*) 
FROM epilepsy_trials 
WHERE start_year < 2000;
USE epilepsy_project;

DELETE FROM epilepsy_trials 
WHERE start_year = 1900;

SELECT COUNT(*) FROM epilepsy_trials;

# INSIGHTS
#Query 1 — Trial Activity by Year
SELECT start_year, COUNT(*) as total_trials
FROM epilepsy_trials
WHERE start_year IS NOT NULL
GROUP BY start_year
ORDER BY start_year;
#Query 2 — Trial Distribution by Phase
SELECT phases, COUNT(*) as total_trials
FROM epilepsy_trials
GROUP BY phases
ORDER BY total_trials DESC;
#Query 3 — Top 10 Countries by Trial Activity
SELECT country, COUNT(*) as total_trials
FROM epilepsy_trials
WHERE country IS NOT NULL
AND country != ''
GROUP BY country
ORDER BY total_trials DESC
LIMIT 10;
#Query 4 — Industry vs Academic vs Government
SELECT sponsor_type, COUNT(*) as total_trials,
ROUND(COUNT(*)*100.0/SUM(COUNT(*)) OVER(),1) as percentage
FROM epilepsy_trials
GROUP BY sponsor_type
ORDER BY total_trials DESC;
#Query 5 — Trial Status Breakdown
SELECT trial_status_clean, COUNT(*) as total_trials
FROM epilepsy_trials
GROUP BY trial_status_clean
ORDER BY total_trials DESC;

UPDATE epilepsy_trials
SET country = 'China'
WHERE country = 'ChinNot Specified';







UPDATE epilepsy_trials
SET country = 'China'
WHERE country = 'ChinNot Specified';

UPDATE epilepsy_trials
SET country = 'Vietnam'
WHERE country = 'VietNot Specifiedm';

SELECT DISTINCT country 
FROM epilepsy_trials 
WHERE country LIKE '%Not Specified%';


UPDATE epilepsy_trials
SET country = 'China'
WHERE country = 'ChiNot Specified';

SELECT DISTINCT country 
FROM epilepsy_trials 
WHERE country LIKE '%Not Specified%';

SELECT DISTINCT country 
FROM epilepsy_trials 
WHERE country LIKE '%Not Specified%';
SELECT country, COUNT(*) as total_trials
FROM epilepsy_trials
WHERE country IS NOT NULL
AND country != ''
GROUP BY country
ORDER BY total_trials DESC
LIMIT 10;
# for line chart phase trend over time
SELECT t.start_year, t.phases, COUNT(*) as total_trials
FROM epilepsy_trials t
WHERE t.start_year IS NOT NULL
AND t.phases IN ('PHASE1','PHASE2','PHASE3','PHASE4')
GROUP BY t.start_year, t.phases
ORDER BY t.start_year;
#Query 7 — Full Country List (not just top 10)
SELECT country, COUNT(*) as total_trials,
ROUND(COUNT(*)*100.0/(SELECT COUNT(*) FROM epilepsy_trials),2) as global_share_pct
FROM epilepsy_trials
WHERE country IS NOT NULL
AND country != ''
GROUP BY country
ORDER BY total_trials DESC;
#Query 8 — India Specific Deep Dive
SELECT 
    phases,
    trial_status_clean,
    sponsor_type,
    COUNT(*) as total_trials
FROM epilepsy_trials
WHERE country = 'India'
GROUP BY phases, trial_status_clean, sponsor_type
ORDER BY total_trials DESC;
#Query 9 — India vs Top 5 Countries by Year
SELECT start_year,
SUM(CASE WHEN country = 'United States' THEN 1 ELSE 0 END) as USA,
SUM(CASE WHEN country = 'China' THEN 1 ELSE 0 END) as China,
SUM(CASE WHEN country = 'France' THEN 1 ELSE 0 END) as France,
SUM(CASE WHEN country = 'United Kingdom' THEN 1 ELSE 0 END) as UK,
SUM(CASE WHEN country = 'India' THEN 1 ELSE 0 END) as India
FROM epilepsy_trials
WHERE start_year IS NOT NULL
GROUP BY start_year
ORDER BY start_year;














