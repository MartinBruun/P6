import json
import os
from flask import Flask
import data_models
app = Flask(__name__)

machine_name = ['#1','#2','#3','#4']

@app.route('/')
def menu():
    machine_name_string = ""
    for machineName in machine_name:
        machine_name_string = machine_name_string + "\n  <a href='/light'>" + machineName +"</a>"

    return "<p> booking kalender</p> \n <p>oplås maskine:" + machine_name_string + "</p>"

@app.route('/getMachinesInfo')
def getMachinesInfo():
    with open("data_models/machineList.json", "r") as file:
        mList = json.loads(file.read())
    
    return mList


@app.route('/light')
def light():
    file = open(r'./use_cases/relay.py', 'r').read()
    exec(file)
    return "<a href='/'> Machine has been unlocked </a>"

if __name__ == "__main__":
    debug = False if int(os.environ.get("BOX_DEBUG",default="1")) == 0 else True
    port= int(os.environ.get("BOX_PORT"))
    host = os.environ.get("BOX_HOST")
    app.run(debug=debug, port=port, host=host)
    # app.run(debug=True, port=5000, host='0.0.0.0')

    