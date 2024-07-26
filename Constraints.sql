-- CREATE
-- UNIQUE INDEX asset_type
-- ON assets(id_, type_);

-- CREATE 
-- UNIQUE INDEX table_name
-- ON tables(id_, name_);

-- CREATE
-- UNIQUE INDEX insured_dates
-- ON insured(cash_flow_id, start_date_, end_date);


ALTER TABLE subscriptions
ADD CONSTRAINT renewable
CHECK (is_renewable = 0 OR is_renewable = 1);

ALTER TABLE subscriptions
ADD CONSTRAINT sub_cost
CHECK (cost_ >= 0);

ALTER TABLE wages
ADD CONSTRAINT positive_wage
CHECK (wage > 0);

ALTER TABLE penalties
ADD CONSTRAINT fee
CHECK (fee >= 0);

ALTER TABLE insurance
ADD CONSTRAINT insurance_cost
CHECK (cost_ >= 0);

ALTER TABLE procured
ADD CONSTRAINT procured_cost
CHECK (cost_ >= 0);

ALTER TABLE subscribed
ADD CONSTRAINT subscribed_dates
CHECK (start_date_ <= end_date);

ALTER TABLE receives
ADD CONSTRAINT receives_dates
CHECK (issue_date <= due_date);

ALTER TABLE insured
ADD CONSTRAINT insured_dates
CHECK (start_date_ <= end_date);

ALTER TABLE grants
ADD CONSTRAINT amount
CHECK (amount >= 0);

UPDATE subscriptions
SET is_renewable = is_renewable + 2

UPDATE subscriptions
SET cost_ = -1

UPDATE wages
SET wage = -1

UPDATE penalties
SET fee = -1

UPDATE insurance
SET cost_ = -1

UPDATE procured
SET cost_ = -1

UPDATE subscribed
SET start_date_ = end_date + 1

UPDATE receives
SET issue_date = due_date + 1

UPDATE insured
SET start_date_ = end_date + 1

UPDATE grants
SET amount = -1