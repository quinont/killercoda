from bottle import route, run, template, request, HTTPResponse, response
from json import dumps
import requests
import os

DOMINIO_APP = os.environ.get("DOMINIO_APP", None)
PATH_APP = os.environ.get("PATH_APP", None)
STATUS_CODE_APP = os.environ.get("STATUS_CODE_APP", "200")


@route('/hello/<name>')
def index(name):
    return template('<b>Hello {{name}}</b>!', name=name)

@route('/toapp')
def app():
    previewVersion = request.headers.get('PreviewVersion', None)
    headers_dict=None
    if previewVersion and previewVersion.lower() == "yes":
        headers_dict = {"PreviewVersion": "yes"}

    r = requests.get("http://" + DOMINIO_APP + PATH_APP, headers=headers_dict)
    hostname = os.uname()[1]
    output = {
        "server": hostname,
        "server_origin": r.json()["server"],
        "status_code": r.status_code,
        "message": r.json()["message"]
    }

    response.status = int(STATUS_CODE_APP)
    response.content_type = 'application/json'
    response.headers["server"] = 'Repeater-app'

    return dumps(output)

@route('/origin')
def origin():
    hostname = os.uname()[1]
    output = {
        "server": hostname,
        "server_origin": "origen",
        "status_code": "origen",
        "message": f"Hello from {hostname}!"
    }

    response.status = int(STATUS_CODE_APP)
    response.content_type = 'application/json'
    response.headers["server"] = 'Repeater-app'

    return dumps(output)

run(host='0.0.0.0', port=8080)
