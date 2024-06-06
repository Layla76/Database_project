# Database_project

[ERD image](ERD.png)

[DSD image](DSD.png)

[Dump image 1](Dump1.png) [Dump image 2](Dump2.png) [Dump image 3](Dump3.png) [Dump image 4](Dump4.png) [Dump image 5](Dump5.png)

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
