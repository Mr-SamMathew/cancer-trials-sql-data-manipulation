# Clinical Trial Data Manipulation (SQL)

## Project Overview
This repository contains an end-to-end SQL data manipulation project evaluating **10,000 cancer clinical trials** (2020–2024). The goal of this analysis is to address real-world business requirements across Clinical Operations, Strategic Finance, and Oncology R&D teams using standard T-SQL, aggregate analysis, and advanced window functions.

---

## Database Schema (DDL)
The table structure and data types defined in SQL Server (`dbo.cancer_trials_2020_2024`):

```sql
CREATE TABLE [dbo].[cancer_trials_2020_2024](
    [nct_id]             [nvarchar](50)   NOT NULL,
    [study_title]        [nvarchar](300)  NOT NULL,
    [study_status]       [nvarchar](50)   NOT NULL,
    [study_type]         [nvarchar](50)   NOT NULL,
    [phase]              [nvarchar](1800) NOT NULL,
    [conditions]         [nvarchar](max)  NOT NULL,
    [interventions]      [nvarchar](1800) NULL,
    [intervention_types] [nvarchar](1800) NULL,
    [lead_sponsor]       [nvarchar](max)  NOT NULL,
    [sponsor_type]       [nvarchar](max)  NULL,
    [enrollment]         [int]            NOT NULL,
    [sex]                [nvarchar](50)   NOT NULL,
    [start_date]         [nvarchar](50)   NOT NULL,
    [completion_date]    [nvarchar](50)   NOT NULL,
 CONSTRAINT [PK_cancer_trials_2020_2024] PRIMARY KEY CLUSTERED ([nct_id] ASC)
);

## Key SQL Concepts Applied

*Aggregate Summaries & Grouping: Grouped multi-variable aggregations (`COUNT`, `SUM`, `AVG`, `MAX`, `ROUND`) to evaluate sponsor performance and participant metrics.
*String Pattern Matching & Wildcards: Used pattern filtering (`LIKE '%...%'`) for condition text searching and multi-intervention string parsing.
*Data Quality & Handling Nulls: Cleaned incomplete metadata by explicitly filtering out untracked study phases (`IS NULL` or `'Not Specified'`).
*Window Functions: Applied analytic window functions (`ROW_NUMBER() OVER()`, `AVG() OVER()`, `SUM() OVER(PARTITION BY... ORDER BY...)`) for sequential tracking, benchmark comparisons, and running totals.


## Repository Structure

cancer-trials-sql-analysis/
├── data/
│   └── cancer_trials_2020_2024.csv    # Raw dataset (10,000 clinical trial records)
├── sql/
│   └── cancer_trials_analysis.sql     # Formatted production SQL queries with business contexts
└── README.md                          # Project documentation and summary
