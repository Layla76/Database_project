-- 1. How much money has the library spent on books?
SELECT SUM(procured.cost_) AS total_cost
FROM procurements
INNER JOIN procured ON procurements.id_ = procured.procurement_id
INNER JOIN books ON books.id_ = procured.book_id;
  
-- 2. What was the most expensive procurement?
SELECT MAX(procured.cost_)
FROM procurements
INNER JOIN procured ON procurements.id_ = procured.procurement_id
INNER JOIN books ON books.id_ = procured.book_id;

-- -- 3. What is the average insurance plan length in use?
SELECT AVG(end_date - start_date_) AS avg_length_in_days
FROM insured
INNER JOIN insurance ON insurance.id_ = insured.insurance_id
INNER JOIN insurable_entities ON insurable_entities.id_ = insured.insurable_entity_id

-- 4. What is the average funding given per grant?
SELECT AVG(grants.amount) AS avg_grant
FROM funding
INNER JOIN grants ON funding.id_ = grants.funding_id
INNER JOIN funding_sources ON funding_sources.id_ = grants.funding_source_id;

-- 5. Add 90 days to each insurance plan
UPDATE insured
SET end_date = end_date + 90

-- 6. Add 30 days to each subscription
UPDATE subscribed
SET end_date = end_date + 30;

-- 7. Delete subscribed members who have a first time subscription and who have had more than 5 penalties
DELETE FROM subscribed
WHERE member_id IN (
  SELECT member_id
  FROM receives
  GROUP BY member_id
  HAVING COUNT(*) > 5
) AND member_id IN (
  SELECT member_id
  FROM subscribed
  WHERE subscription_id = (
    SELECT id_
    FROM subscriptions
    WHERE type_ = 'first_time'
  )
);

-- 8. Delete procurements that cost less than $30000
DELETE FROM procured
WHERE cost_ < 30000