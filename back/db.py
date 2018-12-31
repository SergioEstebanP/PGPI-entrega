from flask_sqlalchemy import SQLAlchemy
from flask_login import UserMixin

import global_app

app = global_app.app
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://PGPI_grupo02:JEbITzwe@localhost/PGPI_grupo02'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)

class Usuario(db.Model, UserMixin):
    nick = db.Column(db.String(50), primary_key=True)
    email = db.Column(db.String(50))
    password = db.Column(db.String(50))
    nombre = db.Column(db.String(50))
    apellidos = db.Column(db.String(100))
    biografia = db.Column(db.String(200))
    fotoPerfil = db.Column(db.String(200))
    tipo = db.Column(db.Integer)

class Incidencia(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    titulo = db.Column(db.String(100))
    comentario = db.Column(db.String(200))
    prioridad = db.Column(db.Integer)
    tiempoEstimado = db.Column(db.Integer)
    descripcion = db.Column(db.String(200))
    estado = db.Column(db.Integer)
    tecnicoAsignado = db.Column(db.String(50))
    cliente = db.Column(db.String(50))

def close_db():
    #global db
    if db:
        db.close()
        db = None

def init_db():
    cursor = db.cursor()

    for line in open('schema.sql'):
        cursor.execute(line)
        db.commit()

def execute_command(command):
    #db = get_db()
    cursor = db.cursor(dictionary=True)

    cursor.execute(command)
    db.commit()
    result = cursor.fetchall()

    return result



#######################
#       USUARIO       #
#######################
def get_users():
    return Usuario.query.all()

def get_user(nick):
    return Usuario.query.get(nick)

'''
#######################
#     INCIDENCIA      #
#######################
def insert_incidencia(idIncidencia, descripcion, estado, cliente, comentario=None, prioridad=None, tiempoEstimado=None, tecnico=None):
    #db = get_db()
    cursor = db.cursor()

    cursor.execute('INSERT INTO incidencia VALUES (%s, %s, %s, %s, %s, %s, %s, %s)', (idIncidencia, comentario, prioridad, tiempoEstimado, descripcion, estado, tecnico, cliente))
    db.commit()

def get_incidencias():
    #db = get_db()
    cursor = db.cursor(dictionary=True)

    cursor.execute('SELECT * FROM incidencia')
    result = cursor.fetchall()

    return result

def get_incidencia(id):
    #db = get_db()
    cursor = db.cursor(dictionary=True)

    cursor.execute('SELECT * FROM usuario WHERE id = %d', (id, ))
    result = cursor.fetchone()

    return result
'''
