
/*

 Row Count to confirm all records from files had been imported

*/

SELECT
		COUNT(URN) [Rows],
		COUNT(DISTINCT URN) [Unique URN]
FROM Funding2021
-- 20168 records

SELECT
		COUNT(URN) [Rows],
		COUNT(DISTINCT URN) [Unique URN]
FROM Funding2022
-- 20152 records

SELECT
		COUNT(URN) [Rows],
		COUNT(DISTINCT URN) [Unique URN]
FROM Funding2023
-- 20177 records

SELECT
		COUNT(URN) [Rows],
		COUNT(DISTINCT URN) [Unique URN]
FROM Funding2024
-- 20181 records

SELECT
		COUNT(URN) [Rows],
		COUNT(DISTINCT URN) [Unique URN]
FROM Funding2025
-- 20150 records


/*

 Create View that combines each annual table into one

*/

CREATE VIEW Funding_Combined
AS
SELECT 
		'2020-2021' TimePeriod,
		Local_Authority_Name,
		URN,
		School_Name,
		Phase,
		Allocation_per_Pupil,
		Total_Number_of_Pupils,
		Total_Funding
FROM Funding2021
UNION ALL
SELECT 
		'2021-2022' TimePeriod,
		Local_Authority_Name,
		URN,
		School_Name,
		Phase,
		Allocation_per_Pupil,
		Total_Number_of_Pupils_Rounded,
		Total_Funding
FROM Funding2022
UNION ALL
SELECT 
		'2022-2023' TimePeriod,
		LA_Name,
		School_URN,
		School_Name,
		School_Phase,
		Allocation_per_Pupil,
		Total_Number_of_Pupils,
		Total_Funding
FROM Funding2023
UNION ALL
SELECT 
		'2023-2024' TimePeriod,
		LA_Name,
		School_URN,
		School_Name,
		School_Phase,
		Allocation_per_Pupil,
		Total_Number_of_Pupils,
		Total_Funding
FROM Funding2024
UNION ALL
SELECT 
		'2024-2025' TimePeriod,
		LA_Name,
		School_URN,
		School_Name,
		Education_Phase,
		Allocation_per_Pupil,
		Total_Number_of_Pupils,
		Total_Funding
FROM Funding2025


/*

 Total Funding by Year

*/

SELECT 
		TimePeriod,
		SUM(CONVERT(decimal(10,2), Total_Funding))/1000000000 [Total_Funding (£B)]
FROM Funding_Combined
GROUP BY TimePeriod
ORDER BY TimePeriod


/*

 List all Local Authority Names and School Phase to check for duplication

*/

-- Local Authority
SELECT
		DISTINCT Local_Authority_Name
FROM Funding_Combined
ORDER BY Local_Authority_Name

-- School Phase
SELECT
		DISTINCT Phase
FROM Funding_Combined
ORDER BY Phase


/*

 % Difference in Total Funding by Year from Previous Year

*/

WITH TF_2021 AS (
	SELECT 
			SUM(Total_Funding) Total_Funding_2021
	FROM Funding2021
), TF_2022 AS (
	SELECT 
			SUM(Total_Funding) Total_Funding_2022
	FROM Funding2022
), TF_2023 AS (
	SELECT 
			SUM(Total_Funding) Total_Funding_2023
	FROM Funding2023
), TF_2024 AS (
	SELECT 
			SUM(Total_Funding) Total_Funding_2024
	FROM Funding2024
), TF_2025 AS (
	SELECT 
			SUM(Total_Funding) Total_Funding_2025
	FROM Funding2025
)
SELECT 
		CONVERT(decimal(5,1), (TF_2022.Total_Funding_2022-TF_2021.Total_Funding_2021)*100/TF_2021.Total_Funding_2021) [% Diff Total Funding 2021-22],
		CONVERT(decimal(5,1), (TF_2023.Total_Funding_2023-TF_2022.Total_Funding_2022)*100/TF_2022.Total_Funding_2022) [% Diff Total Funding 2022-23],
		CONVERT(decimal(5,1), (TF_2024.Total_Funding_2024-TF_2023.Total_Funding_2023)*100/TF_2023.Total_Funding_2023) [% Diff Total Funding 2023-24],
		CONVERT(decimal(5,1), (TF_2025.Total_Funding_2025-TF_2024.Total_Funding_2024)*100/TF_2024.Total_Funding_2024) [% Diff Total Funding 2024-25]
FROM TF_2021
CROSS JOIN TF_2022
CROSS JOIN TF_2023
CROSS JOIN TF_2024
CROSS JOIN TF_2025


/*

 Average Allocation per Pupil by Year and Local Authority

*/

WITH AVERAGE_APP AS (
SELECT 
		TimePeriod,
		Local_Authority_Name,
		URN,
		Total_Number_of_Pupils,
		Allocation_per_Pupil,
		PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY Allocation_per_Pupil) OVER(PARTITION BY TimePeriod, Local_Authority_Name) Avg_Allocation_per_Pupil
FROM Funding_Combined
)
SELECT 
		TimePeriod [Academic Year],
		Local_Authority_Name [Local Authority],
		COUNT(URN) [Schools],
		SUM(Total_Number_of_Pupils) [Total Number of Pupils],
		ROUND(AVG(Avg_Allocation_per_Pupil), 0) [Avg Allocation per Pupil],
		RANK() OVER(PARTITION BY TimePeriod ORDER BY CONVERT(int, AVG(Avg_Allocation_per_Pupil)) DESC) [Rank]
FROM AVERAGE_APP
WHERE URN NOT IN (100000, 144638)
GROUP BY TimePeriod, Local_Authority_Name
ORDER BY TimePeriod, 6, Local_Authority_Name


/*

 Difference in % Change in Allocation per Pupil from Previous Year vs Inflation

*/

WITH AVERAGE_APP_2021 AS (
SELECT 
		CASE WHEN Phase = 'Primary' THEN '1. Primary & Middle Deemed Primary'
			WHEN Phase = 'Middle deemed primary' THEN '1. Primary & Middle Deemed Primary'
			WHEN Phase = 'Secondary' THEN '2. Secondary & Middle Deemed Secondary'
			WHEN Phase = 'Middle deemed secondary' THEN '2. Secondary & Middle Deemed Secondary'
			WHEN Phase = 'All-through' THEN '3. All-through' END Phase,
		Local_Authority_Name,
		Allocation_per_Pupil,
		URN,
		PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY Allocation_per_Pupil) OVER(PARTITION BY Phase) Avg_Allocation_per_Pupil
FROM Funding2021 
), AVERAGE_APP_2022 AS (
SELECT 
		CASE WHEN Phase = 'Primary' THEN '1. Primary & Middle Deemed Primary'
			WHEN Phase = 'Middle deemed primary' THEN '1. Primary & Middle Deemed Primary'
			WHEN Phase = 'Secondary' THEN '2. Secondary & Middle Deemed Secondary'
			WHEN Phase = 'Middle deemed secondary' THEN '2. Secondary & Middle Deemed Secondary'
			WHEN Phase = 'All-through' THEN '3. All-through' END Phase,
		Local_Authority_Name,
		Allocation_per_Pupil,
		URN,
		PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY Allocation_per_Pupil) OVER(PARTITION BY Phase) Avg_Allocation_per_Pupil
FROM Funding2022 
), AVERAGE_APP_2023 AS (
SELECT 
		CASE WHEN School_Phase = 'Primary' THEN '1. Primary & Middle Deemed Primary'
			WHEN School_Phase = 'Middle deemed primary' THEN '1. Primary & Middle Deemed Primary'
			WHEN School_Phase = 'Secondary' THEN '2. Secondary & Middle Deemed Secondary'
			WHEN School_Phase = 'Middle deemed secondary' THEN '2. Secondary & Middle Deemed Secondary'
			WHEN School_Phase = 'All-through' THEN '3. All-through' END Phase,
		LA_Name,
		Allocation_per_Pupil,
		School_URN,
		PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY Allocation_per_Pupil) OVER(PARTITION BY School_Phase) Avg_Allocation_per_Pupil
FROM Funding2023 
), AVERAGE_APP_2024 AS (
SELECT 
		CASE WHEN School_Phase = 'Primary' THEN '1. Primary & Middle Deemed Primary'
			WHEN School_Phase = 'Middle deemed primary' THEN '1. Primary & Middle Deemed Primary'
			WHEN School_Phase = 'Secondary' THEN '2. Secondary & Middle Deemed Secondary'
			WHEN School_Phase = 'Middle deemed secondary' THEN '2. Secondary & Middle Deemed Secondary'
			WHEN School_Phase = 'All-through' THEN '3. All-through' END Phase,
		LA_Name,
		Allocation_per_Pupil,
		School_URN,
		PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY Allocation_per_Pupil) OVER(PARTITION BY School_Phase) Avg_Allocation_per_Pupil
FROM Funding2024 
), AVERAGE_APP_2025 AS (
SELECT 
		CASE WHEN Education_Phase = 'Primary' THEN '1. Primary & Middle Deemed Primary'
			WHEN Education_Phase = 'Middle (deemed primary)' THEN '1. Primary & Middle Deemed Primary'
			WHEN Education_Phase = 'Secondary' THEN '2. Secondary & Middle Deemed Secondary'
			WHEN Education_Phase = 'Middle (deemed secondary)' THEN '2. Secondary & Middle Deemed Secondary'
			WHEN Education_Phase = 'All-through' THEN '3. All-through' END Phase,
		LA_Name,
		Allocation_per_Pupil,
		School_URN,
		PERCENTILE_CONT(0.5) WITHIN GROUP(ORDER BY Allocation_per_Pupil) OVER(PARTITION BY Education_Phase) Avg_Allocation_per_Pupil
FROM Funding2025 
)
SELECT 
		F21.Phase [Education Phase],
		CONVERT(decimal(5,2), (((F22.Avg_Allocation_per_Pupil - F21.Avg_Allocation_per_Pupil)*100)/F21.Avg_Allocation_per_Pupil)-9.5) [2022],
		CONVERT(decimal(5,2), (((F23.Avg_Allocation_per_Pupil - F22.Avg_Allocation_per_Pupil)*100)/F22.Avg_Allocation_per_Pupil)-6.8) [2023],
		CONVERT(decimal(5,2), (((F24.Avg_Allocation_per_Pupil - F23.Avg_Allocation_per_Pupil)*100)/F23.Avg_Allocation_per_Pupil)-2.2) [2024],
		CONVERT(decimal(5,2), (((F25.Avg_Allocation_per_Pupil - F24.Avg_Allocation_per_Pupil)*100)/F24.Avg_Allocation_per_Pupil)-3.8) [2025]
FROM
(SELECT 
		Phase,
		AVG(Avg_Allocation_per_Pupil) Avg_Allocation_per_Pupil
FROM AVERAGE_APP_2021
GROUP BY Phase
) F21
LEFT JOIN
(SELECT 
		Phase,
		AVG(Avg_Allocation_per_Pupil) Avg_Allocation_per_Pupil
FROM AVERAGE_APP_2022
GROUP BY Phase
) F22
	ON F21.Phase = F22.Phase
LEFT JOIN
(SELECT 
		Phase,
		AVG(Avg_Allocation_per_Pupil) Avg_Allocation_per_Pupil
FROM AVERAGE_APP_2023
GROUP BY Phase
) F23
	ON F22.Phase = F23.Phase
LEFT JOIN
(SELECT 
		Phase,
		AVG(Avg_Allocation_per_Pupil) Avg_Allocation_per_Pupil
FROM AVERAGE_APP_2024
GROUP BY Phase
) F24
	ON F23.Phase = F24.Phase
LEFT JOIN
(SELECT 
		Phase,
		AVG(Avg_Allocation_per_Pupil) Avg_Allocation_per_Pupil
FROM AVERAGE_APP_2025
GROUP BY Phase
) F25
	ON F24.Phase = F25.Phase
WHERE F21.Phase IS NOT NULL
ORDER BY F21.Phase
