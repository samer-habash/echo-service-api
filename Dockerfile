FROM python:3.7.9-slim-buster
WORKDIR /app
COPY requirements.txt ./
RUN pip install -r requirements.txt

COPY echo-serviceapp.py ./
EXPOSE 5000

CMD ["python", "echo-serviceapp.py"]