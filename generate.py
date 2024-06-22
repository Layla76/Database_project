from faker import Faker
import random
import datetime

fake = Faker()

# ENTITIES

# books = 10,000
with open('books.sql', 'w') as file:
    for i in range(10_000):
        id_ = f'{i:<9}'.replace(' ', '0')
        insert_statement = f"INSERT INTO books (id_) VALUES ({id_});\n"
        file.write(insert_statement)

# providers = 9
with open('providers.sql', 'w') as file:
    for i in range(1, 10):
        id_ = i * 111_111_111
        insert_statement = f"INSERT INTO providers (id_) VALUES ({id_});\n"
        file.write(insert_statement)

# employees = 100
with open('employees.sql', 'w') as file:
    for i in range(1, 101):
        id_ = f'{i:<9}'.replace(' ', '0')
        insert_statement = f"INSERT INTO employees (id_) VALUES ({id_});\n"
        file.write(insert_statement)

# members = 1000
with open('members.sql', 'w') as file:
    for i in range(1, 1001):
        id_ = f'{i:<9}'.replace(' ', '0')
        insert_statement = f"INSERT INTO members (id_) VALUES ({id_});\n"
        file.write(insert_statement)

# insurable entities = 12,000
with open('insurable_entities.sql', 'w') as file:
    for i in range(1, 12_001):
        id_ = f'{i:<9}'.replace(' ', '0')
        insert_statement = f"INSERT INTO insurable_entities (id_) VALUES ({id_});\n"
        file.write(insert_statement)

# funding sources = 50
with open('funding_sources.sql', 'w') as file:
    for i in range(1, 51):
        id_ = f'{i:<9}'.replace(' ', '0')
        insert_statement = f"INSERT INTO funding_sources (id_) VALUES ({id_});\n"
        file.write(insert_statement)

# jobs = 30
with open('jobs.sql', 'w') as file:
    for i in range(1, 31):
        id_ = f'{i:<9}'.replace(' ', '0')
        insert_statement = f"INSERT INTO jobs (id_) VALUES ({id_});\n"
        file.write(insert_statement)

# wages = 100 -- 1:1 with employees
with open('wages.sql', 'w') as file:
    types = ['salaried', 'hourly', 'overtime', 'bonus']
    for i in range(1, 101):
        id_ = f'{i:<9}'.replace(' ', '0')
        job_id = f'{(i % 30):<9}'.replace(' ', '0')
        type_ = "'" + random.choice(types) + "'"
        if i < 10:
            wage = round(random.uniform(1_000_000, 10_000_000), 2)
        else:
            wage = round(random.uniform(1_000, 10_000), 2)
        insert_statement = f"INSERT INTO wages (id_, job_id, type_, wage) VALUES ({id_}, {job_id}, {type_}, {wage});\n"
        file.write(insert_statement)

# procurements = 3
with open('procurements.sql', 'w') as file:
    types = ['new', 'rare', 'inter_library_loan']
    for i in range(3):
        id_ = (i + 1) * 111_111_111
        type_ = "'" + types[i] + "'"
        insert_statement = f"INSERT INTO procurements (id_, type_) VALUES ({id_}, {type_});\n"
        file.write(insert_statement)

# subscriptions = 4
with open('subscriptions.sql', 'w') as file:
    types = ['ordinary', 'family', 'first_time', 'extended']
    costs = [300.00, 1000.00, 200.00, 1400.00]
    renewable = [1, 1, 0, 1]
    for i in range(4):
        id_ = (i + 1) * 111_111_111
        type_ = "'" + types[i] + "'"
        cost = costs[i]
        is_renewable = renewable[i]
        insert_statement = f"INSERT INTO subscriptions (id_, type_, cost_, is_renewable) VALUES ({id_}, {type_}, {cost}, {is_renewable});\n"
        file.write(insert_statement)

# penalties = 3
with open('penalties.sql', 'w') as file:
    types = ['late', 'damaged', 'lost']
    fees = [100.00, 300.00, 1000.00]
    for i in range(3):
        id_ = (i + 1) * 111_111_111
        type_ = "'" + random.choice(types) + "'"
        fee = fees[i]
        insert_statement = f"INSERT INTO penalties (id_, type_, fee) VALUES ({id_}, {type_}, {fee});\n"
        file.write(insert_statement)

# insurance = 27 -- 9 providers * 3 variants
with open('insurance.sql', 'w') as file:
    plans = ['book', 'room', 'building']
    for i in range(27):
        id_ = f'{i:<9}'.replace(' ', '0')
        provider_id = ((i % 9) + 1) * 111_111_111
        if i < 9:
            plan = "'" + plans[0] + "'"
            cost = round(random.uniform(10, 500), 2)
        elif i < 18:
            plan = "'" + plans[1] + "'"
            cost = round(random.uniform(1_000, 10_000), 2)
        else:
            plan = "'" + plans[2] + "'"
            cost = round(random.uniform(10_000, 100_000_000), 2)
        insert_statement = f"INSERT INTO insurance (id_, provider_id, plan, cost_) VALUES ({id_}, {provider_id}, {plan}, {cost});\n"
        file.write(insert_statement)

# funding = 3
with open('funding.sql', 'w') as file:
    types = ['book', 'room', 'building']
    for i in range(3):
        id_ = f'{i + 1:<9}'.replace(' ', '0')
        type_ = "'" + types[i] + "'"
        insert_statement = f"INSERT INTO funding (id_, type_) VALUES ({id_}, {type_});\n"
        file.write(insert_statement)


# RELATIONS

# paid
with open('paid.sql', 'w') as file:
    for i in range(200_000):
        id_ = f'{(i % 100) + 1:<9}'.replace(' ', '0')
        date = "'" + str(fake.date_between(start_date=datetime.date(2023, 1, 1), end_date=datetime.date(2024, 6, 15))) + "'"
        insert_statement = f"INSERT INTO paid (wage_id, employee_id, date_) VALUES ({id_}, {id_}, {date});\n"
        file.write(insert_statement)

# procured
with open('procured.sql', 'w') as file:
    p_ids = [111_111_111, 222_222_222, 333_333_333]
    for i in range(200_000):
        procurement_id = random.choice(p_ids)
        book_id = f'{(i % 10_000) + 1:<9}'.replace(' ', '0')
        date = "'" + str(fake.date_between(start_date=datetime.date(2023, 1, 1), end_date=datetime.date(2024, 6, 15))) + "'"
        cost = round(random.uniform(100, 500_000), 2)
        insert_statement = f"INSERT INTO procured (procurement_id, book_id, date_, cost_) VALUES " \
                           f"({procurement_id}, {book_id}, {date}, {cost});\n"
        file.write(insert_statement)

# subscribed
with open('subscribed.sql', 'w') as file:
    s_ids = [111_111_111, 222_222_222, 333_333_333, 444_444_444]
    for i in range(200_000):
        subscription_id = random.choice(s_ids)
        member_id = f'{(i % 1_000) + 1:<9}'.replace(' ', '0')
        start_date = "'" + str(fake.date_between(start_date=datetime.date(2023, 1, 1), end_date=datetime.date(2024, 6, 15))) + "'"
        end_date = "'" + str(fake.date_between(start_date=datetime.date(2023, 2, 1), end_date=datetime.date(2025, 6, 15))) + "'"
        insert_statement = f"INSERT INTO subscribed (subscription_id, member_id, start_date_, end_date) VALUES " \
                           f"({subscription_id}, {member_id}, {start_date}, {end_date});\n"
        file.write(insert_statement)

# receives
with open('receives.sql', 'w') as file:
    p_ids = [111_111_111, 222_222_222, 333_333_333]
    for i in range(200_000):
        member_id = f'{(i % 1_000) + 1:<9}'.replace(' ', '0')
        penalty_id = random.choice(p_ids)
        issue_date = "'" + str(fake.date_between(start_date=datetime.date(2023, 1, 1), end_date=datetime.date(2024, 6, 15))) + "'"
        due_date = "'" + str(fake.date_between(start_date=datetime.date(2023, 2, 1), end_date=datetime.date(2025, 6, 15))) + "'"
        insert_statement = f"INSERT INTO receives (member_id, penalty_id, issue_date, due_date) VALUES " \
                           f"({member_id}, {penalty_id}, {issue_date}, {due_date});\n"
        file.write(insert_statement)

# insured
with open('insured.sql', 'w') as file:
    for i in range(200_000):
        insurance_id = f'{(i % 27) + 1:<9}'.replace(' ', '0')
        insurable_entity_id = f'{(i % 12_000) + 1:<9}'.replace(' ', '0')
        start_date = "'" + str(fake.date_between(start_date=datetime.date(2023, 1, 1), end_date=datetime.date(2024, 6, 15))) + "'"
        end_date = "'" + str(fake.date_between(start_date=datetime.date(2023, 2, 1), end_date=datetime.date(2025, 6, 15))) + "'"
        insert_statement = f"INSERT INTO insured (insurance_id, insurable_entity_id, start_date_, end_date) VALUES " \
                           f"({insurance_id}, {insurable_entity_id}, {start_date}, {end_date});\n"
        file.write(insert_statement)

# grants
with open('grants.sql', 'w') as file:
    f_ids = [100_000_000, 200_000_000, 300_000_000]
    fs_ids = []
    for i in range(50):
        fs_ids.append(f'{i + 1:<9}'.replace(' ', '0'))
    for i in range(200_000):
        funding_source_id = random.choice(fs_ids)
        funding_id = random.choice(f_ids)
        amount = round(random.uniform(100, 500_000), 2)
        date = "'" + str(fake.date_between(start_date=datetime.date(2021, 1, 1), end_date=datetime.date(2024, 6, 15))) + "'"
        insert_statement = f"INSERT INTO grants (funding_source_id, funding_id, amount, date_) VALUES " \
                           f"({funding_source_id}, {funding_id}, {amount}, {date});\n"
        file.write(insert_statement)
