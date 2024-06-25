CREATE
UNIQUE INDEX grants_index
ON grants (funding_source_id, funding_id, amount, date_);

CREATE
UNIQUE INDEX procured_index
ON procured (procurement_id, book_id, date_);

CREATE
UNIQUE INDEX insured_index
ON insured (insurance_id, insurable_entity_id, start_date_, end_date);


ALTER TABLE subscriptions
ADD CONSTRAINT sub
CHECK (is_renewable = 0 OR is_renewable = 1), 
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
CHECK (start_date_ >= end_date);

ALTER TABLE receives
ADD CONSTRAINT receives_dates
CHECK (issue_date >= due_date);

ALTER TABLE insured
ADD CONSTRAINT insured_dates
CHECK (start_date_ >= end_date);

ALTER TABLE grants
ADD CONSTRAINT amount
CHECK (amount >= 0);
