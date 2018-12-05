from flask import Flask, render_template, Response
import cv2

app = Flask(__name__)
vc = cv2.VideoCapture(0)

@app.route('/')
def index():
    # Take a picture and save it so page can load it 
    gen()
    return render_template('index.html')

def gen():
    done, frame = vc.read()
    cv2.imwrite('t.jpg', frame)

if __name__ == '__main__':
    app.run(host='0.0.0.0')
