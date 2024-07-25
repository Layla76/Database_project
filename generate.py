from faker import Faker
import random
import datetime

fake = Faker()
s = [0, 1]

# ENTITIES

# assets = 400,000 -- 100000000 - 399999000
with open('insert.sql', 'a') as file:
    types = ["book", "room", "building"]
    for i in range(400_000):
        id_ = f'{i + 1:<9}'.replace(' ', '0')
        if i < 95_000:
            type_ = "'" + types[0] + "'"
        elif i < 195_000:
            type_ = "'" + types[1] + "'"
        elif i < 295_000:
            type_ = "'" + types[2] + "'"
        else:
            type_ = "'" + random.choice(types) + "'"
        insert_statement = f"INSERT INTO assets (id_, type_) VALUES ({id_}, {type_});\n"
        file.write(insert_statement)

# books = 100,000 --- 100000000 - 999990000
with open('insert.sql', 'a') as file:
    for i in range(100_000):
        asset_id = f'{i + 1:<9}'.replace(' ', '0')
        price = round(random.uniform(2, 50), 2)
        insert_statement = f"INSERT INTO books (asset_id, price) VALUES ({asset_id}, {price});\n"
        file.write(insert_statement)

# rooms = 100,000 --- 100001000 - 199999000
with open('insert.sql', 'a') as file:
    for i in range(100_001, 200_000):
        asset_id = f'{i:<9}'.replace(' ', '0')
        price = round(random.uniform(2000, 10000), 0)
        insert_statement = f"INSERT INTO rooms (asset_id, price) VALUES ({asset_id}, {price});\n"
        file.write(insert_statement)

# buildings = 100,000 --- 100000100 - 299999000
with open('insert.sql', 'a') as file:
    for i in range(200_001, 300_000):
        asset_id = f'{i:<9}'.replace(' ', '0')
        price = round(random.uniform(100000, 5000000), 0)
        insert_statement = f"INSERT INTO buildings (asset_id, price) VALUES ({asset_id}, {price});\n"
        file.write(insert_statement)

# suppliers = 10,000 -- 100000000 - 999900000
with open('insert.sql', 'a') as file:
    for i in range(10_000):
        id_ = f'{i + 1:<9}'.replace(' ', '0')
        insert_statement = f"INSERT INTO suppliers (id_) VALUES ({id_});\n"
        file.write(insert_statement)

# providers = 9 --- 111111111 ... 999999999
with open('insert.sql', 'a') as file:
    for i in range(1, 10):
        id_ = i * 111_111_111
        insert_statement = f"INSERT INTO providers (id_) VALUES ({id_});\n"
        file.write(insert_statement)

# people = 20,000 --- 100000000 - 199990000
with open('insert.sql', 'a') as file:
    for i in range(20_000):
        id_ = f'{i + 1:<9}'.replace(' ', '0')
        insert_statement = f"INSERT INTO people (id_) VALUES ({id_});\n"
        file.write(insert_statement)

# insurance = 100 -- 100000000 - 990000000
with open('insert.sql', 'a') as file:
    for i in range(100):
        id_ = f'{i + 1:<9}'.replace(' ', '0')
        provider_id = ((i % 9) + 1) * 111_111_111
        cost = int(random.uniform(10, 10_000))
        insert_statement = f"INSERT INTO insurance (id_, provider_id, cost_) VALUES ({id_}, {provider_id}, {cost});\n"
        file.write(insert_statement)

# employees = 10,000 --- 100000000 - 999900000
with open('insert.sql', 'a') as file:
    for i in range(10_000):
        id_ = f'{i + 1:<9}'.replace(' ', '0')
        person_id = int(random.uniform(1, 20_000))
        person_id = f'{person_id:<9}'.replace(' ', '0')
        insert_statement = f"INSERT INTO employees (id_, person_id) VALUES ({id_}, {person_id});\n"
        file.write(insert_statement)

# jobs = 100 -- 1000000000 - 99000000000
with open('insert.sql', 'a') as file:
    for i in range(100):
        id_ = f'{i + 1:<9}'.replace(' ', '0')
        insert_statement = f"INSERT INTO jobs (id_) VALUES ({id_});\n"
        file.write(insert_statement)

# wages = 10,000
with open('insert.sql', 'a') as file:
    for i in range(10_000):
        id_ = f'{i + 1:<9}'.replace(' ', '0')
        job_id = int(random.uniform(1, 100))
        job_id = f'{job_id:<9}'.replace(' ', '0')
        wage = int(random.uniform(1_000, 10_000))
        insert_statement = f"INSERT INTO wages (id_, job_id, wage) VALUES ({id_}, {job_id}, {wage});\n"
        file.write(insert_statement)

# members = 10,000 --- 100000000 - 999900000
with open('insert.sql', 'a') as file:
    for i in range(10_000):
        id_ = f'{i + 1:<9}'.replace(' ', '0')
        person_id = int(random.uniform(1, 20_000))
        person_id = f'{person_id:<9}'.replace(' ', '0')
        insert_statement = f"INSERT INTO members (id_, person_id) VALUES ({id_}, {person_id});\n"
        file.write(insert_statement)

# subscriptions = 4 --- 111111111 ... 444444444
with open('insert.sql', 'a') as file:
    types = ['regular', 'student', 'soldier', 'senior']
    costs = [300.00, 120.00, 100.00, 140.00]
    for i in range(4):
        id_ = (i + 1) * 111_111_111
        type_ = "'" + types[i] + "'"
        cost = costs[i]
        insert_statement = f"INSERT INTO subscriptions (id_, type_, cost_) VALUES ({id_}, {type_}, {cost});\n"
        file.write(insert_statement)

# penalties = 3 --- 111111111 ... 333333333
with open('insert.sql', 'a') as file:
    types = ['late', 'damaged', 'lost']
    fees = [10.00, 100.00, 200.00]
    for i in range(3):
        id_ = (i + 1) * 111_111_111
        type_ = "'" + random.choice(types) + "'"
        fee = fees[i]
        insert_statement = f"INSERT INTO penalties (id_, type_, fee) VALUES ({id_}, {type_}, {fee});\n"
        file.write(insert_statement)

# donors = 500 --- 1000000000 - 499000000
with open('insert.sql', 'a') as file:
    for i in range(500):
        id_ = f'{i + 1:<9}'.replace(' ', '0')
        insert_statement = f"INSERT INTO donors (id_) VALUES ({id_});\n"
        file.write(insert_statement)

# tables = 6
with open('insert.sql', 'a') as file:
    names = ["grants", "procurements", "insured", "payments", "subscribed", "member_penalties"]
    flow = [1, 0, 0, 0, 1, 1]
    for i in range(1, 7):
        id_ = f'{i:<9}'.replace(' ', '0')
        name = "'" + names[i - 1] + "'"
        flow_direction = flow[i - 1]
        insert_statement = f"INSERT INTO tables (id_, name_, flow_direction) VALUES ({id_}, {name}, {flow_direction});\n"
        file.write(insert_statement)

# cash flow = 1,200,000 --- 1000000000 - 119999900
with open('insert.sql', 'a') as file:
    for i in range(1_200_000):
        id_ = f'{i + 1:<9}'.replace(' ', '0')
        table_id = f'{(i % 6) + 1:<9}'.replace(' ', '0')
        insert_statement = f"INSERT INTO cash_flow (id_, table_id) VALUES ({id_}, {table_id});\n"
        file.write(insert_statement)

# grants = 200,000 --- 1000000000 - 199999000
with open('insert.sql', 'a') as file:
    for i in range(200_000):
        cash_flow_id = f'{i + 1:<9}'.replace(' ', '0')
        donor_id = int(random.uniform(1, 500))
        donor_id = f'{donor_id:<9}'.replace(' ', '0')
        amount = int(random.uniform(1000, 50_000))
        date = "'" + str(fake.date_between(start_date=datetime.date(2023, 1, 1), end_date=datetime.date(2024, 9, 15))) + "'"
        status = int(random.uniform(0, 2))
        insert_statement = f"INSERT INTO grants (cash_flow_id, donor_id, amount, date_, status_) VALUES ({cash_flow_id}, " \
                           f"{donor_id}, {amount}, {date}, {status});\n"
        file.write(insert_statement)


# RELATIONS

# payments = 200,000 --- 2000000000 - 399999000
with open('insert.sql', 'a') as file:
    for i in range(200_000, 400_000):
        cash_flow_id = f'{i + 1:<9}'.replace(' ', '0')
        wage_id = f'{(i % 10_000) + 1:<9}'.replace(' ', '0')
        employee_id = f'{(i % 10_000) + 1:<9}'.replace(' ', '0')
        date = "'" + str(fake.date_between(start_date=datetime.date(2023, 1, 1), end_date=datetime.date(2024, 9, 15))) + "'"
        status = random.choice(s)
        insert_statement = f"INSERT INTO payments (cash_flow_id, wage_id, employee_id, date_, status_) " \
                           f"VALUES ({cash_flow_id}, {wage_id}, {employee_id}, {date}, {status});\n"
        file.write(insert_statement)

# procurements = 200,000 --- 4000000000 - 599999000
with open('insert.sql', 'a') as file:
    for i in range(400_000, 600_000):
        cash_flow_id = f'{i + 1:<9}'.replace(' ', '0')
        supplier_id = f'{(i % 10_000) + 1:<9}'.replace(' ', '0')
        asset_id = f'{i + 1:<9}'.replace(' ', '0')
        date = "'" + str(fake.date_between(start_date=datetime.date(2023, 1, 1), end_date=datetime.date(2024, 9, 15))) + "'"
        status = random.choice(s)
        insert_statement = f"INSERT INTO procurements (cash_flow_id, supplier_id, asset_id, date_, status_) VALUES " \
                           f"({cash_flow_id}, {supplier_id}, {asset_id}, {date}, {status});\n"
        file.write(insert_statement)

# subscribed = 200,000 --- 6000000000 - 799999000
with open('insert.sql', 'a') as file:
    for i in range(600_000, 800_000):
        cash_flow_id = f'{i + 1:<9}'.replace(' ', '0')
        subscription_id = random.choice([111111111, 222222222, 333333333, 444444444])
        member_id = f'{(i % 10_000) + 1:<9}'.replace(' ', '0')
        start_date = "'" + str(fake.date_between(start_date=datetime.date(2023, 1, 1), end_date=datetime.date(2024, 9, 15))) + "'"
        end_date = "'" + str(fake.date_between(start_date=datetime.date(2023, 1, 1), end_date=datetime.date(2025, 9, 15))) + "'"
        status = random.choice(s)
        insert_statement = f"INSERT INTO subscribed (cash_flow_id, subscription_id, member_id, start_date_, end_date, status_) " \
                           f"VALUES ({cash_flow_id}, {subscription_id}, {member_id}, {start_date}, {end_date}, {status});\n"
        file.write(insert_statement)

# member penalties = 200,000 --- 8000000000 - 999999000
with open('insert.sql', 'a') as file:
    for i in range(800_000, 1_000_000):
        cash_flow_id = f'{i + 1:<9}'.replace(' ', '0')
        member_id = f'{(i % 10_000) + 1:<9}'.replace(' ', '0')
        penalty_id = random.choice([111111111, 222222222, 333333333])
        issue_date = "'" + str(fake.date_between(start_date=datetime.date(2023, 1, 1), end_date=datetime.date(2024, 9, 15))) + "'"
        due_date = "'" + str(fake.date_between(start_date=datetime.date(2023, 1, 1), end_date=datetime.date(2025, 9, 15))) + "'"
        status = random.choice(s)
        insert_statement = f"INSERT INTO member_penalties (cash_flow_id, member_id, penalty_id, issue_date, due_date, status_) " \
                           f"VALUES ({cash_flow_id}, {member_id}, {penalty_id}, {issue_date}, {due_date}, {status});\n"
        file.write(insert_statement)

# insured = 200,000 --- 1000000000 - 119999900
with open('insert.sql', 'a') as file:
    for i in range(1_000_000, 1_200_000):
        cash_flow_id = f'{i + 1:<9}'.replace(' ', '0')
        insurance_id = f'{(i % 27) + 1:<9}'.replace(' ', '0')
        asset_id = f'{i + 1:<9}'.replace(' ', '0')
        start_date = "'" + str(fake.date_between(start_date=datetime.date(2023, 1, 1), end_date=datetime.date(2024, 9, 15))) + "'"
        end_date = "'" + str(fake.date_between(start_date=datetime.date(2023, 1, 1), end_date=datetime.date(2025, 9, 15))) + "'"
        status = random.choice(s)
        insert_statement = f"INSERT INTO insured (cash_flow_id, insurance_id, asset_id, start_date_, end_date, status_) VALUES " \
                           f"({cash_flow_id}, {insurance_id}, {asset_id}, {start_date}, {end_date}, {status});\n"
        file.write(insert_statement)
