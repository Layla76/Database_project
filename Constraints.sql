CREATE
UNIQUE INDEX asset_type
ON assets(id_, type_);

CREATE 
UNIQUE INDEX table_name
ON tables(id_, name_);

CREATE
UNIQUE INDEX insured_dates
ON insured(cash_flow_id, start_date_, end_date);


-- ALTER TABLE

-- No negative amounts *****************************************************
ALTER TABLE subscriptions
ADD CONSTRAINT sub_cost
CHECK (cost_ >= 0);

ALTER TABLE wages
ADD CONSTRAINT pos_wage
CHECK (wage > 0);

ALTER TABLE insurance
ADD CONSTRAINT pos_ins
CHECK (cost_ > 0);

ALTER TABLE books
ADD CONSTRAINT pos_price_bo
CHECK (price > 0);

ALTER TABLE rooms
ADD CONSTRAINT pos_price_r
CHECK (price > 0);

ALTER TABLE buildings
ADD CONSTRAINT pos_price_bu
CHECK (price > 0);

ALTER TABLE grants
ADD CONSTRAINT pos_grant
CHECK (amount > 0);

ALTER TABLE penalties
ADD CONSTRAINT pen_fee
CHECK (fee >= 0);

-- -- status is 0 or 1 ********************************************************
ALTER TABLE grants
ADD CONSTRAINT stat_grant
CHECK (status_ = 0 or status_ = 1);

ALTER TABLE procurements
ADD CONSTRAINT stat_proc
CHECK (status_ = 0 or status_ = 1);

ALTER TABLE insured
ADD CONSTRAINT stat_insured
CHECK (status_ = 0 or status_ = 1);

ALTER TABLE payments
ADD CONSTRAINT stat_pay
CHECK (status_ = 0 or status_ = 1);

ALTER TABLE subscribed
ADD CONSTRAINT stat_sub
CHECK (status_ = 0 or status_ = 1);

ALTER TABLE member_penalties
ADD CONSTRAINT stat_mem_pen
CHECK (status_ = 0 or status_ = 1);

-- dates are chronological *************************************************
DELETE FROM insured
WHERE start_date_ > end_date;

ALTER TABLE insured
ADD CONSTRAINT insured_dates
CHECK (start_date_ <= end_date);

DELETE FROM subscribed
WHERE start_date_ > end_date;

ALTER TABLE subscribed
ADD CONSTRAINT subscribed_dates
CHECK (start_date_ <= end_date);

DELETE FROM member_penalties
WHERE issue_date > due_date;

ALTER TABLE member_penalties
ADD CONSTRAINT mem_pen_dates
CHECK (issue_date <= due_date);


-- Create errors ***********************************************************
UPDATE subscriptions
SET cost_ = -1;

UPDATE wages
SET wage = -1;

UPDATE penalties
SET fee = -1;

UPDATE insurance
SET cost_ = -1;

UPDATE books
SET price = -1;

UPDATE rooms
SET price = -1;

UPDATE buildings
SET price = -1;

UPDATE subscribed
SET start_date_ = end_date + 1;

UPDATE grants
SET amount = -1;

UPDATE grants
SET status_ = -1;

UPDATE procurements
SET status_ = -1;

UPDATE insured
SET status_ = -1;

UPDATE payments
SET status_ = -1;

UPDATE subscribed
SET status_ = -1;

UPDATE member_penalties
SET status_ = -1;

UPDATE insured
SET start_date_ = end_date + 1;

UPDATE subscribed
SET start_date_ = end_date + 1;

UPDATE member_penalties
SET issue_date = due_date + 1;
