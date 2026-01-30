# Climbing Gym Revenue. Data Analytics Project

I analyzed operational, membership, and engagement data from a climbing gym to identify opportunities to increase revenue and retention. Using SQL, Python, and Power BI, I delivered actionable recommendations on pricing strategy, membership promotion, and customer engagement.

## :page_facing_up: Project Overview

### The Climbing Gym 
The synthetic data generated for this project contains realistic observations of a climbing gym during a period of three years (2021-2023). This gym opens from 8:00h until 22:00h and offers three types of membership:
- **Annual**: Unlimited acces for 12 months. *780€/year*
- **Monthly**: Unlimited access during the active month. *75€/month*
- **Punch card**: 10 visits per card. *120€/card*


### Objective 
To understand how membership types, attendance behavior, and facility usage impact revenue and customer churn, in order to identify opportunities to improve this particular climbing gym’s business strategy.

### Specific Business Questions
- Is there a seasonal pattern of attendance through the year?
- Which membership types generate the most revenue?
- When is the gym most crowded? By which type of members?
- What signals indicate customer churn?

## :file_folder: The Dataset 
The dataset of this project contains 3 files in CSV format. </br>
+ `customers.csv`:
    + customer_id: customer identification code
    + first_name 
    + last_name 
    + gender
    + date_of_birth
    + skill_level: climbing level of the customer (Beginner/Intermediate/Advanced)
    + home_city: city where the customer lives
    + signup_date: when the customer first signed up

+ `memberships.csv`:
    + membership_id 
    + customer_id 
    + membership_type
    + price_per_month 
    + start_date: date when membership started
    + end_date: full date when membership expired/was terminated
    + status: whether the membership is active at the time this analysis is carried out

+ `visits.csv`:
    + visit_id
    + customer_id
    + visit_date
    + check_in_time 
    + check_out_time 




## :computer: Project Workflow
I separated raw data, cleaned views, and analytical views to ensure dashboard's KPIs were based on validated data while preserving the original tables.
First of all, cleaning views were created so that data: had no duplicates, had no mispelled values, was correctly formatted, contained range of values in quantitative columns that made sense. 
Secondly, SQL views were created in BigQuery to prepare analytical datasets for dashboarding.
Finally, Power BI was used to visualize key business metrics, including revenue trends, attendance behavior, and route popularity. Dashboard screenshots are included in the repository.


### Tech Stack Summary
- BigQuery (SQL): data cleaning & analytical views
- Power BI: KPI dashboards
- Python: churn prediction modeling (in process)
