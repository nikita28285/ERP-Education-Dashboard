ERP Education Dashboard

This project provides an education-focused analytics dashboard for users across the academic ecosystem (teachers, students, content creators, institutions, and admins).
It works similar to a learning platform like YouTube, where users can upload videos, post comments, and reply — and the system tracks engagement and activity.

The dashboard helps visualize and understand how users interact, where they come from, and what content performs well.

Features

State-wise → City-wise → Location-wise user analytics

User demographics: role, age, gender, qualification

Upcoming birthdays within the next 15 days

Content activity tracking:

Posts

Comments

Replies

Video uploads

Parent–child relationships to connect users, posts, and comments

SQL sub-procedures and joins used to build structured ERP data views

Tech Stack

SQL – data modeling, joins, stored procedures, relationships

Power BI – dashboard design & visual reporting

DAX – calculated fields (age, KPIs, measures)

Power BI Service – published live dashboard

## SQL Scripts

All SQL scripts for this project are available in the /sql folder.

They include:
- table creation scripts
- joins and relationships
- stored procedures
- KPI and reporting queries

This approach ensures reliable data flow and accurate reporting.

# Power BI Dashboard — ERP Education Project

This folder contains the Power BI files used to build the ERP Education Dashboard.

The dashboard analyzes users, content activity, roles, engagement, and key KPIs related to education platforms.

## Files Included

- `.pbix` file — main dashboard built in Power BI Desktop  
- placeholder file — used only to create this folder

## How the Dashboard Works

1. SQL data is prepared and cleaned in the database  
2. Power BI connects to SQL tables and views  
3. DAX is used to calculate measures such as:
   - Age calculation
   - KPI summaries
   - Engagement metrics
4. Visual reports display insights clearly for decision-making

## Reports Inside the Dashboard

- Geography report (State → City → Location)
- User insights (role, gender, age)
- Upcoming birthdays (next 15 days)
- Posts, comments, and replies activity

## Opening the Dashboard

Download the `.pbix` file and open it using **Power BI Desktop**.

If you do not have Power BI Desktop, it can be installed for free from Microsoft.

---

This folder is part of the complete ERP Education Dashboard project.

Dashboard

Published on Power BI Service.
