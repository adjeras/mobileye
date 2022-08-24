from flask import Flask, request
app = Flask(__name__)
import os

@app.route('/messages', methods=['GET'])
def search():
    args = request.args
    var1 = args.get('word')
    if var1:
        file = open("../data/word.txt", "a")
        file.write(var1+'\n')
        file.close
        return f'{var1}'
    else:
        return f'{os.environ["RESPONCE"]}'

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
