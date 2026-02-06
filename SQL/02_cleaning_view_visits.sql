-- Cleaned visits view
CREATE OR REPLACE VIEW climbing_gym.vw_visits_clean AS
SELECT
  v.visit_id,

  -- Normalized identifiers
  CAST(v.customer_id AS INT64) AS customer_id,
  m.membership_id,

  -- Visit timestamps
  v.check_in_time,
  v.check_out_time,

  -- Derived visit fields
  DATE(v.check_in_time) AS visit_date,
  EXTRACT(HOUR FROM v.check_in_time) AS check_in_hour,
  TIMESTAMP_DIFF(v.check_out_time, v.check_in_time, MINUTE) AS visit_duration_minutes,

  -- Membership context (VERY useful for BI)
  m.membership_type,
  m.membership_status,
  m.start_date AS membership_start_date,
  m.end_date AS membership_end_date,
  m.price_per_month

FROM climbing_gym.visits_ext v

-- Enforce valid customers
JOIN climbing_gym.customers c
  ON CAST(v.customer_id AS INT64) = c.customer_id

-- Enforce valid memberships
JOIN climbing_gym.vw_memberships_clean m
  ON c.customer_id = m.customer_id

WHERE
  -- Logical visit times
  v.check_out_time >= v.check_in_time

  -- Gym opening hours
  AND TIME(v.check_in_time) >= '06:00:00'
  AND TIME(v.check_out_time) <= '22:00:00'

  -- Visit occurred during membership validity
  AND DATE(v.check_in_time) BETWEEN m.start_date AND COALESCE(m.end_date, CURRENT_DATE());