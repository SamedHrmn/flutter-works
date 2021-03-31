import base64
import os
from cv2 import imwrite
from flask import Flask, request, jsonify, json
from werkzeug.utils import secure_filename
from model import convert_image_to_grey
from werkzeug.serving import WSGIRequestHandler

ROOT_DIR = os.path.dirname(os.path.abspath(__file__))
STATIC_FOLDER = os.path.join(ROOT_DIR, "static")
UPLOAD_FOLDER = os.path.join(STATIC_FOLDER, "uploads")
RESPONSE_FOLDER = os.path.join(STATIC_FOLDER, "response")

ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg'}

app = Flask(static_folder=STATIC_FOLDER, import_name=__name__)
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
app.config['RESPONSE_FOLDER'] = RESPONSE_FOLDER
app.config['STATIC_FOLDER'] = STATIC_FOLDER


@app.route('/')
def index():
    return 'Hello World!'


@app.route('/json_example', methods=['POST', 'GET'])
def get_json():
    if request.method == "POST":
        json_data = request.get_json(force=True)  # Force parametresi mimetype'ı ignore eder
        return json.dumps(json_data['data'])


def allowed_file(filename):
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS


@app.route('/get_image', methods=['POST', 'GET'])
def get_image():
    if request.method == 'POST':
        file = request.files['file']

        if file and allowed_file(file.filename):
            filename = secure_filename(file.filename)

            file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
            grey_image = convert_image_to_grey(os.path.join(app.config['UPLOAD_FOLDER'], filename))

            imwrite(os.path.join(app.config['RESPONSE_FOLDER'], filename), grey_image)

            converted_image_path = os.path.join(RESPONSE_FOLDER, os.listdir(app.config['RESPONSE_FOLDER'])[0])

            with open(str(converted_image_path), "rb") as im:
                converted_image = im.read()

            image_string = base64.b64encode(converted_image).decode('ascii')
            return json.dumps({"img": image_string})


WSGIRequestHandler.protocol_version = "HTTP/1.1"
if __name__ == '__main__':
    app.run(debug=False, host='0.0.0.0')
