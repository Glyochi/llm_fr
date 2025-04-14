from flask import Flask, render_template, request, make_response
import asyncio
from flask_socketio import SocketIO
import ollama
import logging

import os.path

# Initialize Logger
logger = logging.getLogger(__name__)


LOG_FILE_NAME="ollama.log"

# If file not found then create new log file
if not (os.path.isfile(LOG_FILE_NAME)):
    f = open(LOG_FILE_NAME, "w")
    f.close()
logging.basicConfig(filename=LOG_FILE_NAME, level=logging.INFO)
logger.info("Ollama server is starting") 



# Initialize Flask/SocketIO server
app = Flask(__name__)
socketio = SocketIO(app)


# Initialize Ollama Client
ollama_model = "llama3.2:3b"





@app.route('/health')
def route_health():
    logger.info("'Health' endpoint was hit")
    return "We gucci 3"

@app.route('/ask', methods=["POST"])
def route_ask():
    logger.info("'Ask' endpoint was hit")
    logging.info(f"Request: {request.json}")
    
    req = request.json
    # Get user prompt
    prompt = req.get("prompt", None)
    if prompt == None:
        logging.error("Missing field 'prompt' in the request")
        response = make_response("Invalid request, missing field 'prompt' in the request's body", 400)
        return response

    
    def generate_model_response(): 
        for part in ollama.chat(model=ollama_model, messages=[{
            'role': 'user',
            'content': prompt
            }], stream=True):
            yield part['message']['content']
        
    
    return generate_model_response()

    response = make_response(model_response, 200)
    return response


@socketio.on('connect')
def on_connect(auth):
    logger.info("User Connected")



if __name__ == '__main__':
    
    socketio.run(app, host="0.0.0.0", port=5001)

    


















