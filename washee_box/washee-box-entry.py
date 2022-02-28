import os
from flask import Flask
app = Flask(__name__)

machine_name = ['#1','#2','#3','#4']

@app.route('/')
def menu():
    machine_name_string = ""
    for machineName in machine_name:
        machine_name_string = machine_name_string + "\n  <a href='/unlock'>" + machineName +"</a>"

    return "<p><a href='/booking'> booking kalender</a></p> \n <p>oplås maskine:" + machine_name_string + "</p>"+ "\n <p><a href='/settings'>update settings</a></p>"+"\n<p><a href='/accepted_users'>update users</a></p> "

@app.route('/unlock')
def unlock():
    file = open(r'./use_cases/relay.py', 'r').read()
    exec(file)
    return "<a href='/'> Machine has been unlocked </a>"

@app.route('/lock')
def lock():
    file = open(r'./use_cases/relay.py', 'r').read()
    exec(file)
    return "<a href='/'> Machine has been locked </a>"

@app.route('/settings')
def update_settings():
    file = open(r'./use_cases/relay.py', 'r').read()
    exec(file)
    return "<a href='/'> Settings has been updated </a>"

@app.route('/accepted_users')
def update_accepted_users():
    file = open(r'./use_cases/relay.py', 'r').read()
    exec(file)
    return "<a href='/'> Accepted users has been updated </a>"

@app.route('/booking')
def display_booking():
    file = open(r'./use_cases/relay.py', 'r').read()
    exec(file)
    return '<div class="Calendar"><a href="/"> Mandag | | </a><a href="/"> Tirsdag | | </a><a href="/"> Onsdag | | </a><a href="/"> Torsdag | | </a><a href="/"> Fredag | | </a><a href="/"> Lørdag | | </a><a href="/"> Søndag | | </a></div>'

if __name__ == "__main__":
    debug = True #False if int(os.environ.get("BOX_DEBUG",default="1")) == 0 else True
    port= 5001 #int(os.environ.get("BOX_PORT"))
    host = '0.0.0.0' #os.environ.get("BOX_HOST")
    app.run(debug=debug, port=port, host=host)
    