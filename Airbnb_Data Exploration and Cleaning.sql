/* 

US_Airbnb_2020 Data Exploration

Skills used: Data type converting, CTE's, Windows Functions, Aggregate Functions, Cleaning data, Creating Views

Data source: https://www.kaggle.com/kritikseth/us-airbnb-open-data

*/


SELECT *
FROM [Portfolio Project].[dbo].[AB_US_2020]

-- Standardize Date Format

ALTER TABLE AB_US_2020
Add last_review_dateconverted Date;

Update AB_US_2020
SET last_review_dateconverted = CONVERT(Date,last_review)


-- Dropping unecessary columns for future analysis - host_name, last_reviews

ALTER TABLE AB_US_2020
DROP COLUMN host_name, last_review


-- Replacing NULL values in reviews_per_month with 0

UPDATE [Portfolio Project].[dbo].[AB_US_2020]
SET reviews_per_month = 0
WHERE reviews_per_month IS NULL

-- Top hosts (IDs) with multiple listings 

SELECT COUNT(host_id) host_count,
		host_id
FROM [Portfolio Project].[dbo].[AB_US_2020]
GROUP BY host_id
ORDER BY host_count DESC

-- Top cities with the most listings

SELECT COUNT(host_id) city_count,
		city
FROM [Portfolio Project].[dbo].[AB_US_2020]
GROUP BY city
ORDER BY city_count DESC

-- Average price of each city 

SELECT AVG(price) avg_price,
		city
FROM [Portfolio Project].[dbo].[AB_US_2020]
GROUP BY city
ORDER BY avg_price DESC

-- Cities with the most to the least reviews

SELECT sum(number_of_reviews) total_reviews, city
FROM [Portfolio Project].[dbo].[AB_US_2020]
GROUP BY city
ORDER BY total_reviews DESC

-- Percentage of listings by city
	-- Method #1: Using over()

SELECT city, COUNT(*) * 100.0 / SUM(COUNT(*)) OVER()
FROM [Portfolio Project].[dbo].[AB_US_2020]
GROUP BY city

	-- Method #2: Using CTE
WITH t(city, citycount) 
AS 
( 
    SELECT city, count(*) 
    FROM [Portfolio Project].[dbo].[AB_US_2020]
    GROUP BY city
)
SELECT city, citycount * 100.0/(SELECT sum(citycount) FROM t)
FROM t;

-- Creating View to store data for future use
CREATE VIEW [Percentlistingbycity] AS
WITH t(city, citycount) 
AS 
( 
    SELECT city, count(*) 
    FROM [Portfolio Project].[dbo].[AB_US_2020]
    GROUP BY city
)

