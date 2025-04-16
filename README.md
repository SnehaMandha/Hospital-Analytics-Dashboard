# Hospital-Analytics-Dashboard
A complete SQL + Power BI project designed to simulate clinical data analysis in a hospital setting. This project focuses on analyzing patient flows, departmental performance, diagnoses, readmissions, and staff distribution using real-world healthcare analytics techniques.

# 📌 Project Overview

Objective: To analyze and visualize hospital operations using structured healthcare data across patients, admissions, diagnoses, treatments, staff, and readmissions.

Tools Used:
MySQL: For data modeling and writing advanced SQL queries
Power BI: For building interactive dashboards and visuals
CSV Files: Simulated healthcare datasets
User Role Simulated: Clinical Analyst / Healthcare BI Developer

# 📊 Power BI Dashboard Features

Admissions by Department & Staff Role (stacked bar)
Average Length of Stay by Department (bar + calculated measure)
Monthly Admissions Trend (line chart)
Top 5 Diagnoses by Frequency (bar chart)
Readmission Reasons (pie chart)
ICD Code Distribution (bar chart)
KPI Cards for Total Patients, Total Admissions, Average Stay
Slicers for Gender, Department, Staff Role, and Date

# 🧠 SQL Capabilities Demonstrated

Basic Queries (SELECT, WHERE, GROUP BY, ORDER BY)
Joins across normalized tables (JOIN, LEFT JOIN)
Aggregations (COUNT, AVG, MAX, MIN)
Conditional logic (CASE statements)
Subqueries and correlated subqueries
Common Table Expressions (CTEs)
Window Functions: RANK(), ROW_NUMBER(), COUNT() OVER, MOVING AVERAGE

# 📁 Datasets

All CSVs are synthetic but mimic real clinical structures:
patients.csv: Demographics and contact info
admissions.csv: Admission/discharge records
diagnoses.csv: ICD-based diagnosis codes
treatments.csv: Procedures administered
staff.csv: Doctors, nurses, and department affiliations
readmissions.csv: Readmit dates and reasons

# 🚀 How to Run

SQL:
Import CSV files into MySQL using pgAdmin or CLI
Run schema.sql to create tables
Use analysis_queries.sql to explore data

Power BI:
Open hospital_dashboard.pbix
View or customize visuals
Use slicers to explore metrics dynamically
