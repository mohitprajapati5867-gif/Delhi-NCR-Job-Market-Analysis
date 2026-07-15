
 -- DELHI NCR JOB MARKET ANALYSIS 2024
============================================================
-- SECTION 1: BASIC EXPLORATION
-- ============================================================

-- Total jobs by title
SELECT Job_Title,
COUNT(*) AS Job_Count,
ROUND(COUNT(*) * 100.0 / 300, 1) AS Pct_of_Total
FROM Delhi_NCR_Job_Market
GROUP BY Job_Title
ORDER BY Job_Count DESC

-- Jobs by location
SELECT Location,
COUNT(*) AS Job_Count,
ROUND(COUNT(*) * 100.0 / 300, 1) AS Pct_of_Total
FROM Delhi_NCR_Job_Market
GROUP BY Location
ORDER BY Job_Count DESC

-- Work mode distribution
SELECT Work_Mode,
COUNT(*) AS Job_Count,
ROUND(COUNT(*) * 100.0 / 300, 1)   AS Percentage
FROM Delhi_NCR_Job_Market
GROUP BY Work_Mode
ORDER BY Job_Count DESC

-- Industry-wise job count
SELECT Industry,
COUNT(*) AS Total_Jobs,
COUNT(CASE WHEN Company_Size = 'Large' THEN 1 END) AS Large_Company,
COUNT(CASE WHEN Company_Size = 'Mid' THEN 1 END) AS Mid_Company,
COUNT(CASE WHEN Company_Size = 'Startup' THEN 1 END) AS Startup
FROM Delhi_NCR_Job_Market
GROUP BY Industry
ORDER BY Total_Jobs DESC


-- ============================================================
-- SECTION 2: SKILLS ANALYSIS
-- ============================================================

-- How many jobs mention SQL?
SELECT 
COUNT(*) AS Jobs_With_SQL,
ROUND(COUNT(*) * 100.0 / 300, 1) AS Pct_of_Total
FROM Delhi_NCR_Job_Market
WHERE Skills LIKE '%SQL%'

-- Key skill frequency (top 10 skills)
SELECT Skill, COUNT(*) AS Job_Count,
]ROUND(COUNT(*) * 100.0 / 300, 1) AS Pct_of_Total
FROM (SELECT 'SQL' AS Skill FROM Delhi_NCR_Job_Market WHERE Skills LIKE '%SQL%'
UNION ALL
SELECT 'Excel' FROM Delhi_NCR_Job_Market WHERE Skills LIKE '%Excel%'
UNION ALL
SELECT 'Power BI' FROM Delhi_NCR_Job_Market WHERE Skills LIKE '%Power BI%'
UNION ALL
SELECT 'Python' FROM Delhi_NCR_Job_Market WHERE Skills LIKE '%Python%'
UNION ALL
SELECT 'Tableau' FROM Delhi_NCR_Job_Market WHERE Skills LIKE '%Tableau%'
UNION ALL
SELECT 'VBA' FROM Delhi_NCR_Job_Market WHERE Skills LIKE '%VBA%'
UNION ALL
SELECT 'Advanced Excel' FROM Delhi_NCR_Job_Market WHERE Skills LIKE '%Advanced Excel%'
UNION ALL
SELECT 'MS Access' FROM Delhi_NCR_Job_Market WHERE Skills LIKE '%MS Access%'
UNION ALL
SELECT 'DAX' FROM Delhi_NCR_Job_Market WHERE Skills LIKE '%DAX%'
UNION ALL
SELECT 'Statistics' FROM Delhi_NCR_Job_Market WHERE Skills LIKE '%Statistics%') AS SkillList
GROUP BY Skill
ORDER BY Job_Count DESC

-- Skills required per role
SELECT Job_Title,
COUNT(CASE WHEN Skills LIKE '%SQL%' THEN 1 END) AS SQL_Count,
COUNT(CASE WHEN Skills LIKE '%Excel%' THEN 1 END) AS Excel_Count,
COUNT(CASE WHEN Skills LIKE '%Power BI%' THEN 1 END) AS PowerBI_Count,
COUNT(CASE WHEN Skills LIKE '%Python%' THEN 1 END) AS Python_Count,
COUNT(CASE WHEN Skills LIKE '%Tableau%' THEN 1 END) AS Tableau_Count,
COUNT(CASE WHEN Skills LIKE '%VBA%' THEN 1 END) AS VBA_Count,
COUNT(*) AS Total_Jobs
FROM Delhi_NCR_Job_Market
GROUP BY Job_Title
ORDER BY Total_Jobs DESC

-- Jobs requiring SQL + Power BI together (most recruiter-friendly combo)
SELECT Job_Title,
Company_Name,
Location,
Experience_Required,
Work_Mode,
Skills
FROM Delhi_NCR_Job_Market
WHERE Skills LIKE '%SQL%' AND Skills LIKE '%Power BI%'
ORDER BY Job_Title, Location


-- ============================================================
-- SECTION 3: SALARY ANALYSIS
-- ============================================================

-- Average salary by role
SELECT Job_Title,
COUNT(*) AS Total_Jobs,
COUNT(CASE WHEN Salary_Shown = 1 THEN 1 END)  AS Jobs_With_Salary,             ---("Salary Shown= 1 means YES and 0 For No)
ROUND(AVG(CASE WHEN Salary_Shown = 1 THEN Salary_Min END), 0) AS Avg_Sal_Min,          ---("Salary Shown= 1 means YES and 0 For No)
ROUND(AVG(CASE WHEN Salary_Shown = 1 THEN Salary_Max END), 0) AS Avg_Sal_Max,        ---("Salary Shown= 1 means YES and 0 For No)
ROUND(AVG(CASE WHEN Salary_Shown = 1                                ---("Salary Shown= 1 means YES and 0 For No)
THEN (Salary_Min + Salary_Max) / 2.0 END), 0) AS Avg_Salary 
FROM Delhi_NCR_Job_Market
GROUP BY Job_Title
ORDER BY Avg_Salary DESC

-- Salary transparency by industry
SELECT Industry,
COUNT(*) AS Total_Jobs,
COUNT(CASE WHEN Salary_Shown = 1 THEN 1 END) AS Disclosed,                          ---("Salary Shown= 1 means YES and 0 For No)
ROUND(COUNT(CASE WHEN Salary_Shown = 1 THEN 1 END) * 100.0 / COUNT(*), 1) AS Disclosure_Rate_Pct,     ---("Salary Shown= 1 means YES and 0 For No)
ROUND(AVG(CASE WHEN Salary_Shown = 1 THEN (Salary_Min + Salary_Max) / 2.0 END), 0) AS Avg_Salary         ---("Salary Shown= 1 means YES and 0 For No)
FROM Delhi_NCR_Job_Market
GROUP BY Industry
ORDER BY Avg_Salary DESC

-- Salary range by work mode
SELECT Work_Mode,
COUNT(*) AS Jobs,
ROUND(AVG(CASE WHEN Salary_Shown= 1 THEN (Salary_Min+Salary_Max)/2.0 END), 0) AS Avg_Salary,   ---("Salary Shown= 1 means YES and 0 For No)
ROUND(MIN(CASE WHEN Salary_Shown= 1 THEN Salary_Min END), 0) AS Min_Salary,                ---("Salary Shown= 1 means YES and 0 For No)
ROUND(MAX(CASE WHEN Salary_Shown= 1 THEN Salary_Max END), 0) AS Max_Salary               ---("Salary Shown= 1 means YES and 0 For No)
FROM Delhi_NCR_Job_Market
GROUP BY Work_Mode
ORDER BY Avg_Salary DESC

-- ============================================================
-- SECTION 4: FRESHER-SPECIFIC ANALYSIS
-- ============================================================

-- Fresher-eligible jobs (0-2 years experience)
SELECT
COUNT(*) AS Fresher_Eligible_Jobs,
ROUND(COUNT(*) * 100.0 / 300, 1) AS Pct_of_Total
FROM Delhi_NCR_Job_Market
WHERE Experience_Required IN ('0-1 years','0-2 years','Fresher','1-2 years')

-- Best roles for freshers with salary
SELECT Job_Title,
Location,
Company_Name,
Industry,
Experience_Required,
Work_Mode,
Salary_Min,
Salary_Max,
Skills
FROM Delhi_NCR_Job_Market
WHERE Experience_Required IN ('0-1 years','0-2 years','Fresher') AND Salary_Shown = 1  ---("Salary Shown= 1 means YES and 0 For No)
ORDER BY Salary_Max DESC

-- Fresher jobs by location
SELECT Location,
COUNT(*) AS Fresher_Jobs,
ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Delhi_NCR_Job_Market
WHERE Experience_Required IN ('0-1 years','0-2 years','Fresher')), 1) AS Pct
FROM Delhi_NCR_Job_Market
WHERE Experience_Required IN ('0-1 years','0-2 years','Fresher')
GROUP BY Location
ORDER BY Fresher_Jobs DESC

--Top companies hiring freshers
SELECT TOP 10 Company_Name, Industry,
COUNT(*) AS Fresher_Openings
FROM Delhi_NCR_Job_Market
WHERE Experience_Required IN ('0-1 years','0-2 years','Fresher')
GROUP BY Company_Name, Industry
ORDER BY Fresher_Openings DESC

-- ============================================================
-- SECTION 5: ADVANCED ANALYSIS
-- ============================================================

-- Role × Location heatmap (cross-tab)
SELECT Job_Title,
SUM(CASE WHEN Location = 'Gurugram' THEN 1 ELSE 0 END) AS Gurugram,
SUM(CASE WHEN Location = 'Delhi' THEN 1 ELSE 0 END) AS Delhi,
SUM(CASE WHEN Location = 'Noida' THEN 1 ELSE 0 END) AS Noida,
SUM(CASE WHEN Location = 'Faridabad' THEN 1 ELSE 0 END) AS Faridabad,
SUM(CASE WHEN Location = 'Ghaziabad' THEN 1 ELSE 0 END) AS Ghaziabad,
COUNT(*) AS Grand_Total
FROM Delhi_NCR_Job_Market
GROUP BY Job_Title
ORDER BY Grand_Total DESC

-- Industry × Work Mode breakdown
SELECT Industry,
SUM(CASE WHEN Work_Mode = 'Onsite' THEN 1 ELSE 0 END) AS Onsite,
SUM(CASE WHEN Work_Mode = 'Hybrid' THEN 1 ELSE 0 END) AS Hybrid,
SUM(CASE WHEN Work_Mode = 'Remote' THEN 1 ELSE 0 END) AS Remote,
COUNT(*) AS Total
FROM Delhi_NCR_Job_Market
GROUP BY Industry
ORDER BY Total DESC

-- Company size vs average salary
SELECT Company_Size,
COUNT(*) AS Total_Jobs,
ROUND(AVG(CASE WHEN Salary_Shown=1         ---("Salary Shown= 1 means YES and 0 For No)
THEN (Salary_Min+Salary_Max)/2.0 END), 0) AS Avg_Salary,
COUNT(CASE WHEN Salary_Shown=1 THEN 0 END) AS Salary_Disclosed
FROM Delhi_NCR_Job_Market
GROUP BY Company_Size
ORDER BY Avg_Salary DESC


sp_help Delhi_NCR_Job_Market

-- Most common skill combinations (SQL + ?)
SELECT CASE 
WHEN Skills LIKE '%Python%'   AND Skills LIKE '%Power BI%' THEN 'SQL + Python + Power BI'
WHEN Skills LIKE '%Python%'   AND Skills LIKE '%Excel%'    THEN 'SQL + Python + Excel'
WHEN Skills LIKE '%Power BI%' AND Skills LIKE '%Excel%'    THEN 'SQL + Power BI + Excel'
WHEN Skills LIKE '%VBA%'      AND Skills LIKE '%Excel%'    THEN 'SQL + VBA + Excel'
WHEN Skills LIKE '%Tableau%'  AND Skills LIKE '%Excel%'    THEN 'SQL + Tableau + Excel'
ELSE 'Other SQL Combo'
END AS Skill_Combo,
COUNT(*) AS Job_Count,
ROUND(COUNT(*)*100.0/300,1) AS Pct_of_Total
FROM Delhi_NCR_Job_Market
WHERE Skills LIKE '%SQL%'
GROUP BY 
CASE 
WHEN Skills LIKE '%Python%'   AND Skills LIKE '%Power BI%' THEN 'SQL + Python + Power BI'
WHEN Skills LIKE '%Python%'   AND Skills LIKE '%Excel%'    THEN 'SQL + Python + Excel'
WHEN Skills LIKE '%Power BI%' AND Skills LIKE '%Excel%'    THEN 'SQL + Power BI + Excel'
WHEN Skills LIKE '%VBA%'      AND Skills LIKE '%Excel%'    THEN 'SQL + VBA + Excel'
WHEN Skills LIKE '%Tableau%'  AND Skills LIKE '%Excel%'    THEN 'SQL + Tableau + Excel'
ELSE 'Other SQL Combo'
END
ORDER BY Job_Count DESC

-- Jobs trend by month posted
SELECT 
FORMAT(Date_Posted, 'yyyy-MM')  AS Month,
COUNT(*) AS Jobs_Posted, COUNT(CASE WHEN Experience_Required IN ('0-1 years','0-2 years','Fresher') THEN 1 END) AS Fresher_Jobs
FROM Delhi_NCR_Job_Market
GROUP BY FORMAT(Date_Posted, 'yyyy-MM')
ORDER BY Month

-- ============================================================
-- END OF FILE
-- ============================================================
