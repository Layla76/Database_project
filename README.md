# Database_project

[ERD image](ERD.png)

[DSD image](DSD.png)

[Dump image 1](Dump1.png)
[Dump image 2](Dump2.png)
[Dump image 3](Dump3.png)
[Dump image 4](Dump4.png)
[Dump image 5](Dump5.png)

The database entities relate to the subject “billing.”

Wages
- Provides a list of the types of wage options (hourly, salaried, overtime, bonus).
- One of its attributes is job_id, a primary key from the jobs table, which makes it a foreign key in the wages table.
- An additional entity that is needed is employees, so that Wwges x employees can interact in the relation "paid."

Procurements
- Provideds a list of the types of procurement options (new, rare, inter-library loan).
- An additional entity that is needed is books, so that procurements x books can interact in the relation "procured."

Subscriptions
- Provides a list of the types of subscription options (ordinary, family, first time, extended).
- An additional entity that is needed is members, so that subscriptions x members can interact in the relation "subscribed."

Penalties
- Provides a list of the types of penalty options (late, damaged, lost).
- An additional entity that is needed is members, so that penalties x members can interact in the relation "receives."

Insurance
- Provides a list of the types of insurance options (book, room, building).
- One of its attributes is provider_id, a primary key from the providers table, which makes it a foreign key in the insurance table.
- An additional entity that is needed is insurable_entities, so that insurance x insurable_entities can interact in the relation "insured."

Funding
- Provides a list of the types of funding options (book, room, building).
- An additional entity that is needed is funding_sources, so that funding x funding_sources can interact in the relation "grants."

Data generation
- Made a python script (generate.py) to generate all insert statements.
- 200,000 rows per table


------------------------------------------------------------------------


1. How much money has the library spent on books?
  Response:       49583649665.73
  Time:           95.054 ms
  Improved time:  
  
2. What was the most expensive procurement?
  Response:       499995.54
  Time:           47.569 ms
  Improved time:  

3. How much have members paid in fines due for each type of penalty?
  Response:       damaged = 61714000.00
                  late = 6178800.00
                  lost = 18595500.00
  Time:           57.240 ms
  Improved time: 

4. What is the average funding given per grant?
  Response:       250518.302880111000
  Time:           1894.002 ms
  Improved time:  

5. Add 90 days to insured end dates
  Response:       UPDATE 192299
  Time:           11.262 ms
  Improved time: 

6. Increase family subscriptions by $5
  Response:       UPDATE 189059
  Time:           1793.834 ms
  Improved time: 

7. Delete subscribed members who have a first time subscription and who have had more than 5 penalties
  Response:       DELETE 189059
  Time:           434.161 ms
  Improved time: 

8. Delete procurements that cost less than $30000
  Response:       DELETE 11633
  Time:           175.577 ms
  Improved time: 


1. Delete payments that were less than $[numeric]
  Response:       DELETE 46844
  Time:           90.673 ms
  Improved time: 

2. How many items are insured for over $[numeric]?
  Response:       10800
  Time:           111.030 ms
  Improved time: 

3. The deadline for penalties is extended by [int] days
  Response:       UPDATE 185487
  Time:           1536.594 ms
  Improved time: 

4. How many subscriptions are active after [date]?
  Response:       122223
  Time:           43.153 ms
  Improved time: 
