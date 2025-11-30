# Hospital Data Analysis (SQL)

This repository contains a collection of SQL queries for analyzing hospital encounter data, procedure trends, payer coverage, and patient readmissions. The goal of this project is to extract meaningful insights from the hospital database using clean, well-structured SQL.

---

## 📌 Overview

This project answers key analytical questions related to healthcare operations, including:

* Total encounters per year
* Encounter class distribution
* Encounter duration (over/under 24 hours)
* Payer coverage analysis
* Procedure frequency and cost insights
* Payer-level total claim cost
* Quarterly patient admissions
* 30-day patient readmission detection

---

## 🗂️ Files

* **HospitalQuery.sql** — Main SQL script containing all analysis queries.

---

## 📊 Key Analyses

### 1. Total Encounters Per Year

Counts all hospital encounters grouped by year.

### 2. Encounter Class Distribution

Calculates what percentage of total encounters fall into each class (ambulatory, outpatient, wellness, etc.).

### 3. Encounter Duration Analysis

Determines the percentage of encounters lasting under or over 24 hours.

### 4. Payer Coverage Insights

Identifies encounters with zero payer coverage and their overall percentage.

### 5. Procedure Analytics

* Top 10 most frequent procedures
* Top 10 highest average base cost procedures

### 6. Payer-Level Claim Cost

Average total claim cost for each payer.

### 7. Quarterly Admissions

Counts unique patient admissions per year and quarter.

### 8. Readmission Detection

Identifies patients readmitted within 30 days of a previous encounter.

---

## ⚙️ Technologies

* **SQL Server**
* **T-SQL Window Functions**
* **Joins, Aggregations, Date Functions**


