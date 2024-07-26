-- 1. How much money has the library spent on books?
SELECT SUM(books.price) as total_book_cost
FROM assets
INNER JOIN procurements ON assets.id_ = procurements.asset_id
INNER JOIN suppliers ON suppliers.id_ = procurements.supplier_id
INNER JOIN books ON assets.id_ = books.asset_id
WHERE assets.type_ = 'book' and procurements.status_ = 1;
  
-- 2. What is the most expensive procurement?
SELECT MAX(buildings.price)
FROM suppliers
INNER JOIN procurements ON suppliers.id_ = procurements.supplier_id
INNER JOIN assets ON assets.id_ = procurements.asset_id
INNER JOIN buildings ON buildings.asset_id = assets.id_
WHERE assets.type_ = 'building' and procurements.status_ = 1;

-- 3. What is the average insurance plan length in use?
SELECT AVG(end_date - start_date_) AS avg_length_in_days
FROM insured
INNER JOIN insurance ON insurance.id_ = insured.insurance_id
INNER JOIN assets ON assets.id_ = insured.asset_id

-- 4. What is the library's balance?
 SELECT
(SELECT SUM(grants.amount * tables.flow_direction)
FROM grants
INNER JOIN cash_flow ON cash_flow.id_ = grants.cash_flow_id
INNER JOIN tables ON cash_flow.table_id = tables.id_
WHERE grants.status_ = 1)

+

(SELECT SUM(wages.wage * tables.flow_direction)
FROM payments
INNER JOIN cash_flow ON cash_flow.id_ = payments.cash_flow_id
INNER JOIN tables ON cash_flow.table_id = tables.id_
INNER JOIN wages ON wages.id_ = payments.wage_id
WHERE payments.status_ = 1 and tables.name_ = 'payments')

+

(SELECT SUM(subscriptions.cost_ * tables.flow_direction)
FROM subscribed
INNER JOIN cash_flow ON cash_flow.id_ = subscribed.cash_flow_id
INNER JOIN tables ON cash_flow.table_id = tables.id_
INNER JOIN subscriptions ON subscriptions.id_ = subscribed.subscription_id
WHERE subscribed.status_ = 1 and tables.name_ = 'subscribed')

+

(SELECT SUM(penalties.fee * tables.flow_direction)
FROM member_penalties
INNER JOIN cash_flow ON cash_flow.id_ = member_penalties.cash_flow_id
INNER JOIN tables ON cash_flow.table_id = tables.id_
INNER JOIN penalties ON penalties.id_ = member_penalties.penalty_id
WHERE member_penalties.status_ = 1 and tables.name_ = 'member_penalties')

+

(SELECT SUM(books.price * tables.flow_direction)
FROM procurements
INNER JOIN cash_flow ON cash_flow.id_ = procurements.cash_flow_id
INNER JOIN tables ON cash_flow.table_id = tables.id_
INNER JOIN assets ON assets.id_ = procurements.asset_id
INNER JOIN books ON books.asset_id = assets.id_
WHERE procurements.status_ = 1 and assets.type_ = 'book' and tables.name_ = 'procurements')

+

(SELECT SUM(rooms.price * tables.flow_direction)
FROM procurements
INNER JOIN cash_flow ON cash_flow.id_ = procurements.cash_flow_id
INNER JOIN tables ON cash_flow.table_id = tables.id_
INNER JOIN assets ON assets.id_ = procurements.asset_id
INNER JOIN rooms ON rooms.asset_id = assets.id_
WHERE procurements.status_ = 1 and assets.type_ = 'room' and tables.name_ = 'procurements')

+

(SELECT SUM(buildings.price * tables.flow_direction)
FROM procurements
INNER JOIN cash_flow ON cash_flow.id_ = procurements.cash_flow_id
INNER JOIN tables ON cash_flow.table_id = tables.id_
INNER JOIN assets ON assets.id_ = procurements.asset_id
INNER JOIN buildings ON buildings.asset_id = assets.id_
WHERE procurements.status_ = 1 and assets.type_ = 'building' and tables.name_ = 'procurements')

+ 

(SELECT SUM(insurance.cost_ * tables.flow_direction)
FROM insured
INNER JOIN cash_flow ON cash_flow.id_ = insured.cash_flow_id
INNER JOIN tables ON cash_flow.table_id = tables.id_
INNER JOIN assets ON assets.id_ = insured.asset_id
INNER JOIN books ON books.asset_id = assets.id_
INNER JOIN insurance ON insurance.id_ = insured.insurance_id
WHERE insured.status_ = 1 and assets.type_ = 'book' and tables.name_ = 'insured')

+

(SELECT SUM(insurance.cost_ * tables.flow_direction)
FROM insured
INNER JOIN cash_flow ON cash_flow.id_ = insured.cash_flow_id
INNER JOIN tables ON cash_flow.table_id = tables.id_
INNER JOIN assets ON assets.id_ = insured.asset_id
INNER JOIN rooms ON rooms.asset_id = assets.id_
INNER JOIN insurance ON insurance.id_ = insured.insurance_id
WHERE insured.status_ = 1 and assets.type_ = 'room' and tables.name_ = 'insured')

+

(SELECT SUM(insurance.cost_ * tables.flow_direction)
FROM insured
INNER JOIN cash_flow ON cash_flow.id_ = insured.cash_flow_id
INNER JOIN tables ON cash_flow.table_id = tables.id_
INNER JOIN assets ON assets.id_ = insured.asset_id
INNER JOIN buildings ON buildings.asset_id = assets.id_
INNER JOIN insurance ON insurance.id_ = insured.insurance_id
WHERE insured.status_ = 1 and assets.type_ = 'building' and tables.name_ = 'insured')

AS balance;

-- 5. Add 90 days to each insurance plan
UPDATE insured
SET end_date = end_date + 90

-- 6. Add 30 days to each subscription
UPDATE subscribed
SET end_date = end_date + 30;

-- 7. Delete subscribed members who have had more than 5 penalties
DELETE FROM subscribed
WHERE member_id IN (
  SELECT member_id
  FROM member_penalties
  GROUP BY member_id
  HAVING COUNT(*) > 5
);

-- 8. Delete procurements that cost more than 3,000,000
DELETE FROM procurements
WHERE procurements.asset_id IN (
  SELECT assets.id_
  FROM procurements
  INNER JOIN books ON books.asset_id = procurements.asset_id
  INNER JOIN assets ON assets.id_ = procurements.asset_id
  WHERE books.price > 3000000 and assets.type_ = 'book'
) OR procurements.asset_id IN (
  SELECT assets.id_
  FROM procurements
  INNER JOIN rooms ON rooms.asset_id = procurements.asset_id
  INNER JOIN assets ON assets.id_ = procurements.asset_id
  WHERE rooms.price > 3000000 and assets.type_ = 'room'
) OR procurements.asset_id IN (
  SELECT assets.id_
  FROM procurements
  INNER JOIN buildings ON buildings.asset_id = procurements.asset_id
  INNER JOIN assets ON assets.id_ = procurements.asset_id
  WHERE buildings.price > 3000000 and assets.type_ = 'building'
);
