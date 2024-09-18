FROM python:3.12

WORKDIR /

COPY requirements.txt

RUN pip install -r requirements.txt

COPY app.py

COPY templates

EXPOSE 5001

CMD ["python", "app.py"]
