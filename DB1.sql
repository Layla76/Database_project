CREATE TABLE IF NOT EXISTS books
(
  id_ numeric(10,0) primary key
);

CREATE TABLE IF NOT EXISTS providers
(
  id_ numeric(10,0) primary key
);

CREATE TABLE IF NOT EXISTS employees
(
  id_ numeric(9,0) primary key
);

CREATE TABLE IF NOT EXISTS members
(
  id_ numeric(9,0) primary key
);

CREATE TABLE IF NOT EXISTS "insurableEntities"
(
  id_ numeric(10,0) primary key
);

CREATE TABLE IF NOT EXISTS "fundingSources"
(
  id_ numeric(10,0) primary key
);

CREATE TABLE IF NOT EXISTS jobs
(
  id_ numeric(10,0) primary key
);

CREATE TABLE IF NOT EXISTS wages
(
  id_ numeric(10,0) primary key,
  jobId numeric(10,0) references jobs,
  type_ varchar(50),
  wage numeric(10,2)
);

CREATE TABLE IF NOT EXISTS procurements
(
  id_ numeric(10,0) primary key,
  type_ varchar(50)
);

CREATE TABLE IF NOT EXISTS subscriptions
(
  id_ numeric(10,0) primary key,
  type_ varchar(50),
  cost_ numeric(10,2),
  isRenewable numeric(1,0)
);

CREATE TABLE IF NOT EXISTS penalties
(
  id_ numeric(10,0) primary key,
  type_ varchar(50),
  fee numeric(10,2)
);

CREATE TABLE IF NOT EXISTS insurance
(
  id_ numeric(10,0) primary key,
  providerId numeric(10,0) references providers,
  plan varchar(50),
  cost_ numeric(10,2)
);

CREATE TABLE IF NOT EXISTS funding
(
  id_ numeric(10,0) primary key,
  type_ varchar(50)
);

