FROM python:3.9

ENV PYTHONUNBUFFERED=1

WORKDIR /app
COPY requirements.txt /app/
RUN python -m pip install -r requirements.txt