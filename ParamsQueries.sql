-- 1. Delete payments that were less than $[numeric]
PREPARE del_payments (numeric) AS 
DELETE FROM paid
USING employees, wages
WHERE employees.id_ = paid.employee_id
AND paid.wage_id = wages.id_
AND wages.wage < $1;

EXECUTE del_payments(1000000000000);

-- 2. How many items are insured for over $[numeric]?
PREPARE count_insured (numeric) AS 
SELECT COUNT(DISTINCT insurable_entities.id_)
FROM insurable_entities
JOIN insured ON insurable_entities.id_ = insured.insurable_entity_id
JOIN insurance ON insured.insurance_id = insurance.id_
WHERE insurance.cost_ > $1;

EXECUTE count_insured(1000000)

-- 3. The deadline for penalties is extended by [int] days
PREPARE extend_penalty (int) AS 
UPDATE receives
SET due_date = due_date + $1;

EXECUTE extend_penalty(1);

-- 4. How many subscriptions are active after [date]?
PREPARE active_subs (date) AS 
SELECT COUNT(subscribed.subscription_id)
FROM subscribed
WHERE end_date > $1;

EXECUTE active_subs('01-01-2024');