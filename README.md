# Database_project

![image](https://github.com/user-attachments/assets/59a502a8-a608-487e-b8da-c8063f33d229)

The ERD shows all things related to billing.

LIBRARY ASSETS  <br />

Books:  <br />
ID - PK  <br />
Price - price of the book  <br />

Rooms:  <br />
ID - PK  <br />
Price - price of the room  <br />


Building: <br />
ID - PK <br />
Price - price of the building <br />

Assets: <br />
ID - PK <br />
Type -  books, rooms, or buildings <br />
Type ID - FK from the table of the given type <br />

Suppliers (sources to buy assets for the library): <br />
ID - PK <br />
Name - name of the supplier <br />

Procurements -- between assets and suppliers: <br />
ID - PK so that it can be referenced by the “tables” table below <br />
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
ID - PK so that it can be referenced by the “tables” table below <br />
Start date - start date of plan <br />
End date - end date of plan <br />
Status - have funds been transferred yet? 0 - no, 1 - yes <br />

-----

EMPLOYEE SALARIES

Jobs: <br />
ID - PK <br />
Title - the name of the position <br />

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
ID - PK so that it can be referenced by the “tables” table below <br />
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
ID - PK so that it can be referenced by the “tables” table below <br />
Start date - start date of subscription <br />
End date - end date of subscription <br />
Status - have funds been transferred yet? 0 - no, 1 - yes <br />

Penalties (fines for members): <br />
ID - PK <br />
Type - late book, lost book, damaged book <br />
Fee - cost of fine <br />

Member penalties -- between members and penalties: <br />
ID - PK so that it can be referenced by the “tables” table below <br />
Issue date - date given <br />
Due date - date payment is due <br />
Status - have funds been transferred yet? 0 - no, 1 - yes <br />

-----

GRANTS

Donors: <br />
ID - PK <br />
Name - name of donor <br />

Grants: <br />
ID - PK <br />
Donor ID - FK from donor table <br />
Amount - amount to be donated <br />
Date - date of donation <br />
Status - have funds been transferred yet? 0 - no, 1 - yes <br />

-----

CASH FLOW

Tables (tables that list incoming or outgoing funds): <br />
ID - PK <br />
Name - name of table (grants, payments, procurements, insured, subscribed, member penalties) <br />
Flow direction - incoming or outgoing <br />


Cash flow: <br />
ID - PK <br />
Table ID - FK from tables table <br />
Type ID - FK from the given type table <br />


![image](https://github.com/user-attachments/assets/4fbe96ee-06d3-42e6-a0dc-0ad4ba897e39)

[Dump image 1](Dump1.png)
[Dump image 2](Dump2.png)
[Dump image 3](Dump3.png)
[Dump image 4](Dump4.png)
[Dump image 5](Dump5.png)

Data generation
- Made a python script (generate.py) to generate all insert statements.
- 200,000 rows per relation table


------------------------------------------------------------------------


1. How much money has the library spent on books?
  Response:       49583649665.73
  Time:           95.054 ms
  New time:       94.361 ms
  
2. What was the most expensive procurement?
  Response:       499995.54
  Time:           93.568 ms 47.910 ms
  New time:       45.900 ms

3. What is the average insurance plan length in use?
  Response:       290.0300261571823046
  Time:           96.274 ms
  New time:       70.464 ms

4. What is the average funding given per grant?
  Response:       250518.302880111000
  Time:           ~1875 ms 99.040 ms
  New time:       97.761 ms

5. Add 90 days to each insurance plan
  Response:       UPDATE 192299
  Time:           11.262 ms 1887.873 ms
  New time:       2591.625 ms

6. Add 30 days to each subscription
  Response:       UPDATE 189059
  Time:           1793.834 ms 1940.444 ms
  New time:       1747.863 ms

7. Delete subscribed members who have a first time subscription and who have had more than 5 penalties
  Response:       DELETE 189059
  Time:           434.161 ms
  New time:       351.778 ms

8. Delete procurements that cost less than $30000
  Response:       DELETE 11633
  Time:           175.577 ms
  New time:       84.050 ms


1. Delete payments that were less than $[numeric]
  Response:       DELETE 46844
  Time:           90.673 ms
  New time:       107.955 ms

2. How many items are insured for over $[numeric]?
  Response:       10800
  Time:           111.030 ms
  New time:       83.017 ms

3. The deadline for penalties is extended by [int] days
  Response:       UPDATE 185487
  Time:           1536.594 ms
  New time:       1497.826 ms

4. How many subscriptions are active after [date]?
  Response:       122223
  Time:           43.153 ms
  New time:       41.700 ms


Explanation of constraint errors:
1. subscriptions.is_renewable is not 0 or 1
2. subscriptions.cost_ is negative
3. wages.wage is not positive
4. penalties.fee is negative
5. insurance.cost_ is negative
6. procured.cost_ is negative
7. subscribed.start_date_ is later than end_date
8. receives.issue_date is later than due_date
9. insured.start_date_ is later than end_date
10. grants.amount is negative
