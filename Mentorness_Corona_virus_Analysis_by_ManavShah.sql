SELECT * FROM covid
WHERE Province IS NULL OR 
Country_Region IS NULL OR 
Latitude IS NULL OR 
Longitude IS NULL OR 
Date IS NULL OR
Confirmed IS NULL OR 
Deaths IS NULL OR
Recovered IS NULL  ;
UPDATE covid SET Date = STR_TO_DATE(Date, '%d-%m-%Y');
SET SQL_SAFE_UPDATES = 0;
SELECT Date from covid;
UPDATE covid 
SET 
Province = COALESCE(Province, 'N/A'),
Country_Region = COALESCE(Country_Region, 'N/A'),
Latitude = COALESCE(Latitude, 0.0),
Longitude = COALESCE(Longitude, 0.0),
Date  = COALESCE(Date, (SELECT min(date))),
Confirmed  = COALESCE(Confirmed, 0),
Deaths  = COALESCE(Deaths, 0),
Recovered = COALESCE(Recovered, 0);
SELECT count(*) AS Total_Rows FROM covid;
SELECT MIN(Date) AS start_date, MAX(Date) AS end_date
FROM covid;
SELECT extract(YEAR FROM Date) as year,extract(MONTH FROM Date) as no_of_month ,
AVG(Deaths) as avg_of_deaths,
AVG(Recovered) as avg_of_recovered,
AVG(Confirmed) as avg_of_confirmed from covid 
GROUP BY year , no_of_month
ORDER BY year ,no_of_month;
SELECT Deaths, COUNT(Deaths) AS value_occurrence
FROM covid
GROUP BY Deaths
ORDER BY value_occurrence DESC
LIMIT 1;
SELECT extract(YEAR FROM Date) as year,
MAX(Deaths) as MAX_Deaths,
MAX(Recovered) as Max_Recovered,
MAX(Confirmed) as Max_Confirmed from covid 
GROUP BY year
ORDER BY year ; 
SELECT extract(YEAR FROM Date) as year,
MIN(Deaths) as Min_Deaths,
MIN(Recovered) as Min_Recovered,
MIN(Confirmed) as Min_Confirmed from covid 
GROUP BY year
ORDER BY year ; 
SELECT extract(YEAR FROM Date) as year,
SUM(Deaths) as Min_Deaths,
SUM(Recovered) as Min_Recovered,
SUM(Confirmed) as Min_Confirmed from covid 
GROUP BY year
ORDER BY year ; 
SELECT extract(YEAR FROM Date) as year, extract(MONTH FROM Date) as month ,
SUM(Confirmed) as Total_Confirmed,
AVG(Confirmed) as Average_Confirmed,
STDDEV(Confirmed) as standard_deviation ,
VARIANCE(Confirmed) as Variance from covid 
GROUP BY year , month
ORDER BY year ,month;
SELECT extract(YEAR FROM Date) as year, extract(MONTH FROM Date) as month ,
SUM(Deaths) as Total_Deaths,
AVG(Deaths) as Average_Deaths,
STDDEV(Deaths) as standard_deviation ,
VARIANCE(Deaths) as Variance from covid 
GROUP BY year , month
ORDER BY year ,month;
SELECT extract(YEAR FROM Date) as year, extract(MONTH FROM Date) as month ,
SUM(Recovered) as Total_Recovered,
AVG(Recovered) as Average_Recovered,
STDDEV(Recovered) as standard_deviation ,
VARIANCE(Recovered) as Variance from covid 
GROUP BY year , month
ORDER BY year ,month;
SELECT Country_Region,
SUM(Confirmed) AS Highest_cases FROM covid 
GROUP BY Country_Region
ORDER BY Highest_cases ASC 
LIMIT 1;
SELECT Country_Region,
SUM(Recovered) AS Highest_Recovered_cases FROM covid 
GROUP BY Country_Region
ORDER BY Highest_Recovered_cases DESC 
LIMIT 5;