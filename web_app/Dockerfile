# syntax=docker/dockerfile:1
FROM python:3
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
WORKDIR /web_app
COPY requirements.txt /web_app/
RUN pip install -r requirements.txt
COPY . /web_app/

