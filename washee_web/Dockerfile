# pull official base image
FROM debian:10.3-slim

# set work directory
WORKDIR /usr/src/washee_web

# set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# install psycopg2 dependencies
RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get autoremove -y \
    && apt-get install -y \
      gcc \
      python3 \
      build-essential \
      zlib1g-dev \
      wget \
      unzip \
      cmake \
      python3-dev \
      python3-pip \
      python3-numpy \
      python3-pandas \
      gfortran \
      libssl-dev \
      libffi-dev \
      libc6 \
      libblas-dev \
      liblapack-dev \
      libatlas-base-dev \
      libpq-dev \
      dos2unix \
    && apt-get clean
RUN apt install -y netcat

# Install 
RUN pip3 install --upgrade pip
COPY ./requirements.txt .
RUN pip3 install -r requirements.txt

# copy entrypoint.sh
COPY ./entrypoint.sh .
RUN dos2unix ./entrypoint.sh
RUN sed -i 's/\r$//g' /usr/src/washee_web/entrypoint.sh
RUN chmod +x /usr/src/washee_web/entrypoint.sh

# copy project
COPY . .

# run entrypoint.sh
ENTRYPOINT ["/usr/src/washee_web/entrypoint.sh"]
