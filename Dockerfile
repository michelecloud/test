# Usa un'immagine di Python preconfigurata per Flask
FROM python:3.12

# Imposta l'ambiente Python in modalità non bufferizzata per la stampa e l'output
ENV PYTHONPATH=/app/test

# Imposta la directory di lavoro all'interno del container
WORKDIR /app/test


# Installa le dipendenze Python
RUN pip install Flask Werkzeug 

# Copia il codice dell'applicazione nella directory di lavoro nel container
COPY . .

# Comando di avvio per l'applicazione Flask
CMD ["python", "app.py"]
