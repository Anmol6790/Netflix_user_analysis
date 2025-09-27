# Netflix_user_analysis
Netflix User &amp; Content Analysis using Power BI &amp; R. Insights on user behavior, churn, subscriptions, and regional trends with interactive dashboards and visual analytics.
🎬 Netflix User Analytics Dashboard
📌 Project Summary

This project is an end-to-end Data Analytics solution combining Python (for data preparation & analysis) and Power BI (for dashboarding & storytelling).
The objective is to analyze Netflix user engagement, churn patterns, and content performance to provide data-driven recommendations for retention and growth.

🛠 Tech Stack
Python → Data Cleaning, Merging, Engagement & Churn Analysis
Power BI → Data Modeling, KPIs, Interactive Dashboards
CSV + PNG Outputs → Processed datasets & visual reports

🎯 Business Questions Addressed
What type of content do users prefer – Movies vs TV Shows?
Which subscription plan has the highest churn?
How does device usage (Mobile, Laptop, TV) affect engagement?
Which genres & regions should Netflix invest in for better ROI?

├── RAnalysis/
│   ├── Analysis1_load_merge.R       # Data loading & merging
│   ├── Analysis2_engagement.R       # Engagement analysis
│   ├── Analysis3_churn.R            # Churn analysis
│   ├── Analysis4_region.R           # Regional insights
│
├── Screenshots/
│   ├── Netflix_Logo_RGB.png
│   ├── Screenshot_cleaning_R.png
│   ├── Screenshot_churn_R.png
│   ├── Screenshot_powerBi_dashboard.png
│   ├── Screenshot_device_usage.png
│   ├── Screenshot_genre_analysis.png
│   ├── Screenshot_modelView.png
│
├── data/
│   ├── netflix_titles.csv
│   ├── user_activity_dataset.csv
│
├── outputs/
│   ├── avg_watch_by_device.csv/.png
│   ├── avg_watch_by_subscription.csv/.png
│   ├── churn_by_device.csv/.png
│   ├── churn_by_subscription.csv/.png
│   ├── churn_overall.csv/.png
│
├── netflix.pbix        # Power BI Dashboard
├── README.md           # Documentation
