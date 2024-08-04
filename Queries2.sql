-- 1. Do employees with a birthday in January make more than the average employee?
SELECT AVG(wages.wage) AS Jan_avg
FROM employee_birthdays
INNER JOIN wages ON wages.employee_id = employee_birthdays.id_
WHERE EXTRACT(MONTH FROM employee_birthdays.birthdate) = 1;

SELECT AVG(wages.wage) AS all_avg
FROM employee_birthdays
INNER JOIN wages ON wages.employee_id = employee_birthdays.id_;

--         jan_avg        
-- -----------------------
--  5321.0304635761589404
-- (1 row)

-- Time: 22.927 ms

--         all_avg        
-- -----------------------
--  5490.3935992888098678
-- (1 row)

-- Time: 17.442 ms


-- 2. Do older employees make more than younger employees?
SELECT AVG(wages.wage) AS older_avg
FROM employee_birthdays
INNER JOIN wages ON wages.employee_id = employee_birthdays.id_
WHERE EXTRACT(YEAR FROM employee_birthdays.birthdate) <= 1975;

SELECT AVG(wages.wage) AS younger_avg
FROM employee_birthdays
INNER JOIN wages ON wages.employee_id = employee_birthdays.id_
WHERE EXTRACT(YEAR FROM employee_birthdays.birthdate) > 1975;

--        older_avg       
-- -----------------------
--  5517.5834532374100719
-- (1 row)

-- Time: 21.020 ms

--       younger_avg      
-- -----------------------
--  5485.4266000788539887
-- (1 row)

-- Time: 20.410 ms


-- 3. Are any employees working for more than 60 hours in a week? 
SELECT employee_id
FROM employee_times
GROUP BY employee_id
HAVING COUNT(timeslot) > 60/4;

-- employee_id 
-- -------------
-- (0 rows)

-- Time: 19.294 ms

-- (Assumes each shift is 4 hours. The max hours is 7 * 4 = 28)


-- 4. Does nighttime security earn more than daytime security?
SELECT AVG(wages.wage) AS night
FROM employee_times
INNER JOIN wages ON wages.employee_id = employee_times.employee_id
WHERE employee_times.timeslot > '22:00' OR employee_times.timeslot < '4:00';

SELECT AVG(wages.wage) AS day
FROM employee_times
INNER JOIN wages ON wages.employee_id = employee_times.employee_id
WHERE employee_times.timeslot > '4:00' AND employee_times.timeslot < '22:00';

--          night         
-- -----------------------
--  5230.9220779220779221
-- (1 row)

-- Time: 16.567 ms

--           day          
-- -----------------------
--  5505.6399886677526737
-- (1 row)

-- Time: 20.391 ms