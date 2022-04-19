# syntax=docker/dockerfile:1

FROM python:3.7.6-slim

RUN apt-get update
RUN apt-get install -y --no-install-recommends

# for flask web server
EXPOSE 8082

# set work directory
WORKDIR /usr/src/washee_box

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install dependencies
RUN pip install --upgrade pip
COPY ./requirements.txt .
RUN pip install -r requirements.txt


# Flask environment variables
ENV FLASK_APP=washee_box_entry.py
ENV FLASK_DEBUG=${BOX_DEBUG}

# copy entrypoint.sh
COPY ./entrypoint.sh .
RUN sed -i 's/\r$//g' /usr/src/washee_box/entrypoint.sh
RUN ["chmod", "+x", "/usr/src/washee_box/entrypoint.sh"]

# copy project
COPY . .

# run entrypoint.sh
ENTRYPOINT ["/usr/src/washee_box/entrypoint.sh"]