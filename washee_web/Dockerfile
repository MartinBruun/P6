# pull official base image
FROM python:3.7-slim-buster

# set work directory
WORKDIR /usr/src/washee_web

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

# install psycopg2 dependencies
RUN apt-get update \
    && apt install -y netcat \
    && apt-get install -y\
    build-essential libssl-dev libffi-dev libblas3 libc6 liblapack3 gcc python3-dev python3-pip cython libpq-dev python3-sklearn python3-sklearn-lib python3-sklearn-doc jq \
    unzip

# install dependencies
RUN pip install --upgrade pip
COPY ./requirements.txt .
RUN pip install -r requirements.txt

# copy entrypoint.sh
COPY ./entrypoint.sh .
RUN sed -i 's/\r$//g' /usr/src/washee_web/entrypoint.sh
RUN chmod +x /usr/src/washee_web/entrypoint.sh

# copy project
COPY . .

# run entrypoint.sh
ENTRYPOINT ["/usr/src/washee_web/entrypoint.sh"]
