CREATE OR REPLACE VIEW climbing_gym.vw_monthly_revenue_by_membership AS
SELECT
  DATE_TRUNC(start_date, MONTH) AS revenue_month,
  membership_type,
  
  --Estimate Annual price per month
  SUM(
    CASE
      WHEN membership_type = 'Annual' THEN price_per_month / 12
      ELSE price_per_month
    END
  ) AS normalized_monthly_revenue,

  COUNT(DISTINCT membership_id) AS active_memberships

FROM climbing_gym.vw_memberships_clean

GROUP BY revenue_month, membership_type
ORDER BY revenue_month, membership_type;


CREATE OR REPLACE VIEW climbing_gym.vw_daily_attendance AS
SELECT
  DATE(check_in_time) AS visit_date_start,
  COUNT(DISTINCT visit_id) AS total_visits
FROM climbing_gym.vw_visits_clean
GROUP BY visit_date;


CREATE OR REPLACE VIEW climbing_gym.vw_daily_attendance_by_membership AS
SELECT
  DATE(check_in_time) AS visit_date,
  membership_type,
  COUNT(*) AS total_visits
FROM climbing_gym.vw_visits_clean
GROUP BY visit_date, membership_type
ORDER BY visit_date, membership_type;




CREATE OR REPLACE VIEW climbing_gym.vw_hourly_attendance AS
WITH daily_hourly AS (
  SELECT
    DATE(check_in_time) AS visit_date,
    EXTRACT(HOUR FROM check_in_time) AS hour_of_day,
    COUNT(*) AS visits
  FROM climbing_gym.vw_visits_clean
  GROUP BY visit_date, hour_of_day
)
SELECT
  hour_of_day,
  AVG(visits) AS avg_visits_per_hour
FROM daily_hourly
GROUP BY hour_of_day
ORDER BY hour_of_day;



CREATE OR REPLACE VIEW climbing_gym.vw_hourly_attendance_by_membership AS
WITH daily_hourly AS (
  SELECT
    DATE(check_in_time) AS visit_date,
    EXTRACT(HOUR FROM check_in_time) AS hour_of_day,
    membership_type,
    COUNT(*) AS visits
  FROM climbing_gym.vw_visits_clean
  GROUP BY visit_date, hour_of_day, membership_type
)
SELECT
  hour_of_day,
  membership_type,
  AVG(visits) AS avg_visits_per_hour
FROM daily_hourly
GROUP BY hour_of_day, membership_type
ORDER BY hour_of_day, membership_type;


