import mysql.connector

import click
from flask import current_app, g
from flask.cli import with_appcontext


def get_db():
    if 'db' not in g:
        g.db = mysql.connector.connect(
            user='PGPI_grupo02'
            passwd='JEbITzwe'
            host='jair.lab.inf.uva.es'
            database='PGPI_grupo02'
        )

    return g.db

def close_db(e=None):
    db = g.pop('db', None)

    if db is not None:
        db.close()

def init_db():
    db = get_db()

    cursor = db.cursor()
    for line in open('schema.sql'):
        cursor.execute(line)
        db.commit()
