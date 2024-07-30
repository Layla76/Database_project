-- 1. Add new asset before adding the same id to books/rooms/buildings

-- function
CREATE OR REPLACE function add_asset()
returns trigger
as
$$
declare 
  new_id INTEGER;
begin
 IF TG_ARGV[0] = 'book' THEN
  INSERT INTO assets (id_, type_) VALUES (new_id, 'book');
  SELECT id_ INTO new_id FROM assets WHERE type_ = 'book' ORDER BY id_ DESC LIMIT 1;
 ELSIF TG_ARGV[0] = 'room' THEN
  INSERT INTO assets (type_) VALUES ('room');
  SELECT id_ INTO new_id FROM assets WHERE type_ = 'room' ORDER BY id_ DESC LIMIT 1;
 ELSIF TG_ARGV[0] = 'building' THEN
  INSERT INTO assets (type_) VALUES ('building');
  SELECT id_ INTO new_id FROM assets WHERE type_ = 'building' ORDER BY id_ DESC LIMIT 1;
 END IF;
 insert into books (price) values (10.00);

 NEW.asset_id := new_id;
 return NEW;
end;
$$
language plpgsql;

-- CREATE FUNCTION
-- Time: 7.101 ms

-- triggers
CREATE trigger add_asset_book
BEFORE INSERT
ON books
FOR EACH ROW
EXECUTE function add_asset('book');

-- CREATE TRIGGER
-- Time: 9.903 ms

CREATE trigger add_asset_room
BEFORE INSERT
ON rooms
FOR EACH ROW
EXECUTE function add_asset('room');

-- CREATE TRIGGER
-- Time: 1.388 ms

CREATE trigger add_asset_building
BEFORE INSERT
ON buildings
FOR EACH ROW
EXECUTE function add_asset('building');

-- CREATE TRIGGER
-- Time: 0.462 ms


-- 2. Add new cash flow before adding the same id to grants/payments/procurements/insured/subscribed/member_penalties

-- function
CREATE OR REPLACE function add_cash_flow()
returns trigger
as
$$
declare 
  new_id INTEGER;

begin

IF TG_ARGV[0] = '100000000' THEN
  INSERT INTO cash_flow (table_id) VALUES (100000000);
  SELECT id_ INTO new_id FROM cash_flow WHERE table_id = 100000000 ORDER BY id_ DESC LIMIT 1;
 ELSIF TG_ARGV[0] = '200000000' THEN
  INSERT INTO cash_flow (table_id) VALUES (200000000);
  SELECT id_ INTO new_id FROM cash_flow WHERE table_id = 200000000 ORDER BY id_ DESC LIMIT 1;
 ELSIF TG_ARGV[0] = '300000000' THEN
  INSERT INTO cash_flow (table_id) VALUES (300000000);
  SELECT id_ INTO new_id FROM cash_flow WHERE table_id = 300000000 ORDER BY id_ DESC LIMIT 1;
 ELSIF TG_ARGV[0] = '400000000' THEN
  INSERT INTO cash_flow (table_id) VALUES (400000000);
  SELECT id_ INTO new_id FROM cash_flow WHERE table_id = 400000000 ORDER BY id_ DESC LIMIT 1;
 ELSIF TG_ARGV[0] = '500000000' THEN
  INSERT INTO cash_flow (table_id) VALUES (500000000);
  SELECT id_ INTO new_id FROM cash_flow WHERE table_id = 500000000 ORDER BY id_ DESC LIMIT 1;
 ELSIF TG_ARGV[0] = '600000000' THEN
  INSERT INTO cash_flow (table_id) VALUES (600000000);
  SELECT id_ INTO new_id FROM cash_flow WHERE table_id = 600000000 ORDER BY id_ DESC LIMIT 1;
 END IF;

 NEW.cash_flow_id := new_id;
 return NEW;
end;
$$
language plpgsql;

-- CREATE FUNCTION
-- Time: 5.102 ms

-- triggers
CREATE trigger add_cf_grants
BEFORE INSERT
ON grants
FOR EACH ROW
EXECUTE function add_cash_flow(100000000);

-- CREATE TRIGGER
-- Time: 2.182 ms

CREATE trigger add_cf_procurements
BEFORE INSERT
ON procurements
FOR EACH ROW
EXECUTE function add_cash_flow(200000000);

-- CREATE TRIGGER
-- Time: 0.618 ms

CREATE trigger add_cf_insured
BEFORE INSERT
ON insured
FOR EACH ROW
EXECUTE function add_cash_flow(300000000);

-- CREATE TRIGGER
-- Time: 0.295 ms

CREATE trigger add_cf_payments
BEFORE INSERT
ON payments
FOR EACH ROW
EXECUTE function add_cash_flow(400000000);

-- CREATE TRIGGER
-- Time: 0.320 ms

CREATE trigger add_cf_subscribed
BEFORE INSERT
ON subscribed
FOR EACH ROW
EXECUTE function add_cash_flow(500000000);

-- CREATE TRIGGER
-- Time: 0.281 ms

CREATE trigger add_cf_member_penalties
BEFORE INSERT
ON member_penalties
FOR EACH ROW
EXECUTE function add_cash_flow(600000000);

-- CREATE TRIGGER
-- Time: 2.491 ms