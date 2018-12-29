import functools
from flask import Blueprint, flash, g, redirect, render_template, request, session, url_for
from flaskr.db import *

bp = Blueprint('auth', __name__)

@bp.route('/', methods=('GET', 'POST'))
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
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
            return redirect(url_for('index'))

        flash(error)

    return render_template('login.html')

#@bp.before_app_request
def load_logged_in_user():
    user_id = session.get('user_id')

    if user_id is None:
        g.user = None
    else:
        g.user = get_user(user_id)

@bp.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('index'))

def login_required(view):
    @functools.wraps(view)
    def wrapped_view(**kwargs):
        if g.user is None:
            return redirect(url_for('auth.login'))

        return view(**kwargs)

    return wrapped_view
