import os
from datetime import datetime
from functools import wrap

from flask import Flask, render_template, request, flash, redirect, url_for
from flask_login import LoginManager, current_user, login_user, logout_user, login_required, UserMixin

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
            login_user(user)
            return redirect(url_for('index'))

    return render_template('login.html')

@app.route("/logout")
@login_required
def logout():
    logout_user()
    return redirect(url_for('login'))



@app.route("/index")
@login_required
def index():
    if current_user.tipo == 0: #Supervisor
        return render_template('incidencias_supervisor.html')
    elif current_user.tipo == 1: #Tecnico
        return render_template('incidencias_tecnico.html')
    elif current_user.tipo == 2: #Cliente
        return render_template('incidencias_cliente.html')

@app.route('/informacion_incidencia')
@login_required
def informacion_incidencia_cliente():
    return render_template('info_incidencia.html')
  
@app.route('/registrar_nueva_incidencia', methods=['GET', 'POST'])
@login_required
@requires_access_level([1, 2])
def registrar_nueva_incidencia():
    if request.method == 'POST':
        titulo          = request.form.get('titulo')
        comentario      = ''
        prioridad       = 0
        tiempoEstimado  = 0
        descripcion     = request.form.get('descripcion')
        fecha           = datetime.strptime(request.form.get('fecha'), '%Y-%m-%d')
        estado          = 0
        tecnicoAsignado = 'sin asignar'
        reportadaPor    = current_user.nick
        idInventario    = request.form.get('idElementoInventario')
        categoria       = request.form.get('categoria')

        insert_incidencia(titulo, descripcion, fecha, estado, reportadaPor, categoria, comentario, prioridad, tiempoEstimado, tecnicoAsignado)
       
        return redirect(url_for('incidencias'))
      
    return render_template('datos_incidencia_cliente.html')


def requires_access_level(access_level):
    def decorator(f):
        @wraps(f)
        def decorated_function(*args, **kwargs):
            if current_user.tipo not in access_level:
                return redirect(url_for('index'))

            return f(*args, **kwargs)
        return decorated_function
    return decorator



###################################################
###                 DATABASE                    ###
###################################################

from flask_sqlalchemy import SQLAlchemy
from flask_login import UserMixin

app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://PGPI_grupo02:JEbITzwe@127.0.0.1:3306/PGPI_grupo02'
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

    def get_id(self):
            return self.nick

class Incidencia(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    titulo = db.Column(db.String(100))
    comentario = db.Column(db.String(200))
    prioridad = db.Column(db.Integer)
    tiempoEstimado = db.Column(db.Integer)
    descripcion = db.Column(db.String(200))
    fecha = db.Column(db.DateTime)
    estado = db.Column(db.Integer)
    tecnicoAsignado = db.Column(db.String(50))
    reportadaPor = db.Column(db.String(50))
    categoria = db.Column(db.String(40))
     
class ElementoIncidencia(db.Model):
    incidencia = db.Column(db.Integer, primary_key=True)
    elemento = db.Column(db.Integer, primary_key=True)

class Cambio(db.Model):
    fecha = db.Column(db.DateTime, primary_key=True)
    estado = db.Column(db.Integer)
    tecnico = db.Column(db.String(50))
    incidencia = db.Column(db.Integer)


#######################
#       USUARIO       #
#######################
@login_manager.user_loader
def get_user(nick):
    return Usuario.query.get(nick)

 
#######################
#     INCIDENCIA      #
#######################
def insert_incidencia(titulo, descripcion, fecha, estado, reportadaPor, categoria, comentario=None, prioridad=None, tiempoEstimado=None, tecnicoAsignado=None):
    db.session.add(Incidencia(titulo=titulo, comentario=comentario, prioridad=prioridad, tiempoEstimado=tiempoEstimado, descripcion=descripcion, fecha=fecha, estado=estado, tecnicoAsignado=tecnicoAsignado, reportadaPor=reportadaPor, categoria=categoria))
    db.session.commit()

def get_incidencias():
    return list(Incidencia.query.all())

def get_incidencias_by_user(userNick):
    return list(Incidencia.query.filter_by(reportadaPor=userNick))


#######################
#     INVENTARIO      #
#######################
def insert_elemento_incidencia(incidencia, elemento):
    db.session.add(ElementoIncidencia(incidencia=incidencia, elemento=elemento))
    db.session.commit()

def get_elementos_incidencia(incidencia):
    return list(ElementoIncidencia.query.filter_by(incidencia=incidencia))


#######################
#       CAMBIO        #
#######################
def insert_cambio(estado, tecnico, incidencia, fecha=datetime.now()):
    db.session.add(Cambio(fecha=fecha, estado=estado, tecnico=tecnico, incidencia=incidencia))
    db.session.commit()
