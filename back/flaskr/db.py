import mysql.connector

db = None

def get_db():
    global db
    if not db:
        db = mysql.connector.connect(
            user='PGPI_grupo02',
            passwd='JEbITzwe',
            host='jair.lab.inf.uva.es',
            database='PGPI_grupo02'
        )

    return db

def close_db():
    if db:
        db.close()

def init_db():
    db = get_db()
    cursor = db.cursor()

    for line in open('schema.sql'):
        cursor.execute(line)
        db.commit()

def insert_user(nick, email, password, nombre, apellidos, biografia=None, fotoPerfil=None):
    db = get_db()
    cursor = db.cursor()

    cursor.execute('INSERT INTO usuario VALUES (%s, %s)', (nick, email, password, nombre, apellidos, biografia, fotoPerfil))
    db.commit()

    print(cursor.rowcount, "records inserted.")

def get_users():
    db = get_db()
    cursor = db.cursor()
    
    cursor.execute('SELECT * FROM usuario')
    result = cursor.fetchall()

    print(result)
