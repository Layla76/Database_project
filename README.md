
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

7. Delete subscribed members who have had more than 5 penalties<br />
  Response:        DELETE 199076
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

![image](https://github.com/user-attachments/assets/3c3f6011-122b-4f26-9351-de333d1adff5)<br />

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
