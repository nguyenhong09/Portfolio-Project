/* 

Queries for Tableau Project

Data source: https://www.kaggle.com/kritikseth/us-airbnb-open-data

*/


-- Table 1_Percent of listings by city

SELECT city, COUNT(*) * 100.0 / SUM(COUNT(*)) OVER() listing_percent
FROM [Portfolio Project].[dbo].[AB_US_2020]
GROUP BY city

-- Table 2_Average price by room type

SELECT room_type, AVG(price) avg_price
FROM [Portfolio Project].[dbo].[AB_US_2020]
GROUP BY room_type

-- Table 3_Number of listings by room type

SELECT room_type, count (distinct(id)) listing_number
FROM [Portfolio Project].[dbo].[AB_US_2020]
GROUP BY room_type

-- Table 4_Correlation between total_reviews, availability_365 and price by city

SELECT city, SUM(number_of_reviews) total_reviews, sum(availability_365) availability, AVG(price) avg_price
FROM [Portfolio Project].[dbo].[AB_US_2020]
GROUP BY city


