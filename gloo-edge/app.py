from flask import Flask
import time

app = Flask("myapp")


@app.route("/")
def index():
    time.sleep(10)
    return "It works"


if __name__ == "__main__":
    app.run(host='0.0.0.0')