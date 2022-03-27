# syntax=docker/dockerfile:1

FROM python:3

RUN apt-get update
RUN apt-get install -y --no-install-recommends

# for flask web server
EXPOSE 8082

# set work directory
WORKDIR /usr/src

# install dependencies
RUN pip install --upgrade pip
COPY ./requirements.txt .
RUN pip install -r requirements.txt

# Flask environment variables
ENV FLASK_APP=washee-box-entry.py
ENV FLASK_DEBUG=${BOX_DEBUG}

# copy project
COPY . .

# run the entrypoint
CMD ["python3", "washee-box-entry.py"]