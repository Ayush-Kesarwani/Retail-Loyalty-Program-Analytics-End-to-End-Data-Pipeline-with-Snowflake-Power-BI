# Retail-Loyalty-Program-Analytics-End-to-End-Data-Pipeline-with-Snowflake-Power-BI
📌 Project Overview

This project demonstrates the design and implementation of a complete data pipeline, starting from data generation to building an interactive Power BI dashboard. It simulates a retail loyalty program and provides insights into revenue, customer behavior, product performance, and regional sales.

The workflow covers:
Data Generation (Python) – Created realistic dummy data for:
Customers (loyalty tiers: Platinum, Gold, Silver, etc.)
Products (multiple categories)
Stores (various regions)
10 years of order history (2014–2024).

Cloud Data Warehouse (Snowflake ❄️)
Database, schema, and stage setup.
CSV upload using SnowSQL.
Role-based access control (users, permissions).
Data cleaning and preprocessing with SQL.

Data Visualization (Power BI)
Connected Snowflake to Power BI.
Designed a star schema model (fact + dimension tables).
Built calculated columns & measures in Power Query/DAX.
Developed dashboards for insights.

📊 Dashboard Insights
Revenue Trends: Nearly $45M in total orders over 10 years, led by SMB & Exclusive stores.
Customer Behavior: Most orders occur on weekdays; Platinum & Gold loyalty tiers dominate purchases.
Geographic Insights: North & South regions generate the highest sales.
Product Performance: Pets, Sports & Recreation, and Kitchen & Dining categories are top contributors.

🛠️ Tech Stack
Python – Data generation (Pandas, Faker)
Snowflake – Cloud data warehouse
SQL – Data cleaning, preprocessing
Power BI – Data modeling & dashboarding

🌟 Key Learnings
End-to-end workflow from data creation → cloud storage → visualization.
Hands-on experience with Snowflake security & governance.
Practical skills in data modeling, DAX, and dashboard design.
