import os

from flask import Flask, render_template, request, flash, session, g
from flaskr.db import *
from random import randint

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)

def create_app(test_config=None):
    # create and configure the app
    app = Flask(__name__, instance_relative_config=True)
    app.config.from_mapping(
        SECRET_KEY='dev',
        DATABASE=os.path.join(app.instance_path, 'flaskr.sqlite'),
    )

    if test_config is None:
        # load the instance config, if it exists, when not testing
        app.config.from_pyfile('config.py', silent=True)
    else:
        # load the test config if passed in
        app.config.from_mapping(test_config)

    # ensure the instance folder exists
    try:
        os.makedirs(app.instance_path)
    except OSError:
        pass

    @app.route('/informacion_incidencia', methods=['GET', 'POST'])
    def informacion_incidencia_cliente():
            return render_template('info_incidencia.html')

    @app.route('/registrar_nueva_incidencia', methods=['GET', 'POST'])
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

        elif request.method == 'GET':
            return render_template('datos_incidencia_cliente.html')

    @app.route('/', methods=('GET', 'POST'))
    def login():

        if request.method == 'POST':
            username = request.form['username']
            password = request.form['password']
            session['userNick'] = username
            db = get_db()
            error = None
            user = get_user(username)

            if user is None:
                error = 'Incorrect username.'
            elif password != user['password']:
                error = 'Incorrect password.'

            if error is None:
                session.clear()
                session['user_id'] = user['nick']
                return render_template('incidencias_cliente.html')

            flash(error)

        return render_template('login.html')

    #from . import db
    #db.init_app(app)

    #from . import auth
    #app.register_blueprint(auth.bp)

    return app
