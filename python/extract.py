import psycopg2
def connect_db():
    # move this to a secure location

    conn = psycopg2.connect(database="the_database",
                            host="172.17.0.2",   #something something docker compose use network
                            user="notsosecretusername",
                            password="supersecretpassword",
                            port="5432")

    return conn

def create_table(table_name, columns):
    query = 'CREATE TABLE ' + table_name + ' (ins_date TIMESTAMP NOT NULL DEFAULT clock_timestamp()'

    for column in columns:
        query = query + ', ' + column + ' VARCHAR(255)'

    query = query + ');'

    print('DROP TABLE ' + table_name + ';')
    try:
        conn.cursor().execute('DROP TABLE ' + table_name)
    except Exception as error:
        print ("Oops! An exception has occured:", error)
        conn.rollback()

    print(query + ';')
    try:
        conn.cursor().execute(query)
        conn.commit()
    except Exception as error:
        print ("Oops! An exception has occured:", error)
        conn.rollback()

def insert_into_db(table_name, columns, values):
    query = 'INSERT INTO ' + table_name + ' ('
    
    for column in columns:
        query = query + column + ", "
    
    query = query[0:len(query) - 2] + ') VALUES ('

    for value in values:
        query = query + "'" + value + "', "

    query = query[0:len(query) - 2] + ')'

    print(query + ';')
    conn.cursor().execute(query)
    conn.commit() #hmmm 1 commit per insert... something something execute many

def read_file_into_table(filepath):
    #do testing if file exists
    file = open(filepath)

    #skip the first header line, or use to create tables in improved version
    header  = file.readline().strip()
    columns = header.split(',')

    table_name = 'ods.ods_' + filepath[filepath.rfind('/') + 1:len(filepath) - 4]
    create_table(table_name, columns)

    for line in file:
        clean_line = line.strip()
        insert_into_db(table_name, columns, clean_line.split(','))

    file.close

print('Connect to the database')
conn   = connect_db()
#some check if we have connection here

print('Starting extract...')
#for larger sets grab filelist from OS and loop
read_file_into_table('raw_data/customers.csv')
read_file_into_table('raw_data/installments.csv')
read_file_into_table('raw_data/leases.csv')

print('committing to DB')
conn.commit()
conn.close