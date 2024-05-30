-- Entities

create table if not exists books
(
  id_ numeric(10,0) primary key
);

create table if not exists providers
(
  id_ numeric(10,0) primary key
);

create table if not exists employees
(
  id_ numeric(9,0) primary key
);

create table if not exists members
(
  id_ numeric(9,0) primary key
);

create table if not exists insurable_entities
(
  id_ numeric(10,0) primary key
);

create table if not exists funding_sources
(
  id_ numeric(10,0) primary key
);

create table if not exists jobs
(
  id_ numeric(10,0) primary key
);

create table if not exists wages
(
  id_ numeric(10,0) primary key,
  job_id numeric(10,0) references jobs,
  type_ varchar(50),
  wage numeric(10,2)
);

create table if not exists procurements
(
  id_ numeric(10,0) primary key,
  type_ varchar(50)
);

create table if not exists subscriptions
(
  id_ numeric(10,0) primary key,
  type_ varchar(50),
  cost_ numeric(10,2),
  is_renewable numeric(1,0)
);

create table if not exists penalties
(
  id_ numeric(10,0) primary key,
  type_ varchar(50),
  fee numeric(10,2)
);

create table if not exists insurance
(
  id_ numeric(10,0) primary key,
  provider_id numeric(10,0) references providers,
  plan varchar(50),
  cost_ numeric(10,2)
);

create table if not exists funding
(
  id_ numeric(10,0) primary key,
  type_ varchar(50)
);


-- Relations

create table if not exists paid
(
  wage_id numeric(10, 0),
  employee_id numeric(9, 0),
  date_ date,
  primary key (wage_id, employee_id),
  foreign key (wage_id) references wages(id_),
  foreign key (employee_id) references employees(id_)
);

create table if not exists procured
(
  procurement_id numeric(10, 0),
  book_id numeric(10, 0),
  date_ date,
  cost_ numeric(10, 2),
  primary key (procurement_id, book_id),
  foreign key (procurement_id) references procurements(id_),
  foreign key (book_id) references books(id_)
);

create table if not exists subscribed
(
  subscription_id numeric(10, 0),
  member_id numeric(9, 0),
  start_date_ date,
  end_date date,
  primary key (subscription_id, member_id),
  foreign key (subscription_id) references subscriptions(id_),
  foreign key (member_id) references members(id_)
);

create table if not exists receives
(
  member_id numeric(10, 0),
  penalty_id numeric(10, 0),
  issue_date date,
  due_date date,
  primary key (member_id, penalty_id),
  foreign key (member_id) references members(id_),
  foreign key (penalty_id) references penalties(id_)
);

create table if not exists insured
(
  insurance_id numeric(10, 0),
  insurable_entity_id numeric(10, 0),
  start_date_ date,
  end_date date,
  primary key (insurance_id, insurable_entity_id),
  foreign key (insurance_id) references insurance(id_),
  foreign key (insurable_entity_id) references insurable_entity(id_)
);

create table if not exists grants
(
  funding_source_id numeric(10, 0),
  funding_id numeric(10, 0),
  amount numeric(10, 2),
  date_ date,
  primary key (funding_source_id, funding_id),
  foreign key (funding_source_id) references funding_sources(id_),
  foreign key (funding_id) references funding(id_)
);

