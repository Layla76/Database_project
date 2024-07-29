-- 1. Employees with wages
CREATE OR REPLACE VIEW employee_wage AS
SELECT 
  employees.person_id AS id_, 
  wages.wage AS wage
FROM employees
INNER JOIN payments ON payments.employee_id = employees.person_id
INNER JOIN wages ON payments.wage_id = wages.id_;

-- CREATE VIEW
-- Time: 3.073 ms


-- Which employees have the highest wage?
SELECT employee_wage.id_ AS id_, employee_wage.wage AS wage_
FROM employee_wage
INNER JOIN (
    SELECT MAX(wage) AS max_wage
    FROM employee_wage
) AS max_wage_table ON employee_wage.wage = max_wage_table.max_wage;

-- Time: 100.877 ms



-- 2. All assets with price, type, and status
CREATE OR REPLACE VIEW asset_price AS
SELECT 
  assets.id_ AS id_, 
  books.price AS price, 
  'book' AS type_, 
  procurements.status_ AS status_
FROM assets
INNER JOIN books ON books.asset_id = assets.id_
INNER JOIN procurements ON procurements.asset_id = assets.id_

UNION ALL

SELECT 
  assets.id_ AS id_, 
  rooms.price AS price, 
  'room' AS type_, 
  procurements.status_ AS status_
FROM assets
INNER JOIN rooms ON rooms.asset_id = assets.id_
INNER JOIN procurements ON procurements.asset_id = assets.id_

UNION ALL

SELECT 
  assets.id_ AS id_, 
  buildings.price AS price, 
  'building' AS type_, 
  procurements.status_ AS status_
FROM assets
INNER JOIN buildings ON buildings.asset_id = assets.id_
INNER JOIN procurements ON procurements.asset_id = assets.id_;

-- CREATE VIEW
-- Time: 8.401 ms


-- How much has been/will be spent on assets (payment status irrelevant)?
SELECT SUM(price) AS total_spent
FROM asset_price;

-- total_spent   
-- -----------------
--  170097271103.08
-- (1 row)

-- Time: 157.452 ms



-- 3. All cash flow (id, table name, flow, status)
CREATE OR REPLACE VIEW all_cash_flow AS
SELECT 
  cash_flow.id_ AS id_, 
  'procurements' AS table_, 
  asset_price.price * tables.flow_direction AS flow, 
  procurements.status_ AS status_
FROM cash_flow
INNER JOIN tables ON cash_flow.table_id = tables.id_
INNER JOIN procurements ON procurements.cash_flow_id = cash_flow.id_
INNER JOIN asset_price ON asset_price.id_ =  procurements.asset_id -- using view #2

UNION ALL

SELECT 
  cash_flow.id_ AS id_, 
  'insured' AS table_, 
  insurance.cost_ * tables.flow_direction AS flow, 
  insured.status_ AS status_
FROM cash_flow
INNER JOIN tables ON cash_flow.table_id = tables.id_
INNER JOIN insured ON insured.cash_flow_id = cash_flow.id_
INNER JOIN insurance ON insurance.id_ = insured.insurance_id

UNION ALL

SELECT 
  cash_flow.id_ AS id_, 
  'payments' AS table_, 
  wages.wage * tables.flow_direction AS flow, 
  payments.status_ AS status_
FROM cash_flow
INNER JOIN tables ON cash_flow.table_id = tables.id_
INNER JOIN payments ON payments.cash_flow_id = cash_flow.id_
INNER JOIN wages ON wages.id_ = payments.wage_id

UNION ALL

SELECT 
  cash_flow.id_ AS id_, 
  'grants' AS table_, 
  grants.amount * tables.flow_direction AS flow, 
  grants.status_ AS status_
FROM cash_flow
INNER JOIN tables ON cash_flow.table_id = tables.id_
INNER JOIN grants ON grants.cash_flow_id = cash_flow.id_

UNION ALL

SELECT 
  cash_flow.id_ AS id_, 
  'subscriptions' AS table_, 
  subscriptions.cost_ * tables.flow_direction AS flow, 
  subscribed.status_ AS status_
FROM cash_flow
INNER JOIN tables ON cash_flow.table_id = tables.id_
INNER JOIN subscribed ON subscribed.cash_flow_id = cash_flow.id_
INNER JOIN subscriptions ON subscriptions.id_ = subscribed.subscription_id

UNION ALL

SELECT 
  cash_flow.id_ AS id_, 
  'penalties' AS table_, 
  penalties.fee * tables.flow_direction AS flow, 
  member_penalties.status_ AS status_
FROM cash_flow
INNER JOIN tables ON cash_flow.table_id = tables.id_
INNER JOIN member_penalties ON member_penalties.cash_flow_id = cash_flow.id_
INNER JOIN penalties ON penalties.id_ = member_penalties.penalty_id;

-- CREATE VIEW
-- Time: 8.382 ms


-- What is the total from the incoming flow (grants, penalties, subscriptions)?
SELECT SUM(flow) AS total_earned
FROM all_cash_flow
WHERE (table_ = 'grants' or table_ = 'penalties' or table_ = 'subscriptions') and status_ = 1;

-- total_earned 
-- --------------
--   74324991.00
-- (1 row)

-- Time: 371.575 ms



-- 4. Members and subscription type
CREATE OR REPLACE VIEW member_subs AS
SELECT 
  members.person_id AS id_,
  subscriptions.type_ AS subscription
FROM members
INNER JOIN subscribed ON members.person_id = subscribed.member_id
INNER JOIN subscriptions ON subscriptions.id_ = subscribed.subscription_id;

-- CREATE VIEW
-- Time: 37.499 ms


-- What is the most used subscription?
SELECT subscription AS most_used_sub
FROM member_subs
GROUP BY subscription
ORDER BY COUNT(subscription) DESC
LIMIT 1;

-- most_used_sub
-- ---------------
--  senior
-- (1 row)

-- Time: 87.190 ms
