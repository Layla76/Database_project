-- 1. Delete payments that were less than $[numeric]
PREPARE del_payments (numeric) AS 
DELETE FROM payments
USING employees, wages
WHERE employees.id_ = payments.employee_id
AND payments.wage_id = wages.id_
AND wages.wage < $1;

EXECUTE del_payments(90000);

-- 2. How many items are insured for over $[numeric]?
PREPARE count_insured (numeric) AS 
SELECT COUNT(DISTINCT assets.id_)
FROM assets
JOIN insured ON assets.id_ = insured.asset_id
JOIN insurance ON insured.insurance_id = insurance.id_
WHERE insurance.cost_ > $1;

EXECUTE count_insured(5000);

-- 3. The deadline for penalties is extended by [int] days
PREPARE extend_penalty (int) AS 
UPDATE member_penalties
SET due_date = due_date + $1;

EXECUTE extend_penalty(1);

-- 4. How many subscriptions are active after [date]?
PREPARE active_subs (date) AS 
SELECT COUNT(subscribed.subscription_id)
FROM subscribed
WHERE end_date > $1;

EXECUTE active_subs('01-01-2023');
