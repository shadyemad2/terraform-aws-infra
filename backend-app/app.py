import socket
from flask import Flask, render_template_string, request
from datetime import datetime

app = Flask(__name__)

@app.route('/')
def index():
    hostname = socket.gethostname()
    ip_address = socket.gethostbyname(hostname)
    return render_template_string(f"""
        <html>
        <head>
            <title>Welcome</title>
            <style>
                body {{ font-family: Arial, sans-serif; background: #f8f9fa; text-align: center; padding: 50px; }}
                h1 {{ color: #007bff; }}
                p {{ color: #555; }}
            </style>
        </head>
        <body>
            <h1>Welcome to Shady's Web App 🚀</h1>
            <p>This is a secure and styled Flask application running on EC2.</p>
            <p><strong>Served from:</strong> {hostname} ({ip_address})</p>
            <p><a href="/hello">Say Hello</a></p>
        </body>
        </html>
    """)

@app.route('/hello')
def hello():
    user_ip = request.remote_addr
    now = datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    hostname = socket.gethostname()
    ip_address = socket.gethostbyname(hostname)
    return render_template_string(f"""
        <html>
        <head>
            <title>Hello</title>
            <style>
                body {{ font-family: Arial; background-color: #e2f0d9; text-align: center; padding: 50px; }}
                h2 {{ color: #28a745; }}
            </style>
        </head>
        <body>
            <h2>Hello from the backend!</h2>
            <p>Your IP: {user_ip}</p>
            <p>Time: {now}</p>
            <p><strong>Served from:</strong> {hostname} ({ip_address})</p>
            <p><a href="/">Go Back</a></p>
        </body>
        </html>
    """)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
