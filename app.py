from flask import Flask

from src.main import main

app = Flask(__name__)

@app.route('/')
def hello_world():
    return main()
