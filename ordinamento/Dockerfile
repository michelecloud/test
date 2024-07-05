FROM python:3.12

WORKDIR /app

COPY requirements.txt .
COPY app/app.py ./app.py
COPY app/templates ./templates

RUN pip install -r requirements.txt

EXPOSE 5000

CMD ["python", "app.py"]
