import os
import socket
import secrets
import requests
from datetime import date
from flask import Flask, request, url_for, jsonify

# Configure app
app = Flask(__name__)
app.secret_key = secrets.token_urlsafe(32)
app.config[ 'WTF_CSRF_SECRET_KEY' ] = secrets.token_urlsafe(32)

# Getting the path
basedir = os.path.abspath(os.path.dirname(__file__))

# Getting the IP of the Server
hostname = socket.gethostname()
local_ip = socket.gethostbyname(hostname)
public_ip = requests.get('https://api.ipify.org').text


@app.route("/", methods=[ 'GET', 'POST' ])
def index():
    data = request.data
    if data:
        return url_for('api_body', body=data)
    return "The request body is empty, please send a valid request"


@app.route("/<body>", methods=[ 'GET', 'POST' ])
def api_body(body):
    today_date = str(date.today())
    with open(basedir + '/log/' + 'api-log' + today_date + '.log', 'a+') as logfile:
        logfile.write(body + "\n")
    return body + " Backend_IP=" + public_ip


app.run(host="0.0.0.0")