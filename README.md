
# COVID Vaccination Analytics

This project demonstrates an end-to-end **ETL and Analytics pipeline** for Covid-19 vaccination data using **MySQL**.  
It includes **data staging**, **schema design**, **data transformation**, **loading into final tables**, and **analytical queries** for insights.

---

## 📌 Project Overview

- **Dataset:** Covid-19 country vaccinations and manufacturer data.
- **Tools Used:** MySQL (Workbench), CSV files, SmartDraw for ER Diagram.
- **ETL Process:** Extract data from CSV → Load into staging tables → Transform and insert into final normalized tables → Perform analytics.
- **Objective:** Build a structured database to analyze total vaccinations, vaccines used, daily trends, and manufacturer contributions.

---

## 📁 Project Structure

covid-vaccination-analytics/
├── schema.sql                 # All CREATE TABLE & INSERT scripts
├── staging_data/
│   ├── country_vaccinations.csv
│   ├── country_vaccinations_by_manufacturer.csv
├── queries.sql                # All SELECT and ANALYTICAL queries
├── ER_diagram.png             # ER Diagram image
└── README.md                  # Project documentation

---

## ⚙️ Steps Performed

1️⃣ **Database & Staging:**  
- Created staging tables ('staging_vaccinations`, `staging_manufacturer')  
- Loaded raw CSV data using 'LOAD DATA LOCAL INFILE'

2️⃣ **Schema Design:**  
- Designed final tables:  
  - `countries` — stores country metadata  
  - `vaccines` — vaccine details  
  - `vaccinations` — vaccination records  
  - `vaccinations_by_manufacturer` — manufacturer-wise doses

3️⃣ **ETL Logic:**  
- Transformed multi-vaccine rows using `SUBSTRING_INDEX` to split vaccine strings  
- Inserted normalized records into final tables with proper `country_id` & `vaccine_id`

4️⃣ **Analytics:**  
- Queried daily trends, vaccine usage stats, manufacturer share, and running totals.

---

## 🗂️ ER Diagram

**Entities:**  
- `countries (PK)`  
- `vaccines (PK)`  
- `vaccinations (FK: country_id, vaccine_id)`  
- `vaccinations_by_manufacturer (FK: country_id, vaccine_id)`

**Relationships:**  
- One country → many vaccinations  
- One vaccine → many vaccinations  
- `vaccinations_by_manufacturer` connects country & vaccine with total doses.

---

## ✅ Key Queries

- Daily total vaccinations by country  
- Top vaccines used globally  
- Manufacturer-wise total doses for a country  
- Running total and trends for India.

---

## 📌 How to Run

1. Clone this repo.
2. Create the database `covid_analytics_db`.
3. Run `schema.sql` to create tables.
4. Load CSV files into staging tables.
5. Run `queries.sql` for transformations & analytics.

---

## 📢 Conclusion

This project is a **solid demonstration of ETL + SQL + Data Modeling** for a real-world Covid dataset.  
It highlights **schema design**, **foreign keys**, **data transformation**, and **insights generation** — useful for interviews and hands-on SQL practice.

---


