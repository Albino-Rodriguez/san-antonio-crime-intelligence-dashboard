-- =========================================================
-- San Antonio Crime Analysis Dashboard
-- SQL Data Cleaning
-- =========================================================

-- ---------------------------------------------------------
-- 1. Create cleaned analysis table
-- ---------------------------------------------------------

DROP TABLE IF EXISTS crime_clean;

CREATE TABLE crime_clean AS
SELECT
    Report_ID,
    DATE(Report_Date) AS report_date,
    NIBRS_Code_Name AS crime_type,
    NIBRS_Crime_Against AS crime_against,
    Service_Area AS service_area,
    NIBRS_Group AS crime_group,
    Zip_Code AS zip_code,
    DATETIME(DateTime) AS incident_datetime
FROM crime_raw;

-- ---------------------------------------------------------
-- 2. Add time intelligence columns
-- ---------------------------------------------------------

ALTER TABLE crime_clean ADD COLUMN year INTEGER;
ALTER TABLE crime_clean ADD COLUMN month INTEGER;
ALTER TABLE crime_clean ADD COLUMN day_of_week INTEGER;

UPDATE crime_clean
SET
    year = CAST(strftime('%Y', report_date) AS INTEGER),
    month = CAST(strftime('%m', report_date) AS INTEGER),
    day_of_week = CAST(strftime('%w', report_date) AS INTEGER);

-- ---------------------------------------------------------
-- 3. Basic data validation checks
-- ---------------------------------------------------------

-- Check sample rows
SELECT *
FROM crime_clean
LIMIT 10;

-- Check total records
SELECT COUNT(*) AS total_records
FROM crime_clean;

-- Check month distribution
SELECT
    month,
    COUNT(*) AS incidents
FROM crime_clean
GROUP BY month
ORDER BY month;

-- Check year distribution
SELECT
    year,
    COUNT(*) AS incidents
FROM crime_clean
GROUP BY year
ORDER BY year;

-- Check missing zip codes
SELECT COUNT(*) AS null_zip_codes
FROM crime_clean
WHERE zip_code IS NULL;

-- ---------------------------------------------------------
-- 4. Analytical queries used for Tableau dashboard
-- ---------------------------------------------------------

-- Monthly crime trend
SELECT
    month,
    COUNT(*) AS incidents
FROM crime_clean
GROUP BY month
ORDER BY month;

-- Top crime types
SELECT
    crime_type,
    COUNT(*) AS incidents
FROM crime_clean
GROUP BY crime_type
ORDER BY incidents DESC
LIMIT 10;

-- Crime by service area
SELECT
    service_area,
    COUNT(*) AS incidents
FROM crime_clean
GROUP BY service_area
ORDER BY incidents DESC;

-- Crime group distribution
SELECT
    crime_group,
    COUNT(*) AS incidents
FROM crime_clean
GROUP BY crime_group
ORDER BY incidents DESC;

-- Crime by zip code (hotspots)
SELECT
    zip_code,
    COUNT(*) AS incidents
FROM crime_clean
GROUP BY zip_code
ORDER BY incidents DESC;

-- Crime against categories
SELECT
    crime_against,
    COUNT(*) AS incidents
FROM crime_clean
GROUP BY crime_against
ORDER BY incidents DESC;