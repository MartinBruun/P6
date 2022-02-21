# install flask
## cd washee_box/
## python3 -m venv venv
## . venv/bin/activate
## stat venv #to check that the folder is owned by the washee-user (pi)
## pip install -r requirements.txt
## touch washee-box-entry.py
## opret flask route file kommandoer
## export FLASK_APP=washee-box-entry.py
## flask run --host=0.0.0.0
## sudo shutdown