# 📊 Delhi NCR Job Market Analysis 2024

> **"Maine 300+ Data Analyst job postings analyze kiye — kyunki data hi jawab deta hai"**

[![Excel](https://img.shields.io/badge/Excel-Advanced-green)](https://github.com/mohitprajapati5867-gif)
[![SQL](https://img.shields.io/badge/SQL-SSMS-blue)](https://github.com/mohitprajapati5867-gif)
[![Power BI](https://img.shields.io/badge/Power%20BI-Dashboard-yellow)](https://github.com/mohitprajapati5867-gif)

---

## 🎯 Project Overview

As a Data Analyst fresher in Delhi NCR, I faced a common problem — applying to 50+ jobs with almost no response. Instead of giving up, I decided to **analyze the job market itself**.

This project analyzes **300 Data Analyst job postings** from Delhi NCR (Naukri.com) to uncover:
- Which skills are actually in demand?
- Which companies hire freshers?
- What salary can a fresher expect?
- Which location has the most opportunities?

---

## 📁 Project Structure

```
Delhi-NCR-Job-Market-Analysis/
│
├── data/
│   └── Delhi_NCR_Job_Market_2024.csv      # 300 job postings dataset
│
├── excel/
│   └── Delhi_NCR_Job_Market_Analysis.xlsx # 5-sheet Excel analysis
│       ├── Dashboard Summary
│       ├── Skills Analysis
│       ├── Salary Analysis (COUNTIFS, AVERAGEIFS, MINIFS, MAXIFS)
│       ├── Raw Data
│       └── Pivot Analysis
│
├── sql/
│   └── Delhi_NCR_Job_Market_Analysis.sql  # 20 queries across 6 sections
│
├── powerbi/
│   └── screenshots/                        # Dashboard screenshots
│
└── README.md
```

---

## 📊 Key Findings

| Metric | Finding |
|---|---|
| 🥇 Most In-Demand Skill | **SQL** — 100% of all job postings |
| 🥈 Second Most In-Demand | **Excel / Advanced Excel** — 79% |
| 🥉 Third Most In-Demand | **Power BI** — 57% |
| 📍 Top Hiring City | **Gurugram** — 35% of all jobs |
| 🏢 Top Hiring Sector | **E-commerce** — 37 openings |
| 👶 Fresher Eligible Jobs | **52%** of all postings |
| 🏠 Remote Jobs | Only **16%** — office culture dominates |
| 💰 Avg Fresher Salary | **₹3.8L – ₹5.1L** (Data Analyst) |
| 💼 Highest Paying Role | **Analytics Analyst** — ₹7L avg |

---

## 🛠 Tools Used

| Tool | Purpose |
|---|---|
| **Excel** | Data cleaning, COUNTIFS, AVERAGEIFS, MINIFS, MAXIFS, Pivot tables |
| **SQL (SSMS)** | 20 queries — skills analysis, salary analysis, fresher jobs, cross-tabs |
| **Power BI** | 4-page interactive dashboard with DAX measures |
| **Python (pandas)** | Dataset creation, skill frequency analysis |

---

## 📈 Excel Analysis Highlights

The Excel workbook contains **5 sheets** with full formula-based analysis:

**Salary Analysis Sheet formulas used:**
```excel
-- Count jobs where salary is disclosed
=COUNTIF('Raw Data'!I4:I303,"Yes")

-- Average salary for a specific role
=AVERAGEIFS('Raw Data'!F4:F303,'Raw Data'!B4:B303,"Data Analyst",'Raw Data'!I4:I303,"Yes")

-- Minimum salary for a role
=MINIFS('Raw Data'!F4:F303,'Raw Data'!B4:B303,"Data Analyst",'Raw Data'!I4:I303,"Yes")

-- Maximum salary for a role
=MAXIFS('Raw Data'!G4:G303,'Raw Data'!B4:B303,"Business Analyst",'Raw Data'!I4:I303,"Yes")

-- Salary midpoint calculation
=(AVERAGEIFS(Salary_Min,...) + AVERAGEIFS(Salary_Max,...)) / 2
```

---

## 🗄 SQL Analysis Highlights

**20 queries across 6 sections:**

```sql
-- Top skills by frequency
SELECT Skill, COUNT(*) AS Job_Count,
    ROUND(COUNT(*) * 100.0 / 300, 1) AS Pct_of_Total
FROM (
    SELECT 'SQL' AS Skill FROM JobPostings WHERE Skills LIKE '%SQL%'
    UNION ALL
    SELECT 'Power BI' FROM JobPostings WHERE Skills LIKE '%Power BI%'
    -- ... more skills
) AS SkillList
GROUP BY Skill
ORDER BY Job_Count DESC;

-- Fresher eligible jobs
SELECT Job_Title, Company_Name, Location, Salary_Min, Salary_Max
FROM JobPostings
WHERE Experience_Required IN ('0-1 years','0-2 years','Fresher')
  AND Salary_Shown = 'Yes'
ORDER BY Salary_Max DESC;
```

---

## 📊 Power BI Dashboard

4-page interactive dashboard with:
- **Page 1:** Overview — KPI cards (300 jobs, 52% fresher, ₹4.9L avg salary)
- **Page 2:** Skills Analysis — Top 10 skills bar chart
- **Page 3:** Location & Company — Map + industry breakdown
- **Page 4:** Salary Insights — Role-wise salary range chart

*(Screenshots in `/powerbi/screenshots/` folder)*

---

## 💡 Insights for Freshers

Based on 300 job postings, here's what Delhi NCR recruiters actually want:

1. **Master SQL first** — it's in 100% of postings, not Python
2. **Excel is non-negotiable** — 79% jobs require it
3. **Power BI > Tableau** — 57% vs 27% in Delhi NCR
4. **Gurugram is the hub** — 35% of all jobs are here
5. **Don't only apply to "Data Analyst"** — MIS Executive, Reporting Analyst, Business Analyst have same skills but 3x more openings
6. **52% jobs are fresher-eligible** — market is open, target right roles

---

## 🔗 Connect With Me

- **LinkedIn:** [linkedin.com/in/mr-mohit-691951296](https://linkedin.com/in/mr-mohit-691951296)
- **GitHub:** [github.com/mohitprajapati5867-gif](https://github.com/mohitprajapati5867-gif)

---

## 📌 Part of Series

This project is **Part 3** of my LinkedIn series:
**"From Zero to Data Analyst — Solving Real Problems Until I Get Hired"**

Follow along on LinkedIn for weekly data analysis projects!

