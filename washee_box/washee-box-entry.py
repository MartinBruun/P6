from flask import Flask
app = Flask(__name__)

machine_name = ['#1','#2','#3','#4']

@app.route('/')
def menu():
    machine_name_string = ""
    for machineName in machine_name:
        machine_name_string = machine_name_string + "\n  <a href='/light'>" + machineName +"</a>"

    return "<p> booking kalender</p> \n <p>oplås maskine:" + machine_name_string + "</p>"

@app.route('/light')
def light():
    file = open(r'./use_cases/relay.py', 'r').read()
    exec(file)
    return "<a href='/'> Machine has been unlocked </a>"

if __name__ == "__main__":
    app.run(debug=True)