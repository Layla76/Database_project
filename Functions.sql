-- 1. Get the sum of the book prices
create or replace function get_sum_book_prices()
returns numeric
as
$$
begin
 RETURN (
  SELECT SUM(books.price)
  FROM assets
  INNER JOIN procurements ON assets.id_ = procurements.asset_id
  INNER JOIN books ON assets.id_ = books.asset_id
  WHERE assets.type_ = 'book' and procurements.status_ = 1
 );
end;
$$
language plpgsql;

-- CREATE FUNCTION
-- Time: 4.024 ms


-- 2. Get the most expensive procurement
create or replace function get_most_expensive_procurement()
returns numeric
as
$$
begin
 RETURN (
  SELECT MAX(buildings.price)
  FROM suppliers
  INNER JOIN procurements ON suppliers.id_ = procurements.supplier_id
  INNER JOIN assets ON assets.id_ = procurements.asset_id
  INNER JOIN buildings ON buildings.asset_id = assets.id_
  WHERE assets.type_ = 'building' and procurements.status_ = 1
 );
end;
$$
language plpgsql;

-- CREATE FUNCTION
-- Time: 4.245 ms


-- 3. Get average insurance plan length
create or replace function get_avg_insurance_length()
returns numeric
as
$$
begin
 RETURN (
  SELECT AVG(end_date - start_date_) AS avg_length_in_days
  FROM insured
  INNER JOIN insurance ON insurance.id_ = insured.insurance_id
  INNER JOIN assets ON assets.id_ = insured.asset_id
 );
end;
$$
language plpgsql;

-- CREATE FUNCTION
-- Time: 2.698 ms


-- 4. Get price sum of books/rooms/buildings
create or replace function get_total_price_for_asset_type(asset_type text)
returns numeric
as
$$
begin
    RETURN (
        SELECT SUM(price * tables.flow_direction)
        FROM procurements
        INNER JOIN cash_flow ON cash_flow.id_ = procurements.cash_flow_id
        INNER JOIN tables ON cash_flow.table_id = tables.id_
        INNER JOIN assets ON assets.id_ = procurements.asset_id
        INNER JOIN (
            SELECT asset_id, price FROM books
            UNION ALL
            SELECT asset_id, price FROM rooms
            UNION ALL
            SELECT asset_id, price FROM buildings
        ) AS asset_prices ON assets.id_ = asset_prices.asset_id
        WHERE procurements.status_ = 1 and assets.type_ = asset_type and tables.name_ = 'procurements'
     );
end;
$$
LANGUAGE plpgsql;

-- CREATE FUNCTION
-- Time: 19.267 ms

