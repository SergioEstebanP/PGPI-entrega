import os
from random import randint
from collections import namedtuple

from flask import Flask, render_template, request, flash, session, g, redirect, url_for
from flask_login import LoginManager, current_user, login_user, logout_user, login_required
from flask_login import UserMixin

app = Flask(__name__)
app.config['SECRET_KEY'] = os.urandom(24)

login_manager = LoginManager(app)
login_manager.init_app(app)
login_manager.login_view = 'login'


@app.route('/', methods=['GET', 'POST'])
@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        user = get_user(username)

        if user is None:
            flash('Incorrect username.')
        elif password != user.password:
            flash('Incorrect password.')
        else:
            userType = user.tipo
            if userType == 0:
                    # supervisor
                    incidencias = get_incidencias()

                    incidencias_abiertas = get_incidencias_abiertas_super()
                    incidencias_notif_cierre = get_incidencias_notif_cierre_super()

                    login_user(load_user(user.nick))
                    return render_template('incidencias_supervisor.html', userType=userType, userName=username, incidencias=incidencias, incidencias_abiertas = incidencias_abiertas, incidencias_notif_cierre = incidencias_notif_cierre)

            if userType == 1:
                    # tecnico
                    incidencias = get_incidencias_by_user(username)

                    incidencias_abiertas = get_incidencias_abiertas(username)
                    incidencias_notif_cierre = get_incidencias_notif_cierre(username)

                    login_user(load_user(user.nick))
                    return render_template('incidencias_columnas.html', userType=userType, userName=username, incidencias=incidencias, incidencias_abiertas = incidencias_abiertas, incidencias_notif_cierre = incidencias_notif_cierre)

            if userType == 2:
                    # cliente
                    incidencias = get_incidencias_by_user(username)
                    login_user(load_user(user.nick))
                    return render_template('incidencias_cliente.html', userType=userType, userName=username, incidencias=incidencias)

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

@app.route('/informacion_incidencia/<idIncidencia>', methods=['GET', 'POST'])
@login_required
def informacion_incidencia_cliente(idIncidencia):
    incidencias = get_incidencia(idIncidencia)
    listaTecnicos = get_tecnicos()
    if request.method == 'POST':
        tecnico = request.form['tecnicoAsignado']
        cambio_estado_incidencia(idIncidencia, 1, tecnico)

    print(incidencias[0].tecnicoAsignado)
    print(incidencias[0].estado)
    return render_template('info_incidencia.html', idIncidencia=idIncidencia, incidencias=incidencias, listaTecnicos=listaTecnicos)

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
        idIncidencia = randint(0, 10000)
        comentario = ''
        prioridad = 0
        tiempoEstimado = 0
        tecnico = 'sin asignar'

        insert_incidencia(idIncidencia, tituloIncidencia,descripcion, 0, current_user.nick, comentario, prioridad, tiempoEstimado, tecnico)

        return render_template('incidencias_cliente.html', incidencias=get_incidencias_by_user(current_user.nick))

    elif request.method == 'GET':
        return render_template('datos_incidencia_cliente.html')

@login_manager.user_loader
def load_user(nick):
    return get_user(nick)



###################################################
###                 DATABASE                    ###
###################################################

from flask_sqlalchemy import SQLAlchemy
from flask_login import UserMixin

app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://PGPI_grupo02:JEbITzwe@jair.lab.inf.uva.es:3306/PGPI_grupo02'
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

    def get_id(self):
        return self.nick

class Incidencia(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    titulo = db.Column(db.String(100))
    comentario = db.Column(db.String(200))
    prioridad = db.Column(db.Integer)
    tiempoEstimado = db.Column(db.Integer)
    descripcion = db.Column(db.String(200))
    estado = db.Column(db.Integer)
    tecnicoAsignado = db.Column(db.String(50))
    reportadaPor = db.Column(db.String(50))



#######################
#       USUARIO       #
#######################
def get_users():
    return list(Usuario.query.all())

def get_user(nick):
    return Usuario.query.get(nick)

def get_tecnicos():
    return list(Usuario.query.filter_by(tipo=1))

#######################
#     INCIDENCIA      #
#######################
def insert_incidencia(id, titulo, descripcion, estado, cliente, comentario=None, prioridad=None, tiempoEstimado=None, tecnicoAsignado=None):
    db.session.add(Incidencia(id=id, titulo=titulo, comentario=comentario, prioridad=prioridad, tiempoEstimado=tiempoEstimado, descripcion=descripcion, estado=estado, tecnicoAsignado=tecnicoAsignado, reportadaPor=cliente))
    db.session.commit()

def cambio_estado_incidencia(id, estado, tecnicoAsignado):
    incidencia = Incidencia.query.get(id)
    incidencia.estado = estado
    incidencia.tecnicoAsignado = tecnicoAsignado
    db.session.commit()

def get_incidencias():
    return list(Incidencia.query.all())

def get_incidencia(id):
    return list(Incidencia.query.filter_by(id=id))

def get_incidencias_by_user(userNick):
    return list(Incidencia.query.filter_by(reportadaPor=userNick))

def get_incidencias_abiertas(userNick):
    return list(Incidencia.query.filter_by(tecnicoAsignado=userNick, estado=1))

def get_incidencias_abiertas_super():
    return list(Incidencia.query.filter_by(estado=0))

def get_incidencias_notif_cierre_super():
    return list(Incidencia.query.filter_by(estado=2))

def get_incidencias_notif_cierre(userNick):
    return list(Incidencia.query.filter_by(reportadaPor=userNick, estado=2))

