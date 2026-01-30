# Climbing Gym DA Project

I analyzed operational, membership, and engagement data from a climbing gym to identify opportunities to increase revenue and retention. Using SQL, Python, and Power BI, I delivered actionable recommendations on pricing strategy, class scheduling, and route setting.

## :page_facing_up: Project Overview

## :file_folder: The Dataset 
The dataset of this project contains x files in CSV format. </br>
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
    + membership_id: 
    + customer_id: 
    + membership_type:
    + price_per_month: 
    + start_date: date when membership started
    + end_date: full date when membership expired/was terminated
    + status: whether the membership is active at the time this analysis is carried out

+ `visits.csv`:
    + visit_id:
    + customer_id:
    + visit_date:
    + check_in_time: 
    + check_out_time: 

+ `classes.csv`:
    + class_id:
    + class_name:
    + level:
    + price:
    + instructor:
    + max_capacity:
    + class_date:

+ `class_attendance.csv`:
    + attendance_id:
    + class_id:
    + customer_id: 
    + attended: 

+ `routes.csv`:
    + route_id: 
    + route_type: 
    + grade:
    + wall_zone:
    + set_date: 
    + reset_date: 

+ `route_climbs.csv`:
    + climb_id:
    + route_id:
    + customer_id:
    + climb_date:
    + completed:

## :computer: Project Workflow
I separated raw data, cleaned views, and analytical views to ensure dashboard's KPIs were based on validated data while preserving the original tables.
After data profiling, cleaning views were created so that data:
-Had no erroneous duplicates 
-Had no mispelled values 
-Was correctly formatted
-Contained range of values in quantitative columns that made sense
**SQL views** were created in **BigQuery** to prepare analytical datasets for dashboarding.
**Power BI** was used to visualize key business metrics, including revenue trends, attendance behavior, and route popularity. Dashboard screenshots are included in the repository.

Route difficulties were normalized to a single grading system (French) to ensure consistent difficulty-level analysis. Bouldering grades originally recorded in the Hueco (V) scale were mapped explicitly in the cleaning layer.

During data validation, I identified visits referencing non-existent customers. These rows were excluded in the cleaning layer to enforce referential integrity between customers, memberships, and visits



This project analyzes operational and customer data from a climbing gym
to understand revenue, attendance patterns, route popularity, and customer churn.

### Tech Stack
- BigQuery (SQL): data cleaning & analytical views
- Python: churn prediction modeling
- Power BI: KPI dashboards

### Key Business Questions
- Which memberships generate the most revenue?
- When is the gym most crowded?
- What signals indicate customer churn?

### Data Modeling Approach
Raw data → Clean views → Analytical views → Dashboards

