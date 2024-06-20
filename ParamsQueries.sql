-- 1. Delete hourly employees who were paid less than $[numeric]
PREPARE delete_employees (numeric) AS 
DELETE FROM employees
WHERE id_ IN (
  SELECT employee_id
  FROM paid
  WHERE wages.type_ = "hourly" AND wages.wage < $1
);

-- 2. How many items are insured for over $[numeric]?
PREPARE count_insured (numeric) AS 
SELECT COUNT(DISTINCT insurable_entities.id_)
FROM insurable_entities
WHERE id_ IN (
  SELECT insurable_entities.id_
  FROM insured
  WHERE insurance.cost_ > $1
);

-- 3. The deadline for penalties is extended by [int] days
PREPARE extend_penalty (int) AS 
UPDATE receives
SET due_date + $1;

-- 4. How many subscriptions are active after [date]?
PREPARE active_subs (date) AS 
SELECT COUNT(subscribed.subscription_id)
FROM subscribed
WHERE end_date > $1;