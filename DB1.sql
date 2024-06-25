-- Entities

create table if not exists books
(
  id_ numeric(9,0) primary key
);

create table if not exists providers
(
  id_ numeric(9,0) primary key
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
  id_ numeric(9,0) primary key
);

create table if not exists funding_sources
(
  id_ numeric(9,0) primary key
);

create table if not exists jobs
(
  id_ numeric(9,0) primary key
);

create table if not exists wages
(
  id_ numeric(9,0) primary key,
  job_id numeric(9,0) not null references jobs on delete cascade,
  type_ varchar(50) not null,
  wage numeric(12,2) not null
);

create table if not exists procurements
(
  id_ numeric(9,0) primary key,
  type_ varchar(50) not null
);

create table if not exists subscriptions
(
  id_ numeric(9,0) primary key,
  type_ varchar(50) not null,
  cost_ numeric(6,2) not null,
  is_renewable numeric(1,0) not null
);

create table if not exists penalties
(
  id_ numeric(9,0) primary key,
  type_ varchar(50) not null,
  fee numeric(6,2) not null
);

create table if not exists insurance
(
  id_ numeric(9,0) primary key,
  provider_id numeric(9,0) not null references providers on delete cascade,
  plan varchar(50) not null,
  cost_ numeric(10,2) not null
);

create table if not exists funding
(
  id_ numeric(9,0) primary key,
  type_ varchar(50) not null
);


-- Relations

create table if not exists paid
(
  wage_id numeric(9, 0),
  employee_id numeric(9, 0),
  date_ date,
  primary key (wage_id, employee_id, date_),
  foreign key (wage_id) references wages(id_) on delete cascade,
  foreign key (employee_id) references employees(id_) on delete cascade
);

create table if not exists procured
(
  procurement_id numeric(9, 0),
  book_id numeric(9, 0),
  date_ date,
  cost_ numeric(12, 2) not null,
  primary key (procurement_id, book_id, date_),
  foreign key (procurement_id) references procurements(id_) on delete cascade,
  foreign key (book_id) references books(id_) on delete cascade
);

create table if not exists subscribed
(
  subscription_id numeric(9, 0),
  member_id numeric(9, 0),
  start_date_ date,
  end_date date not null,
  primary key (subscription_id, member_id, start_date_),
  foreign key (subscription_id) references subscriptions(id_) on delete cascade,
  foreign key (member_id) references members(id_) on delete cascade
);

create table if not exists receives
(
  member_id numeric(9, 0),
  penalty_id numeric(9, 0),
  issue_date date,
  due_date date not null,
  primary key (member_id, penalty_id, issue_date),
  foreign key (member_id) references members(id_) on delete cascade,
  foreign key (penalty_id) references penalties(id_) on delete cascade
);

create table if not exists insured
(
  insurance_id numeric(9, 0),
  insurable_entity_id numeric(9, 0),
  start_date_ date,
  end_date date not null,
  primary key (insurance_id, insurable_entity_id, start_date_),
  foreign key (insurance_id) references insurance(id_) on delete cascade,
  foreign key (insurable_entity_id) references insurable_entities(id_) on delete cascade
);

create table if not exists grants
(
  funding_source_id numeric(9, 0),
  funding_id numeric(9, 0),
  amount numeric(12, 2) not null,
  date_ date,
  primary key (funding_source_id, funding_id, date_),
  foreign key (funding_source_id) references funding_sources(id_) on delete cascade,
  foreign key (funding_id) references funding(id_) on delete cascade
);

