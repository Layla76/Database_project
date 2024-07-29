-- 1. Penalty issue and due dates
CREATE OR REPLACE VIEW penalty_dates AS
SELECT 
  due_date,
  status_
FROM member_penalties
WITH CHECK OPTION;

-- CREATE VIEW
-- Time: 4.507 ms


-- Add 20 days to due dates that are less than 10 days away from now and that references a fee that hasn't been paid yet
UPDATE penalty_dates
SET due_date = due_date + 20
WHERE due_date - CURRENT_DATE < 10 and status_ = 0;

-- UPDATE 25781
-- Time: 340.235 ms


-- Add 15 days to due dates that have passed and that reference a fee that hasn't been paid yet
UPDATE penalty_dates
SET due_date = due_date + 15
WHERE CURRENT_DATE > due_date and status_ = 0;

-- UPDATE 24792
-- Time: 124.329 ms



-- 2. Grants amount, date, status
CREATE OR REPLACE VIEW grant_amounts AS
SELECT 
  amount,
  date_,
  status_
FROM grants
WITH CHECK OPTION;

-- CREATE VIEW
-- Time: 6.524 ms


-- Grants arranged before 2024 have been paid
UPDATE grant_amounts
SET status_ = 1
WHERE date_ < '2024-01-01';

-- UPDATE 105481
-- Time: 962.034 ms


-- Delete grants that haven't been paid for over 1.5 years past the arrangement date
DELETE FROM grant_amounts
WHERE CURRENT_DATE - date_ > 547 and status_ = 0;

-- DELETE 0
-- Time: 81.990 ms



-- 3. Payments date, status
CREATE OR REPLACE VIEW payment AS
SELECT 
  date_,
  status_
FROM payments
WITH CHECK OPTION;

-- CREATE VIEW
-- Time: 3.976 ms


-- Payments from last month or later are paid
UPDATE payment
SET status_ = 1
WHERE date_ <= CURRENT_DATE - 30;

-- UPDATE 171855
-- Time: 2522.504 ms (00:02.523)


-- Delete payments from before 2 years ago
DELETE FROM payment
WHERE date_ + 730 < CURRENT_DATE;

-- DELETE 0
-- Time: 54.103 ms



-- 4. Subscribed dates
CREATE OR REPLACE VIEW sub_dates AS
SELECT 
  start_date_,
  end_date,
  status_
FROM subscribed
WITH CHECK OPTION;

-- CREATE VIEW
-- Time: 4.363 ms


-- Delete subscriptions that haven't been paid for for longer than 10 days
DELETE FROM sub_dates
WHERE start_date_ + 10 < CURRENT_DATE and status_ = 0;

-- DELETE 64539
-- Time: 187.798 ms


-- Delete subscriptions from before 5 years ago
DELETE FROM sub_dates
WHERE end_date + 1826 < CURRENT_DATE;

-- DELETE 0
-- Time: 30.306 ms
