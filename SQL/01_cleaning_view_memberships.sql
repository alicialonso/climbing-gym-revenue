CREATE OR REPLACE VIEW climbing_gym.vw_memberships_clean AS
SELECT
  membership_id,
  customer_id,
  membership_type,
  start_date,
  end_date,
  monthly_price,
  CASE
    WHEN end_date IS NULL OR end_date >= CURRENT_DATE()
    THEN 'Active'
    ELSE 'Expired'
  END AS membership_status
FROM climbing_gym.memberships
WHERE
  membership_type IS NOT NULL
  AND monthly_price > 0
  AND (end_date IS NULL OR start_date <= end_date);



CREATE OR REPLACE VIEW climbing_gym.vw_visits_clean AS
SELECT
  visit_id,
  customer_id,
  check_in_time,
  check_out_time,
  TIMESTAMP_DIFF(check_out_time, check_in_time, MINUTE) AS visit_duration_minutes
FROM climbing_gym.visitis
WHERE
  check_in_time IS NOT NULL
  AND check_out_time IS NOT NULL
  AND check_out_time >= check_in_time
  AND TIMESTAMP_DIFF(check_out_time, check_in_time, MINUTE) BETWEEN 30 AND 300; --Between 30 mins and 5 hours

CREATE OR REPLACE VIEW climbing_gym.vw_class_attendance_clean AS
SELECT
  class_id,
  customer_id,
  attendance_date,
  attended
FROM climbing_gym.class_attendance
WHERE
  attended IN ('Yes', 'No')
  AND class_id IS NOT NULL
  AND customer_id IS NOT NULL;


CREATE OR REPLACE VIEW climbing_gym.vw_route_climbs_clean AS
SELECT
  climb_id,
  route_id,
  customer_id,
  climb_date
FROM climbing_gym.route_climbs
WHERE
  route_id IS NOT NULL
  AND customer_id IS NOT NULL
  AND climb_date IS NOT NULL;




-------- Churn features View

CREATE OR REPLACE VIEW climbing_gym.vw_churn_features AS
WITH visit_metrics AS (
  SELECT
    customer_id,
    COUNT(*) AS total_visits,
    AVG(visit_duration_minutes) AS avg_visit_duration,
    MAX(check_in_time) AS last_visit_date
  FROM climbing_gym.vw_visits_clean
  GROUP BY customer_id
),

class_metrics AS (
  SELECT
    customer_id,
    COUNTIF(attended = 'Yes') AS total_classes_attended
  FROM climbing_gym.vw_class_attendance_clean
  GROUP BY customer_id
)

SELECT
  m.customer_id,
  m.membership_type,
  m.monthly_price,
  m.membership_status,

  -- Membership duration
  DATE_DIFF(
    COALESCE(m.end_date, CURRENT_DATE()),
    m.start_date,
    DAY
  ) AS membership_duration_days,

  -- Visit features
  v.total_visits,
  ROUND(
    v.total_visits /
    NULLIF(DATE_DIFF(CURRENT_DATE(), m.start_date, MONTH), 0),
    2
  ) AS avg_visits_per_month,

  DATE_DIFF(
    CURRENT_DATE(),
    DATE(v.last_visit_date),
    DAY
  ) AS days_since_last_visit,

  ROUND(v.avg_visit_duration, 2) AS avg_visit_duration_minutes,

  -- Class engagement
  COALESCE(c.total_classes_attended, 0) AS total_classes_attended

FROM climbing_gym.vw_memberships_clean m
LEFT JOIN visit_metrics v
  ON m.customer_id = v.customer_id
LEFT JOIN class_metrics c
  ON m.customer_id = c.customer_id;