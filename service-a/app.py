from flask import Flask, jsonify

app = Flask(__name__)

@app.get('/')
def root():
    return jsonify({"service": "A", "message": "Hello from Service A"})

@app.get('/health')
def health():
    return jsonify({"service": "A", "status": "healthy"})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
