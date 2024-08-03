-- types
CREATE TYPE dept AS ENUM ('Library', 'Desk', 'Archives', 'Management', 'Security');
CREATE TYPE team AS ENUM ('Library', 'Desk', 'Archives', 'Security');
CREATE TYPE days AS ENUM ('Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday');
CREATE TYPE genre AS ENUM ('children', 'mystery', 'fantasy', 'romance', 'science fiction', 'thriller', 'historical fiction', 'biography', 'self-help', 'cookbook');
CREATE TYPE specialty AS ENUM ('children', 'mystery', 'fantasy', 'romance', 'science fiction', 'thriller', 'historical fiction', 'biography');
CREATE TYPE post AS ENUM ('Front door', 'Back door', 'Side door', 'Main floor', 'Archives');

-- tables
ALTER TABLE employees
ADD name_          VARCHAR NOT NULL,
ADD  start_date_   DATE NOT NULL,
ADD  birthdate      DATE NOT NULL,
ADD  department     dept NOT NULL
ADD job_id          INTEGER NOT NULL;

ALTER TABLE employees
ADD CONSTRAINT fk_job
FOREIGN KEY (job_id) REFERENCES jobs(id_) ON DELETE CASCADE;


CREATE TABLE if NOT EXISTS shift (
    day_of_week    days NOT NULL,
    timeslot       INTERVAL NOT NULL,
CONSTRAINT pk_Shift PRIMARY KEY (day_of_week,timeslot));


CREATE TABLE if NOT EXISTS librarian (
    employee_id    INTEGER NOT NULL,
    specialty      genre NOT NULL,
CONSTRAINT pk_Librarian PRIMARY KEY (employee_id),
CONSTRAINT fk_Librarian FOREIGN KEY (employee_id)
    REFERENCES employees (id_)
    MATCH FULL
    ON DELETE NO ACTION
    ON UPDATE CASCADE);


CREATE TABLE if NOT EXISTS preserver (
    employee_id          INTEGER NOT NULL,
    specialty      specialty NOT NULL,
CONSTRAINT pk_Preserver PRIMARY KEY (employee_id),
CONSTRAINT fk_Preserver FOREIGN KEY (employee_id)
    REFERENCES employees (id_)
    MATCH FULL
    ON DELETE NO ACTION
    ON UPDATE CASCADE);


CREATE TABLE if NOT EXISTS secretary (
    employee_id          INTEGER NOT NULL,
CONSTRAINT pk_Secretary PRIMARY KEY (employee_id),
CONSTRAINT fk_Secretary FOREIGN KEY (employee_id)
    REFERENCES employees (id_)
    MATCH FULL
    ON DELETE NO ACTION
    ON UPDATE CASCADE);


CREATE TABLE if NOT EXISTS manager (
    employee_id          INTEGER NOT NULL,
    team           team NOT NULL,
CONSTRAINT pk_Manager PRIMARY KEY (employee_id),
CONSTRAINT fk_Manager FOREIGN KEY (employee_id)
    REFERENCES employees (id_)
    MATCH FULL
    ON DELETE NO ACTION
    ON UPDATE CASCADE);


CREATE TABLE if NOT EXISTS security_ (
    employee_id          INTEGER NOT NULL,
    location       post NOT NULL,
CONSTRAINT pk_Security PRIMARY KEY (employee_id),
CONSTRAINT fk_Security FOREIGN KEY (employee_id)
    REFERENCES employees (id_)
    MATCH FULL
    ON DELETE NO ACTION
    ON UPDATE CASCADE);


CREATE TABLE works (
    employee_id          INTEGER NOT NULL,
    day_of_week    days NOT NULL,
    timeslot       INTERVAL NOT NULL,
CONSTRAINT pk_Works PRIMARY KEY (employee_id,day_of_week,timeslot),
CONSTRAINT fk_Works FOREIGN KEY (employee_id)
    REFERENCES employees (id_)
    MATCH FULL
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
CONSTRAINT fk_Works2 FOREIGN KEY (day_of_week,timeslot)
    REFERENCES shift (day_of_week,timeslot)
    MATCH FULL
    ON DELETE CASCADE
    ON UPDATE CASCADE);