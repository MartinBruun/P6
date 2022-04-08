#!/bin/sh

if [ "$DATABASE" = "postgres" ]
then
    echo "Waiting for postgres..."

    while ! nc -z $DB_HOST $DB_PORT; do
      sleep 0.1
    done

    echo "PostgreSQL started"
fi

python3 manage.py flush --no-input
python3 manage.py makemigrations
python3 manage.py migrate
#python3 manage.py createsuperuser --noinput (command was used to create the first admin, now saved in init_priorgade_washing_room.json)
python3 manage.py loaddata init_priorgade.json

exec "$@"
