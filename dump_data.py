import subprocess


def dump_postgresql_database(host, port, dbname, user, output_file):
    try:
        # Construct the pg_dump command
        pg_dump_command = [
            'pg_dump',
            '--host', host,
            '--port', str(port),
            '--dbname', dbname,
            '--username', user,
            '--file', output_file,
            '--format', 'c'  # Custom format, includes both schema and data'
        ]

        # Run the pg_dump command
        subprocess.run(pg_dump_command, check=True)
        print(f"Database {dbname} dumped successfully to {output_file}")

    except subprocess.CalledProcessError as e:
        print(f"Error dumping database: {e}")


host = 'localhost'
port = 5432
dbname = 'project'
user = 'laylastein'
output_file = 'database_dump.sql'

dump_postgresql_database(host, port, dbname, user, output_file)