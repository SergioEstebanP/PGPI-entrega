import mysql.connector

db = None

def get_db():
    global db
    if not db:
        db = mysql.connector.connect(
            user='PGPI_grupo02',
            passwd='JEbITzwe',
            host='localhost',
            database='PGPI_grupo02'
        )

    return db

def close_db():
    global db
    if db:
        db.close()
        db = None

def init_db():
    db = get_db()
    cursor = db.cursor()

    for line in open('schema.sql'):
        cursor.execute(line)
        db.commit()

def execute_command(command):
    db = get_db()
    cursor = db.cursor(dictionary=True)

    cursor.execute(command)
    db.commit()
    result = cursor.fetchall()

    return result



#######################
#       USUARIO       #
#######################
ef get_users():
    db = get_db()
    cursor = db.cursor(dictionary=True)
    
    cursor.execute('SELECT * FROM usuario')
    result = cursor.fetchall()

    return result

def get_user(nick):
    db = get_db()
    cursor = db.cursor(dictionary=True)
    
    cursor.execute('SELECT * FROM usuario WHERE nick LIKE %s', (nick, ))
    result = cursor.fetchone()

    return result

#######################
#     INCIDENCIA      #
#######################
def insert_incidencia(id, descripcion, estado, cliente, comentario=None, prioridad=None, tiempoEstimado=None, tecnico=None):
    db = get_db()
    cursor = db.cursor()

    cursor.execute('INSERT INTO incidencia VALUES (%d, %s, %d, %d, %s, %d, %s, %s)', (id, comentario, prioridad, tiempoEstimado, descripcion, estado, tecnico, cliente))
    db.commit()

def get_incidencias():
    db = get_db()
    cursor = db.cursor(dictionary=True)
    
    cursor.execute('SELECT * FROM incidencia')
    result = cursor.fetchall()

    return result

def get_incidencia(id):
    db = get_db()
    cursor = db.cursor(dictionary=True)
    
    cursor.execute('SELECT * FROM usuario WHERE id = %d', (id, ))
    result = cursor.fetchone()

    return result
