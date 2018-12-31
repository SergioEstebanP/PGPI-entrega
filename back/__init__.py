import os
from random import randint
from collections import namedtuple

from flask import Flask, render_template, request, flash, session, g
from flask_login import LoginManager, current_user, login_user, logout_user, login_required
from flask_login import UserMixin

app = Flask(__name__)
app.config['SECRET_KEY'] = os.urandom(24)

login_manager = LoginManager(app)
login_manager.init_app(app)
login_manager.login_view = 'login'


@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        user = get_user(username)

        if user is None:
            flash('Incorrect username.')
        elif password != user['password']:
            flash('Incorrect password.')
        else:
            login_user(load_user(user['nick']))
            return redirect(url_for('incidencias'))

    return render_template('login.html')

@app.route("/logout")
@login_required
def logout():
    logout_user()
    return redirect(url_for('login'))


@app.route('/incidencias')
@login_required
def incidencias():
    return render_template('incidencias_cliente.html')

@app.route('/informacion_incidencia', methods=['GET', 'POST'])
@login_required
def informacion_incidencia_cliente():
    return render_template('info_incidencia.html')

@app.route('/registrar_nueva_incidencia', methods=['GET', 'POST'])
@login_required
def registrar_nueva_incidencia():
    if request.method == 'POST':
        form = request.form
        tituloIncidencia = form.get('titulo')
        descripcion = form.get('descripcion')
        idElementoInventario = form.get('idElementoInventario')
        fecha = form.get('fecha')
        categoria = form.get('categoria')
        idIncidencia = randint(0, 9999999999)
        comentario = ''
        prioridad = 0
        tiempoEstimado = 0
        tecnico = 'sin asignar'

        insert_incidencia(idIncidencia, descripcion, 0, session.get('user_id'), comentario, prioridad, tiempoEstimado, tecnico)

        return render_template('incidencias_cliente.html')

    return render_template('datos_incidencia_cliente.html')

@login_manager.user_loader
def load_user(nick):
    return Usuario.get(Usuario.nick == nick)



###################################################
###                 DATABASE                    ###
###################################################

from flask_sqlalchemy import SQLAlchemy
from flask_login import UserMixin

app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://PGPI_grupo02:JEbITzwe@localhost:3306/PGPI_grupo02'
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
