-- Cleaned memberships view
CREATE OR REPLACE VIEW climbing_gym.vw_memberships_clean AS
SELECT
  membership_id,
  customer_id,
  membership_type,
  price_per_month,
  start_date,
  end_date,

-- Membership status column creation
  CASE
    WHEN end_date IS NULL OR end_date >= CURRENT_DATE()
      THEN 'Active'
    ELSE 'Expired'
  END AS membership_status,

-- Membership duration in days 
  DATE_DIFF(
    COALESCE(end_date, CURRENT_DATE()),
    start_date,
    DAY
  ) AS membership_duration_days

FROM climbing_gym.memberships
WHERE
  customer_id IS NOT NULL
  AND start_date IS NOT NULL
  AND price_per_month > 0
  AND (
    end_date IS NULL 
    OR end_date >= start_date
  );









