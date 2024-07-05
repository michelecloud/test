from flask import Flask, request, render_template
from functools import cmp_to_key

app = Flask(__name__)
nomi = []
nomi_ordinati = []

def confronta_nomi(nome1, nome2):
    return (nome1 > nome2) - (nome1 < nome2)

@app.route('/')
def index():
    return render_template('index.html', nomi=nomi, nomi_ordinati=nomi_ordinati)

@app.route('/aggiungi_nome', methods=['POST'])
def aggiungi_nome():
    nome = request.form['nome']
    nomi.append(nome)
    return render_template('index.html', nomi=nomi, nomi_ordinati=nomi_ordinati)

@app.route('/ordina_nomi', methods=['POST'])
def ordina_nomi():
    global nomi_ordinati
    nomi_ordinati = sorted(nomi, key=cmp_to_key(confronta_nomi))
    return render_template('index.html', nomi=nomi, nomi_ordinati=nomi_ordinati)

@app.route('/reset', methods=['POST'])
def reset():
    global nomi, nomi_ordinati
    nomi = []
    nomi_ordinati = []
    return render_template('index.html', nomi=nomi, nomi_ordinati=nomi_ordinati)

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')


