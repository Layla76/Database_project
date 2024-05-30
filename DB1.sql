-- SCHEMA: billing

CREATE SCHEMA IF NOT EXISTS billing
    AUTHORIZATION postgres;

CREATE TABLE IF NOT EXISTS billing.books
(
  id_ numeric(10,0) primary key
);

CREATE TABLE IF NOT EXISTS billing.providers
(
  id_ numeric(10,0) primary key
);

CREATE TABLE IF NOT EXISTS billing.employees
(
  id_ numeric(9,0) primary key
);

CREATE TABLE IF NOT EXISTS billing.members
(
  id_ numeric(9,0) primary key
);

CREATE TABLE IF NOT EXISTS billing."insurableEntities"
(
  id_ numeric(10,0) primary key
);

CREATE TABLE IF NOT EXISTS billing."fundingSources"
(
  id_ numeric(10,0) primary key
);

CREATE TABLE IF NOT EXISTS billing.jobs
(
  id_ numeric(10,0) primary key
);

CREATE TABLE IF NOT EXISTS billing.wages
(
  id_ numeric(10,0) primary key,
  jobId numeric(10,0) references billing.jobs,
  type_ varchar(50),
  wage numeric(10,2)
);

CREATE TABLE IF NOT EXISTS billing.procurements
(
  id_ numeric(10,0) primary key,
  type_ varchar(50)
);

CREATE TABLE IF NOT EXISTS billing.subscriptions
(
  id_ numeric(10,0) primary key,
  type_ varchar(50),
  cost_ numeric(10,2),
  isRenewable numeric(1,0)
);

CREATE TABLE IF NOT EXISTS billing.penalties
(
  id_ numeric(10,0) primary key,
  type_ varchar(50),
  fee numeric(10,2)
);

CREATE TABLE IF NOT EXISTS billing.insurance
(
  id_ numeric(10,0) primary key,
  providerId numeric(10,0) references billing.providers,
  plan varchar(50),
  cost_ numeric(10,2)
);

CREATE TABLE IF NOT EXISTS billing.funding
(
  id_ numeric(10,0) primary key,
  type_ varchar(50)
);

