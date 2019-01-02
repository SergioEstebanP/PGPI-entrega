if [ ! -d venv ]
then
    python3 -m venv venv
fi

. venv/bin/activate

pip install Flask
pip install flask-login
pip install flask-sqlalchemy
pip install mysqlclient

deactivate
