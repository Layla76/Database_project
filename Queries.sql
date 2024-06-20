-- 1. How much money has the library spent on books?
SELECT SUM(procured.cost_) AS total_cost
FROM procurements
JOIN procured ON procurement.id_ = procured.procurement_id
JOIN books ON book.id_ = procured.book_id;
  
-- 2. What was the most expensive procurement?
SELECT MAX(procured.cost_)
FROM procurements
JOIN procured ON procurement.id_ = procured.procurement_id
JOIN books ON book.id_ = procured.book_id;

-- 3. How much have members paid in fines due for each type of penalty?
SELECT receives.type_, SUM(receives.fee) AS total_fees
FROM penalties
JOIN receives ON penalties.id_ = receives.penalty_id
JOIN books ON members.id_ = receives.member_id
GROUP BY receives.type_;

-- 4. What is the average funding given per grant?
SELECT AVG(grants.amount) AS average_grant
FROM funding
JOIN grants ON funding.id_ = grants.funding_id
JOIN books ON funding_sources.id_ = grants.funding_source_id;

-- 5. Increase hourly wages by $5
UPDATE wages
SET wage = wage + 5
WHERE type_ = "hourly";

UPDATE paid
SET wages.wage = wages.wage + 5
WHERE wages.type_ = "hourly";


-- 6. Increase family subscriptions by $5
UPDATE subscriptions
SET cost = cost + 5
WHERE type_ = "family";

UPDATE subscribed
SET subscriptions.cost = subscriptions.cost + 5
WHERE subscriptions.type_ = "family";

-- 7. Delete subscribed members who have a first time subscription and who have had more than 5 penalties
DELETE FROM subscribed
WHERE subscriptions.type_ = "first_time" AND member_id IN (
  SELECT member_id
  FROM receives
  GROUP BY member_id
  HAVING COUNT(*) > 5
);

-- 8. Delete procurements that cost less than $3
DELETE FROM procured
WHERE cost < 3