# San Antonio Crime Intelligence Dashboard

## Project Overview
This project analyzes crime incidents in San Antonio using SQL and Tableau to uncover patterns in crime type, geographic distribution, and temporal trends. The goal of this analysis was to transform raw crime data into an interactive dashboard that provides insights into crime activity across the city.

The final dashboard allows users to explore crime patterns by time, location, and offense category while highlighting key hotspots and trends.

---

## Dashboard Preview
![San Antonio Crime Dashboard](images/Dashboard_preview2.jpg)

---

## Tools Used

| Tool | Purpose |
|-----|-----|
| SQLite | Data cleaning and transformation |
| SQL | Feature engineering and aggregation |
| Tableau | Data visualization and dashboard development |
| GitHub | Portfolio hosting and version control |

---

## Dataset
The dataset contains reported crime incidents from the San Antonio Police Department including:

- Incident report ID
- Report date
- Crime type
- Crime category (crime against)
- Police service area
- Crime group classification
- ZIP code location
- Incident timestamp

This dataset was cleaned and prepared for analysis using SQL.

---

## Data Cleaning Process (SQL)

The raw dataset was transformed into an analysis-ready table using the following steps:

1. Created a cleaned analysis table (`crime_clean`) from the raw dataset.
2. Standardized date fields for time-based analysis.
3. Generated time intelligence fields including:
   - Year
   - Month
   - Day of week
4. Verified data quality and validated the distribution of records.

Example SQL transformation:

```sql
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
