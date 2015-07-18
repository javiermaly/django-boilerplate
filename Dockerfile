FROM python:2.7
ENV PYTHONUNBUFFERED 1
COPY src /app/
COPY config/requirements.txt /app/requirements.txt
WORKDIR /app
RUN pip install -r requirements.txt
