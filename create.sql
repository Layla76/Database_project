-- Entities

create table if not exists people
(
  id_ numeric(9,0) primary key
);

create table if not exists providers
(
  id_ numeric(9,0) primary key
);

create table if not exists jobs
(
  id_ numeric(9,0) primary key
);

create table if not exists donors
(
  id_ numeric(9,0) primary key
);

create table if not exists employees
(
  id_ numeric(9,0) primary key,
  person_id numeric(9,0) references people(id_) on delete cascade
);

create table if not exists members
(
  id_ numeric(9,0) primary key,
  person_id numeric(9,0) references people(id_) on delete cascade
);

create table if not exists assets
(
  id_ numeric(9,0) primary key,
  type_ varchar(50) not null
);

create table if not exists books
(
  asset_id numeric(9,0) primary key references assets(id_) on delete cascade,
  price numeric(4,2) not null
);

create table if not exists rooms
(
  asset_id numeric(9,0) primary key references assets(id_) on delete cascade,
  price numeric(4,0) not null
);

create table if not exists buildings
(
  asset_id numeric(9,0) primary key references assets(id_) on delete cascade,
  price numeric(8,0) not null
);

create table if not exists tables
(
  id_ numeric(9,0) primary key,
  name_ varchar(50) not null,
  flow_direction numeric(1,0) not null
);

create table if not exists cash_flow
(
  id_ numeric(9,0) primary key,
  table_id numeric(9,0) references tables(id_) on delete cascade
);

create table if not exists grants
(
  cash_flow_id numeric(9,0) primary key references cash_flow(id_) on delete cascade,
  donor_id numeric(9,0) references donors(id_) on delete cascade,
  amount numeric(12, 2) not null,
  date_ date not null,
  status_ numeric(1,0) not null
);

create table if not exists wages
(
  id_ numeric(9,0) primary key,
  job_id numeric(9,0) not null references jobs(id_) on delete cascade,
  wage numeric(12,2) not null
);

create table if not exists suppliers
(
  id_ numeric(9,0) primary key
);

create table if not exists insurance
(
  id_ numeric(9,0) primary key,
  provider_id numeric(9,0) not null references providers(id_) on delete cascade,
  cost_ numeric(10,2) not null
);

create table if not exists subscriptions
(
  id_ numeric(9,0) primary key,
  type_ varchar(50) not null,
  cost_ numeric(6,2) not null
);

create table if not exists penalties
(
  id_ numeric(9,0) primary key,
  type_ varchar(50) not null,
  fee numeric(6,2) not null
);



-- Relations

create table if not exists payments
(
  cash_flow_id numeric(9,0) primary key references cash_flow(id_) on delete cascade,
  wage_id numeric(9, 0) references wages(id_) on delete cascade,
  employee_id numeric(9, 0) references employees(id_) on delete cascade,
  date_ date not null,
  status_ numeric(1,0) not null,
  unique (wage_id, employee_id, date_)
);

create table if not exists procurements
(
  cash_flow_id numeric(9,0) primary key references cash_flow(id_) on delete cascade,
  supplier_id numeric(9, 0) references suppliers(id_) on delete cascade,
  asset_id numeric(9, 0) references assets(id_) on delete cascade,
  date_ date not null,
  status_ numeric(1, 0) not null,
  unique (supplier_id, asset_id, date_)
);

create table if not exists subscribed
(
  cash_flow_id numeric(9,0) primary key references cash_flow(id_) on delete cascade,
  subscription_id numeric(9, 0) references subscriptions(id_) on delete cascade,
  member_id numeric(9, 0) references members(id_) on delete cascade,
  start_date_ date not null,
  end_date date not null,
  status_ numeric(1, 0) not null,
  unique (subscription_id, member_id, start_date_)
);

create table if not exists member_penalties
(
  cash_flow_id numeric(9,0) primary key references cash_flow(id_) on delete cascade,
  member_id numeric(9, 0) references members(id_) on delete cascade,
  penalty_id numeric(9, 0) references penalties(id_) on delete cascade,
  issue_date date not null,
  due_date date not null,
  status_ numeric(1, 0) not null,
  unique (member_id, penalty_id, issue_date)
);

create table if not exists insured
(
  cash_flow_id numeric(9,0) primary key references cash_flow(id_) on delete cascade,
  insurance_id numeric(9, 0) references insurance(id_) on delete cascade,
  asset_id numeric(9, 0) references assets(id_) on delete cascade,
  start_date_ date not null,
  end_date date not null,
  status_ numeric(1, 0) not null,
  unique (insurance_id, asset_id, start_date_)
);
