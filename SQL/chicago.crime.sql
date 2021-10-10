-- Total # of crimes recorded 
SELECT COUNT(*) AS Crime_Count
FROM ChicagoCrimeData;

-- Community areas with per capita income level < 11000
SELECT COMMUNITY_AREA_NAME, PER_CAPITA_INCOME
FROM ChicagoCensusData 
WHERE PER_CAPITA_INCOME < 11000;

-- Case #s for crimes involving minors
SELECT CASE_NUMBER, DESCRIPTION
FROM ChicagoCrimeData
WHERE DESCRIPTION LIKE "%MINOR%";

-- List all kidnapping crimes involving a child
SELECT CASE_NUMBER, DESCRIPTION
FROM ChicagoCrimeData
WHERE PRIMARY_TYPE = "KIDNAPPING"
AND DESCRIPTION LIKE "%CHILD%";

-- Type of crimes recorded at school 
SELECT PRIMARY_TYPE, DESCRIPTION, LOCATION_DESCRIPTION 
FROM ChicagoCrimeData
WHERE LOCATION_DESCRIPTION LIKE "%SCHOOL%";

-- Average Safety for all Types of Schools
SELECT ElementaryMiddleorHighSchool, ROUND(AVG(SAFETY_SCORE), 2) Avg_Safety_Score
FROM ChicagoPublicSchools
GROUP BY ElementaryMiddleorHighSchool;

-- Top 5 community areas with highest % of households below poverty line
SELECT COMMUNITY_AREA_NAME, PERCENT_HOUSEHOLDS_BELOW_POVERTY
FROM ChicagoCensusData
ORDER BY PERCENT_HOUSEHOLDS_BELOW_POVERTY DESC LIMIT 5;

-- Top 3 crime prone areas
SELECT c.COMMUNITY_AREA_NAME, COUNT(*) Crime_Count
FROM ChicagoCensusData c, ChicagoCrimeData d
WHERE c.COMMUNITY_AREA_NUMBER = d.COMMUNITY_AREA_NUMBER
GROUP BY c.COMMUNITY_AREA_NAME
ORDER BY Crime_Count DESC Limit 3;

-- Use of sub-query to find the name of the community area with the highest hardship index
SELECT COMMUNITY_AREA_NAME, HARDSHIP_INDEX
FROM ChicagoCensusData
WHERE (SELECT MAX(HARDSHIP_INDEX) FROM ChicagoCensusData) = HARDSHIP_INDEX;

-- Sub-query to determine the Community Area Name with the most number of crimes
SELECT COMMUNITY_AREA_NAME, COUNT(*) Crime_Count
FROM ChicagoCensusData c INNER JOIN ChicagoCrimeData d
ON c.COMMUNITY_AREA_NUMBER = d.COMMUNITY_AREA_NUMBER
GROUP BY c.COMMUNITY_AREA_NAME
ORDER BY Crime_Count Desc LIMIT 1;