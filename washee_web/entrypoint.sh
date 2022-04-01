#!/bin/sh

if [ "$DATABASE" = "postgres" ]
then
    echo "Waiting for postgres..."

    while ! nc -z $DB_HOST $DB_PORT; do
      sleep 0.1
    done

    echo "PostgreSQL started"
fi

python manage.py flush --no-input
python manage.py makemigrations
python manage.py migrate
#python manage.py createsuperuser --noinput (command was used to create the first admin, now saved in init_priorgade_washing_room.json)
python manage.py loaddata init_priorgade.json

exec "$@"
