
# Database_project

Stage 1

![image](https://github.com/user-attachments/assets/baa9067a-0b49-4853-a668-74ceeb04e21c)
<br /><br />
The ERD shows all entities and relations related to billing.  <br /><br />


CASH FLOW

Tables (tables that list incoming or outgoing funds): <br />
ID - PK <br />
Name - name of table (grants, payments, procurements, insured, subscribed, member penalties) <br />
Flow direction - incoming - 1 or outgoing - -1 <br />

Cash flow: <br />
ID - PK <br />
Table ID - FK from tables table <br />

** All tables in tables.name will have non overlapping foreign keys from cash_flow.ID

-----

LIBRARY ASSETS  <br />

Assets: <br />
ID - PK <br />
Type -  books, rooms, or buildings <br />

Books:  <br />
Asset ID - PK, FK from asset table  <br />
Price - price of the book  <br />

Rooms:  <br />
Asset ID - PK, FK from asset table  <br />
Price - price of the room  <br />

Buildings: <br />
Asset ID - PK, FK from asset table <br />
Price - price of the building <br />

** Books, rooms, and buildings will have no overlapping keys with each other. This is acheived by first creating a new asset row, and then using its ID to create a new book/room/building row.

Suppliers (sources to buy assets for the library): <br />
ID - PK <br />

Procurements -- between assets and suppliers: <br />
Cash flow ID - PK, FK from cash flow table <br />
Date - date of procurement <br />
Status - have funds been transferred yet? 0 - no, 1 - yes <br />
** The cost is based on the corresponding cost of the asset’s type ID <br />

Providers (insurance providers): <br />
ID - PK <br />

Insurance (insurance plans): <br />
ID - PK <br />
Cost - cost of insurance plan <br />
Provider ID - FK from providers table <br />

Insured -- between assets and insurance: <br />
Cash flow ID - PK, FK from cash flow table <br />
Start date - start date of plan <br />
End date - end date of plan <br />
Status - have funds been transferred yet? 0 - no, 1 - yes <br />

-----

EMPLOYEE SALARIES

Jobs: <br />
ID - PK <br />

Wages: <br />
ID - PK <br />
Job ID - FK from jobs table <br />
Wage - the set monthly wage <br />

People (all people in the database): <br />
ID - PK <br />

Employees: <br />
ID - PK <br />
Person ID - FK from people table <br />

Payments -- between wages and employees: <br />
Cash flow ID - PK, FK from cash flow table <br />
Date - payment due date <br />
Status - have funds been transferred yet? 0 - no, 1 - yes <br />

-----

LIBRARY MEMBERS

Members: <br />
ID - PK <br />
Person ID - FK from people table <br />

Subscriptions (member subscriptions): <br />
ID - PK <br />
Type - regular, student, soldier, senior <br />
Cost - cost of subscription <br />

Subscribed -- between members and subscriptions: <br />
Cash flow ID - PK, FK from cash flow table <br />
Start date - start date of subscription <br />
End date - end date of subscription <br />
Status - have funds been transferred yet? 0 - no, 1 - yes <br />

Penalties (fines for members): <br />
ID - PK <br />
Type - late book, lost book, damaged book <br />
Fee - cost of fine <br />

Member penalties -- between members and penalties: <br />
Cash flow ID - PK, FK from cash flow table <br />
Issue date - date given <br />
Due date - date payment is due <br />
Status - have funds been transferred yet? 0 - no, 1 - yes <br />

-----

GRANTS

Donors: <br />
ID - PK <br />

Grants: <br />
Cash flow ID - PK, FK from cash flow table <br />
Donor ID - FK from donor table <br />
Amount - amount to be donated <br />
Date - date of donation <br />
Status - have funds been transferred yet? 0 - no, 1 - yes <br />


![image](https://github.com/user-attachments/assets/45edb5cc-99b0-4b02-9fca-fe7c4fa2fa73)

[Dump image 1](Dumps/Dump1.png)
[Dump image 2](Dumps/Dump2.png)
[Dump image 3](Dumps/Dump3.png)
[Dump image 4](Dumps/Dump4.png)
[Dump image 5](Dumps/Dump5.png)

The file for creating the tables: [create.sql](create.sql)<br />

Data generation
- Made a [python script](generate.py) to generate all insert statements.
- 200,000 rows per relation table

The json file: [json](ERD.json)<br />

Data dump script: [dump](dump_data.py)<br />

------------------------------------------------------------------------

Stage 2<br />

Backup and restore:<br />

[Backup log](backupSQL.log)<br />
[Backup sql](backupSQL.sql)<br />
[Backup log](backupPSQL.log)<br />
[Backup psql](backupPSQL.sql)<br />

-----
<br />

[Regular queries](Queries.sql)<br />

1. How much money has the library spent on books?<br />
  Response:       922476.57
  <br />

2. What was the most expensive procurement?<br />
  Response:       4999769
  <br />

3. What is the average insurance plan length in use?<br />
  Response:       183.1465088248385822
  <br />

4. What is the library's balance?<br />
  Response:       -22044209639.12
<br />

5. Add 90 days to each insurance plan<br />
  Response:        UPDATE 199958
<br />

6. Add 30 days to each subscription<br />
  Response:       UPDATE 199076
<br />

7. Delete books and rooms that have an asset id that already exists in another asset table<br />
  Response:        DELETE 5998
                    DELETE 0 <br />
<br />

8. Delete procurements that cost more than 3,000,000<br />
  Response:       DELETE 21202
<br /><br />

[Parameterized queries](ParamsQueries)<br />

1. Delete payments that were less than $[numeric]<br />
  Response:       DELETE 196347
<br />

2. How many items are insured for over $[numeric]?<br />
  Response:       63660
<br />

3. The deadline for penalties is extended by [int] days<br />
  Response:       UPDATE 198744
<br />

4. How many subscriptions are active after [date]?<br />
  Response:       124944
<br />

-----
<br />

[Old query time logs](OldTimes.log)<br />
<br />

-----
<br />

*** Indexes: <br /><br />
CREATE<br />
UNIQUE INDEX asset_type<br />
ON assets(id_, type_);<br />

CREATE <br />
UNIQUE INDEX table_name<br />
ON tables(id_, name_);<br />

CREATE<br />
UNIQUE INDEX insured_dates<br />
ON insured(cash_flow_id, start_date_, end_date);<br />

----- 
<br />

[New query time logs](NewTimes.log)<br />

![image](https://github.com/user-attachments/assets/0991703a-5b29-417f-bf6c-0ee67d2a9851)
<br />

[Constraints + updates to test contraints](Constraints.sql)<br />

Errors and explanations:<br />

////////////////////////////////////////////////// Errors due to updating amounts, costs, etc to a negative number //////////////////////////////////////////////////<br /><br />
psql:/Users/laylastein/Database_project/Database_project/Constraints.sql:99: ERROR:  new row for relation "subscriptions" violates check constraint "sub_cost"<br />
DETAIL:  Failing row contains (111111111, regular, -1.00).<br />
<br />

psql:/Users/laylastein/Database_project/Database_project/Constraints.sql:102: ERROR:  new row for relation "wages" violates check constraint "pos_wage"<br />
DETAIL:  Failing row contains (100000000, 340000000, -1.00).<br />
<br />

psql:/Users/laylastein/Database_project/Database_project/Constraints.sql:105: ERROR:  new row for relation "penalties" violates check constraint "pen_fee"<br />
DETAIL:  Failing row contains (111111111, lost, -1.00).<br />
<br />

psql:/Users/laylastein/Database_project/Database_project/Constraints.sql:108: ERROR:  new row for relation "insurance" violates check constraint "pos_ins"<br />
DETAIL:  Failing row contains (100000000, 111111111, -1.00).<br />
<br />

psql:/Users/laylastein/Database_project/Database_project/Constraints.sql:111: ERROR:  new row for relation "books" violates check constraint "pos_price_bo"<br />
DETAIL:  Failing row contains (100000000, -1.00).<br />
<br />

psql:/Users/laylastein/Database_project/Database_project/Constraints.sql:114: ERROR:  new row for relation "rooms" violates check constraint "pos_price_r"<br />
DETAIL:  Failing row contains (300010000, -1).<br />
<br />

psql:/Users/laylastein/Database_project/Database_project/Constraints.sql:117: ERROR:  new row for relation "buildings" violates check constraint "pos_price_bu"<br />
DETAIL:  Failing row contains (600010000, -1).<br />
<br />

psql:/Users/laylastein/Database_project/Database_project/Constraints.sql:123: ERROR:  new row for relation "grants" violates check constraint "pos_grant"<br />
DETAIL:  Failing row contains (100000000, 123000000, -1.00, 2023-07-03, 1).<br />
<br /><br />

-----
<br />

////////////////////////////////////////////////// Errors due to updating status to be something other than 1 or 0 //////////////////////////////////////////////////<br /><br />
psql:/Users/laylastein/Database_project/Database_project/Constraints.sql:126: ERROR:  new row for relation "grants" violates check constraint "stat_grant"<br />
DETAIL:  Failing row contains (100000000, 123000000, 44573.00, 2023-07-03, -1).<br />
<br />
psql:/Users/laylastein/Database_project/Database_project/Constraints.sql:129: ERROR:  new row for relation "procurements" violates check constraint "stat_proc"<br />
DETAIL:  Failing row contains (400001000, 100000000, 400000000, 2024-03-16, -1).<br />
<br />
psql:/Users/laylastein/Database_project/Database_project/Constraints.sql:132: ERROR:  new row for relation "insured" violates check constraint "stat_insured"<br />
DETAIL:  Failing row contains (100000100, 200000000, 100000000, 2023-09-03, 2024-02-02, -1).<br />
<br />
psql:/Users/laylastein/Database_project/Database_project/Constraints.sql:135: ERROR:  new row for relation "payments" violates check constraint "stat_pay"<br />
DETAIL:  Failing row contains (200001000, 100000000, 100000000, 2024-03-01, -1).<br />
<br />
psql:/Users/laylastein/Database_project/Database_project/Constraints.sql:138: ERROR:  new row for relation "subscribed" violates check constraint "stat_sub"<br />
DETAIL:  Failing row contains (600002000, 333333333, 200000000, 2023-09-04, 2024-08-20, -1).<br />
<br />
psql:/Users/laylastein/Database_project/Database_project/Constraints.sql:141: ERROR:  new row for relation "member_penalties" violates check constraint "stat_mem_pen"<br />
DETAIL:  Failing row contains (800001000, 100000000, 222222222, 2023-01-24, 2024-11-09, -1).<br />
<br /><br />

-----
<br />

////////////////////////////////////////////////// Errors due to updating start dates to be after end dates //////////////////////////////////////////////////<br /><br />
psql:/Users/laylastein/Database_project/Database_project/Constraints.sql:120: ERROR:  new row for relation "subscribed" violates check constraint "subscribed_dates"<br />
DETAIL:  Failing row contains (600002000, 333333333, 200000000, 2024-08-21, 2024-08-20, 0).<br />
<br />
psql:/Users/laylastein/Database_project/Database_project/Constraints.sql:144: ERROR:  new row for relation "insured" violates check constraint "insured_dates"<br />
DETAIL:  Failing row contains (100000100, 200000000, 100000000, 2024-02-03, 2024-02-02, 1).<br />
<br />
psql:/Users/laylastein/Database_project/Database_project/Constraints.sql:147: ERROR:  new row for relation "subscribed" violates check constraint "subscribed_dates"<br />
DETAIL:  Failing row contains (600002000, 333333333, 200000000, 2024-08-21, 2024-08-20, 0).<br />
<br />
psql:/Users/laylastein/Database_project/Database_project/Constraints.sql:150: ERROR:  new row for relation "member_penalties" violates check constraint "mem_pen_dates"<br />
DETAIL:  Failing row contains (800001000, 100000000, 222222222, 2024-11-10, 2024-11-09, 1).<br />
<br />

-----

Stage 3<br />

New queries using joins

1. Time: 90.838 ms
2. Time: 55.907 ms
3. Time: 116.002 ms

![image](https://github.com/user-attachments/assets/653acf15-00e0-4c7b-b38b-ae6213212afc)<br />
<br />

-----
<br />

[Views and select queries](Views.sql)<br />

Only after I wrote the above views did I realize that views can only have updates/insertions/deletions if they're from a single table. So [here](UpdatableViews.sql) are four new views for the purpose of updating/inserting/deleting.<br />

-----
<br /><br />

Generating total prices for books, rooms, and buildings<br /><br />
![image](https://github.com/user-attachments/assets/7d8f5274-7035-4898-ac0f-d856fd36946d)<br /><br /><br />
![image](https://github.com/user-attachments/assets/024d6a64-1c66-46e0-96e9-6a2a56ac5b0d)<br /><br /><br />
![image](https://github.com/user-attachments/assets/8c31d453-e3f5-4b45-8681-108073c9eef6)<br /><br /><br />
The reason that the totals for books and rooms seems to be zero in the graph is that proportionally, the total spend on buildings is much greater (data generation was random, but given contraints so that books prices < room prices < building prices). The first line on the y axis is already 20,000,000,000, which is 2 and 4 order of magnitudes greater than the rooms and books total, respectively.
<br /><br /><br /><br />

Generating total subscriptions for regular, student, soldier, and senior<br /><br />
![image](https://github.com/user-attachments/assets/fc58f7d4-1cc8-4b99-8d9e-ae923d1f229c)<br /><br /><br />
![image](https://github.com/user-attachments/assets/1fc35eaf-ce8f-445a-989d-c519f49feaac)<br /><br /><br />
![image](https://github.com/user-attachments/assets/2bd94269-4c98-406e-94b3-d004e10ac343)<br /><br /><br />
<br /><br /><br />

-----<br /><br />

[Functions](Functions.sql)<br />

Function #4 combines three select queries for the prices of books, rooms, and buildings. The parameter is the asset type (book/room/building) and instead of one of the inner joins being either the book, room, or building table, it unions the tables so that the asset id will match a row in the new table.
<br /><br />

[Triggers](Triggers.sql)<br /><br />

The two triggers make sure that [1] asset ids across books, rooms, and buildings are all unique and [2] cash flow ids across grants + all relation tables are unique. The trigger calls the function with a parameter specifying the relevant table, and the function inserts a new asset/cash flow and inserts the same id* to the new row that called the trigger. The id is retrieved by selecting the first id that appears in a table of descending ids. The passed argument can only be referenced through the variable TG_ARGV[0].<br /><br />

The id is determined by a sequence that increases by 1 for each insertion.** <br />

CREATE SEQUENCE asset_id_seq;<br />
CREATE SEQUENCE cf_id_seq;<br />

Altering the tables to have the default primary key go by the sequence<br />
ALTER TABLE assets<br />
ALTER COLUMN id_ SET DEFAULT nextval('asset_id_seq');<br /><br />

ALTER TABLE cash_flow<br />
ALTER COLUMN id_ SET DEFAULT nextval('cf_id_seq');<br /><br />

I found the max ids for each table and set the sequences to the max + 1<br />

SELECT setval('asset_id_seq', 999990001, false);<br />
SELECT setval('cf_id_seq', 999999001, false);<br /><br />

Inserting into books:<br />
INSERT INTO books (price) values (10.00);<br />
INSERT 0 1<br />
Time: 16.337 ms<br />

Books table:<br />
![image](https://github.com/user-attachments/assets/03d14bc5-a766-4a59-8b53-62e72614df29)<br />
<br />
Assets table:<br />
![image](https://github.com/user-attachments/assets/466a2f32-4ff4-4650-a61d-adb1cf09adab)<br />
<br /><br />

Inserting into grants:<br />
INSERT INTO grants (donor_id, amount, date_, status_) values (123000000, 40826.00, '2024-08-07', 0);<br />
INSERT 0 1<br />
Time: 17.395 ms<br />
<br />
Grants table:<br />
![image](https://github.com/user-attachments/assets/701a39bd-b0d2-4dc5-9f4c-e291beab8d85)<br />
<br />
Cash flow table:<br />
![image](https://github.com/user-attachments/assets/d4eba391-aabf-410f-a76c-17821633106e)<br />

