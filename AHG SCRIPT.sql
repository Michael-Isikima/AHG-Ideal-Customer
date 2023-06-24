
---AHG query script
-- Selecting colums
SELECT DG.EnglishCountryRegionName,
FI.SalesAmount,
FI.OrderQuantity,
DM.CustomerKey,
DM.Gender,
DM.MaritalStatus,
DM.YearlyIncome,
DM.TotalChildren,
DM.EnglishEducation,
CASE													 -- Creating salary segments
	WHEN [YearlyIncome] BETWEEN 10000 AND 50000 THEN 'Segment A'
	WHEN [YearlyIncome] BETWEEN 50001 AND 100000 THEN 'Segment B'
	WHEN [YearlyIncome] >= 100001 THEN 'Segment C'
	END AS Salary_Segment,
CASE												-- Creating children categorization
	WHEN [TotalChildren] BETWEEN 0 AND 1 THEN 'Low'
	WHEN [TotalChildren] BETWEEN 2 AND 3 THEN 'Moderate'
	WHEN [TotalChildren] BETWEEN 4 AND 5 THEN 'High'
	END AS Children_Category,

CASE [EnglishCountryRegionName]								--Continent Categorization
	WHEN 'Australia' THEN 'Australia'
	WHEN 'United States' THEN 'North America'
	WHEN 'Canada' THEN 'North America'
	WHEN 'Germany' THEN 'Europe'
	WHEN 'France' THEN 'Europe'
	WHEN 'United Kingdom' THEN 'Europe'
END AS Continent

FROM [dbo].[DimCustomer] DM									-- Joining Tables
JOIN [dbo].[FactInternetSales] FI
ON DM.CustomerKey = FI.CustomerKey
JOIN [dbo].[DimGeography] DG
ON DM.GeographyKey = DG.GeographyKey