-- employees

UPDATE employees
SET name_ = SUBSTRING(MD5(RANDOM()::text), 1, 5);

UPDATE employees
SET birthdate = (
    '1970-08-01'::date +
    (FLOOR(RANDOM() * (('2004-08-31'::date - '1970-08-01'::date)))::int)
);

UPDATE employees
SET start_date_ = (
    '2022-08-01'::date +
    (FLOOR(RANDOM() * (('2024-08-31'::date - '2022-08-01'::date)))::int)
);

