-- 1. Employee birthdays
CREATE OR REPLACE VIEW employee_birthdays AS
SELECT 
  id_,
  birthdate
FROM employees
WITH CHECK OPTION;

-- Get employees whose birthdays are today
SELECT *
FROM employee_birthdays
WHERE EXTRACT(MONTH FROM birthdate) = EXTRACT(MONTH FROM CURRENT_DATE)
  AND EXTRACT(DAY FROM birthdate) = EXTRACT(DAY FROM CURRENT_DATE);

-- Temporarily set leap year birthdays to a birthday that no one else has while preserving the true birth year
UPDATE employee_birthdays
SET birthdate = DATE '1800-01-01' + (EXTRACT(YEAR FROM birthdate) % 100) * INTERVAL '1 year'
WHERE EXTRACT(MONTH FROM birthdate) = 2
  AND EXTRACT(DAY FROM birthdate) = 29;


-- 2. Employee work times
CREATE OR REPLACE VIEW employee_times AS
SELECT 
  employee_id,
  timeslot
FROM works
WITH CHECK OPTION;

-- Get late working employees
SELECT *
FROM employee_times
WHERE timeslot < '04:00' OR timeslot > '22:00';

-- Delete rows with late working employees who aren't security
DELETE FROM employee_times
WHERE timeslot < '04:00' OR timeslot > '22:00'
AND employee_id IN (
  SELECT employee_id
  FROM employees
  WHERE employee_id < 800000000
);