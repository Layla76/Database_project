from faker import Faker
import random

fake = Faker()

with open('books.sql', 'w') as file:
    for _ in range(200_000):
        id_ = fake.random_int(min=1000000000, max=9999999999)
        insert_statement = f"INSERT INTO books (id_) VALUES ({id_});\n"
        file.write(insert_statement)

with open('providers.sql', 'w') as file:
    for _ in range(200_000):
        id_ = fake.random_int(min=1000000000, max=9999999999)
        insert_statement = f"INSERT INTO providers (id_) VALUES ({id_});\n"
        file.write(insert_statement)

with open('employees.sql', 'w') as file:
    for _ in range(200_000):
        id_ = fake.random_int(min=100000000, max=999999999)
        insert_statement = f"INSERT INTO employees (id_) VALUES ({id_});\n"
        file.write(insert_statement)

with open('members.sql', 'w') as file:
    for _ in range(200_000):
        id_ = fake.random_int(min=100000000, max=999999999)
        insert_statement = f"INSERT INTO members (id_) VALUES ({id_});\n"
        file.write(insert_statement)

with open('insurable_entities.sql', 'w') as file:
    for _ in range(200_000):
        id_ = fake.random_int(min=1000000000, max=9999999999)
        insert_statement = f"INSERT INTO insurable_entities (id_) VALUES ({id_});\n"
        file.write(insert_statement)

with open('funding_sources.sql', 'w') as file:
    for _ in range(200_000):
        id_ = fake.random_int(min=1000000000, max=9999999999)
        insert_statement = f"INSERT INTO funding_sources (id_) VALUES ({id_});\n"
        file.write(insert_statement)

with open('jobs.sql', 'w') as file:
    for _ in range(200_000):
        id_ = fake.random_int(min=1000000000, max=9999999999)
        insert_statement = f"INSERT INTO jobs (id_) VALUES ({id_});\n"
        file.write(insert_statement)

with open('wages.sql', 'w') as file:
    types = ['salaried', 'hourly', 'overtime', 'bonus']
    for _ in range(200_000):
        id_ = fake.random_int(min=1000000000, max=9999999999)
        job_id = fake.random_int(min=1000000000, max=9999999999)
        type_ = random.choice(types)
        wage = round(random.uniform(1, 10_000_000), 2)
        insert_statement = f"INSERT INTO wages (id_, job_id, type_, wage) VALUES ({id_}, {job_id}, {type_}, {wage});\n"
        file.write(insert_statement)

with open('procurements.sql', 'w') as file:
    types = ['new', 'rare', 'inter_library_loan']
    for _ in range(200_000):
        id_ = fake.random_int(min=1000000000, max=9999999999)
        type_ = random.choice(types)
        insert_statement = f"INSERT INTO procurements (id_, type_) VALUES ({id_}, {type_});\n"
        file.write(insert_statement)

with open('subscriptions.sql', 'w') as file:
    types = ['ordinary', 'family', 'first_time', 'extended']
    for _ in range(200_000):
        id_ = fake.random_int(min=1000000000, max=9999999999)
        type_ = random.choice(types)
        cost = round(random.uniform(1, 10_000_000), 2)
        is_renewable = fake.random_int(min=0, max=1)
        insert_statement = f"INSERT INTO subscriptions (id_, type_, cost, is_renewable) VALUES ({id_}, {type_}, {cost}, {is_renewable});\n"
        file.write(insert_statement)

with open('penalties.sql', 'w') as file:
    types = ['late', 'damaged', 'lost']
    for _ in range(200_000):
        id_ = fake.random_int(min=1000000000, max=9999999999)
        type_ = random.choice(types)
        fee = round(random.uniform(1, 10_000_000), 2)
        insert_statement = f"INSERT INTO penalties (id_, type_, fee) VALUES ({id_}, {type_}, {fee});\n"
        file.write(insert_statement)

with open('insurance.sql', 'w') as file:
    plans = ['book', 'room', 'building']
    for _ in range(200_000):
        id_ = fake.random_int(min=1000000000, max=9999999999)
        provider_id = fake.random_int(min=1000000000, max=9999999999)
        plan = random.choice(plans)
        cost = round(random.uniform(1, 10_000_000), 2)
        insert_statement = f"INSERT INTO insurance (id_, provider_id, plan, cost) VALUES ({id_}, {provider_id}, {plan}, {cost});\n"
        file.write(insert_statement)

with open('funding.sql', 'w') as file:
    types = ['book', 'room', 'building']
    for _ in range(200_000):
        id_ = fake.random_int(min=1000000000, max=9999999999)
        type_ = random.choice(types)
        insert_statement = f"INSERT INTO funding (id_, type_) VALUES ({id_}, {type_});\n"
        file.write(insert_statement)